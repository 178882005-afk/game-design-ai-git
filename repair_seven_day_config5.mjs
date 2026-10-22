import fs from 'node:fs/promises';
const paths = [
  'D:/Administrator/Desktop/Internal-git-DG-BattleWiki-Treasure-2.0/envs/dev/xml_gy/normal/Q_七日挑战_seven_day_challenge_data.xml',
  'D:/Administrator/Desktop/xitong/1-1数值模块/3-3配置文档/Q_七日挑战_seven_day_challenge_data.xml',
];
const rowRe = /<Row\b[\s\S]*?<\/Row>/g;
const cellRe = /<Cell\b[^>]*\/>|<Cell\b[^>]*>[\s\S]*?<\/Cell>/g;
function attr(token, key) { return token.match(new RegExp(`(?:ss:)?${key}="([^"]*)"`))?.[1] ?? ''; }
function dataOf(cell) { return cell?.match(/<Data\b[^>]*>([\s\S]*?)<\/Data>/)?.[1] ?? ''; }
function cellsOf(row) { const out=[]; let col=1; for(const token of row.match(cellRe)??[]){const i=Number(attr(token,'Index'));if(i)col=i;out.push({col,token,value:dataOf(token)});col++;}return out; }
function value(row,col){return cellsOf(row).find((c)=>c.col===col)?.value??'';}
function setCell(row,col,value,type='Number'){for(const c of cellsOf(row)){if(c.col===col){const data=`<Data ss:Type="${type}">${value}</Data>`;const repl=c.token.includes('/>')?`<Cell ss:StyleID="s51">${data}</Cell>`:c.token.replace(/<Data\b[^>]*>[\s\S]*?<\/Data>/,data);return row.replace(c.token,repl);}}return row;}
function edit(xml,name,fn){const a=xml.indexOf(`<Worksheet ss:Name="${name}">`),b=xml.indexOf('</Worksheet>',a)+'</Worksheet>'.length;return xml.slice(0,a)+fn(xml.slice(a,b))+xml.slice(b);}
function rebuild(segment,rows){const actual=rows.length;return segment.replace(/<Row\b[\s\S]*?<\/Row>/g,'__ROW__').replace(/(?:__ROW__)+/,rows.join('')).replace(/ss:ExpandedRowCount="\d+"/,`ss:ExpandedRowCount="${actual}"`);}
function replaceRows(segment,rows){const first=segment.search(rowRe);const last=[...segment.matchAll(rowRe)].at(-1);const end=last.index+last[0].length;return segment.slice(0,first)+rows.join('')+segment.slice(end).replace(/ss:ExpandedRowCount="\d+"/,`ss:ExpandedRowCount="${rows.length}"`);}
for(const path of paths){
  let xml=await fs.readFile(path,'utf8');
  xml=edit(xml,'活动开启',(seg)=>{const rows=seg.match(rowRe)??[];for(let i=rows.length-2;i<rows.length;i++)rows[i]=setCell(rows[i],1,'5');return replaceRows(seg,rows);});
  xml=edit(xml,'活动任务列表',(seg)=>{const rows=seg.match(rowRe)??[];for(let i=rows.length-28;i<rows.length;i++)rows[i]=setCell(rows[i],1,'5');return replaceRows(seg,rows);});
  xml=edit(xml,'活跃奖励',(seg)=>{const rows=seg.match(rowRe)??[];for(let i=rows.length-12;i<rows.length;i++)rows[i]=setCell(rows[i],1,'5');return replaceRows(seg,rows);});
  xml=edit(xml,'活动任务商店',(seg)=>{
    let rows=seg.match(rowRe)??[];
    rows=rows.filter((r)=>value(r,1)!=='5');
    const source=rows.filter((r)=>{const id=Number(value(r,3));return id>=106&&id<=140;});
    if(source.length!==35)throw new Error(`Expected 35 config-4 shop rows, got ${source.length}`);
    const clones=source.map((r)=>{const oldId=Number(value(r,3));let x=setCell(r,1,'5');x=setCell(x,2,oldId<=133?'1':'2');return setCell(x,3,String(oldId+35));});
    return replaceRows(seg,[...rows,...clones]);
  });
  await fs.writeFile(path,xml,'utf8');
}
console.log('config 5 blocks repaired');
