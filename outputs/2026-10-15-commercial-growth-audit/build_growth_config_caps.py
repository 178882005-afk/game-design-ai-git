"""Recompute stage and row-maximum costs from the latest local formal XML.

The result is a configuration bound, not a predicted or observed completion day.
"""

from __future__ import annotations

import csv
import re
from collections import defaultdict
from pathlib import Path

from growth_source_probe import rows_from_spreadsheetml


ROOT = Path(r"E:\x1\配置\trunk\xml_gy\normal")
OUT = Path(__file__).with_name("growth_config_caps.tsv")
FIELDS = ["成长线", "对象/品质组", "目标", "配置行上限", "资源", "累计数量", "配置来源", "计算口径"]
RESULT = []


def records(filename, sheet):
    raw = list(rows_from_spreadsheetml(ROOT / filename, sheet))
    header = raw[1][1]
    return [
        {"_row": rowno, **{name: cells.get(col, "") for col, name in header.items() if name}}
        for rowno, cells in raw[2:]
        if cells
    ]


def pairs(raw):
    return [(int(i), int(float(q))) for i, q in re.findall(r"\{\s*(\d+)\s*,\s*([\d.]+)\s*\}", raw)]


def add(line, subject, target, maxlevel, resource, qty, source, note):
    RESULT.append([line, subject, target, maxlevel, resource, qty, source, note])


leader = {int(r["level"]): r for r in records("W_玩家等级_leader_data.xml", "等级") if r.get("level", "").isdigit()}
assert set(leader) == set(range(1, 301))
for target in (11, 30, 42, 300):
    r = leader[target]
    add("玩家等级", "角色", f"1→{target}级", 300, "累计经验", int(r["need_exp_total"]),
        f"W_玩家等级/等级!C{r['_row']}", "达到目标级的配置累计经验；非实际获取天数")

chapters = {int(r["chapter_id"]): r for r in records("Z_主线推图_chapter_pve_data.xml", "章节配置")
            if r.get("chapter_type") == "主线" and r.get("chapter_id", "").isdigit()}
assert set(chapters) == set(range(1, 401))
for target in (10, 40, 57, 60, 400):
    add("主线", "普通主线", f"第1～{target}关各首通1次", 400, "配置体力门票",
        sum(int(chapters[i].get("energy_cost", "0")) for i in range(1, target + 1)),
        f"Z_主线推图/章节配置!I{chapters[1]['_row']}:I{chapters[target]['_row']}",
        "仅成功挑战各1次；失败重试、战力与开放条件另计")

cards = defaultdict(dict)
for r in records("D_单位_unit_data.xml", "卡牌升级"):
    if r.get("quality", "").isdigit() and r.get("level", "").isdigit():
        cards[int(r["quality"])][int(r["level"])] = r
for q in (3, 4, 5, 6, 10007, 40007):
    levels = cards[q]
    cap = max(levels)
    assert set(levels) == set(range(1, cap + 1))
    for target in (30, cap):
        if target > cap:
            continue
        for label, key in (("梦灵经验", "exp_count"), ("该梦灵碎片", "piece_count")):
            add("梦灵", f"成本组{q}", f"单个1→{target}级", cap, label,
                sum(int(float(levels[i].get(key) or 0)) for i in range(2, target + 1)),
                f"D_单位/卡牌升级!{levels[2]['_row']}:{levels[target]['_row']}",
                "需先持有对应本体；不同成本组不可通用")

equip = defaultdict(dict)
for r in records("D_队长装备_captain_equip_data.xml", "强化等级"):
    if r.get("lev", "").isdigit():
        equip[r["position"]][int(r["lev"])] = r
assert len(equip) == 6 and all(set(v) == set(range(301)) for v in equip.values())
for target in (10, 50, 100, 300):
    gold = 0
    paper = 0
    for part, levels in equip.items():
        for level in range(target):
            for item, qty in pairs(levels[level]["cost"]):
                if item == 2:
                    gold += qty
                else:
                    paper += qty
    source = "D_队长装备/强化等级!3:1812"
    add("装备强化", "六部位各一件", f"全部0→{target}级", 300, "金币", gold, source,
        "强化成本取原等级行，至300级用0～299行；六部位分别升级")
    add("装备强化", "六部位各一件", f"全部0→{target}级", 300, "六种部位专属图纸合计", paper, source,
        "合计量不代表六种部位库存可互换")

