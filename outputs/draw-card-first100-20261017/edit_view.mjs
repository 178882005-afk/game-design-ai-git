import fs from 'node:fs/promises';
import { Workbook } from '@oai/artifact-tool';

const dir = new URL('.', import.meta.url);
const input = JSON.parse(await fs.readFile(new URL('edit_input.json',dir),'utf8'));
const wb = Workbook.create();
const colLetter = col => { let s=''; while(col){col--;s=String.fromCharCode(65+col%26)+s;col=Math.floor(col/26);} return s; };
for(const data of input.sheets){
  const sheet=wb.worksheets.add(data.name);
  const rowMax=Math.max(...data.rows.map(r=>r.row));
  const colMax=Math.max(...data.rows.flatMap(r=>Object.keys(r.cells).map(Number)));
  const matrix=Array.from({length:rowMax},()=>Array(colMax).fill(null));
  for(const r of data.rows)for(const [c,cell] of Object.entries(r.cells))matrix[r.row-1][Number(c)-1]=cell.type==='Number'?Number(cell.value):cell.value;
  sheet.getRange(`A1:${colLetter(colMax)}${rowMax}`).values=matrix;
  const view=input.views.find(x=>x.name===data.name);
  for(const c of view.columns)sheet.getRange(`${colLetter(c.col)}1:${colLetter(c.col+c.span)}${rowMax}`).format.columnWidthPx=c.width*4/3;
  for(const r of view.rows){
    sheet.getRange(`A${r.row}:${colLetter(colMax)}${r.row}`).format.rowHeightPx=r.height*4/3;
    for(const c of r.cells){
      const range=sheet.getRange(`${colLetter(c.col)}${r.row}`);
      const st=input.styles[c.style]??{};
      if(st.font)range.format.font={name:st.font.FontName??'Microsoft Yahei',size:Number(st.font.Size??10),color:st.font.Color??'#000000',bold:st.font.Bold==='1'};
      if(st.fill)range.format.fill=st.fill;
      if(st.align){
        if(['Left','Center','Right'].includes(st.align.Horizontal))range.format.horizontalAlignment=st.align.Horizontal.toLowerCase();
        range.format.verticalAlignment=st.align.Vertical==='Bottom'?'bottom':st.align.Vertical==='Top'?'top':'center';
        range.format.wrapText=st.align.WrapText==='1';
      }
    }
  }
}
for(const [name,range,file] of [['奖池','A580:S585','before_pool.png'],['卡池等级机制','A48:J51','before_pity.png']]){
  const blob=await wb.render({sheetName:name,range,scale:1,format:'png'});
  await fs.writeFile(new URL(file,dir),new Uint8Array(await blob.arrayBuffer()));
}
console.log('Before views prepared.');
if(process.argv.includes('--apply')){
  const operations=[];
  for(const op of input.ops){
    const range=wb.worksheets.getItem(op.sheet).getRange(`${colLetter(op.col)}${op.row}`);
    if(String(range.values[0][0]??'')!==op.old)throw new Error(`Stale value at ${op.sheet}/${op.row}/${op.col}`);
    range.values=[[op.new]];
    operations.push({...op,new:range.values[0][0]});
  }
  wb.recalculate();
  const inspected=[];
  for(const op of operations){
    inspected.push((await wb.inspect({kind:'table',range:`'${op.sheet}'!${colLetter(op.col)}${op.row}`,include:'values,formulas',tableMaxRows:1,tableMaxCols:1,maxChars:1000})).ndjson);
  }
  for(const [name,range,file] of [['奖池','Q580:Z585','after_pool.png'],['卡池等级机制','E48:F51','after_pity.png']]){
    const blob=await wb.render({sheetName:name,range,scale:1,format:'png'});
    await fs.writeFile(new URL(file,dir),new Uint8Array(await blob.arrayBuffer()));
  }
  await fs.writeFile(new URL('authored_changes.json',dir),JSON.stringify({source_hash:input.source_hash,ops:operations},null,2));
  await fs.writeFile(new URL('artifact_inspect.json',dir),JSON.stringify(inspected,null,2));
  console.log(`Authored and inspected ${operations.length} cells.`);
}
