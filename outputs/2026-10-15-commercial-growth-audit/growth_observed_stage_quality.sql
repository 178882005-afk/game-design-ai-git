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
)
SELECT COUNT(*) win_rows,COUNT(DISTINCT e.chr_id) win_roles,
SUM(CASE WHEN COALESCE(GET_JSON_STRING(s.ext,'$.battle_uid'),'')='' THEN 1 ELSE 0 END) missing_bid_rows,
SUM(CASE WHEN CAST(GET_JSON_STRING(s.info,'$.章节') AS INT) NOT BETWEEN 1 AND 400 OR GET_JSON_STRING(s.info,'$.章节') IS NULL THEN 1 ELSE 0 END) invalid_chapter_rows,
MIN(s.date_time) first_win,MAX(s.date_time) last_win
FROM e JOIN dwd_join_log_fh s ON TRIM(CAST(s.chr_id AS STRING))=e.chr_id
WHERE s.date_time>='2026-09-24' AND s.date_time<'2026-10-15'
AND s.date_time>=e.reg_time AND s.date_time<DATE_ADD(e.reg_time,INTERVAL 14 DAY)
AND s.type='主线副本' AND s.name='基础战斗信息' AND s.result=1
