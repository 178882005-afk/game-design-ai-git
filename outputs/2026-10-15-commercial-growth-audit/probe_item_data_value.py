"""Diagnostic comparison of formal item `value` and known anchors."""

from pathlib import Path
from growth_source_probe import rows_from_spreadsheetml

path = Path(r"E:\x1\配置\trunk\xml_gy\normal\D_道具_item_data.xml")
for rowno, row in rows_from_spreadsheetml(path, "道具信息"):
    if row.get(1, "") in {"1", "2", "44", "41", "10003", "50001", "50002", "50026", "6220021", "6200012", "100040"}:
        print(rowno, row.get(1), str(row.get(2, "")).encode("unicode_escape").decode(), "value", row.get(19), "recycle_price", row.get(18))
