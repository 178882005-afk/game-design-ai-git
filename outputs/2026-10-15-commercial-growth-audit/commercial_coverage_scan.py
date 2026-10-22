import re, collections, os
import xml.etree.ElementTree as ET
import openpyxl

base = "E:/x1/配置/trunk/xml_gy/normal/"
wbpath = "E:/x1/配置/trunk/策划文档/数值文档/《梦境护卫队》6-1商业化数值.xlsx"
ns = '{urn:schemas-microsoft-com:office:spreadsheet}'

def table(filename, sheetname):
    root=ET.parse(base+filename).getroot()
    for ws in root.findall(ns+'Worksheet'):
        if ws.get(ns+'Name') != sheetname: continue
        rows=ws.find(ns+'Table').findall(ns+'Row')
        def cells(row):
            d={}; col=1
            for c in row.findall(ns+'Cell'):
                col=int(c.get(ns+'Index') or col)
                data=c.find(ns+'Data')
                if data is not None: d[col]=data.text or ''
                col+=1
            return d
        names=cells(rows[1]); out=[]
        # SpreadsheetML can skip empty Excel rows with ss:Index. Track the
        # actual worksheet row address rather than the XML Row element count.
        excel_row=0
        for pos,row in enumerate(rows):
            excel_row=int(row.get(ns+'Index') or excel_row+1)
            if pos<2: continue
            d=cells(row)
            if d: out.append({'_row':excel_row, **{key:d.get(idx,'') for idx,key in names.items()}})
        return out
    return []
def pairs(s): return [(int(a),float(b)) for a,b in re.findall(r'\{\s*(\d+)\s*,\s*([\d.]+)\s*\}',str(s))]
def intval(s):
    try: return int(float(s))
    except: return None
w=openpyxl.load_workbook(wbpath,read_only=True,data_only=True)
v=w['价值表']; anchor={}; nameanchor={}
for r in range(4,125):
    name=v[f'C{r}'].value; iid=intval(v[f'D{r}'].value); val=v[f'F{r}'].value
    if not isinstance(val,(int,float)) or not name: continue
    nameanchor[name]=(r,val)
    if iid is not None: anchor[iid]=(r,val,name)
items=table('D_道具_item_data.xml','道具信息')
item={intval(d.get('id')):d for d in items if intval(d.get('id')) is not None}
chest=table('B_宝箱奖励_chest_data.xml','宝箱')
chest={intval(d.get('id')):d for d in chest if intval(d.get('id')) is not None}
pool=table('B_宝箱奖励_chest_data.xml','奖池')
pool={intval(d.get('id')):d for d in pool if intval(d.get('id')) is not None}
reward=table('B_宝箱奖励_chest_data.xml','奖励内容')
groups=collections.defaultdict(list)
for d in reward:
    gid=intval(d.get('reward_group'))
    if gid is not None: groups[gid].append(d)
choose=table('D_道具_item_data.xml','自选内容')
chooses=collections.defaultdict(list)
for d in choose:
    gid=intval(d.get('pool_id'))
    if gid is not None: chooses[gid].append(d)
def info(i):
    d=item.get(i,{})
    return d.get('name',''),d.get('type',''),d.get('item_attr',''), d.get('value','')
# reward occurrences: category, product, id
occ=[]
def add(cat, prod, s):
    for i,n in pairs(s): occ.append((cat,str(prod),i,n))
for d in table('S_首充_first_pay_data.xml','奖励'):
    if d.get('server_open_point')=='9': add('首充',d.get('level'),d.get('reward'))
for d in table('A_活动商店_activity_shop_data.xml','活动商城'):
    if intval(d.get('id')) in [1806,1807,1808]: add('每日特惠',d.get('id'),d.get('rewards'))
for d in table('R_日周月礼包_period_package_data.xml','礼包'):
    if d.get('server_open_point')=='2' and d.get('need'): add('日周月礼包',d.get('id'),d.get('rewards'))
