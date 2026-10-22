import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { FileBlob, SpreadsheetFile } from '@oai/artifact-tool';

const source = 'E:/x1/配置/trunk/策划文档/数值文档/《梦境护卫队》6-1商业化数值_新期修正版_20261016.xlsx';
const out = path.dirname(fileURLToPath(import.meta.url));
const wb = await SpreadsheetFile.importXlsx(await FileBlob.load(source));
const names = ['现行活动索引', '现行活动商品', '现行任务奖励', '现行招募日期', '现行抽卡消耗', '现行奖池权重', '现行奖池奖励'];
const summary = await wb.inspect({ kind: 'sheet', include: 'id,name', maxChars: 10000 });
console.log(summary.ndjson);
for (const [i, name] of names.entries()) {
  const inspect = await wb.inspect({ kind: 'region', sheetId: name, range: 'A1:N8', maxChars: 1200 });
  console.log('REGION', name, inspect.ndjson);
  const blob = await wb.render({ sheetName: name, range: i === 1 ? 'A1:Z9' : 'A1:N11', scale: 1, format: 'png' });
  await fs.writeFile(path.join(out, `source_${i + 1}.png`), new Uint8Array(await blob.arrayBuffer()));
}
