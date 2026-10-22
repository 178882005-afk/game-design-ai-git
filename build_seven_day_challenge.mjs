import fs from 'node:fs/promises';
import { xml2js } from 'xml-js';
import { SpreadsheetFile, Workbook } from '@oai/artifact-tool';

const base = 'D:/Administrator/Desktop/Internal-git-DG-BattleWiki-Treasure-2.0/envs/dev/xml_gy/normal';
const source = {
  challenge: `${base}/Q_七日挑战_seven_day_challenge_data.xml`,
  tasks: `${base}/R_任务_task_data.xml`,
  items: `${base}/D_道具_item_data.xml`,
};
const outputDir = 'D:/Administrator/Documents/ChatGPT/xitongAGENT/outputs/seven_day_challenge';

const xml = async (path) => xml2js(await fs.readFile(path, 'utf8'), { compact: false });
const children = (node, name) => (node?.elements ?? []).filter((e) => e.type === 'element' && (!name || e.name === name));
const attr = (node, key) => node?.attributes?.[`ss:${key}`] ?? node?.attributes?.[key] ?? '';
const text = (node) => (node?.elements ?? []).filter((e) => e.type === 'text' || e.type === 'cdata').map((e) => e.text ?? '').join('');
const worksheet = (book, name) => children(book.elements?.find((e) => e.name === 'Workbook'), 'Worksheet').find((w) => attr(w, 'Name') === name);

function rowsFromWorksheet(ws) {
  const table = children(ws, 'Table')[0];
  return children(table, 'Row').map((row) => {
    const result = [];
    let col = 1;
    for (const cell of children(row, 'Cell')) {
      const index = Number(attr(cell, 'Index'));
      if (index) col = index;
      const data = children(cell, 'Data')[0];
      result[col - 1] = data ? text(data) : '';
      col += 1;
    }
    return result;
  });
}

const challengeBook = await xml(source.challenge);
const taskBook = await xml(source.tasks);
const itemBook = await xml(source.items);

const challengeSheets = {
  config: rowsFromWorksheet(worksheet(challengeBook, '活动配置')),
  active: rowsFromWorksheet(worksheet(challengeBook, '活动开启')),
  taskList: rowsFromWorksheet(worksheet(challengeBook, '活动任务列表')),
  shop: rowsFromWorksheet(worksheet(challengeBook, '活动任务商店')),
  rewards: rowsFromWorksheet(worksheet(challengeBook, '活跃奖励')),
};
const taskRows = rowsFromWorksheet(worksheet(taskBook, '任务信息'));
const itemRows = rowsFromWorksheet(worksheet(itemBook, '道具信息'));

const taskHeaders = taskRows[1] ?? [];
const taskMap = new Map(taskRows.slice(2).filter((r) => /^\d+$/.test(r?.[0] ?? '')).map((r) => [Number(r[0]), Object.fromEntries(taskHeaders.map((h, i) => [h, r[i] ?? '']))]));
const itemMap = new Map(itemRows.slice(2).filter((r) => /^\d+$/.test(r?.[0] ?? '')).map((r) => [Number(r[0]), r[1] ?? '']));

function parsePairs(raw) {
  return [...String(raw ?? '').matchAll(/\{\s*(\d+)\s*,\s*([^}\s]+)\s*\}/g)].map((m) => ({ id: Number(m[1]), count: m[2], name: itemMap.get(Number(m[1])) ?? '[未找到道具名]' }));
}
function readableCondition(raw, desc) {
  const value = String(raw ?? '').trim();
  return desc || value || '';
}
function rewardText(raw) {
  return parsePairs(raw).map((p) => `${p.name}(${p.id}) × ${p.count}`).join('；');
}
const timeById = new Map(challengeSheets.config.slice(2).filter((r) => /^\d+$/.test(r?.[2] ?? '')).map((r) => [Number(r[2]), { start: r[0] ?? '', end: r[1] ?? '' }]));
let activeId = null;
const activeRows = challengeSheets.active.slice(2).flatMap((r) => {
  if (/^\d+$/.test(r?.[0] ?? '')) activeId = Number(r[0]);
  if (!activeId || !/^(1|2)$/.test(r?.[1] ?? '')) return [];
  const time = timeById.get(activeId) ?? {};
  return [{ id: activeId, type: Number(r[1]), existDay: r[2] ?? '', openDay: r[3] ?? '', closeDay: r[4] ?? '', resCfg: r[5] ?? '', typeName: r[6] ?? '', start: time.start ?? '', end: time.end ?? '' }];
});
const activeByIdType = new Map(activeRows.map((r) => [`${r.id}|${r.type}`, r]));
const currentCfgId = 4;

