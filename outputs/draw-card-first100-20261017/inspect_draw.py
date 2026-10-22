import json
import sys
from pathlib import Path
import xml.etree.ElementTree as ET

SOURCE = Path(r'E:\x1\c#\trunk\trunk\xml_gy\normal\C_抽卡_draw_card_data.xml')
NS = {'s': 'urn:schemas-microsoft-com:office:spreadsheet'}
S = '{' + NS['s'] + '}'

def parse(raw):
    root = ET.fromstring(raw)
    sheets = []
    for sheet in root.findall('s:Worksheet', NS):
        rows = []
        row_index = 0
        for row in sheet.findall('s:Table/s:Row', NS):
            row_index = int(row.get(S + 'Index', row_index + 1))
            cells = {}
            col = 0
            for cell in row.findall('s:Cell', NS):
                col = int(cell.get(S + 'Index', col + 1))
                data = cell.find('s:Data', NS)
                if data is not None:
                    cells[str(col)] = {'value': data.text or '', 'type': data.get(S + 'Type'), 'formula': cell.get(S + 'Formula')}
            rows.append({'row': row_index, 'cells': cells})
        sheets.append({'name': sheet.get(S + 'Name'), 'rows': rows})
    return sheets

if __name__ == '__main__':
    sheets = parse(SOURCE.read_bytes())
    (Path(__file__).parent / 'source.json').write_text(json.dumps(sheets, ensure_ascii=False), encoding='utf-8')
    names = sys.argv[1:] or ['抽卡', '奖池', '奖励内容', '常量', '奖池开启']
    for sheet in sheets:
        if sheet['name'] not in names:
            continue
        print('\nSHEET', sheet['name'])
        for row in sheet['rows']:
            values = {col: c['value'] for col, c in row['cells'].items()}
            if row['row'] <= 5 or sheet['name'] in ['抽卡', '奖池开启', '常量', '说明'] or any('普池' in v or '普通' in v for v in values.values()):
                print(row['row'], json.dumps(values, ensure_ascii=False))
