# 指定商业化 pay_id 近 30 日支付核对

- 查询时间：2026-10-15 13:16（Asia/Shanghai）；StarRocks 产品 `fh`，只读查询返回 40 行，`truncated=false`。
- SQL：[`targeted_pay_groups_20261015.sql`](targeted_pay_groups_20261015.sql)；结果：[`targeted_pay_groups_result.tsv`](targeted_pay_groups_result.tsv)。查询表为 `dwd_payment_incr_unique_v4_empty_fh` 与 `gm_im_pay_package_fh`。
- 本地 SQL guard：`PASS`；SHA-256 `ee8646dcf38514b89f416b1eb912aa5888079a28a87f1509c80f73fdf09270ee`；服务端继续限制 SELECT 与分区 EXPLAIN。
- 近 30 个完整日为 `[2026-09-15 00:00:00, 2026-10-15 00:00:00)`；单日为 2026-10-14，均为 Asia/Shanghai。筛 `platform_name IN ('sy','mix')`、非空渠道且排除 `175_97`、`currency_amount>0`、`pay_category IN ('1','4')`，排除代金券购入包 ID，要求非空有效订单与角色，按 `order_id` 首条去重。
- `pay_category=1` 金额为直充人民币；`pay_category=4` 为代金券消费等值金额，不是人民币实收。两类订单数可相加，各类去重角色数不能直接相加。
- `current_alias` 来自当前 `gm_im_pay_package_fh`，并非交易时版本的商品名或价格；空白不代表该 ID 不存在。原始 pay ID 不包含活动方案，因此 `1610008`、`1610010` 的支付不能仅凭此查询归因到活动战令；15 个当前新服礼包引用的 pay ID 有订单，也不能归因为当前 SKU 销量。`2010004–6` 被活动商城 base_id `21029/21037` 共用，`1310019–21` 被 `21022/21901` 共用，部分 base_id 还有旧服期次。必须再连角色开服日、活动参与／领取及交易时 SKU。
- 查询范围内，新手礼包 `300–313`、七日直购 `71015–71028`、职业礼包 `92000–92009` 无符合条件记录。16 个基金 pay ID 仅 `40101`、`40402`、`40403` 有记录，其余 `40001–40009`、`40201–40202`、`40301–40302` 无符合条件记录。
- 未做退款/冲正净额、最早建角平台与渠道锁定、内部号排除、交易时版本还原；此表仅供商业化玩家行为校准，不等同财务结算。无记录只针对上述时间、平台、渠道及支付类型，不能判定商品从未上架或从未购买。
