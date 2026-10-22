"""Verify that every reward ID and product association is in the price ledger.

This check deliberately reads the four source TSVs independently of the
builder. It tests catalog coverage, not the economic correctness of a price.
"""

from __future__ import annotations

import collections
import csv
import re
from pathlib import Path


HERE = Path(__file__).resolve().parent
PAIR = re.compile(r"(?<!\d)(\d+)×([\d.]+)")
GROUPS = (
    ("基础商品", "基础商品关联数"),
    ("扩展现金目录", "扩展现金目录关联数"),
    ("新服活动", "新服活动关联数"),
    ("现行补录商品", "现行补录商品关联数"),
)


def rows(name: str) -> list[dict[str, str]]:
    with (HERE / name).open("r", encoding="utf-8-sig", newline="") as handle:
        return list(csv.DictReader(handle, delimiter="\t"))


def reward_ids(raw: str) -> set[int]:
    if not raw:
        return set()
    result = set()
    for part in raw.split(";"):
        part = part.strip()
        found = PAIR.findall(part)
        if not found and "×" not in part:
            continue  # A dynamic source description has no explicit reward item ID.
        if len(found) != 1:
            raise ValueError(f"Unparsed reward token: {part!r}")
        result.add(int(found[0][0]))
    return result


def check() -> tuple[int, dict[str, int]]:
    expected: dict[int, dict[str, set[str]]] = collections.defaultdict(
        lambda: collections.defaultdict(set)
    )
    for row in rows("commercial_reward_lines.tsv"):
        expected[int(row["奖励ID"])]["基础商品"].add(f"{row['模块']}:{row['商品ID']}")
    for row in rows("additional_cash_catalog.tsv"):
        for field in ("付费奖励ID×数量", "分期奖励ID×数量"):
            for item_id in reward_ids(row[field]):
                expected[item_id]["扩展现金目录"].add(f"{row['模块']}:{row['商品ID']}")
    for row in rows("event_cash_catalog.tsv"):
        for item_id in reward_ids(row["奖励ID及数量"]):
            expected[item_id]["新服活动"].add(f"{row['模块']}:{row['SKU_ID']}")
    for row in rows("remaining_current_skus.tsv"):
        for item_id in reward_ids(row["奖励ID×数量"]):
            expected[item_id]["现行补录商品"].add(f"{row['模块']}:{row['商品ID']}")

    ledger_rows = rows("item_anchor_ledger.tsv")
    ledger = {int(row["道具ID"]): row for row in ledger_rows}
    if len(ledger) != len(ledger_rows):
        raise AssertionError("Duplicate item ID in item_anchor_ledger.tsv")
    if set(ledger) != set(expected):
        missing = sorted(set(expected) - set(ledger))
        extra = sorted(set(ledger) - set(expected))
        raise AssertionError(f"Item coverage mismatch: missing={missing}; extra={extra}")

    for item_id, row in ledger.items():
        references = []
        for group, field in GROUPS:
            refs = sorted(expected[item_id][group])
            if int(row[field]) != len(refs):
                raise AssertionError(f"{item_id}: {field} {row[field]} != {len(refs)}")
            references.extend(f"{group}/{ref}" for ref in refs)
        if int(row["下游商品关联总数"]) != len(references):
            raise AssertionError(f"{item_id}: downstream total mismatch")
        if row["关联商品标识"].split(";") != references:
            raise AssertionError(f"{item_id}: downstream product references mismatch")

    group_item_counts = {
        group: sum(bool(expected[item_id][group]) for item_id in expected)
        for group, _ in GROUPS
    }
    return len(expected), group_item_counts


if __name__ == "__main__":
    item_count, group_counts = check()
    print(f"PASS: {item_count} exact reward IDs across four catalogs")
    print(group_counts)
