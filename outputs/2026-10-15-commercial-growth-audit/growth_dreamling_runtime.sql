WITH all_reg AS (
 SELECT TRIM(CAST(chr_id AS STRING)) chr_id,TRIM(CAST(account_id AS STRING)) account_id,
 LOWER(TRIM(platform_name)) platform_name,LOWER(TRIM(channel_name)) channel_name,
 gameserver_no,the_date_time reg_time,
 DENSE_RANK() OVER(PARTITION BY TRIM(CAST(chr_id AS STRING)) ORDER BY the_date_time) rk
 FROM dwd_chr_v9_fh WHERE date_time >= '2020-01-01' AND date_time < '2026-10-01'
 AND the_date_time < '2026-10-01 00:00:00'
), first_reg AS (
 SELECT chr_id,MIN(account_id) account_id,MIN(platform_name) platform_name,
 MIN(channel_name) channel_name,MIN(gameserver_no) gameserver_no,
 MIN(reg_time) reg_time,
 COUNT(DISTINCT CONCAT(COALESCE(account_id,''),'|',COALESCE(platform_name,''),'|',COALESCE(channel_name,''))) variants
 FROM all_reg WHERE rk=1 GROUP BY chr_id
), sr AS (
 SELECT gameserver_no,MIN(open_time) open_time FROM product_info_fh
 WHERE product_name='fh' AND platform_name='wxmjhwd' AND channel_name='355_1'
 AND gameserver_no BETWEEN 1 AND 6 GROUP BY gameserver_no
), c AS (
 SELECT r.* FROM first_reg r JOIN sr ON r.gameserver_no=sr.gameserver_no
 WHERE r.platform_name='wxmjhwd' AND r.channel_name='355_1'
 AND r.reg_time>=sr.open_time AND r.reg_time<DATE_ADD(sr.open_time,INTERVAL 1 DAY)
 AND r.variants=1 AND COALESCE(r.chr_id,'') NOT IN ('','0')
 AND COALESCE(r.account_id,'') NOT IN ('','0')
), e AS (
 SELECT c.* FROM c WHERE NOT EXISTS(
 SELECT 1 FROM gm_internal_stats_api_fh i WHERE i.date_time='2026-10-15'
 AND TRIM(CAST(i.chr_id AS STRING))=c.chr_id)
 AND NOT EXISTS(
 SELECT 1 FROM gm_chxo_operate_logs_fh g WHERE g.date_time >= '2020-01-01'
 AND g.date_time < '2026-10-15' AND TRIM(CAST(g.chr_id AS STRING))=c.chr_id)
), targets AS (
 SELECT '任一梦灵' AS target,0 AS unit_id,10 AS lv
 UNION ALL SELECT '任一梦灵',0,30
 UNION ALL SELECT '任一橙梦灵',-5,10
 UNION ALL SELECT '任一橙梦灵',-5,30
 UNION ALL SELECT '关羽',1110100,10
 UNION ALL SELECT '关羽',1110100,30
 UNION ALL SELECT '吟游诗人',1230100,10
 UNION ALL SELECT '吟游诗人',1230100,30
), reached AS (
 SELECT p.chr_id,t.target,t.lv,MIN(p.date_time) first_ts
 FROM dwd_pet_fh p JOIN e ON TRIM(CAST(p.chr_id AS STRING))=e.chr_id
 JOIN targets t ON get_json_int(p.old_pet,'$.等级')<t.lv
 AND get_json_int(p.new_pet,'$.等级')>=t.lv
 AND (t.unit_id=0 OR p.pet_id=t.unit_id OR (t.unit_id=-5 AND p.pet_id IN (1110100,1130100,1530100,1210300,1140100,1430700,1140200)))
 WHERE p.date_time >= '2026-09-24' AND p.date_time < '2026-10-15'
 AND p.event='梦灵升级' AND p.date_time>=e.reg_time
 AND p.date_time<DATE_ADD(e.reg_time,INTERVAL 14 DAY)
 GROUP BY p.chr_id,t.target,t.lv
), per_role AS (
 SELECT t.target,t.lv,e.chr_id,
 CASE WHEN r.first_ts IS NULL THEN 0
 ELSE CAST(FLOOR(TIMESTAMPDIFF(SECOND,e.reg_time,r.first_ts)/86400)+1 AS INT)
 END AS life_day
 FROM e CROSS JOIN targets t
 LEFT JOIN reached r ON r.chr_id=e.chr_id AND r.target=t.target AND r.lv=t.lv
)
SELECT target,lv,life_day,COUNT(*) roles_n FROM per_role
GROUP BY target,lv,life_day ORDER BY target,lv,life_day;

