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
   AND COALESCE(CAST(package_name AS STRING),'') NOT IN ('6000','6001','6002','6003','6004','6005','6006','6007','6008','6009','6010','6020','6021','6022','6023','6024','6025','6100','6101','6102','6103','6104','6105','6106','6107','6108','6109','6110')
), valid AS (
 SELECT package_id,pay_category,order_id,chr_id,currency_amount,date_time
 FROM ranked WHERE rn=1 AND order_id NOT IN ('','0') AND chr_id NOT IN ('','0') AND package_id IS NOT NULL AND package_id<>''
), agg AS (
 SELECT package_id,pay_category,
        COUNT(*) AS orders_30d, COUNT(DISTINCT chr_id) AS roles_30d, SUM(currency_amount) AS amount_30d,
        SUM(CASE WHEN date_time >= '2026-10-14 00:00:00' THEN 1 ELSE 0 END) AS orders_d14,
        COUNT(DISTINCT CASE WHEN date_time >= '2026-10-14 00:00:00' THEN chr_id ELSE NULL END) AS roles_d14,
        SUM(CASE WHEN date_time >= '2026-10-14 00:00:00' THEN currency_amount ELSE 0 END) AS amount_d14
 FROM valid GROUP BY package_id,pay_category
), cfg AS (
 SELECT name,MAX(alias) AS current_alias,COUNT(DISTINCT alias) AS alias_count
 FROM gm_im_pay_package_fh GROUP BY name
)
SELECT a.*,c.current_alias,c.alias_count FROM agg a LEFT JOIN cfg c ON a.package_id=c.name
WHERE a.package_id IN ('300','301','302','303','304','305','306','307','308','309','310','311','312','313','71015','71016','71017','71018','71019','71020','71021','71022','71023','71024','71025','71026','71027','71028','40001','40002','40003','40004','40005','40006','40007','40008','40009','40101','40402','40403','40201','40202','40301','40302','92000','92001','92002','92003','92004','92005','92006','92007','92008','92009','2010004','2010005','2010006','1310037','1310038','1310039','1310019','1310020','1310021','1910001','1910002','1910004','2012001','2012002','2012003','1610008','1610010')
ORDER BY a.package_id,a.pay_category LIMIT 1000
