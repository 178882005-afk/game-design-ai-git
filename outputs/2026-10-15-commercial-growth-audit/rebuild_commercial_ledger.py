import os,sys,csv,runpy,contextlib,io,collections,re
with contextlib.redirect_stdout(io.StringIO()):
    x=runpy.run_path(os.path.join(os.path.dirname(__file__),'commercial_coverage_scan.py'))
table=x['table']; pairs=x['pairs']; intval=x['intval']; anchor=x['anchor']; item=x['item']
outdir=os.path.dirname(os.path.abspath(__file__))
os.makedirs(outdir,exist_ok=True)
base6='《梦境护卫队》6-1商业化数值.xlsx'
prices={}
for d in table('C_充值_pay_data.xml','支付表'):
    iid=intval(d.get('id')); p=d.get('real_currency','')
    if iid is not None and p:
        try: prices[iid]=float(p)
        except: pass
rules={}
for iid,(r,v,nm) in anchor.items():
    rules[iid]=(v,'ID锚','严格',f'{base6}/价值表!D{r},F{r}')
for iid,price,row in [(62,150,114),(9800301,50,112),(5304237,1024,66)]:
    rules[iid]=(price,'同名/同品质映射','严格',f'{base6}/价值表!C{row},F{row}; D_道具_item_data.xml/道具信息')
rules[5103002]=(1,'同奖池','严格','B_宝箱奖励_chest_data.xml/宝箱!6:7/奖池510300101; 6-1/价值表!D16,F16')
rules[20038]=(80,'奖池期望','严格','B_宝箱奖励_chest_data.xml/宝箱!88/奖池!189/奖励内容!3487:3494')
for iid,price,row,extra in [
    (100008,4000,96,'B_宝箱/宝箱!246/奖励内容!2105:2107'),
    (100009,1500,95,'B_宝箱/宝箱!247/奖励内容!2108:2110'),
    (100143,6000,105,'D_道具/自选内容!362:364'),
    (1530100,240,24,'D_道具/道具信息!2434'),
    (5505001,4000,99,'D_道具/道具信息!112'),
    (5600022,240,24,'B_宝箱/宝箱!325/奖励内容!79:81'),
    (15301011,4000,96,'D_道具/道具信息!2556')]:
    rules[iid]=(price,'品质类目映射','条件',f'{base6}/价值表!F{row}; {extra}')
rules[6200012]=(4800,'历史藏品锚交叉验证','条件',f'{base6}/价值表!B149,G149/商店!N154,P154; _10_养成_10_藏品.xlsx/道具词典!A25:F25')
rules[6220021]=(2400,'历史藏品锚交叉验证','条件',f'{base6}/价值表!B181,G181/商店!N186,P186')
missing={
    100040:'当天特权服务，无独立直售价/固定使用量',
    10140370:'首充特殊促销外观；暂不设跨商品基础锚，不以攻击代理价硬套',
    10340370:'首充特殊促销外观；暂不设跨商品基础锚，不以攻击代理价硬套'
}
# Product records and aggregated reward lines
products={}
def product(cat,pid,name,kind,cost,currency,source,note=''):
    products[(cat,str(pid))]=dict(模块=cat,商品ID=str(pid),商品名=name,支付类型=kind,支付数值=cost,支付币种=currency,折钻成本=(cost*10 if currency=='RMB' and cost is not None else cost),商品配置来源=source,口径备注=note,lines=collections.defaultdict(float),sources=collections.defaultdict(list))
def add(cat,pid,s,source,mult=1):
    z=products[(cat,str(pid))]
    for iid,num in pairs(s):
        z['lines'][iid]+=num*mult
        z['sources'][iid].append(source+('×'+str(mult) if mult!=1 else ''))
