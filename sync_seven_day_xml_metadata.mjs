import fs from 'node:fs/promises';
const paths = [
  'D:/Administrator/Desktop/Internal-git-DG-BattleWiki-Treasure-2.0/envs/dev/xml_gy/normal/Q_七日挑战_seven_day_challenge_data.xml',
  'D:/Administrator/Desktop/xitong/1-1数值模块/3-3配置文档/Q_七日挑战_seven_day_challenge_data.xml',
];
const names = ['活动配置', '活动开启', '活动任务列表', '活动任务商店', '活跃奖励'];
const rowRe = /<Row\b[\s\S]*?<\/Row>/g;
for (const path of paths) {
  let xml = await fs.readFile(path, 'utf8');
  for (const name of names) {
    const start = xml.indexOf(`<Worksheet ss:Name="${name}">`);
    const end = xml.indexOf('</Worksheet>', start);
    const segment = xml.slice(start, end + '</Worksheet>'.length);
    const count = (segment.match(rowRe) ?? []).length;
    const updated = segment.replace(/ss:ExpandedRowCount="\d+"/, `ss:ExpandedRowCount="${count}"`);
    xml = xml.slice(0, start) + updated + xml.slice(end + '</Worksheet>'.length);
  }
  await fs.writeFile(path, xml, 'utf8');
}
console.log('metadata synchronized');
