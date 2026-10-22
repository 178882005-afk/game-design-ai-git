WITH all_reg AS (
 SELECT TRIM(CAST(chr_id AS STRING)) chr_id,TRIM(CAST(account_id AS STRING)) account_id,
 LOWER(TRIM(platform_name)) platform_name,LOWER(TRIM(channel_name)) channel_name,gameserver_no,the_date_time reg_time,
 DENSE_RANK() OVER(PARTITION BY TRIM(CAST(chr_id AS STRING)) ORDER BY the_date_time) rk
 FROM dwd_chr_v9_fh WHERE date_time >= '2020-01-01' AND date_time < '2026-10-01'
 AND the_date_time < '2026-10-01 00:00:00'
),first_reg AS (
 SELECT chr_id,MIN(account_id) account_id,MIN(platform_name) platform_name,MIN(channel_name) channel_name,
 MIN(gameserver_no) gameserver_no,MIN(reg_time) reg_time,
 COUNT(DISTINCT CONCAT(COALESCE(account_id,''),'|',COALESCE(platform_name,''),'|',COALESCE(channel_name,''))) variants
 FROM all_reg WHERE rk=1 GROUP BY chr_id
),sr AS (
 SELECT gameserver_no, MIN(open_time) open_time FROM product_info_fh
 WHERE product_name='fh' AND platform_name='wxmjhwd' AND channel_name='355_1' AND gameserver_no BETWEEN 1 AND 6
 GROUP BY gameserver_no
),c AS (
 SELECT r.* FROM first_reg r JOIN sr ON r.gameserver_no=sr.gameserver_no
 WHERE r.platform_name='wxmjhwd' AND r.channel_name='355_1'
 AND r.reg_time>=sr.open_time AND r.reg_time<DATE_ADD(sr.open_time,INTERVAL 1 DAY)
 AND r.variants=1 AND COALESCE(r.chr_id,'') NOT IN ('','0')
 AND COALESCE(r.account_id,'') NOT IN ('','0')
), e AS (
 SELECT c.* FROM c WHERE NOT EXISTS(
 SELECT 1 FROM gm_internal_stats_api_fh i WHERE i.date_time='2026-10-15' AND TRIM(CAST(i.chr_id AS STRING))=c.chr_id)
 AND NOT EXISTS(SELECT 1 FROM gm_chxo_operate_logs_fh g WHERE g.date_time >= '2020-01-01' AND g.date_time < '2026-10-15' AND TRIM(CAST(g.chr_id AS STRING))=c.chr_id)
),pay_raw AS (
 SELECT TRIM(CAST(p.chr_id AS STRING)) chr_id,TRIM(CAST(p.order_id AS STRING)) order_id,
 p.date_time,p.currency_amount,CAST(p.package_name AS STRING) package_name,p.pay_category,
 ROW_NUMBER() OVER(PARTITION BY p.order_id ORDER BY p.date_time,p.insert_time) rn
 FROM dwd_payment_incr_unique_v4_empty_fh p
 WHERE p.the_date >= '2026-09-24' AND p.the_date < '2026-10-15'
 AND p.date_time >= '2026-09-24' AND p.date_time < '2026-10-15'
),pay_sum AS (
 SELECT e.chr_id,SUM(p.currency_amount) amount14 FROM pay_raw p JOIN e ON p.chr_id=e.chr_id
 WHERE p.rn=1 AND p.date_time>=e.reg_time AND p.date_time<DATE_ADD(e.reg_time,INTERVAL 14 DAY)
 AND COALESCE(p.order_id,'') NOT IN ('','0') AND p.currency_amount>0 AND p.pay_category IN ('1','4')
 AND COALESCE(p.package_name,'') NOT IN ('6000','6001','6002','6003','6004','6005','6006','6007','6008','6009','6010','6020','6021','6022','6023','6024','6025','6100','6101','6102','6103','6104','6105','6106','6107','6108','6109','6110')
 GROUP BY e.chr_id
),g AS (
 SELECT e.chr_id,e.gameserver_no,e.reg_time,COALESCE(p.amount14,0) amount14,
 CASE WHEN COALESCE(p.amount14,0)=0 THEN 'D14非R'
 WHEN p.amount14<=60 THEN 'D14累付(0,60]'
 WHEN p.amount14<=300 THEN 'D14累付(60,300]'
 ELSE 'D14累付>300' END pay_group
 FROM e LEFT JOIN pay_sum p ON p.chr_id=e.chr_id
),
stage_raw AS (
 SELECT g.chr_id,s.date_time,CAST(GET_JSON_STRING(s.info,'$.章节') AS INT) chapter
 FROM g JOIN dwd_join_log_fh s ON TRIM(CAST(s.chr_id AS STRING))=g.chr_id
 WHERE s.date_time >= '2026-09-24' AND s.date_time < '2026-10-15'
 AND s.date_time>=g.reg_time AND s.date_time<DATE_ADD(g.reg_time,INTERVAL 14 DAY)
 AND s.type='主线副本' AND s.name='基础战斗信息' AND s.result=1
 AND CAST(GET_JSON_STRING(s.info,'$.章节') AS INT) BETWEEN 1 AND 400
 AND COALESCE(GET_JSON_STRING(s.ext,'$.battle_uid'),'')<>''
),hits AS (
 SELECT chr_id,MIN(CASE WHEN chapter>=10 THEN date_time END) t10,
 MIN(CASE WHEN chapter>=40 THEN date_time END) t40,
 MIN(CASE WHEN chapter>=57 THEN date_time END) t57
 FROM stage_raw GROUP BY chr_id
),milestones AS (
 SELECT g.pay_group,g.chr_id,g.reg_time,'主线10关' milestone,h.t10 hit_time FROM g LEFT JOIN hits h ON h.chr_id=g.chr_id
 UNION ALL SELECT g.pay_group,g.chr_id,g.reg_time,'主线40关',h.t40 FROM g LEFT JOIN hits h ON h.chr_id=g.chr_id
 UNION ALL SELECT g.pay_group,g.chr_id,g.reg_time,'主线57关',h.t57 FROM g LEFT JOIN hits h ON h.chr_id=g.chr_id
)
SELECT pay_group,milestone, CASE WHEN hit_time IS NULL THEN 0 ELSE CAST(FLOOR(TIMESTAMPDIFF(SECOND,reg_time,hit_time)/86400)+1 AS INT) END life_day,
COUNT(*) roles FROM milestones GROUP BY pay_group,milestone,life_day ORDER BY pay_group,milestone,life_day LIMIT 1000
