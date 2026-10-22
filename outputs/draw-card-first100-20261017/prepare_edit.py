import hashlib
import json
import xml.etree.ElementTree as ET
from pathlib import Path
from inspect_draw import SOURCE, NS, S, parse

out = Path(__file__).parent
raw = SOURCE.read_bytes()
sheets = parse(raw)
by_name = {s['name']: s for s in sheets}
value = lambda r,c: r['cells'].get(str(c),{}).get('value','')
draws = {value(r,1):r for r in by_name['抽卡']['rows']}
assert all(value(draws[str(i)],6)=='1108' and value(draws[str(i)],11)=='6' for i in [5901,5902])
pools = [r for r in by_name['奖池']['rows'] if value(r,1).startswith('59010') and value(r,4)=='5']
assert len(pools)==7
gate = '{acc_draw_count,1108,[{101,2147483647}]}'
ops=[]
for r in pools:
    old=value(r,18)
    assert not old or old.startswith('[') and old.endswith(']')
    new='['+gate+']' if not old or old=='[]' else old[:-1]+','+gate+']'
    ops.append({'sheet':'奖池','row':r['row'],'col':18,'old':old,'new':new,'id':value(r,1)})
mechanism=next(r for r in by_name['卡池等级机制']['rows'] if value(r,1)=='6' and value(r,2)=='1')
old=value(mechanism,5)
assert '{[59010108],100}' in old
ops.append({'sheet':'卡池等级机制','row':mechanism['row'],'col':5,'old':old,'new':old.replace('{[59010108],100}','{[59010108],101}'),'id':'6/1'})
root=ET.fromstring(raw)
styles={}
for style in root.findall('s:Styles/s:Style',NS):
    entry={}
    font=style.find('s:Font',NS)
    if font is not None:
        entry['font']={k.split('}')[-1]:v for k,v in font.attrib.items()}
    fill=style.find('s:Interior',NS)
    if fill is not None:
        entry['fill']=fill.get(S+'Color')
    align=style.find('s:Alignment',NS)
    if align is not None:
        entry['align']={k.split('}')[-1]:v for k,v in align.attrib.items()}
    styles[style.get(S+'ID')]=entry
views=[]
for s in root.findall('s:Worksheet',NS):
    name=s.get(S+'Name')
    if name not in ['奖池','卡池等级机制']:
        continue
    t=s.find('s:Table',NS)
    meta={'name':name,'columns':[],'rows':[]}
    col=0
    for c in t.findall('s:Column',NS):
        col=int(c.get(S+'Index',col+1));span=int(c.get(S+'Span',0))
        meta['columns'].append({'col':col,'span':span,'width':float(c.get(S+'Width','60'))})
        col+=span
    ri=0
    for r in t.findall('s:Row',NS):
        ri=int(r.get(S+'Index',ri+1))
        if not (name=='奖池' and 580<=ri<=585 or name=='卡池等级机制' and 48<=ri<=51):
            continue
        cells=[];ci=0
        for c in r.findall('s:Cell',NS):
            ci=int(c.get(S+'Index',ci+1))
            cells.append({'col':ci,'style':c.get(S+'StyleID',r.get(S+'StyleID','Default'))})
        meta['rows'].append({'row':ri,'height':float(r.get(S+'Height','18')),'cells':cells})
    views.append(meta)
payload={'source_hash':hashlib.sha256(raw).hexdigest(),'ops':ops,'styles':styles,'views':views,'sheets':[s for s in sheets if s['name'] in ['奖池','卡池等级机制']]}
(out/'edit_input.json').write_text(json.dumps(payload,ensure_ascii=False),encoding='utf-8')
print(json.dumps({'changes':len(ops),'orange_pools':[o['id'] for o in ops[:-1]],'gate':gate,'pity':'100 -> 101','source_hash':payload['source_hash']},ensure_ascii=False))