const detail = [];
for (const r of challengeSheets.taskList.slice(2)) {
  if (!/^\d+$/.test(r?.[0] ?? '') || !/^(1|2)$/.test(r?.[1] ?? '') || !/^\d+$/.test(r?.[2] ?? '')) continue;
  const cfgId = Number(r[0]);
  const type = Number(r[1]);
  const day = Number(r[2]);
  const page = r[3] ?? '';
  const ids = [...String(r[4] ?? '').matchAll(/\d+/g)].map((m) => Number(m[0]));
  for (const taskId of ids) {
    const task = taskMap.get(taskId);
    if (!task) {
      detail.push([cfgId, type, day, page, taskId, '[未找到任务]', '', '', '', '', '', '', '', '']);
      continue;
    }
    const rewards = parsePairs(task.reward);
    detail.push([
      cfgId, type, day, page, taskId, task.name ?? '', readableCondition(task.target, task.desc), task.target ?? '', task.reward ?? '', rewardText(task.reward), rewards.map((p) => p.id).join(', '), rewards.map((p) => p.count).join(', '), task.jump_ways ?? '', task.type_name ?? '',
    ]);
  }
}

const rewardRows = challengeSheets.rewards.slice(2).filter((r) => /^\d+$/.test(r?.[0] ?? '')).map((r) => {
  const rewards = parsePairs(r[4]);
  return [Number(r[0]), Number(r[1]), Number(r[2]), Number(r[3]), r[4] ?? '', rewardText(r[4]), rewards.map((p) => p.id).join(', '), rewards.map((p) => p.count).join(', '), r[5] ?? ''];
});

let shopId = null;
let shopType = null;
const shopRows = challengeSheets.shop.slice(2).flatMap((r) => {
  if (/^\d+$/.test(r?.[0] ?? '')) shopId = Number(r[0]);
  if (/^(1|2)$/.test(r?.[1] ?? '')) shopType = Number(r[1]);
  if (!shopId || !shopType || !/^\d+$/.test(r?.[2] ?? '')) return [];
  return [[shopId, shopType, Number(r[3]), Number(r[2]), r[4] ?? '', r[5] ?? '', rewardText(r[5]), r[6] ?? '', r[7] ?? '', rewardText(r[7]), r[8] ?? '', rewardText(r[8]), r[9] ?? '', r[10] ?? '']];
});

const currentDetail = detail.filter((r) => r[0] === currentCfgId && r[1] === 1);

const wb = Workbook.create();
const main = wb.worksheets.add('当前七日挑战');
const history = wb.worksheets.add('全配置任务');
const config = wb.worksheets.add('活动配置');
const reward = wb.worksheets.add('活跃奖励节点');
const shop = wb.worksheets.add('活动任务商店');
for (const sheet of [main, history, config, reward, shop]) sheet.showGridLines = false;

