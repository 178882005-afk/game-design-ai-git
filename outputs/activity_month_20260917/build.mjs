import fs from 'node:fs/promises';
import {fileURLToPath} from 'node:url';
import {Workbook,SpreadsheetFile} from '@oai/artifact-tool';
const root=new URL('.',import.meta.url);
const data=JSON.parse(await fs.readFile(new URL('schedule.json',root),'utf8'));
const wb=Workbook.create();
const gantt=wb.worksheets.add('首月甘特图');
const detail=wb.worksheets.add('活动期次明细');
const audit=wb.worksheets.add('配置筛选记录');
const navy='#263B61',blue='#3F70B5',purple='#7854A8';
function cell(col){let s='';for(let n=col+1;n;n=Math.floor((n-1)/26))s=String.fromCharCode(65+(n-1)%26)+s;return s;}
function base(sh,range){sh.showGridLines=false;sh.getRange(range).format.font={name:'Arial',size:10,color:'#25324A'};sh.getRange(range).format.rowHeight=24;sh.getRange(range).format.verticalAlignment='center';}
function title(sh,text){sh.getRange('A2').values=[[text]];sh.getRange('A2').format.font={size:16,bold:true,color:navy};sh.getRange('A2').format.rowHeight=30;}
function header(sh,range){sh.getRange(range).format={fill:navy,font:{bold:true,color:'#FFFFFF'},horizontalAlignment:'center',verticalAlignment:'center',rowHeight:30};}
function stripes(sh,first,last,width){for(let r=first;r<=last;r++)if(r%2===0)sh.getRange(`A${r}:${width}${r}`).format.fill='#F2F5F9';}
const n=data.periods.length,last=n+8;
base(detail,`A1:S${last}`);title(detail,'首月活动期次明细');
detail.getRange('A3').values=[['口径：按2026-09-17新服批次筛选；D1为开服当天，00:00规则点实际不早于服务器上线。']];
detail.getRange('A4').values=[['知识库索引配置推演；未核实实际最新区服、线上部署版本、GM开关及玩家达标时间。']];
detail.getRange('A5').values=[['时间为左闭右开：结束D15 00:00即覆盖D8–D14，不包含D15活动期。预览／展示另列。']];
detail.getRange('A6').values=[['规则证据：server/src/mod/operating_activities/normal_activity_mgr.erl:L887–985、L1101–1148；normal_activity_mgr_lib.erl:L185–200、L288–328；activity_api.erl:L551–582。']];
detail.getRange('A7').values=[['9月18日起新服招募狂欢改为ID 100640、D2–D7；本表使用截至9月17日适用的ID 100514、D1–D7。']];
const dh=['活动ID','活动名称','调度类型','轮次（0=单次）','开始D','结束D（不含）','预览开始D','展示结束D（不含）','开启时刻','结束时刻（不含）','循环规则','玩家开启条件（原值）','备注','','索引证据','原始开始／循环参数','原始结束参数','适用开服批次','活动类型ID'];
detail.getRange('A8:S8').values=[dh];
detail.getRange(`A9:S${last}`).values=data.periods.map(p=>[p.id,p.name,p.category,p.round,p.start,p.end,p.preview,p.expire,p.begin_label,p.end_label,p.rule,p.condition,p.notes,null,p.source,p.raw_begin,p.raw_end,p.cohort,p.type]);
detail.getRange(`E9:H${last}`).setNumberFormat('0.00');
detail.getRange('A1:A'+last).format.columnWidth=12;
detail.getRange('B1:B'+last).format.columnWidth=22;
detail.getRange('C1:D'+last).format.columnWidth=18;
detail.getRange('E1:H'+last).format.columnWidth=21;
detail.getRange('I1:J'+last).format.columnWidth=30;
detail.getRange('K1:M'+last).format.columnWidth=62;
detail.getRange('N1:N'+last).format.columnWidth=3;
detail.getRange('O1:O'+last).format.columnWidth=72;
detail.getRange('P1:R'+last).format.columnWidth=44;
detail.getRange('S1:S'+last).format.columnWidth=16;
stripes(detail,9,last,'M');header(detail,'A8:M8');header(detail,'O8:S8');
detail.tables.add(`A8:M${last}`,true,'ActivityPeriods');
detail.freezePanes.freezeRows(8);detail.freezePanes.freezeColumns(2);

