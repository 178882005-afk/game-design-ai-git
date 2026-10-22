-- 2026-09-15 至 2026-10-14 完整日，Asia/Shanghai；六档钻石直充的支付 ID。
-- 与 targeted_pay_groups_20261015.sql 使用相同的支付筛选和 order_id 去重口径。
WITH ranked AS (
 SELECT TRIM(CAST(package_name AS STRING)) AS package_id,
        CAST(pay_category AS STRING) AS pay_category,
        TRIM(CAST(order_id AS STRING)) AS order_id,
        TRIM(CAST(chr_id AS STRING)) AS chr_id,
        currency_amount,
        ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY date_time, insert_time) AS rn
 FROM dwd_payment_incr_unique_v4_empty_fh
 WHERE the_date >= '2026-09-15' AND the_date < '2026-10-15'
   AND date_time >= '2026-09-15 00:00:00' AND date_time < '2026-10-15 00:00:00'
   AND platform_name IN ('sy','mix')
   AND channel_name IS NOT NULL AND channel_name <> '' AND channel_name <> '175_97'
   AND currency_amount > 0 AND pay_category IN ('1','4')
   AND TRIM(CAST(package_name AS STRING)) IN ('1000','1001','1003','1004','1005','1006')
)
SELECT package_id, pay_category,
       COUNT(*) AS orders_30d, COUNT(DISTINCT chr_id) AS roles_30d,
       SUM(currency_amount) AS amount_30d
FROM ranked
WHERE rn=1 AND order_id NOT IN ('','0') AND chr_id NOT IN ('','0')
GROUP BY package_id, pay_category
ORDER BY package_id, pay_category
LIMIT 100;
