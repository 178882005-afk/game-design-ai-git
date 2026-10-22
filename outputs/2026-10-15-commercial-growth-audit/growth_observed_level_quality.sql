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
),
d AS (
 SELECT e.chr_id,MAX(v.chr_level) max_login_level
 FROM e JOIN dwd_login_pers_view_fh v ON TRIM(CAST(v.chr_id AS STRING))=e.chr_id
 WHERE v.date_time >= '2026-09-24' AND v.date_time < '2026-10-15'
 GROUP BY e.chr_id
),u AS (
 SELECT e.chr_id,MAX(v.chr_level) max_up_level
 FROM e JOIN dwd_level_up_fh v ON TRIM(CAST(v.chr_id AS STRING))=e.chr_id
 WHERE v.date_time >= '2026-09-24' AND v.date_time < '2026-10-15'
 AND v.date_time>=e.reg_time
 GROUP BY e.chr_id
)
SELECT COUNT(*) n,COUNT(d.chr_id) login_daily_roles,COUNT(u.chr_id) level_log_roles,
SUM(CASE WHEN d.max_login_level>=11 THEN 1 ELSE 0 END) login_level11,
SUM(CASE WHEN u.max_up_level>=11 THEN 1 ELSE 0 END) log_level11,
SUM(CASE WHEN d.max_login_level>=11 AND COALESCE(u.max_up_level,0)<11 THEN 1 ELSE 0 END) missing11,
SUM(CASE WHEN d.max_login_level>=30 THEN 1 ELSE 0 END) login_level30,
SUM(CASE WHEN u.max_up_level>=30 THEN 1 ELSE 0 END) log_level30,
SUM(CASE WHEN d.max_login_level>=30 AND COALESCE(u.max_up_level,0)<30 THEN 1 ELSE 0 END) missing30,
SUM(CASE WHEN d.max_login_level>=42 THEN 1 ELSE 0 END) login_level42,
SUM(CASE WHEN u.max_up_level>=42 THEN 1 ELSE 0 END) log_level42,
SUM(CASE WHEN d.max_login_level>=42 AND COALESCE(u.max_up_level,0)<42 THEN 1 ELSE 0 END) missing42
FROM e LEFT JOIN d ON d.chr_id=e.chr_id LEFT JOIN u ON u.chr_id=e.chr_id
