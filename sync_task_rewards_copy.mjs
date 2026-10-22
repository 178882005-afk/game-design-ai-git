import fs from 'node:fs/promises';
import { FileBlob, SpreadsheetFile } from '@oai/artifact-tool';

const workbookPath = 'D:/Administrator/Documents/ChatGPT/xitongAGENT/outputs/seven_day_challenge/七日挑战规划表_修订版.xlsx';
const taskPaths = [
  'D:/Administrator/Desktop/Internal-git-DG-BattleWiki-Treasure-2.0/envs/dev/xml_gy/normal/R_任务_task_data.xml',
  'D:/Administrator/Desktop/xitong/1-1数值模块/3-3配置文档/R_任务_task_data.xml',
];
const rowRe = /<Row\b[\s\S]*?<\/Row>/g;
const cellRe = /<Cell\b[^>]*\/>|<Cell\b[^>]*>[\s\S]*?<\/Cell>/g;
function attr(token,key){return token.match(new RegExp(`(?:ss:)?${key}="([^"]*)"`))?.[1]??'';}
function dataOf(cell){return cell?.match(/<Data\b[^>]*>([\s\S]*?)<\/Data>/)?.[1]??'';}
function cells(row){const out=[];let col=1;for(const token of row.match(cellRe)??[]){const i=Number(attr(token,'Index'));if(i)col=i;out.push({col,token,value:dataOf(token)});col++;}return out;}
function value(row,col){return cells(row).find((c)=>c.col===col)?.value??'';}
function setCell(row,col,val){for(const c of cells(row)){if(c.col===col){const d=`<Data ss:Type="String">${val}</Data>`;const repl=c.token.includes('/>')?`<Cell ss:StyleID="s51">${d}</Cell>`:c.token.replace(/<Data\b[^>]*>[\s\S]*?<\/Data>/,d);return row.replace(c.token,repl);}}return row;}
function edit(xml,name,fn){const a=xml.indexOf(`<Worksheet ss:Name="${name}">`),b=xml.indexOf('</Worksheet>',a);if(a<0||b<0)throw new Error(name);const end=b+'</Worksheet>'.length;return xml.slice(0,a)+fn(xml.slice(a,end))+xml.slice(end);}
const wb=await SpreadsheetFile.importXlsx(await FileBlob.load(workbookPath));
const rows=wb.worksheets.getItem('当前七日挑战').getRange('E5:J100').values;
const rewards=new Map(rows.map((r)=>[Number(r[0]),`[${[...String(r[5]).matchAll(/\((\d+)\)\s*[×xX*]\s*(\d+)/g)].map((m)=>`{${m[1]},${m[2]}}`).join(',')}]`]));
for(const path of taskPaths){let xml=await fs.readFile(path,'utf8');xml=edit(xml,'任务信息',(seg)=>seg.replace(rowRe,(row)=>{const id=Number(value(row,1));return rewards.has(id)?setCell(row,8,rewards.get(id)):row;}));await fs.writeFile(path,xml,'utf8');}
console.log(JSON.stringify({updatedTaskRewards:rewards.size,files:taskPaths.length}));
