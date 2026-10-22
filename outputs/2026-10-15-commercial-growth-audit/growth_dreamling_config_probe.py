"""Inspect current dreamling unit IDs and cost groups without changing SVN files."""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from growth_source_probe import rows_from_spreadsheetml

source = Path(r"E:\x1\配置\trunk\xml_gy\normal\D_单位_unit_data.xml")
unit_rows = list(rows_from_spreadsheetml(source, "单位信息"))
header = dict(unit_rows[1][1])
print("cost group columns", [(c, v) for c, v in header.items() if "cost" in v.lower() or "消耗" in v])
for rownum, cells in unit_rows:
    if rownum <= 2:
        continue
    try:
        unit_id = int(cells.get(1, 0))
    except ValueError:
        continue
    if unit_id in {1110100, 1530200, 1130200, 1120100, 1610100, 1140200}:
        print(rownum, [(c, v) for c, v in cells.items() if c <= 75])

for quality in (3, 4, 5, 6, 7):
    active = []
    for rownum, cells in unit_rows:
        try:
            unit_id = int(cells.get(1, 0))
            q = int(cells.get(3, 0))
            unit_type = int(cells.get(4, 0))
            in_bag = int(cells.get(8, 0))
        except (ValueError, TypeError):
            continue
        if q == quality and unit_type == 1 and in_bag == 1:
            active.append((unit_id, cells.get(2), cells.get(45), rownum))
    print(f"quality {quality} active heroes ({len(active)}): {active}")

level_rows = list(rows_from_spreadsheetml(source, "卡牌升级"))
for cost_group in ("20003", "10005", "40006", "30007"):
    filtered = [(r, c) for r, c in level_rows if c.get(6) == cost_group]
    print("cost group", cost_group, "row bounds", filtered[0][0], filtered[-1][0])
    for target in (10, 30):
        used = [(r, c) for r, c in filtered if 2 <= int(c.get(2, 0)) <= target]
        print("  to", target, "exp", sum(int(c.get(3, 0)) for _, c in used), "piece", sum(int(c.get(4, 0)) for _, c in used), "rows", used[0][0], used[-1][0])
