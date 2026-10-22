"""Calculate selected static upgrade costs from the pristine local trunk XML snapshot.

These are configuration costs, not server-day completion estimates.
"""

import collections
import re
from pathlib import Path

from growth_source_probe import rows_from_spreadsheetml


ROOT = Path(r"E:\x1\配置\trunk\xml_gy\normal")


def records(filename, sheet):
    rows = list(rows_from_spreadsheetml(ROOT / filename, sheet))
    header = rows[1][1]
    return [
        {"_row": rowno, **{name: cells.get(col, "") for col, name in header.items() if name}}
        for rowno, cells in rows[2:]
        if cells
    ]


def pairs(raw):
    return [(int(item), float(qty)) for item, qty in re.findall(r"\{\s*(\d+)\s*,\s*([0-9.]+)\s*\}", raw)]


cards = collections.defaultdict(dict)
for row in records("D_单位_unit_data.xml", "卡牌升级"):
    if row.get("quality", "").isdigit() and row.get("level", "").isdigit():
        cards[int(row["quality"])][int(row["level"])] = row
print("CARD quality, target, exp, shards, last_row")
for q, levels in sorted(cards.items()):
    for target in (5, 10, 20, 30, 40, 50):
        if not all(level in levels for level in range(2, target + 1)):
            continue
        exp = sum(int(float(levels[level]["exp_count"])) for level in range(2, target + 1))
        shards = sum(int(float(levels[level]["piece_count"])) for level in range(2, target + 1))
        print(q, target, exp, shards, levels[target]["_row"])
print("CARD row_counts", {q: (min(levels), max(levels), len(levels)) for q, levels in cards.items()})

equip = collections.defaultdict(dict)
for row in records("D_队长装备_captain_equip_data.xml", "强化等级"):
    if row.get("lev", "").isdigit():
        equip[row["position"]][int(row["lev"])] = row
print("EQUIP position, target, paper_id, paper_qty, gold_qty, last_row")
for part, levels in equip.items():
    for target in (1, 10, 20, 50, 100):
        if not all(level in levels for level in range(0, target)):
            continue
        costs = collections.Counter()
        for level in range(target):
            costs.update({item: qty for item, qty in pairs(levels[level]["cost"])})
        papers = [(item, qty) for item, qty in costs.items() if item != 2]
        print(part, target, papers, costs[2], levels[target - 1]["_row"])
print("EQUIP row_counts", {part: (min(levels), max(levels), len(levels)) for part, levels in equip.items()})

print("RUNE composition, target_quality, base_quality_1_count")
composition = records("F_符文_rune_data.xml", "符文合成")
for row in composition:
    if row.get("quality", "").isdigit():
        print(row["quality"], row["target_quality"], 4 ** (int(row["target_quality"]) - 1), row["_row"])
