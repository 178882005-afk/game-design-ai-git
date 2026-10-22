import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { FileBlob, SpreadsheetFile } from '@oai/artifact-tool';

const source = 'E:/x1/配置/trunk/策划文档/数值文档/《梦境护卫队》6-1商业化数值_新期修正版_20261016.xlsx';
const out = path.join(path.dirname(fileURLToPath(import.meta.url)), 'roundtrip_probe.xlsx');
const wb = await SpreadsheetFile.importXlsx(await FileBlob.load(source));
const output = await SpreadsheetFile.exportXlsx(wb);
await output.save(out);
console.log(out);
