"""Read current formal configuration row bounds before defining growth endpoints."""

from pathlib import Path
from growth_source_probe import rows_from_spreadsheetml


ROOT = Path(r"E:\x1\配置\trunk\xml_gy\normal")
SHEETS = [
    ("W_玩家等级_leader_data.xml", "等级"),
    ("Z_主线推图_chapter_pve_data.xml", "章节配置"),
    ("D_单位_unit_data.xml", "卡牌升级"),
    ("D_队长装备_captain_equip_data.xml", "强化等级"),
    ("F_符文_rune_data.xml", "符文合成"),
    ("J_基因_evolve_data.xml", "进化"),
    ("M_秘宝养成_treasure_data.xml", "秘宝等级"),
    ("Z_载具养成_vehicle_data.xml", "载具等级"),
    ("Z_载具养成_vehicle_data.xml", "零件升级"),
    ("C_藏品_antique_data.xml", "升星消耗"),
]


for file_name, sheet_name in SHEETS:
    rows = list(rows_from_spreadsheetml(ROOT / file_name, sheet_name))
    print("\n", file_name, sheet_name, "rows=", len(rows))
    for rowno, row in rows[1:4] + rows[-3:]:
        print(rowno, {key: value for key, value in list(row.items())[:12]})
