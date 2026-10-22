import hashlib
import json
import re
import shutil
import xml.etree.ElementTree as ET
from pathlib import Path
from xml.sax.saxutils import escape
from inspect_draw import SOURCE, NS, S, parse

out=Path(__file__).parent
payload=json.loads((out/'authored_changes.json').read_text(encoding='utf-8'))
raw=SOURCE.read_bytes()
assert hashlib.sha256(raw).hexdigest()==payload['source_hash'], 'Source changed; reread before editing.'
text=raw.decode('utf-8')
edits=[]
inserted=[]
for op in payload['ops']:
    # Match the existing ss prefix; the workbook's unmodified bytes are retained.
    pattern=r'<Worksheet\b[^>]*ss:Name="'+re.escape(op['sheet'])+r'"[^>]*>(.*?)</Worksheet>'
    sm=re.search(pattern,text,re.S)
    assert sm, op['sheet']
    row_index=0
    for rm in re.finditer(r'<Row\b[^>]*(?:/>|>.*?</Row>)',sm.group(1),re.S):
        start_tag=rm.group().split('>',1)[0]
        im=re.search(r'ss:Index="(\d+)"',start_tag)
        row_index=int(im.group(1)) if im else row_index+1
        if row_index!=op['row']:
            continue
        col=0
        for cm in re.finditer(r'<Cell\b[^>]*(?:/>|>.*?</Cell>)',rm.group(),re.S):
            tag=cm.group().split('>',1)[0]
            im=re.search(r'ss:Index="(\d+)"',tag)
            col=int(im.group(1)) if im else col+1
            if col!=op['col']:
                continue
            old_cell=cm.group()
            assert 'ss:Formula=' not in old_cell
            dm=re.search(r'(<Data\b[^>]*>)(.*?)(</Data>)',old_cell,re.S)
            if dm:
                assert ET.fromstring(old_cell.replace('ss:','').replace('<Cell','<Cell')).find('Data').text==op['old']
                new_cell=old_cell[:dm.start(2)]+escape(op['new'])+old_cell[dm.end(2):]
            else:
                assert op['old']=='', 'Expected existing value.'
                data='<Data ss:Type="String">'+escape(op['new'])+'</Data>'
                new_cell=old_cell[:-2]+'>'+data+'</Cell>' if old_cell.endswith('/>') else old_cell[:-7]+data+'</Cell>'
            absolute=sm.start(1)+rm.start()+cm.start()
            edits.append((absolute,absolute+len(old_cell),new_cell,old_cell))
            break
        else:
            assert col < op['col'] and op['old']=='', 'Missing cell inside existing cells'
            absolute=sm.start(1)+rm.start()+rm.group().rfind('</Row>')
            data='<Cell ss:Index="'+str(op['col'])+'"><Data ss:Type="String">'+escape(op['new'])+'</Data></Cell>'
            edits.append((absolute,absolute,data,''))
            inserted.append((op['sheet'],op['row'],op['col']))
        break
    else:
        raise AssertionError('Missing target row')
assert len(edits)==8
updated=text
for begin,end,replacement,_original in sorted(edits,reverse=True):
    updated=updated[:begin]+replacement+updated[end:]
new_raw=updated.encode('utf-8')
before=parse(raw);after=parse(new_raw)
allowed={(op['sheet'],op['row'],str(op['col'])):op for op in payload['ops']}
diffs=[]
assert len(before)==len(after)==22
for a,b in zip(before,after):
    assert a['name']==b['name'] and len(a['rows'])==len(b['rows'])
    for ar,br in zip(a['rows'],b['rows']):
        assert ar['row']==br['row']
        for col in set(ar['cells'])|set(br['cells']):
            ac=ar['cells'].get(col);bc=br['cells'].get(col)
            if ac!=bc:
                key=(a['name'],ar['row'],col)
                assert key in allowed, f'Unexpected change {key}'
                assert bc['value']==allowed[key]['new'] and bc['formula'] is None
                diffs.append({'sheet':key[0],'row':key[1],'col':col,'before':ac,'after':bc})
assert len(diffs)==8
before_root=ET.fromstring(raw);after_root=ET.fromstring(new_raw)
for op in payload['ops']:
    for root in [before_root,after_root]:
        sheet=next(s for s in root.findall('s:Worksheet',NS) if s.get(S+'Name')==op['sheet'])
        ri=0
        for row in sheet.findall('s:Table/s:Row',NS):
            ri=int(row.get(S+'Index',ri+1))
            if ri==op['row']:
                ci=0
                for cell in row.findall('s:Cell',NS):
                    ci=int(cell.get(S+'Index',ci+1))
                    if ci==op['col']:
                        for data in list(cell.findall('s:Data',NS)):
                            cell.remove(data)
                        if root is after_root and (op['sheet'],op['row'],op['col']) in inserted:
                            row.remove(cell)
                        break
                break
assert ET.tostring(before_root)==ET.tostring(after_root), 'Structure/style/formula changed.'
assert '\ufffd' not in ''.join(op['new'] for op in payload['ops'])
assert '???' not in ''.join(op['new'] for op in payload['ops'])
backup=out/'before_C_抽卡_draw_card_data.xml'
assert not backup.exists(), 'Backup already exists; do not overwrite.'
shutil.copy2(SOURCE,backup)
assert backup.read_bytes()==raw
assert SOURCE.read_bytes()==raw, 'Source changed before write.'
# r+b avoids truncating a workbook locked by WPS; access is checked before writing.
with SOURCE.open('r+b') as handle:
    assert handle.read()==raw
    handle.seek(0)
    handle.write(new_raw)
    handle.truncate()
assert SOURCE.read_bytes()==new_raw
counts=[0,1,98,99,100,101]
boundary=[{'completed_draws':n,'next_draw':n+1,'orange_gate_pass':101<=n+1<=2147483647} for n in counts]
report={'file':str(SOURCE),'backup':str(backup.resolve()),'changed_cells':diffs,'before_hash':payload['source_hash'],
        'after_hash':hashlib.sha256(new_raw).hexdigest(),'sheets_preserved':22,'unrelated_structure_styles_formulas_preserved':True,
        'boundary_by_indexed_condition':boundary,'runtime_verified':False,
        'limitations':['成长池 1108 的服务端实现不在当前 server 索引中；未运行服务器或导出。',
        '索引 condition.erl 的条件读取玩家缓存；批次中逐抽恢复时点取决于成长池的新实现，未验证。']}
(out/'verification.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps({k:report[k] for k in ['file','backup','before_hash','after_hash','sheets_preserved','unrelated_structure_styles_formulas_preserved','boundary_by_indexed_condition','runtime_verified']},ensure_ascii=False))