const end=data.rows.length+7;
base(gantt,`A1:AG${end}`);title(gantt,'新服首月活动开启顺序');gantt.tabColor=navy;
gantt.getRange('A3').values=[[`D1–D30　${data.summary.activity_count}个活动ID / ${data.summary.period_count}个期次　按首次开启排序；同名不同ID分别保留。`]];
gantt.getRange('A4').values=[['配置推演，线上运行态未验证。批次口径：2026-09-17新服；范围为活动配置表，独立系统日程未包含。']];
gantt.getRange('A5').values=[['蓝色“开”=单次／常驻；紫色数字=循环轮次；“预”=预览；“展”=结束后展示。半天时段见明细。']];
gantt.getRange('A6').values=[['4条首月记录因999门槛列入待核实，不纳入主图；玩家条件、筛选记录与原始配置均保留在后两页。']];
gantt.getRange('A7:AG7').values=[['活动ID','名称','活动期（按完整日）',...Array.from({length:30},(_,i)=>i+1)]];
gantt.getRange('D7:AG7').setNumberFormat('"D"0');
gantt.getRange(`A1:A${end}`).format.columnWidthPx=84;
gantt.getRange(`B1:B${end}`).format.columnWidthPx=160;
gantt.getRange(`C1:C${end}`).format.columnWidthPx=234;
gantt.getRange(`D1:AG${end}`).format.columnWidthPx=33;
gantt.getRange(`D8:AG${end}`).format.horizontalAlignment='center';
const refs={id:`'活动期次明细'!$A$9:$A$${last}`,round:`'活动期次明细'!$D$9:$D$${last}`,start:`'活动期次明细'!$E$9:$E$${last}`,end:`'活动期次明细'!$F$9:$F$${last}`,pre:`'活动期次明细'!$G$9:$G$${last}`,exp:`'活动期次明细'!$H$9:$H$${last}`};
const formulas=[];
data.rows.forEach((r,i)=>{
  const row=i+8;
  const spans=r.periods.map(p=>`D${Math.floor(p.start)}–D${Math.min(Math.ceil(p.end)-1,9999)}`);
  const text=r.periods[0].end>1000?'D1起长期':spans.join(' / ');
  gantt.getRange(`A${row}:C${row}`).values=[[r.id,r.name,text]];
  if(text.length>29){gantt.getRange(`C${row}`).format.wrapText=true;gantt.getRange(`A${row}:AG${row}`).format.rowHeight=38;}
  formulas.push(Array.from({length:30},(_,j)=>{
    const d=`${cell(j+3)}$7`;
    const criteria=`${refs.id},$A${row},${refs.start},"<"&(${d}+1),${refs.end},">"&${d}`;
    const open=`COUNTIFS(${criteria})`;
    const round=`SUMIFS(${refs.round},${criteria})`;
    const pre=`COUNTIFS(${refs.id},$A${row},${refs.pre},"<"&(${d}+1),${refs.start},">"&${d})`;
    const exp=`COUNTIFS(${refs.id},$A${row},${refs.end},"<"&(${d}+1),${refs.exp},">"&${d})`;
    return `=IF(${open}>0,IF(${round}>0,${round},"开"),IF(${pre}>0,"预",IF(${exp}>0,"展","")))`;
  }));
});
gantt.getRange(`D8:AG${end}`).formulas=formulas;
stripes(gantt,8,end,'AG');header(gantt,'A7:AG7');
const grid=gantt.getRange(`D8:AG${end}`);
grid.conditionalFormats.add('containsText',{text:'开',format:{fill:blue,font:{color:'#FFFFFF'}}});
grid.conditionalFormats.add('containsText',{text:'预',format:{fill:'#DCE8F8',font:{color:'#375B8A'}}});
grid.conditionalFormats.add('containsText',{text:'展',format:{fill:'#F5DEAF',font:{color:'#775220'}}});
for(let r=1;r<=4;r++)grid.conditionalFormats.add('cellIs',{operator:'equal',formula:r,format:{fill:r%2?purple:'#AA8CC8',font:{color:'#FFFFFF'}}});
for(const d of [8,15,22,29])gantt.getRange(`${cell(d+2)}7:${cell(d+2)}${end}`).format.borders={left:{style:'thin',color:'#AAB7CD'}};
gantt.freezePanes.freezeRows(7);gantt.freezePanes.freezeColumns(3);

