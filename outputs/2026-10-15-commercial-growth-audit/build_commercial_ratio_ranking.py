"""Build within-currency nominal value rankings from the current scope ledger."""

from __future__ import annotations

import csv
from collections import defaultdict
from pathlib import Path


HERE = Path(__file__).resolve().parent
SOURCE = HERE / "final_commercial_scope.tsv"
TSV = HERE / "commercial_ratio_ranking.tsv"
NOTE = HERE / "commercial_ratio_ranking_note.md"
CURRENCY_ORDER = ["元", "钻", "金币"]

with SOURCE.open(encoding="utf-8-sig", newline="") as handle:
    rows = list(csv.DictReader(handle, delimiter="\t"))

groups = defaultdict(list)
for row in rows:
    if row["完整名义返比"]:
        groups[row["币种"]].append(row)

assert sum(map(len, groups.values())) == 411
assert set(groups) == set(CURRENCY_ORDER)

fields = [
    "同币种名次", "币种", "范围层级", "模块", "商品/档位", "商品键", "付款方式",
    "标价", "完整奖励价值_钻", "完整名义返比", "核价状态", "开放/触发条件",
    "购买/池条件", "配置来源", "估值来源", "备注",
]
ranked = []
for currency in CURRENCY_ORDER:
    current = sorted(
        groups[currency],
        key=lambda row: (-float(row["完整名义返比"]), row["商品键"]),
    )
    for number, row in enumerate(current, 1):
        ranked.append({"同币种名次": number, **{field: row.get(field, "") for field in fields[1:]}})

with TSV.open("w", encoding="utf-8-sig", newline="") as handle:
    writer = csv.DictWriter(handle, fieldnames=fields, delimiter="\t", extrasaction="ignore")
    writer.writeheader()
    writer.writerows(ranked)


def md_cell(value: str) -> str:
    return str(value).replace("|", "／").replace("\n", " ")


parts = [
    "# 现行商品内部名义返比：按付款媒介阅读",
    "",
    "基准为 2026-10-15 的[全商品候选账](final_commercial_scope.tsv)。只有奖励**全部有直接或明确条件锚**，且付款成本可折钻的记录才进入本榜；"
    "逐条条件与来源见[411 条同币种排序明细](commercial_ratio_ranking.tsv)。当前排序包含 **46 条人民币、221 条钻石、144 条金币**记录。"
    "活动兑换、玩法代币、免费领取和 6 档直充首购／复购另列，不能把空白返比当零。",
    "",
    "`返比＝完整奖励规划名义钻价÷支付折钻成本`。人民币按用户确认的 **1 元＝10 钻**；金币按最新 6-1 的 **1 金币＝0.05 钻**。"
    "三种付款媒介各自排序，现金卡／战令的未来领取也必须达成条件。此值用于控制礼包配方，不能当利润率、玩家个人收益或实际购买转化率。",
    "",
]

for currency, limit in (("元", 8), ("钻", 8)):
    current = [row for row in ranked if row["币种"] == currency][:limit]
    parts += [f"## {currency}支付：前 {limit} 条配置候选", "", "| 排名 | 商品／档位 | 价格 | 奖励名义价值 | 内部返比 | 关键条件 |", "|---:|---|---:|---:|---:|---|"]
    for row in current:
        condition = row["核价状态"]
        product = row["商品/档位"]
        display = product if product.startswith(row["模块"]) else f"{row['模块']}·{product}"
        parts.append(
            f"| {row['同币种名次']} | {md_cell(display)} | "
            f"{row['标价']}{currency} | {float(row['完整奖励价值_钻']):,.0f} 钻 | "
            f"**{float(row['完整名义返比']):.2f} 倍** | {md_cell(condition)} |"
        )
    parts.append("")

parts += [
    "## 金币支付：看格位，不按现金礼包比较",
    "",
    "金币支付的 144 条均为随机商店池项，需要刷新抽中。当前同币种最高名义返比为 **0.60 倍**；"
    "例如 1000 金币换 10 张部位图纸，按 3 钻／张的规划锚是 30 钻奖励，金币按 0.05 钻／枚折为 50 钻成本。"
    "这说明在**规划锚口径**下该格位售价高于奖励基础价；金币实际机会成本和玩家短缺需求仍要另看。",
    "",
    "现金榜中体力战令需达到 50 级并领完付费轨，月卡需连续领取；活动券使用当期期次替代价，随机箱用对应池期望。"
    "钻石榜的多条章节礼包包含 `50026` 与通用图纸箱等效的条件假设；该等效性仍待消费路径核查。"
    "因此榜单提供**配方核价顺序**，投放优先级还须结合可见玩家、资源瓶颈、实际购买和对养成节点的提前日。"
    "旧券、过期池和服务端索引整模块停用的礼包已从本榜分母隔离。",
    "",
]
NOTE.write_text("\n".join(parts), encoding="utf-8")
print(f"ranked {len(ranked)}; currencies " + ", ".join(f"{k}={len(groups[k])}" for k in CURRENCY_ORDER))