const mainHeaders = ['配置ID', '挑战类型', '天数', '页签', '任务ID', '任务名称', '任务条件（可读）', '任务条件原文', '奖励原文', '奖励明细（道具名）', '奖励道具ID', '奖励数量', '跳转途径', '任务类型'];
main.getRange('A1').values = [['七日挑战活动规划回归表']];
main.getRange('A2').values = [[`当前生效配置：ID ${currentCfgId}，类型 1（开服 1-7 天），共 ${currentDetail.length} 个任务。来源：Q_七日挑战_seven_day_challenge_data.xml + R_任务_task_data.xml + D_道具_item_data.xml。`]];
main.getRange(`A4:N${4 + currentDetail.length}`).values = [mainHeaders, ...currentDetail];
main.getRange('A1:N1').format = { font: { bold: true, size: 14, color: '#1F2937' } };
main.getRange('A2:N2').format = { font: { italic: true, color: '#6B7280' }, wrapText: false };
main.getRange('A4:N4').format = { fill: '#1F4E78', font: { bold: true, color: '#FFFFFF' }, horizontalAlignment: 'center', verticalAlignment: 'center', wrapText: true };
main.getRange(`A5:N${4 + currentDetail.length}`).format = { verticalAlignment: 'center', wrapText: true };
main.getRange(`A4:N${4 + currentDetail.length}`).format.borders = { style: 'continuous', color: '#D1D5DB' };
main.getRange('A:N').format.columnWidth = 16;
for (const [col, width] of [['F:F', 24], ['G:G', 28], ['H:I', 28], ['J:J', 42], ['M:M', 16]]) main.getRange(col).format.columnWidth = width;
main.getRange('A1:N2').format.rowHeight = 24;
main.getRange('A4:N4').format.rowHeight = 36;
main.freezePanes.freezeRows(4);
main.tables.add(`A4:N${4 + currentDetail.length}`, true, 'CurrentTasks');

history.getRange('A1').values = [['七日挑战全配置任务明细']];
history.getRange('A2').values = [['配置ID 1-4 为不同开服时间区间；用于历史对照与差异追溯。']];
history.getRange(`A4:N${4 + detail.length}`).values = [mainHeaders, ...detail];
history.getRange('A1:N1').format = { font: { bold: true, size: 14, color: '#1F2937' } };
history.getRange('A2:N2').format = { font: { italic: true, color: '#6B7280' }, wrapText: false };
history.getRange('A4:N4').format = { fill: '#496D89', font: { bold: true, color: '#FFFFFF' }, horizontalAlignment: 'center', verticalAlignment: 'center', wrapText: true };
history.getRange(`A5:N${4 + detail.length}`).format = { verticalAlignment: 'center', wrapText: true };
history.getRange('A:N').format.columnWidth = 16;
for (const [col, width] of [['F:F', 24], ['G:G', 28], ['H:I', 28], ['J:J', 42], ['M:M', 16]]) history.getRange(col).format.columnWidth = width;
history.freezePanes.freezeRows(4);
history.tables.add(`A4:N${4 + detail.length}`, true, 'AllTasks');

const configHeaders = ['配置ID', '当前状态', '开服时间下限', '开服时间上限', '类型', '类型名称', '存在天数', '开启创号天数', '关闭创号天数', '配置任务数', '资源配置'];
config.getRange('A1').values = [['活动开启配置']];
config.getRange('A2').values = [[`来源：Q_七日挑战_seven_day_challenge_data.xml / 活动配置 + 活动开启。当前配置为 ID ${currentCfgId}；配置 5 于 2026-09-10 00:00:00 待生效。`]];
config.getRange(`A4:K${4 + activeRows.length}`).values = [configHeaders, ...activeRows.map((r) => [r.id, r.id === currentCfgId ? '当前' : (r.id > currentCfgId ? '待生效' : '历史'), r.start, r.end, r.type, r.typeName, r.existDay, r.openDay, r.closeDay, detail.filter((d) => d[0] === r.id && d[1] === r.type).length, r.resCfg])];
config.getRange('A1:K1').format = { font: { bold: true, size: 14, color: '#1F2937' } };
config.getRange('A2:K2').format = { font: { italic: true, color: '#6B7280' }, wrapText: false };
config.getRange('A4:K4').format = { fill: '#1F4E78', font: { bold: true, color: '#FFFFFF' }, horizontalAlignment: 'center', verticalAlignment: 'center', wrapText: true };
config.getRange(`A4:K${4 + activeRows.length}`).format = { verticalAlignment: 'center', wrapText: true };
config.getRange('A:K').format.columnWidth = 18;
config.getRange('C:D').format.columnWidth = 24;
config.getRange('F:F').format.columnWidth = 24;
config.getRange('K:K').format.columnWidth = 54;
config.freezePanes.freezeRows(4);
config.tables.add(`A4:K${4 + activeRows.length}`, true, 'ActivityConfig');

