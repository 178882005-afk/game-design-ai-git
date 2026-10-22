"""Recompute bounded same-shop alternatives from the current commercial TSV.

These are nominal reward-value scenarios, not currency-to-diamond exchange rates.
"""

import csv
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parent
with (ROOT / "final_commercial_scope.tsv").open(encoding="utf-8-sig", newline="") as file:
    rows = list(csv.DictReader(file, delimiter="\t"))


def best_alternative(candidates, budget, target_key):
    """Bounded knapsack using each configured entry's purchase cap."""
    states = {0: (0, ())}
    for row in candidates:
        if row["商品键"] == target_key:
            continue
        price = int(row["标价"])
        value = float(row["完整奖励价值_钻"])
        cap_match = re.search(r"(?:buy_count|限购)=(\d+)", row["购买/池条件"])
        assert cap_match, row["商品键"]
        cap = min(int(cap_match.group(1)), budget // price)
        previous = states
        states = dict(previous)
        for spent, (total, picks) in previous.items():
            for qty in range(1, cap + 1):
                new_spent = spent + price * qty
                if new_spent > budget:
                    break
                new_total = total + value * qty
                if new_spent not in states or new_total > states[new_spent][0]:
                    states[new_spent] = (new_total, picks + ((row["商品键"], qty),))
    spent, (value, picks) = max(states.items(), key=lambda item: (item[1][0], item[0]))
    return spent, value, picks


for currency, target in (
    ("道具100091", "exchange:30010:3001001"),
    ("道具100110", "exchange:30014:3001401"),
):
    candidates = [r for r in rows if r["币种"] == currency]
    spent, value, picks = best_alternative(candidates, 6, target)
    print(currency, "budget=6", f"spent={spent}", f"alternative_value={value:g}", picks)
    assert spent == 6 and value == 12000

guild = [r for r in rows if r["币种"] == "道具50"]
target = "normal:19:13:0"
for level, expected in ((2, 200), (3, 640), (4, 731)):
    eligible = []
    for row in guild:
        match = re.search(r"\{build_lev,301,(\d+)\}", row["开放/触发条件"])
        if match and int(match.group(1)) <= level:
            eligible.append(row)
    spent, value, picks = best_alternative(eligible, 1000, target)
    print("道具50", f"guild_level={level}", "budget=1000", f"spent={spent}", f"alternative_value={value:g}", picks)
    assert spent == 1000 and value == expected
