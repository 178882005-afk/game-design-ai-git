-- StarRocks read-only coverage probe, product_name=fh through the connected query tool.
-- Window: 2026-10-01 00:00:00 <= date_time < 2026-10-15 00:00:00.
-- Counts show whether each table has records in this window; they do not prove event completeness.
SELECT '道具流水' AS source, COUNT(*) AS rows_n, COUNT(DISTINCT chr_id) AS roles_n FROM dwd_virtual_items_fh WHERE date_time >= '2026-10-01 00:00:00' AND date_time < '2026-10-15 00:00:00'
UNION ALL SELECT '主线与玩法', COUNT(*), COUNT(DISTINCT chr_id) FROM dwd_join_log_fh WHERE date_time >= '2026-10-01 00:00:00' AND date_time < '2026-10-15 00:00:00'
UNION ALL SELECT '伙伴', COUNT(*), COUNT(DISTINCT chr_id) FROM dwd_pet_fh WHERE date_time >= '2026-10-01 00:00:00' AND date_time < '2026-10-15 00:00:00'
UNION ALL SELECT '自定义事件', COUNT(*), COUNT(DISTINCT chr_id) FROM dwd_custom_event_fh WHERE date_time >= '2026-10-01 00:00:00' AND date_time < '2026-10-15 00:00:00'
UNION ALL SELECT '商店', COUNT(*), COUNT(DISTINCT chr_id) FROM dwd_shop_fh WHERE date_time >= '2026-10-01 00:00:00' AND date_time < '2026-10-15 00:00:00'
UNION ALL SELECT '装备', COUNT(*), COUNT(DISTINCT chr_id) FROM dwd_equipment_fh WHERE date_time >= '2026-10-01 00:00:00' AND date_time < '2026-10-15 00:00:00'
UNION ALL SELECT '等级', COUNT(*), COUNT(DISTINCT chr_id) FROM dwd_level_up_fh WHERE date_time >= '2026-10-01 00:00:00' AND date_time < '2026-10-15 00:00:00'
UNION ALL SELECT '经验', COUNT(*), COUNT(DISTINCT chr_id) FROM dwd_experience_fh WHERE date_time >= '2026-10-01 00:00:00' AND date_time < '2026-10-15 00:00:00'
UNION ALL SELECT '货币', COUNT(*), COUNT(DISTINCT chr_id) FROM dwd_virtual_currency_fh WHERE date_time >= '2026-10-01 00:00:00' AND date_time < '2026-10-15 00:00:00'
UNION ALL SELECT '战力', COUNT(*), COUNT(DISTINCT chr_id) FROM dwd_combat_eff_fh WHERE date_time >= '2026-10-01 00:00:00' AND date_time < '2026-10-15 00:00:00'
UNION ALL SELECT '角色属性', COUNT(*), COUNT(DISTINCT chr_id) FROM dwd_users_fh WHERE date_time >= '2026-10-01 00:00:00' AND date_time < '2026-10-15 00:00:00';
