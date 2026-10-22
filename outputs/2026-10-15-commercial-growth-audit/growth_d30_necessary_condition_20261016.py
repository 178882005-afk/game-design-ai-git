"""Check D30 material coverage under the documented D15-D25 inflow scenario."""

import csv
from collections import defaultdict
from pathlib import Path


ROOT = Path(__file__).resolve().parent
SOURCES = (
    "growth_top10_historical_nonr_recent_resources_d25_phases_20261015.tsv",
    "growth_top10_historical_resources_d25_phases_20261015.tsv",
)
by_group = defaultdict(lambda: defaultdict(dict))
for name in SOURCES:
    with (ROOT / name).open(encoding="utf-8-sig", newline="") as file:
        for row in csv.DictReader(file, delimiter="\t"):
            group = (row["玩家类型"], row["付费档"])
            by_group[group][row["道具ID"]][row["阶段"]] = float(row["人均获得"])


def projected(group, item_id):
    phases = by_group[group][item_id]
    assert set(phases) == {"D1-7", "D8-14", "D15-25"}, (group, item_id, phases)
    d25 = sum(phases.values())
    d30 = d25 + 5 * phases["D15-25"] / 11
    return d25, d30


CAPS = {
    "金币": ("2", 140083200),
    "织梦微尘": ("5203001", 307368),
    "潜能棱晶": ("5205001", 420),
    "转运石": ("5523001", 19888000),
}
for group in (("纯新增", "非R"), ("纯新增", "(300,1500]")):
    print(group)
    for label, (item_id, need) in CAPS.items():
        d25, d30 = projected(group, item_id)
        print(label, f"D25={d25:.2f}", f"D30={d30:.2f}", f"D30_coverage={d30/need:.4%}")
    min_gear_d30 = min(projected(group, str(item))[1] for item in range(50003, 50009))
    print("最少部位图纸", f"D30={min_gear_d30:.2f}", f"D30_coverage={min_gear_d30/255134:.4%}")