for d in table('Y_月卡_month_card_data.xml','月卡'):
    if d.get('server_open_point')=='9' and d.get('reward'): 
        add('月卡',d.get('id'),d.get('reward')); add('月卡',d.get('id'),d.get('day_reward'))
for d in table('Z_周签到战令_week_bp_data.xml','周签到奖励配置'):
    if d.get('project_id')=='180005': add('周卡',180005,d.get('pay_gift'))
for d in table('Z_战令_common_war_order_data.xml','战令奖励'):
    if d.get('id')=='104':
        # Verified against indexed server redemption: lv2/28 RMB opens high;
        # pay_id/68 RMB opens the regular pay_reward track.
        add('体力战令', '28元',d.get('pay_reward_high'))
        add('体力战令', '68元',d.get('pay_reward'))
# examine current ids
u=sorted(set(i for _,_,i,_ in occ))
print('ACTIVE IDS',len(u),'OCCURRENCES',len(occ))
for i in u:
    cats=sorted(set(cat for cat,prod,j,n in occ if j==i))
    prods=sorted(set(f'{cat}:{prod}' for cat,prod,j,n in occ if j==i))
    an=anchor.get(i)
    nm=info(i)
    na=nameanchor.get(nm[0])
    ch=chest.get(i)
    cpool=ch.get('pool_list','') if ch else ''
    sel=''; 
    if nm[1]=='7': sel=nm[2]
    print('ID',i,'name',nm[0],'type',nm[1],'attr',nm[2],'itemvalue',nm[3], 'anchor',an,'nameanchor',na,'chestpool',cpool,'products',len(prods),','.join(prods[:20]))
print('BY CATEGORY')
for cat in sorted(set(x[0] for x in occ)):
    c=[x for x in occ if x[0]==cat]; ps=set(x[1] for x in c); ids=set(x[2] for x in c)
    direct=set(i for i in ids if i in anchor)
    print(cat,'products',len(ps),'occ',len(c),'uniqueIDs',len(ids),'directIDs',len(direct),'directOcc',sum(x[2] in direct for x in c),'missingIDs',sorted(ids-direct))
print('CONTAINER DETAILS')
for i in [20038,100008,100009,5103002,5600022,6220021]:
    ch=chest.get(i,{})
    print('CONTAINER',i,info(i),'chest',ch.get('_row'), 'pool_list',ch.get('pool_list'),'reward_mode',ch.get('reward_mode'),'reward_count',ch.get('reward_count'),'choose',ch.get('choose_list'))
    for pid,n in pairs(ch.get('pool_list','')):
        pp=pool.get(pid,{})
        print(' POOL',pid,'row',pp.get('_row'),'weight',pp.get('weight'),'group',pp.get('reward_group'),'draw_info',pp.get('draw_info'))
        gid=intval(pp.get('reward_group'))
        if gid is not None:
            for rr in groups.get(gid,[]):
                rid=intval(rr.get('item_id'))
                print('  REWARD','row',rr.get('_row'),'weight',rr.get('weight'),'id',rid,'count',rr.get('item_count'),'name',info(rid)[0],'anchor',anchor.get(rid),'nameanchor',nameanchor.get(info(rid)[0]))
print('SELF CHOOSE')
for ii in [100143]:
    d=item.get(ii,{})
    gid=intval(d.get('item_attr'))
    print(ii,'pool',gid)
    for rr in chooses.get(gid,[]):
        rid=intval(rr.get('item_id'))
        print(' CHOICE','row',rr.get('_row'),'id',rid,'count',rr.get('item_count'),'name',info(rid)[0],'anchor',anchor.get(rid),'nameanchor',nameanchor.get(info(rid)[0]))
