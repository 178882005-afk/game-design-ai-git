import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { FileBlob, SpreadsheetFile } from '@oai/artifact-tool';

const source = 'D:/Administrator/Documents/ChatGPT/MJ Game  Design AGENT/outputs/01a13de3-b726-7312-9642-5d6da6bd11b4/《梦境护卫队》6-1商业化数值_新期修正版_20261016_按活动合页.xlsx';
const out = path.dirname(fileURLToPath(import.meta.url));
const wb = await SpreadsheetFile.importXlsx(await FileBlob.load(source));
const sheet = '星旅寻梦（现行）';
const summary = await wb.inspect({ kind: 'sheet', include: 'id,name', maxChars: 10000 });
console.log('SHEETS', summary.ndjson);
const ranges = [
  ['top', 'A1:J16'],
  ['products', 'A13:N19'],
  ['tasks', 'A25:N32'],
  ['draws', 'A51:L69'],
  ['weights', 'A72:J80'],
  ['rewards', 'A87:J95'],
];
for (const [key, range] of ranges) {
  const blob = await wb.render({ sheetName: sheet, range, scale: 1, format: 'png' });
  await fs.writeFile(path.join(out, `merged_${key}.png`), new Uint8Array(await blob.arrayBuffer()));
  console.log('RENDER', key, range);
}
