import json, re, math
from pathlib import Path
import activity_clock as a

ROOT=Path(__file__).parent
source=(ROOT/'activity_data.erl').read_text(encoding='utf-8')
c=a.ParsedConfig.load(ROOT/'activity_data.erl')
# Reference cohort only. No actual latest server identity has been supplied.
anchor=int(a.datetime(2026,9,17,tzinfo=a.TIMEZONE).timestamp())
DAY=86400
lines={}
for m in re.finditer(r'^get_activity\((\d+)\)\s*->\s*#\{.*?\n\s*\};',source,re.M|re.S):
    lines[int(m[1])]=[source.count('\n',0,m.start())+1,source.count('\n',0,m.end())+1]

def label(x):
    day=math.floor(x)
    seconds=round((x-day)*DAY)
    return f'D{day} {seconds//3600:02}:{seconds%3600//60:02}'

periods=[]; audit=[]; suspicious=[]
for id,f in c.activities.items():
    name=a.extract_name(f.get('activity_name'))
    category='普通活动' if id in c.operating_ids else '周循环' if id in c.weekly_ids else '独立循环'
    conf=f.get('server_condition','undefined')
    condition=f.get('condition','[]')
    evidence=f'知识库索引 server_data/activity_data.erl:L{lines[id][0]}–L{lines[id][1]}'
    status=''; windows=[]
    if not a.server_condition_matches(a.parse_term(conf),anchor):
        status='不匹配当前新服批次'
    else:
        if category=='普通活动':
            begin=a.resolve_time(a.parse_term(f.get('begin_time')),anchor)
            end=a.resolve_time(a.parse_term(f.get('end_time')),anchor)
            if begin is None or end is None: raise ValueError(id)
            windows=[(None,begin,end)]
        else:
            ot=c.group_open_times[a.parse_term(f['group_id'])] if category=='周循环' else c.cycle_open_times[id]
            base,last,gap=ot
            if not isinstance(base,int):
                status='自然日期循环，需实际开服日期'
            else:
                ri=a.parse_term(f['round_interval'])
                for rnd in range(1,40):
                    if isinstance(ri,tuple) and not ri[0]<=rnd<=ri[1]:continue
                    if isinstance(ri,int) and rnd<ri:continue
                    begin=anchor+(base-1+(rnd-1)*(last+gap))*DAY
                    end=begin+last*DAY
                    override=a.datetime_term_to_timestamp(a.parse_term(f.get('end_time_override')))
                    if category=='周循环' and override is not None:
                        if begin>=override:continue
                        if end+end-begin>override:end=override
                    windows.append((rnd,begin,end))
        valid=[]
        for rnd,begin,end in windows:
            before=a.datetime_term_to_timestamp(a.parse_term(f.get('open_time_before')))
            after=a.datetime_term_to_timestamp(a.parse_term(f.get('open_time_after')))
            if before is not None and begin>=before:continue
            if after is not None and begin<after:continue
            pre=begin-a.duration_seconds(a.parse_term(f.get('preview_time')))
            exp=end+a.duration_seconds(a.parse_term(f.get('expire_time')))
            if end<=begin or exp<=anchor or pre>=anchor+30*DAY:continue
            valid.append((rnd,begin,end,pre,exp))
        if valid:
            suspect=bool(re.search(r'\{(?:level|chapter_pve),999\}',condition))
            status='待核实：999门槛' if suspect else '纳入首月'
            for rnd,begin,end,pre,exp in valid:
                startday=(begin-anchor)/DAY+1; endday=(end-anchor)/DAY+1
                note=[]
                if after:note.append('本期开启时间须≥'+a.timestamp_to_datetime(after).strftime('%Y-%m-%d %H:%M'))
                if before:note.append('本期开启时间须<'+a.timestamp_to_datetime(before).strftime('%Y-%m-%d %H:%M'))
                if startday<1:note.append('固定日期长期开启；首月显示D1–D30')
                if endday>31:note.append('D30后继续')
                if suspect:note.append('level/chapter_pve=999，是否停用未获运行态确认')
                rule='单次'
                if category!='普通活动':
                    rule=f'每{last+gap}天一轮，开{last}天，间隔{gap}天；轮次{f["round_interval"]}'
                p=dict(id=str(id),name=name,category=category,type=a.parse_term(f.get('type')),round=rnd or 0,start=max(1,startday),end=endday,preview=max(1,(pre-anchor)/DAY+1),expire=(exp-anchor)/DAY+1,begin_label=label(startday) if startday>=1 else '开服时已开启',end_label=label(endday) if endday<1000 else '长期（原始截止见明细）',rule=rule,condition=condition,notes='；'.join(note),source=evidence,raw_begin=f.get('begin_time',f.get('open_time','')),raw_end=f.get('end_time',''),cohort=conf,mutex=a.parse_term(f.get('mutex_group_id'),0))
                (suspicious if suspect else periods).append(p)
        elif not status:status='首月无有效时间段'
    audit.append(dict(id=str(id),name=name,category=category,status=status,cohort=conf,condition=condition,raw_begin=f.get('begin_time',f.get('open_time','')),raw_end=f.get('end_time',''),gate_before=f.get('open_time_before',''),gate_after=f.get('open_time_after',''),source=evidence))

periods.sort(key=lambda p:(p['start'],p['id'],p['round']))
# Match configured mutex ordering for a fresh server, without claiming existing live state.
accepted=[]; conflicts=[]
for p in periods:
    hit=next((x for x in accepted if p['mutex']>0 and x['mutex']==p['mutex'] and x['start']<p['end'] and p['start']<x['end']),None)
    if hit:conflicts.append([p['id'],hit['id'],p['start']])
    else:accepted.append(p)
assert not conflicts, conflicts
rows=[]
for id in dict.fromkeys(p['id'] for p in periods):
    ps=[p for p in periods if p['id']==id]
    rows.append(dict(**{k:ps[0][k] for k in ['id','name','category','type','rule','condition']},periods=ps))
summary=dict(config_count=len(c.activities),activity_count=len(rows),period_count=len(periods),suspicious_count=len(suspicious),cohort='2026-09-17新服口径（批次假设，非实际区服确认）',conflicts=conflicts)
# Independent spot checks against the indexed server calendar implementation.
for hours in range(0,30*24,6):
    now=anchor+hours*3600
    result,errors=a.calculate_activities(c,{'open_time':anchor,'zone_name':'reference_new_server'},now)
    assert not errors,errors
    wanted=set()
    for p in result:
        f=c.activities[p['id']]
        if p['status']!='open' or re.search(r'\{(?:level|chapter_pve),999\}',f.get('condition','')):continue
        before=a.datetime_term_to_timestamp(a.parse_term(f.get('open_time_before')))
        after=a.datetime_term_to_timestamp(a.parse_term(f.get('open_time_after')))
        if before is not None and p['begin_time']>=before:continue
        if after is not None and p['begin_time']<after:continue
        wanted.add((str(p['id']),p['round'] or 0))
    got={(p['id'],p['round']) for p in periods if p['start']<=hours/24+1<p['end']}
    assert got==wanted,(hours,got^wanted)
summary['verified_time_samples']=120
out=dict(summary=summary,rows=rows,periods=periods,suspicious=suspicious,audit=audit)
(ROOT/'schedule.json').write_text(json.dumps(out,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps(summary,ensure_ascii=False))
for row in rows:
    print(row['id'],row['name'],row['type'],' / '.join(f"{p['begin_label']}—{p['end_label']} R{p['round']}" for p in row['periods']))
