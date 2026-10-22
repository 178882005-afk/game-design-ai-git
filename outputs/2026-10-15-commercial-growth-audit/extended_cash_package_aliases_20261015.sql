SELECT name, MAX(alias) AS current_alias, COUNT(DISTINCT alias) AS alias_count
FROM gm_im_pay_package_fh
WHERE name IN ('1000','1001','1003','1004','1005','1006','40101','40402','40403')
GROUP BY name
ORDER BY name
LIMIT 20;