rune = {int(r["target_quality"]): r for r in records("F_符文_rune_data.xml", "符文合成")
        if r.get("target_quality", "").isdigit()}
assert set(rune) == set(range(2, 8))
for target in (5, 6, 7):
    add("符文合成", "指定部位1枚", f"品质1→品质{target}", 7, "同部位品质1符文", 4 ** (target - 1),
        f"F_符文/符文合成!3:{rune[target]['_row']}", "纯四合一理论量；高品质直掉和词条随机另算")

research = [r for r in records("J_基因_evolve_data.xml", "进化")
            if r.get("server_open_point") == "2" and r.get("id", "").isdigit()]
assert len(research) == 420
for item, label, expected in ((2, "金币", 6988720), (5203001, "织梦微尘", 307368), (5205001, "潜能棱晶", 420)):
    qty = sum(q for r in research for i, q in pairs(r.get("need_cost", "")) if i == item)
    assert qty == expected
    add("武器研究", "组2", "全部420节点", 420, label, qty,
        "J_基因/进化!427:849", "组2全节点总量；组1不再相加，指定节点另按前置闭包计算")

treasure = {int(r["id"]): r for r in records("M_秘宝养成_treasure_data.xml", "秘宝等级") if r.get("id", "").isdigit()}
assert set(treasure) == set(range(1, 13))
for target in (2, 5, 12):
    r = treasure[target - 1]
    add("秘宝等级", "单件秘宝", f"1→{target}级", 12, "转运石累计洗炼", int(r["expend"]),
        f"M_秘宝养成/秘宝等级!B{r['_row']}", "累计门槛；洗炼消耗同步推进等级，不重复相加")

vehicle = {int(r["vehicle_level"]): r for r in records("Z_载具养成_vehicle_data.xml", "载具等级")
           if r.get("vehicle_level", "").isdigit()}
assert set(vehicle) == set(range(1, 401))
for target in (10, 50, 400):
    add("载具等级", "载具主体", f"1→{target}级", 400, "精密齿轮", 
        sum(q for i in range(2, target + 1) for item, q in pairs(vehicle[i].get("cost", "")) if item == 63),
        f"Z_载具养成/载具等级!C4:C{vehicle[target]['_row']}",
        "开服第22天且主线第60关为功能配置条件；赠送100齿轮单记到账")

for filename, sheet, system, name, maxlevel in [
    ("Z_载具养成_vehicle_data.xml", "零件升级", "载具零件", "等级", 60),
    ("C_藏品_antique_data.xml", "升星消耗", "藏品", "星", 25),
]:
    groups = defaultdict(dict)
    for r in records(filename, sheet):
        if r.get("cost_group_id", "").isdigit() and r.get("level", "").isdigit():
            groups[int(r["cost_group_id"])][int(r["level"])] = r
    assert set(groups) == {4, 5, 6, 7}
    for group, levels in sorted(groups.items()):
        assert set(levels) == set(range(1, maxlevel + 1))
        for target in (10, maxlevel):
            for resource, key in (("该目标专属碎片", "piece_count"), ("金币", "exp_count")):
                qty = 0
                for level in range(2, target + 1):
                    raw = levels[level].get(key, "")
                    qty += int(float(raw or 0)) if key == "piece_count" else sum(q for item, q in pairs(raw) if item == 2)
                add(system, f"成本组{group}单件", f"已激活1→{target}{name}", maxlevel, resource, qty,
                    f"{filename.split('_')[0]}_{filename.split('_')[1].split('.')[0]}/{sheet}!{levels[2]['_row']}:{levels[target]['_row']}",
                    "首次激活本体或10碎片另计；每件专属碎片不通用")

with OUT.open("w", encoding="utf-8-sig", newline="") as file:
    writer = csv.writer(file, delimiter="\t")
    writer.writerow(FIELDS)
    writer.writerows(RESULT)
print(f"{OUT.name}: {len(RESULT)} rows")
