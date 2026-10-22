"""Summarize formal growth row bounds; diagnostic only."""

from collections import defaultdict
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


def scope(rows, key, value):
    return [r for r in rows if r.get(key) == value]


def int_values(rows, key):
    return sorted({int(r[key]) for r in rows if r.get(key, "").isdigit()})


for file_name, sheet_name, key, group in [
    ("D_单位_unit_data.xml", "卡牌升级", "level", "quality"),
    ("D_队长装备_captain_equip_data.xml", "强化等级", "lev", "position"),
    ("M_秘宝养成_treasure_data.xml", "秘宝等级", "id", None),
    ("Z_载具养成_vehicle_data.xml", "载具等级", "vehicle_level", None),
    ("Z_载具养成_vehicle_data.xml", "零件升级", "level", "cost_group_id"),
    ("C_藏品_antique_data.xml", "升星消耗", "level", "cost_group_id"),
]:
    rows = records(file_name, sheet_name)
    grouped = defaultdict(list)
    for row in rows:
        if row.get(key, "").isdigit():
            grouped[row.get(group, "all") if group else "all"].append(row)
    print(file_name.encode("unicode_escape").decode(), sheet_name.encode("unicode_escape").decode())
    for name, sample in grouped.items():
        values = int_values(sample, key)
        escaped_name = str(name).encode("unicode_escape").decode()
        print(escaped_name, "n", len(values), "min", min(values), "max", max(values), "last_row", max(r["_row"] for r in sample))

chapters = records("Z_主线推图_chapter_pve_data.xml", "章节配置")
grouped = defaultdict(list)
for row in chapters:
    if row.get("chapter_id", "").isdigit():
        grouped[(row.get("chapter_type"), row.get("chapter_sub_type"))].append(row)
print("CHAPTER groups")
for key, sample in grouped.items():
    print(str(key).encode("unicode_escape").decode(), len(sample), min(int(r["chapter_id"]) for r in sample), max(int(r["chapter_id"]) for r in sample))
print("CHAPTER ids prefix 101", sorted(int(r["chapter_id"]) for r in chapters if r.get("chapter_id", "").startswith("101"))[-12:])
