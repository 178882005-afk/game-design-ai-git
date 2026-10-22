WITH reg_rows AS (
 SELECT TRIM(CAST(chr_id AS STRING)) chr_id,TRIM(CAST(account_id AS STRING)) account_id,
 LOWER(TRIM(platform_name)) platform_name,LOWER(TRIM(channel_name)) channel_name,
 gameserver_no,the_date_time reg_time,
 ROW_NUMBER() OVER(PARTITION BY TRIM(CAST(chr_id AS STRING)) ORDER BY the_date_time) rn
 FROM dwd_chr_v9_fh
 WHERE date_time >= '2026-03-18' AND date_time < '2026-09-16'
 AND the_date_time < '2026-09-16'
), first_reg AS (
 SELECT chr_id,account_id,platform_name,channel_name,gameserver_no,reg_time
 FROM reg_rows WHERE rn=1
), account_first AS (
 SELECT account_id,MIN(reg_time) first_role_time FROM first_reg
 WHERE COALESCE(account_id,'') NOT IN ('','0') GROUP BY account_id
), servers AS (
 SELECT LOWER(TRIM(platform_name)) platform_name,gameserver_no,MIN(open_time) open_time,
 COUNT(DISTINCT CAST(open_time AS STRING)) open_variants FROM product_info_fh
 WHERE LOWER(TRIM(platform_name)) IN ('sy','mix')
 GROUP BY LOWER(TRIM(platform_name)),gameserver_no
), excluded_accounts AS (
 SELECT DISTINCT r.account_id FROM first_reg r JOIN gm_internal_stats_api_fh i
 ON TRIM(CAST(i.chr_id AS STRING))=r.chr_id
 WHERE i.date_time='2026-10-15' AND COALESCE(r.account_id,'') NOT IN ('','0')
 UNION
 SELECT DISTINCT TRIM(CAST(account_id AS STRING)) FROM gm_chxo_operate_logs_fh
 WHERE date_time >= '2026-03-18' AND date_time < '2026-10-15'
 AND COALESCE(TRIM(CAST(account_id AS STRING)),'') NOT IN ('','0')
 UNION
 SELECT DISTINCT r.account_id FROM first_reg r JOIN gm_chxo_operate_logs_fh g
 ON TRIM(CAST(g.chr_id AS STRING))=r.chr_id
 WHERE g.date_time >= '2026-03-18' AND g.date_time < '2026-10-15'
 AND COALESCE(r.account_id,'') NOT IN ('','0')
), eligible AS (
 SELECT r.chr_id,r.account_id,r.reg_time,r.platform_name,r.channel_name,r.gameserver_no,
 CASE WHEN a.first_role_time<r.reg_time THEN '老新增' ELSE '纯新增' END player_type
 FROM first_reg r JOIN servers s ON r.platform_name=s.platform_name AND r.gameserver_no=s.gameserver_no
 JOIN account_first a ON a.account_id=r.account_id
 WHERE r.reg_time >= '2026-07-18' AND r.reg_time < '2026-09-16'
 AND DATE(r.reg_time)=DATE(s.open_time) AND s.open_variants=1
 AND r.platform_name IN ('sy','mix') AND COALESCE(r.channel_name,'') NOT IN ('','175_97')
 AND COALESCE(r.chr_id,'') NOT IN ('','0') AND COALESCE(r.account_id,'') NOT IN ('','0')
 AND NOT EXISTS (SELECT 1 FROM excluded_accounts x WHERE x.account_id=r.account_id)
), pay_rows AS (
 SELECT TRIM(CAST(chr_id AS STRING)) chr_id,TRIM(CAST(order_id AS STRING)) order_id,
 date_time,pay_category,currency_amount,CAST(package_name AS STRING) package_name,
 ROW_NUMBER() OVER(PARTITION BY TRIM(CAST(order_id AS STRING)) ORDER BY date_time,TRIM(CAST(chr_id AS STRING))) rn
 FROM dwd_payment_incr_unique_v4_empty_fh
 WHERE the_date >= '2026-07-18' AND the_date < '2026-09-23'
 AND date_time >= '2026-07-18' AND date_time < '2026-09-23'
), pay_sum AS (
 SELECT e.chr_id,SUM(p.currency_amount) pay_amount FROM eligible e JOIN pay_rows p
 ON p.chr_id=e.chr_id AND p.date_time>=e.reg_time AND p.date_time<DATE_ADD(e.reg_time,INTERVAL 7 DAY)
 WHERE p.rn=1 AND COALESCE(p.order_id,'') NOT IN ('','0')
 AND p.pay_category IN ('1','4') AND p.currency_amount>0
 AND COALESCE(p.package_name,'') NOT IN ('6000','6001','6002','6003','6004','6005','6006','6007','6008','6009','6010','6020','6021','6022','6023','6024','6025','6100','6101','6102','6103','6104','6105','6106','6107','6108','6109','6110')
 GROUP BY e.chr_id
), tiered AS (
 SELECT e.*,COALESCE(p.pay_amount,0) pay_amount,
 CASE WHEN COALESCE(p.pay_amount,0)=0 THEN 1 WHEN p.pay_amount<=10 THEN 2 WHEN p.pay_amount<=60 THEN 3
 WHEN p.pay_amount<=300 THEN 4 WHEN p.pay_amount<=1500 THEN 5 WHEN p.pay_amount<=5000 THEN 6
 WHEN p.pay_amount<=10000 THEN 7 ELSE 8 END r_order
 FROM eligible e LEFT JOIN pay_sum p ON p.chr_id=e.chr_id
)
, stage AS (
 SELECT t.chr_id,MAX(CAST(GET_JSON_STRING(s.info,'$.章节') AS INT)) max_chapter
 FROM tiered t JOIN dwd_join_log_fh s ON TRIM(CAST(s.chr_id AS STRING))=t.chr_id
 WHERE s.date_time >= '2026-07-18' AND s.date_time < '2026-09-23'
 AND s.date_time>=t.reg_time AND s.date_time<DATE_ADD(t.reg_time,INTERVAL 7 DAY)
 AND s.type='主线副本' AND s.name='基础战斗信息' AND s.result=1
 AND COALESCE(GET_JSON_STRING(s.ext,'$.battle_uid'),'')<>''
 AND CAST(GET_JSON_STRING(s.info,'$.章节') AS INT) BETWEEN 1 AND 400
 GROUP BY t.chr_id
), levels AS (
 SELECT t.chr_id,MAX(CAST(l.chr_level AS INT)) max_level
 FROM tiered t JOIN dwd_level_up_fh l ON TRIM(CAST(l.chr_id AS STRING))=t.chr_id
 WHERE l.date_time >= '2026-07-18' AND l.date_time < '2026-09-23'
 AND l.date_time>=t.reg_time AND l.date_time<DATE_ADD(t.reg_time,INTERVAL 7 DAY)
 GROUP BY t.chr_id
), ranked AS (
 SELECT t.*,COALESCE(s.max_chapter,0) max_chapter,COALESCE(l.max_level,1) max_level,
 ROW_NUMBER() OVER(PARTITION BY t.player_type,t.r_order
 ORDER BY COALESCE(s.max_chapter,0) DESC,COALESCE(l.max_level,1) DESC,t.chr_id) progress_rank,
 COUNT(*) OVER(PARTITION BY t.player_type,t.r_order) group_n
 FROM tiered t LEFT JOIN stage s ON s.chr_id=t.chr_id
 LEFT JOIN levels l ON l.chr_id=t.chr_id
), selected AS (
 SELECT * FROM ranked WHERE progress_rank<=CEIL(group_n*0.1)
), gear_parts AS (SELECT s.chr_id,v.item_id,MIN(CASE WHEN get_json_int(v.ext,'$.升级前')<10 AND get_json_int(v.ext,'$.升级后')>=10 THEN v.date_time END) t10,MIN(CASE WHEN get_json_int(v.ext,'$.升级前')<50 AND get_json_int(v.ext,'$.升级后')>=50 THEN v.date_time END) t50 FROM selected s JOIN dwd_virtual_items_fh v ON TRIM(CAST(v.chr_id AS STRING))=s.chr_id WHERE s.r_order>=2 AND v.date_time>='2026-07-18' AND v.date_time<'2026-09-23' AND v.date_time>=s.reg_time AND v.date_time<DATE_ADD(s.reg_time,INTERVAL 7 DAY) AND v.type_name='主角装备升级' AND v.item_id BETWEEN 50003 AND 50008 GROUP BY s.chr_id,v.item_id), milestone AS (SELECT chr_id,'任一装备强化10' milestone,MIN(t10) first_ts FROM gear_parts GROUP BY chr_id HAVING MIN(t10) IS NOT NULL UNION ALL SELECT chr_id,'六部位强化10',MAX(t10) FROM gear_parts GROUP BY chr_id HAVING COUNT(DISTINCT CASE WHEN t10 IS NOT NULL THEN item_id END)=6 UNION ALL SELECT chr_id,'任一装备强化50',MIN(t50) FROM gear_parts GROUP BY chr_id HAVING MIN(t50) IS NOT NULL UNION ALL SELECT chr_id,'六部位强化50',MAX(t50) FROM gear_parts GROUP BY chr_id HAVING COUNT(DISTINCT CASE WHEN t50 IS NOT NULL THEN item_id END)=6), events AS (SELECT s.player_type,s.r_order,s.chr_id,s.group_n,s.reg_time,m.milestone,m.first_ts FROM milestone m JOIN selected s ON s.chr_id=m.chr_id WHERE m.first_ts IS NOT NULL), ranked_events AS (SELECT *,ROW_NUMBER() OVER(PARTITION BY player_type,r_order,milestone ORDER BY TIMESTAMPDIFF(SECOND,reg_time,first_ts),chr_id) reach_rank FROM events) SELECT player_type,r_order,milestone,MAX(group_n) layer_n,COUNT(*) reached_n,MAX(CASE WHEN reach_rank=CEIL(CEIL(group_n*0.1)*0.5) THEN CAST(FLOOR(TIMESTAMPDIFF(SECOND,reg_time,first_ts)/86400)+1 AS INT) END) cohort_half_day FROM ranked_events GROUP BY player_type,r_order,milestone ORDER BY player_type,r_order,milestone LIMIT 140