# first pay
levelmeta={d['level']:d for d in table('S_首充_first_pay_data.xml','首充') if d.get('server_open_point')=='9'}
for lev,d in sorted(levelmeta.items(),key=lambda kv:int(kv[0])):
    payid=intval(d.get('pay_id')); threshold=d.get('acc_pay')
    if payid is not None:
        cost=prices[payid]; kind='直购RMB'; note='首充特殊促销；三日奖励合并；不可把累充后续档奖励并入6元购买或拿本档与常规礼包直接排序'
    else:
        cost=float(threshold); kind='累充门槛RMB'; note='首充特殊促销；门槛金额非增量购买价，倍率不计算；外观和服务权益单列'
    product('首充',lev,('6元首充' if payid is not None else '累充'+str(int(cost))+'元'),kind,cost,'RMB',f'S_首充_first_pay_data.xml/首充!{d["_row"]}; C_充值_pay_data.xml/pay_id={payid or ""}',note)
for d in table('S_首充_first_pay_data.xml','奖励'):
    if d.get('server_open_point')=='9':
        add('首充',d['level'],d.get('reward'),f'S_首充_first_pay_data.xml/奖励!{d["_row"]}')
# daily deals
for d in table('A_活动商店_activity_shop_data.xml','活动商城'):
    pid=intval(d.get('id'))
    if pid not in (1806,1807,1808): continue
    payid=intval(d.get('pay_id')); cost=prices[payid]
    product('每日特惠',pid,d.get('name',''),'直购RMB',cost,'RMB',f'A_活动商店_activity_shop_data.xml/活动商城!{d["_row"]}; C_充值_pay_data.xml/pay_id={payid}','活动25002；仅现行1806–1808')
    add('每日特惠',pid,d.get('rewards'),f'A_活动商店_activity_shop_data.xml/活动商城!{d["_row"]}')
# period packs
for d in table('R_日周月礼包_period_package_data.xml','礼包'):
    if d.get('server_open_point')!='2' or not d.get('need'): continue
    pid=d['id']; need=pairs(d.get('need')); cost=need[0][1] if need else None
    kind={'1':'日礼包','2':'周礼包','3':'月礼包'}.get(d.get('type'),'礼包')
    product('日周月礼包',pid,kind+'·'+d.get('name',''),'钻石购买',cost,'钻石',f'R_日周月礼包_period_package_data.xml/礼包!{d["_row"]}','开服节点2')
    add('日周月礼包',pid,d.get('rewards'),f'R_日周月礼包_period_package_data.xml/礼包!{d["_row"]}')
# monthly cards
for d in table('Y_月卡_month_card_data.xml','月卡'):
    if d.get('server_open_point')!='9' or d.get('id') not in ('1','3'): continue
    pid=d['id']; payid=intval(d.get('pay_id')); cost=prices[payid]; days=intval(d.get('add_day')) or 30
    product('月卡',pid,d.get('name',''),'直购RMB',cost,'RMB',f'Y_月卡_month_card_data.xml/月卡!{d["_row"]}; C_充值_pay_data.xml/pay_id={payid}',f'按{days}天领取；特权服务另列')
    add('月卡',pid,d.get('reward'),f'Y_月卡_month_card_data.xml/月卡!{d["_row"]}/reward')
    add('月卡',pid,d.get('day_reward'),f'Y_月卡_month_card_data.xml/月卡!{d["_row"]}/day_reward',days)
# weekly pass/card
wd=[d for d in table('Y_月卡_month_card_data.xml','月卡') if d.get('server_open_point')=='9' and d.get('id')=='4'][0]
payid=intval(wd.get('pay_id')); cost=prices[payid]
product('周卡',180005,'签到战令周卡','直购RMB',cost,'RMB',f'Z_周签到战令_week_bp_data.xml/方案配置!7; Y_月卡_month_card_data.xml/月卡!{wd["_row"]}; C_充值_pay_data.xml/pay_id={payid}','只计付费轨；免费轨另列')
for d in table('Z_周签到战令_week_bp_data.xml','周签到奖励配置'):
    if d.get('project_id')=='180005': add('周卡',180005,d.get('pay_gift'),f'Z_周签到战令_week_bp_data.xml/周签到奖励配置!{d["_row"]}')
