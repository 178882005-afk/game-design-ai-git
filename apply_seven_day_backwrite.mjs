import fs from 'node:fs/promises';
import { FileBlob, SpreadsheetFile } from '@oai/artifact-tool';

const qPaths = [
  'D:/Administrator/Desktop/Internal-git-DG-BattleWiki-Treasure-2.0/envs/dev/xml_gy/normal/Q_七日挑战_seven_day_challenge_data.xml',
  'D:/Administrator/Desktop/xitong/1-1数值模块/3-3配置文档/Q_七日挑战_seven_day_challenge_data.xml',
];
const repo = 'D:/Administrator/Desktop/Internal-git-DG-BattleWiki-Treasure-2.0';
const taskPath = `${repo}/envs/dev/xml_gy/normal/R_任务_task_data.xml`;
const workbookPath = 'D:/Administrator/Documents/ChatGPT/xitongAGENT/outputs/seven_day_challenge/七日挑战规划表.xlsx';

const escapeXml = (value) => String(value).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
const rowRe = /<Row\b[\s\S]*?<\/Row>/g;
const cellRe = /<Cell\b[^>]*\/>|<Cell\b[^>]*>[\s\S]*?<\/Cell>/g;

function attr(token, key) {
  const m = token.match(new RegExp(`(?:ss:)?${key}="([^"]*)"`));
  return m?.[1] ?? '';
}
function dataOf(cell) {
  return cell?.match(/<Data\b[^>]*>([\s\S]*?)<\/Data>/)?.[1] ?? '';
}
function cellsOf(row) {
  const cells = [];
  let col = 1;
  for (const token of row.match(cellRe) ?? []) {
    const index = Number(attr(token, 'Index'));
    if (index) col = index;
    cells.push({ col, token, value: dataOf(token) });
    col += 1;
  }
  return cells;
}
function cellValue(row, targetCol) {
  return cellsOf(row).find((c) => c.col === targetCol)?.value ?? '';
}
function setCell(row, targetCol, value, type = 'String') {
  const tokens = row.match(cellRe) ?? [];
  let col = 1;
  for (let i = 0; i < tokens.length; i += 1) {
    const index = Number(attr(tokens[i], 'Index'));
    if (index) col = index;
    if (col === targetCol) {
      const escaped = escapeXml(value);
      const replacement = tokens[i].includes('/>')
        ? `<Cell ss:StyleID="s51"><Data ss:Type="${type}">${escaped}</Data></Cell>`
        : tokens[i].replace(/<Data\b[^>]*>[\s\S]*?<\/Data>/, `<Data ss:Type="${type}">${escaped}</Data>`);
      return row.replace(tokens[i], replacement);
    }
    col += 1;
  }
  return row;
}
function worksheetBounds(xml, name) {
  const start = xml.indexOf(`<Worksheet ss:Name="${name}">`);
  if (start < 0) throw new Error(`Worksheet not found: ${name}`);
  const end = xml.indexOf('</Worksheet>', start);
  return { start, end: end + '</Worksheet>'.length };
}
function editWorksheet(xml, name, fn) {
  const { start, end } = worksheetBounds(xml, name);
  return xml.slice(0, start) + fn(xml.slice(start, end)) + xml.slice(end);
}
function rowsOf(segment) {
  return segment.match(rowRe) ?? [];
}
function activeBlock(segment, id) {
  let current = null;
  return rowsOf(segment).filter((row) => {
    const explicit = cellValue(row, 1);
    if (/^\d+$/.test(explicit)) current = Number(explicit);
    return current === id && cellValue(row, 2) && cellValue(row, 3);
  });
}
function appendRows(segment, rows) {
  if (!rows.length) return segment;
  return segment.replace('</Table>', `${rows.join('')}</Table>`);
}
function syncExpandedRowCount(segment) {
  const actual = (segment.match(rowRe) ?? []).length;
  return segment.replace(/ss:ExpandedRowCount="\d+"/, `ss:ExpandedRowCount="${actual}"`);
}
function updateTaskRewards(xml, rewardByTask) {
  return editWorksheet(xml, '任务信息', (segment) => segment.replace(rowRe, (row) => {
    const taskId = Number(cellValue(row, 1));
    const reward = rewardByTask.get(taskId);
    return reward ? setCell(row, 8, reward, 'String') : row;
  }));
}