const rewardHeaders = ['配置ID', '奖励节点ID', '类型', '所需活跃值', '奖励原文', '奖励明细（道具名）', '奖励道具ID', '奖励数量', '隐藏信息'];
reward.getRange('A1').values = [['活跃值奖励节点规划']];
reward.getRange('A2').values = [['来源：Q_七日挑战_seven_day_challenge_data.xml / 活跃奖励；类型 1=七日挑战，类型 2=8-14日挑战。']];
reward.getRange(`A4:I${4 + rewardRows.length}`).values = [rewardHeaders, ...rewardRows];
reward.getRange('A1:I1').format = { font: { bold: true, size: 14, color: '#1F2937' } };
reward.getRange('A2:I2').format = { font: { italic: true, color: '#6B7280' }, wrapText: false };
reward.getRange('A4:I4').format = { fill: '#1F4E78', font: { bold: true, color: '#FFFFFF' }, horizontalAlignment: 'center', verticalAlignment: 'center', wrapText: true };
reward.getRange(`A4:I${4 + rewardRows.length}`).format = { verticalAlignment: 'center', wrapText: true };
reward.getRange('A:I').format.columnWidth = 18;
reward.getRange('E:E').format.columnWidth = 24;
reward.getRange('F:F').format.columnWidth = 42;
reward.freezePanes.freezeRows(4);
reward.tables.add(`A4:I${4 + rewardRows.length}`, true, 'ActiveRewards');

const shopHeaders = ['配置ID', '类型', '天数', '礼包ID', '商品名称', '奖励原文', '奖励明细（道具名）', '支付表ID', '货币消耗原文', '货币消耗明细', '原价原文', '原价明细', '可购买次数', '显示顺序'];
shop.getRange('A1').values = [['活动任务商店规划']];
shop.getRange('A2').values = [['来源：Q_七日挑战_seven_day_challenge_data.xml / 活动任务商店；保留支付表、货币消耗与原价配置。']];
shop.getRange(`A4:N${4 + shopRows.length}`).values = [shopHeaders, ...shopRows];
shop.getRange('A1:N1').format = { font: { bold: true, size: 14, color: '#1F2937' } };
shop.getRange('A2:N2').format = { font: { italic: true, color: '#6B7280' }, wrapText: false };
shop.getRange('A4:N4').format = { fill: '#496D89', font: { bold: true, color: '#FFFFFF' }, horizontalAlignment: 'center', verticalAlignment: 'center', wrapText: true };
shop.getRange(`A5:N${4 + shopRows.length}`).format = { verticalAlignment: 'center', wrapText: true };
shop.getRange('A:N').format.columnWidth = 18;
shop.getRange('E:E').format.columnWidth = 24;
shop.getRange('F:F').format.columnWidth = 28;
shop.getRange('G:G').format.columnWidth = 48;
shop.freezePanes.freezeRows(4);
shop.tables.add(`A4:N${4 + shopRows.length}`, true, 'ActivityShop');

await wb.recalculate();
const check = await wb.inspect({ kind: 'sheet,region,match', sheetId: '当前七日挑战', range: `A1:N${4 + currentDetail.length}`, searchTerm: '#REF!|#DIV/0!|#VALUE!|#NAME\?|#N/A', options: { useRegex: true, maxResults: 100 }, maxChars: 6000, tableMaxRows: 12, tableMaxCols: 14 });
console.log(check.ndjson);
await fs.mkdir(outputDir, { recursive: true });
const xlsx = await SpreadsheetFile.exportXlsx(wb);
await xlsx.save(`${outputDir}/七日挑战规划表_修订版.xlsx`);
for (const [name, range] of [['当前七日挑战', `A1:N14`], ['活动配置', `A1:K14`], ['活跃奖励节点', `A1:I12`], ['活动任务商店', `A1:N14`]]) {
  const preview = await wb.render({ sheetName: name, range, scale: 1, format: 'png' });
  await fs.writeFile(`${outputDir}/${name}.png`, new Uint8Array(await preview.arrayBuffer()));
}
console.log(JSON.stringify({ currentConfigId: currentCfgId, currentTaskRows: currentDetail.length, detailRows: detail.length, configRows: activeRows.length, rewardRows: rewardRows.length, shopRows: shopRows.length, output: `${outputDir}/七日挑战规划表_修订版.xlsx` }));