# battlepass tracks
battle=[d for d in table('Z_战令_common_war_order_data.xml','战令') if d.get('id')=='104'][0]
for label,payid,field in [('28元轨',intval(battle['pay_lv2_id']),'pay_reward_high'),('68元轨',intval(battle['pay_id']),'pay_reward')]:
    cost=prices[payid]
    product('体力战令',label,'体力战令'+label,'直购RMB',cost,'RMB',f'Z_战令_common_war_order_data.xml/战令!{battle["_row"]}; C_充值_pay_data.xml/pay_id={payid}',f'独立商品对应{field}的50级奖励；服务端索引源码确认档位映射，运行服与实际达级发奖未验证')
for d in table('Z_战令_common_war_order_data.xml','战令奖励'):
    if d.get('id')!='104': continue
    add('体力战令','28元轨',d.get('pay_reward_high'),f'Z_战令_common_war_order_data.xml/战令奖励!{d["_row"]}/pay_reward_high')
    add('体力战令','68元轨',d.get('pay_reward'),f'Z_战令_common_war_order_data.xml/战令奖励!{d["_row"]}/pay_reward')
linecols=['模块','商品ID','商品名','奖励ID','道具名','数量','单价钻石','道具价值钻石','价格等级','估值方法','锚价来源','奖励配置来源','未闭合说明']
prodcols=['模块','商品ID','商品名','支付类型','支付数值','支付币种','折钻成本','奖励列表','严格可核价值钻石','条件估值总价值钻石','未定价ID','严格返比','条件返比','状态','商品配置来源','口径备注']
lines=[]; prows=[]
for (cat,pid),p in products.items():
    strict=0; conditional=0; miss=[]
    for iid,num in sorted(p['lines'].items()):
        name=item.get(iid,{}).get('name','')
        if iid in rules:
            price,method,tier,src=rules[iid]; value=price*num; conditional+=value
            if tier=='严格': strict+=value
            status=tier; reason=''
        else:
            price=''; value=''; method='未定价'; tier='缺价'; src=''; status=tier; reason=missing.get(iid,'缺少确认锚价'); miss.append(iid)
        lines.append(dict(模块=cat,商品ID=pid,商品名=p['商品名'],奖励ID=iid,道具名=name,数量=num,单价钻石=price,道具价值钻石=value,价格等级=status,估值方法=method,锚价来源=src,奖励配置来源='; '.join(p['sources'][iid]),未闭合说明=reason))
    has_conditional=any(i in rules and rules[i][2]=='条件' for i in p['lines'])
    if miss: status='未闭合'
    elif has_conditional: status='条件估值'
    else: status='严格核价'
    cost=p['折钻成本']; ratio_strict=''; ratio_cond=''
    if p['支付类型']!='累充门槛RMB' and cost and not miss and not has_conditional:
        ratio_strict=round(strict/cost,6)
    if p['支付类型']!='累充门槛RMB' and cost and not miss:
        ratio_cond=round(conditional/cost,6)
    prows.append(dict(模块=cat,商品ID=pid,商品名=p['商品名'],支付类型=p['支付类型'],支付数值=p['支付数值'],支付币种=p['支付币种'],折钻成本=cost,奖励列表=';'.join(f'{i}×{num:g}' for i,num in sorted(p['lines'].items())),严格可核价值钻石=round(strict,6),条件估值总价值钻石=round(conditional,6),未定价ID=','.join(str(i) for i in miss),严格返比=ratio_strict,条件返比=ratio_cond,状态=status,商品配置来源=p['商品配置来源'],口径备注=p['口径备注']))
for filename,rows,cols in [('commercial_reward_lines.tsv',lines,linecols),('commercial_products.tsv',prows,prodcols)]:
    path=os.path.join(outdir,filename)
    with open(path,'w',encoding='utf-8-sig',newline='') as f:
        w=csv.DictWriter(f,fieldnames=cols,delimiter='\t'); w.writeheader(); w.writerows(rows)
    print(path,len(rows))
print('PRODUCT_STATUS',collections.Counter(p['状态'] for p in prows))
print('UNPRICED_IDS',sorted(set(int(i) for p in prows for i in p['未定价ID'].split(',') if i)))

