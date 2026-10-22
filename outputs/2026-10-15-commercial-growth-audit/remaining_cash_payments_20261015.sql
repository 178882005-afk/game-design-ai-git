WITH ranked AS (
 SELECT TRIM(CAST(package_name AS STRING)) AS package_id, CAST(pay_category AS STRING) AS pay_category,
        TRIM(CAST(order_id AS STRING)) AS order_id, TRIM(CAST(chr_id AS STRING)) AS chr_id,
        currency_amount, date_time,
        ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY date_time, insert_time) AS rn
 FROM dwd_payment_incr_unique_v4_empty_fh
 WHERE the_date >= '2026-09-15' AND the_date < '2026-10-15'
   AND date_time >= '2026-09-15 00:00:00' AND date_time < '2026-10-15 00:00:00'
   AND platform_name IN ('sy','mix') AND channel_name IS NOT NULL AND channel_name <> '' AND channel_name <> '175_97'
   AND currency_amount > 0 AND pay_category IN ('1','4')
   AND TRIM(CAST(package_name AS STRING)) IN ('101','102','121','122','203','206','209','212','215','1410004','1410005','1410006','1810001','1810002','1810003','1910011','1910012','1910014','2010001','2010002','2010003','2010007','2010008','2010009','2013101','2013102','2013103','2013104')
), valid AS (
 SELECT package_id,pay_category,order_id,chr_id,currency_amount,date_time FROM ranked
 WHERE rn=1 AND order_id NOT IN ('','0') AND chr_id NOT IN ('','0')
), agg AS (
 SELECT package_id,pay_category,COUNT(*) AS orders_30d,COUNT(DISTINCT chr_id) AS roles_30d,
 SUM(currency_amount) AS amount_30d,
 SUM(CASE WHEN date_time >= '2026-10-14 00:00:00' THEN 1 ELSE 0 END) AS orders_d14
 FROM valid GROUP BY package_id,pay_category
), cfg AS (
 SELECT name,MAX(alias) AS current_alias,COUNT(DISTINCT alias) AS alias_count
 FROM gm_im_pay_package_fh GROUP BY name
)
SELECT a.*,c.current_alias,c.alias_count FROM agg a LEFT JOIN cfg c ON a.package_id=c.name
ORDER BY a.package_id,a.pay_category LIMIT 100
