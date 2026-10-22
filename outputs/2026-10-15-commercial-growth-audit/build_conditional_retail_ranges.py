"""Find single-item diamond offer prices without treating them as global item anchors."""

from __future__ import annotations

import csv
from collections import defaultdict
from decimal import Decimal, InvalidOperation
from pathlib import Path

DIRECTORY = Path(__file__).parent
SOURCE = DIRECTORY / "final_commercial_scope.tsv"
TARGET = DIRECTORY / "conditional_retail_ranges.tsv"
FIELDS = ["奖励ID", "最低钻石零售价_每单位", "最高钻石零售价_每单位", "候选报价行数", "模块", "最低价商品键", "最高价商品键", "口径"]


def quote(row):
    if row["币种"] != "钻" or row["付款方式"] != "钻石":
        return None
    rewards = row["奖励ID×数量"].split(";")
    if len(rewards) != 1 or "×" not in rewards[0]:
        return None
    item, quantity = rewards[0].split("×", 1)
    if not item.isdigit():
        return None
    try:
        price = Decimal(row["标价"])
        qty = Decimal(quantity)
    except InvalidOperation:
        return None
    if price <= 0 or qty <= 0:
        return None
    return item, price / qty


with SOURCE.open(encoding="utf-8-sig", newline="") as file:
    source_rows = list(csv.DictReader(file, delimiter="\t"))

prices = defaultdict(list)
for row in source_rows:
    result = quote(row)
    if result:
        item, unit = result
        prices[item].append((unit, row))

with TARGET.open("w", encoding="utf-8-sig", newline="") as file:
    writer = csv.writer(file, delimiter="\t")
    writer.writerow(FIELDS)
    for item, offers in sorted(prices.items(), key=lambda pair: int(pair[0])):
        lo = min(offers, key=lambda pair: pair[0])
        hi = max(offers, key=lambda pair: pair[0])
        writer.writerow([
            item, str(lo[0]), str(hi[0]), len(offers),
            ";".join(sorted({row["模块"] for _, row in offers})),
            lo[1]["商品键"], hi[1]["商品键"],
            "配置可达的单奖励钻石报价；限该格位/期次；非全局道具锚、非实际成交价",
        ])
print(f"{TARGET.name}: {len(prices)} reward IDs")
