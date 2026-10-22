"""Read SVN working-copy metadata for numeric cap source files."""

import datetime as dt
import sqlite3
from pathlib import Path

DB = Path(r"E:\x1\配置\trunk\.svn\wc.db")
names = [
    "W_玩家等级_leader_data.xml", "Z_主线推图_chapter_pve_data.xml",
    "D_单位_unit_data.xml", "D_队长装备_captain_equip_data.xml",
    "F_符文_rune_data.xml", "J_基因_evolve_data.xml",
    "M_秘宝养成_treasure_data.xml", "Z_载具养成_vehicle_data.xml",
    "C_藏品_antique_data.xml",
]
con = sqlite3.connect(DB)
for name in names:
    row = con.execute(
        "select revision, changed_revision, changed_date, presence from NODES "
        "where local_relpath=? and op_depth=0",
        ("xml_gy/normal/" + name,),
    ).fetchone()
    if row:
        revision, changed_revision, micros, presence = row
        date = dt.datetime.fromtimestamp(micros / 1_000_000, dt.UTC).isoformat()
        print(name.encode("unicode_escape").decode(), revision, changed_revision, date, presence)