const wb = await SpreadsheetFile.importXlsx(await FileBlob.load(workbookPath));
const current = wb.worksheets.getItem('当前七日挑战').getRange('E5:J100').values;
const rewardByTask = new Map();
for (const row of current) {
  const taskId = Number(row[0]);
  const detail = String(row[5] ?? '');
  const pairs = [...detail.matchAll(/\((\d+)\)\s*[×xX*]\s*(\d+)/g)].map((m) => `{${m[1]},${m[2]}}`);
  if (taskId && pairs.length) rewardByTask.set(taskId, `[${pairs.join(',')}]`);
}
if (rewardByTask.size !== current.length) throw new Error(`Reward detail parse mismatch: ${rewardByTask.size}/${current.length}`);

const { execFileSync } = await import('node:child_process');
const git = 'C:/Users/Administrator/.cache/codex-runtimes/codex-primary-runtime/dependencies/native/git/cmd/git.exe';
const gitBase = (relative) => execFileSync(git, ['show', `HEAD:${relative}`], { cwd: repo, encoding: 'utf8', maxBuffer: 50 * 1024 * 1024 });
let taskXml = gitBase('envs/dev/xml_gy/normal/R_任务_task_data.xml');
taskXml = updateTaskRewards(taskXml, rewardByTask);
await fs.writeFile(taskPath, taskXml, 'utf8');

function updateQ(xml) {
  let out = xml;
  out = editWorksheet(out, '活动配置', (segment) => {
    const rows = rowsOf(segment);
    const row4 = rows.find((row) => cellValue(row, 3) === '4');
    if (!row4) throw new Error('Config 4 row not found');
    const updatedRow4 = setCell(row4, 2, '{{2026,9,9},{23,59,59}}', 'String');
    let row5 = setCell(row4, 1, '{{2026,9,10},{0,0,0}}', 'String');
    row5 = setCell(row5, 2, '{{2036,12,30},{23,59,59}}', 'String');
    row5 = setCell(row5, 3, '5', 'Number');
    return syncExpandedRowCount(segment.replace(row4, `${updatedRow4}${row5}`));
  });
  out = editWorksheet(out, '活动开启', (segment) => {
    const clones = activeBlock(segment, 4).map((row) => setCell(row, 1, '5', 'Number'));
    return syncExpandedRowCount(appendRows(segment, clones));
  });
  out = editWorksheet(out, '活动任务列表', (segment) => {
    const clones = activeBlock(segment, 4).map((row) => setCell(row, 1, '5', 'Number'));
    return syncExpandedRowCount(appendRows(segment, clones));
  });
  out = editWorksheet(out, '活跃奖励', (segment) => {
    const clones = activeBlock(segment, 4).map((row) => setCell(row, 1, '5', 'Number'));
    return syncExpandedRowCount(appendRows(segment, clones));
  });
  out = editWorksheet(out, '活动任务商店', (segment) => {
    const source = rowsOf(segment).filter((row) => {
      const packageId = Number(cellValue(row, 3));
      return packageId >= 106 && packageId <= 140;
    });
    if (source.length !== 35) throw new Error(`Expected 35 config-4 shop rows, got ${source.length}`);
    const clones = source.map((row) => {
      const packageId = Number(cellValue(row, 3));
      let clone = setCell(row, 1, '5', 'Number');
      clone = setCell(clone, 2, packageId <= 133 ? '1' : '2', 'Number');
      return setCell(clone, 3, String(packageId + 35), 'Number');
    });
    return syncExpandedRowCount(appendRows(segment, clones));
  });
  return out;
}

const originalQ = gitBase('envs/dev/xml_gy/normal/Q_七日挑战_seven_day_challenge_data.xml');
const updatedQ = updateQ(originalQ);
for (const path of qPaths) await fs.writeFile(path, updatedQ, 'utf8');

console.log(JSON.stringify({ taskRewardsUpdated: rewardByTask.size, qFilesUpdated: qPaths.length, qBytes: updatedQ.length, config5Added: true }));