const priority={'待核实：999门槛':0,'纳入首月':1,'首月无有效时间段':2,'不匹配当前新服批次':3};
const filtered=[...data.audit].sort((x,y)=>(priority[x.status]??9)-(priority[y.status]??9)||Number(x.id)-Number(y.id));
const ae=filtered.length+7;
base(audit,`A1:L${ae}`);title(audit,'活动配置筛选记录');
audit.getRange('A3').values=[['完整保留771个配置ID的筛选原因。配置存在不代表线上启用；999门槛仅标为待核实。']];
audit.getRange('A4').values=[['新服批次按2026-09-17假设筛选；9月18日新服配置仍归“不匹配当前新服批次”，可按ID 100640查阅。']];
audit.getRange('A5').values=[['索引版本：server_data/activity_data.erl，SHA-256 fe55b614c81c706b362cdf73c4984d8086ee22ded63dea4a02f8f4da9aa740c1。']];
audit.getRange('A6').values=[['待核实：100018 梦灵收集；300001／300002／300003 职业特卖。其余历史批次、过期记录与D30后活动有各自筛选原因。']];
audit.getRange('A7:L7').values=[['活动ID','活动名称','调度类型','筛选结果','玩家条件','开始／循环参数','结束参数','开服批次条件','开启须早于','开启不得早于','','索引证据']];
audit.getRange(`A8:L${ae}`).values=filtered.map(x=>[x.id,x.name,x.category,x.status,x.condition,x.raw_begin,x.raw_end,x.cohort,x.gate_before,x.gate_after,null,x.source]);
for(const [col,width] of [['A',12],['B',22],['C',16],['D',30],['E',28],['F',40],['G',40],['H',48],['I',40],['J',40],['K',3],['L',72]])audit.getRange(`${col}1:${col}${ae}`).format.columnWidth=width;
stripes(audit,8,ae,'J');header(audit,'A7:J7');header(audit,'L7');
audit.tables.add(`A7:J${ae}`,true,'ConfigurationFilter');
audit.getRange(`D8:D${ae}`).conditionalFormats.add('containsText',{text:'待核实',format:{fill:'#F5DEAF',font:{color:'#775220',bold:true}}});
audit.freezePanes.freezeRows(7);audit.freezePanes.freezeColumns(2);
wb.recalculate();
// Compare every rendered day cell with independent interval overlap calculations.
const actual=gantt.getRange(`D8:AG${end}`).values;
for(let i=0;i<data.rows.length;i++)for(let j=0;j<30;j++){
  const day=j+1,ps=data.rows[i].periods;
  const active=ps.filter(p=>p.start<day+1&&p.end>day);
  let want=active.length?(active.reduce((s,p)=>s+p.round,0)||'开'):ps.some(p=>p.preview<day+1&&p.start>day)?'预':ps.some(p=>p.end<day+1&&p.expire>day)?'展':'';
  if(actual[i][j]!==want)throw Error(`Gantt mismatch ${i},${j}: ${actual[i][j]} != ${want}`);
}
console.log('Verified all 1500 Gantt cells against interval model.');
console.log((await wb.inspect({kind:'match',searchTerm:'#REF!|#DIV/0!|#VALUE!|#NAME\\?|#NUM!|#SPILL!',options:{useRegex:true,maxResults:10},maxChars:1000})).ndjson);
for(const [sh,range,file] of [[gantt,`A1:AG${end}`,'gantt.png'],[detail,'A1:J18','detail_preview.png'],[audit,'A1:F17','audit_preview.png']]){
  const blob=await wb.render({sheetName:sh.name,range,scale:1,format:'png'});
  await fs.writeFile(new URL(file,root),new Uint8Array(await blob.arrayBuffer()));
}
const out=await SpreadsheetFile.exportXlsx(wb);
await out.save(fileURLToPath(new URL('新服首月活动甘特图.xlsx',root)));
console.log('Exported workbook.');