print('CONTAINER POOLS')
for i in [20038,100008,100009,5103002,5600022,6220021]:
    ch=chest.get(i,{})
    print('CONTAINER',i)
    for pid in [int(x) for x in re.findall(r'\d+',ch.get('pool_list',''))]:
        pp=pool.get(pid,{})
        print(' POOL',pid,'row',pp.get('_row'),'weight',pp.get('weight'),'group',pp.get('reward_group'),'draw_info',pp.get('draw_info'))
        gid=intval(pp.get('reward_group'))
        if gid is not None:
            for rr in groups.get(gid,[]):
                rid=intval(rr.get('item_id'))
                print('  REWARD','row',rr.get('_row'),'weight',rr.get('weight'),'id',rid,'count',rr.get('item_count'),'name',info(rid)[0],'anchor',anchor.get(rid),'nameanchor',nameanchor.get(info(rid)[0]))
extra={62:('name',114,150),9800301:('name',112,50),5304237:('name_and_item_value',66,1024),5103002:('same_pool_as_5103001',16,1),20038:('pool_ev',None,80)}
classed={}
for i in u:
    classed[i]='direct' if i in anchor else ('derived' if i in extra else 'missing')
print('COVERAGE_SUMMARY')
for k in ['direct','derived','missing']:
    a=[i for i in u if classed[i]==k]
    o=[x for x in occ if classed[x[2]]==k]
    print(k,'unique',len(a),'occurrences',len(o),'ids',a)
cats=sorted(set(x[0] for x in occ))
full=set()
for cat in cats:
    ps=sorted(set(prod for c,prod,_,_ in occ if c==cat))
    for prod in ps:
        a=[x for x in occ if x[0]==cat and x[1]==prod]
        if all(classed[x[2]]!='missing' for x in a): full.add((cat,prod))
        else: print('INCOMPLETE',cat,prod,sorted(set(x[2] for x in a if classed[x[2]]=='missing')))
print('PRODUCT_FULL',len(full),'TOTAL',len(set((c,p) for c,p,_,_ in occ)))
print('WISH STONE')
for i,d in item.items():
    if '心愿石' in d.get('name',''):
        print(i,d.get('name'),d.get('quality'),d.get('type'),d.get('value'),d.get('_row'))
print('MISSING_DETAILS')
for i in [100008,100009,100040,100143,1530100,5505001,5600022,6200012,6220021,10140370,10340370,15301011]:
 d=item.get(i,{})
 print('ID',i,'name',d.get('name'),'row',d.get('_row'),'quality',d.get('quality'),'type',d.get('type'),'attr',d.get('item_attr'),'itemvalue',d.get('value'),'desc',d.get('desc'))
 if i in chest:
  for pid in [int(x) for x in re.findall(r'\d+',chest[i].get('pool_list',''))]:
   pp=pool.get(pid,{})
   print(' POOL',pid,'group',pp.get('reward_group'),'draw_info',pp.get('draw_info'))
   gid=intval(pp.get('reward_group'))
   for rr in groups.get(gid,[]):
    rid=intval(rr.get('item_id'))
    dd=item.get(rid,{})
    print('  LEAF',rid,'name',dd.get('name'),'quality',dd.get('quality'),'type',dd.get('type'),'itemvalue',dd.get('value'),'anchor',anchor.get(rid))
 if i==100143:
  for rr in chooses.get(intval(d.get('item_attr')),[]):
   rid=intval(rr.get('item_id')); dd=item.get(rid,{})
   print('  CHOICE',rid,'name',dd.get('name'),'quality',dd.get('quality'),'type',dd.get('type'),'itemvalue',dd.get('value'))
print('VALUES')
for cat,prod in sorted(set((c,p) for c,p,_,_ in occ)):
 xs=[x for x in occ if x[0]==cat and x[1]==prod]
 if all(x[2] in anchor or x[2] in extra for x in xs):
  val=sum(n*(anchor[i][1] if i in anchor else extra[i][2]) for _,_,i,n in xs)
  print(cat,prod,round(val,4))
