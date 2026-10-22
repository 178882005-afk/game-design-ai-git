import json
import re
from pathlib import Path
from inspect_draw import parse, SOURCE

out = Path(__file__).parent
sheets = parse(SOURCE.read_bytes())
by_name = {s['name']: s for s in sheets}
def value(row, col):
    return row['cells'].get(str(col), {}).get('value', '')

unit_path = SOURCE.parent / 'D_单位_unit_data.xml'
unit_sheets = parse(unit_path.read_bytes())
units = {}
for sheet in unit_sheets:
    header = next((r for r in sheet['rows'] if value(r, 1) == 'id' and any(c['value'] == 'quality' for c in r['cells'].values())), None)
    if header and any(c['value'] == 'name' for c in header['cells'].values()):
        cols = {c['value']: k for k,c in header['cells'].items()}
        for r in sheet['rows']:
            uid = value(r, cols['id'])
            if uid.isdigit():
                units[uid] = {'name':value(r,cols['name']), 'quality':value(r,cols['quality'])}

pools = {value(r, 1): r for r in by_name['奖池']['rows'] if value(r, 1).isdigit()}
contents = {}
for r in by_name['奖励内容']['rows']:
    if value(r,1).isdigit():
        contents.setdefault(value(r,3), []).append(r)

mechanisms = [r for r in by_name['卡池等级机制']['rows'] if value(r,1) == '1']
scope = []
for r in mechanisms:
    ids = set(re.findall(r'\d{7,}', ','.join(value(r,c) for c in [3,5,7,8,10])))
    for pid in sorted(ids):
        if pid not in pools:
            continue
        p=pools[pid]
        rewards = contents.get(value(p,7), [])
        qualities = sorted({units.get(value(c,5),{}).get('quality','item') for c in rewards if int(value(c,4) or 0)>0})
        scope.append({'level':value(r,2),'id':pid,'pool_row':p['row'],'name':value(p,3),'qualities':qualities,'quality_color':value(p,4),'content_group':value(p,7)})
    print('LEVEL',value(r,2),'count_rules',value(r,7),'section_rules',value(r,8),'extra',value(r,10))

print('POOL CONTENT QUALITY',json.dumps(scope,ensure_ascii=False))
condition_sheets=parse((SOURCE.parent/'T_条件_condition_data.xml').read_bytes())
for s in condition_sheets:
    for r in s['rows']:
        text=' '.join(c['value'] for c in r['cells'].values())
        if any(x in text for x in ['抽卡次数','抽卡累计','acc_draw','draw_count','draw_card_count','func_draw']):
            print('COND',s['name'],r['row'],json.dumps({k:c['value'] for k,c in r['cells'].items()},ensure_ascii=False))
(out/'scope.json').write_text(json.dumps(scope,ensure_ascii=False,indent=2),encoding='utf-8')
