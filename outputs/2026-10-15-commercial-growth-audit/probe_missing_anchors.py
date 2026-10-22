"""Diagnostic count of unresolved reward IDs in the current-scope catalog."""

import collections
import csv
from pathlib import Path

path = Path(__file__).with_name("final_commercial_scope.tsv")
with path.open(encoding="utf-8-sig", newline="") as file:
    rows = list(csv.DictReader(file, delimiter="\t"))
count = collections.Counter()
modules = collections.defaultdict(set)
cash = collections.Counter()
for row in rows:
    for item_id in filter(None, row["缺价奖励ID"].split(",")):
        count[item_id] += 1
        modules[item_id].add(row["模块"])
        if row["付款方式"] == "人民币":
            cash[item_id] += 1
for item_id, frequency in count.most_common(35):
    print(item_id, frequency, "cash", cash[item_id], "modules", len(modules[item_id]), "|", ";".join(sorted(modules[item_id])).encode("unicode_escape").decode()[:180])
