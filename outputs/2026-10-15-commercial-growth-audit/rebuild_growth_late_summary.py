"""Recalculate selected late-growth cost milestones from local formal XML.

Usage: python rebuild_growth_late_summary.py
The output is a static-demand ledger, never an estimated player attainment date.
"""

import csv
import re
from collections import Counter, defaultdict
from pathlib import Path

from inspect_late_config import ROOT, sheet_rows

OUT = Path(__file__).with_name("growth_late_milestones.tsv")
PAIR_RE = re.compile(r"\{\s*(\d+)\s*,\s*(\d+)\s*\}")


def pairs(value: str | None) -> Counter[int]:
    result: Counter[int] = Counter()
    for key, count in PAIR_RE.findall(value or ""):
        result[int(key)] += int(count)
    return result


def rows(file: str, sheet: str) -> list[tuple[int, dict[int, str]]]:
    return [(number, row) for number, row in list(sheet_rows(ROOT / file, sheet))[2:] if row.get(1, "").isdigit()]


def research_nodes() -> dict[str, dict[int, tuple[int, dict[int, str]]]]:
    groups: dict[str, dict[int, tuple[int, dict[int, str]]]] = defaultdict(dict)
    for number, row in rows("J_基因_evolve_data.xml", "进化"):
        groups[row[2]][int(row[1])] = number, row
    assert set(groups) == {"1", "2"}
    assert len(groups["1"]) == len(groups["2"]) == 420
    assert set(groups["1"]) == set(groups["2"])
    for ident in groups["1"]:
        left, right = groups["1"][ident][1], groups["2"][ident][1]
        assert all(left.get(key) == right.get(key) for key in (11, 12, 13, 18))
    return groups


def research_closure(group: dict[int, tuple[int, dict[int, str]]], ident: int) -> tuple[int, Counter[int]]:
    seen: set[int] = set()

    def visit(node: int) -> None:
        if node in seen:
            return
        seen.add(node)
        for prior in re.findall(r"\d+", group[node][1].get(12, "")):
            visit(int(prior))

    visit(ident)
    cost: Counter[int] = Counter()
    for node in seen:
        cost.update(pairs(group[node][1].get(13)))
    return len(seen), cost


def grouped_levels(file: str, sheet: str) -> dict[int, dict[int, tuple[int, dict[int, str]]]]:
    groups: dict[int, dict[int, tuple[int, dict[int, str]]]] = defaultdict(dict)
    for number, row in rows(file, sheet):
        groups[int(row[1])][int(row[2])] = number, row
    return groups


def add(output: list[dict[str, str | int]], system: str, goal: str, phase: str,
        counts: Counter[int], source: str, note: str = "") -> None:
    names = {2: "金币", 63: "精密齿轮", 5203001: "织梦微尘", 5205001: "潜能棱晶", 5523001: "转运石"}
    for ident, amount in sorted(counts.items()):
        output.append({"系统": system, "目标": goal, "阶段": phase, "资源ID": ident,
                       "资源名": names.get(ident, "对应碎片"), "数量": amount,
                       "配置来源": source, "口径": note})


def main() -> None:
    output: list[dict[str, str | int]] = []
    research = research_nodes()["2"]
    for ident in (10, 30, 100, 10020, 10060):
        nodes, cost = research_closure(research, ident)
        add(output, "武器研究", f"ID{ident}", f"前置闭包{nodes}节点", cost,
            f"J_基因/进化!427:{research[ident][0]}", "划断组2；前置ID去重；非逐日供给")
    all_cost: Counter[int] = Counter()
    for _, row in research.values():
        all_cost.update(pairs(row.get(13)))
    add(output, "武器研究", "组2全部420节点", "全量非单一路径", all_cost,
        "J_基因/进化!427:849", "不能与组1再相加")

    treasure = {int(row[1]): (number, row) for number, row in rows("M_秘宝养成_treasure_data.xml", "秘宝等级")}
    for target in (2, 3, 4, 5, 12):
        prev_row, prior = treasure[target - 1]
        threshold = int(prior[2])
        add(output, "秘宝", f"等级{target}", "洗炼累计消耗阈值", Counter({5523001: threshold}),
            f"M_秘宝/秘宝等级!{prev_row}", "累计阈值；不与洗炼消费叠加")
    for number, row in rows("M_秘宝养成_treasure_data.xml", "秘宝技能")[:2]:
        add(output, "秘宝", f"技能{row[1]}升下一级", f"要求秘宝等级{row[4]}", pairs(row[3]),
            f"M_秘宝/秘宝技能!{number}", "独立于洗炼，不增加秘宝等级经验")

    vehicle = {int(row[1]): (number, row) for number, row in rows("Z_载具养成_vehicle_data.xml", "载具等级")}
    for target in (10, 50):
        cost: Counter[int] = Counter()
        for level in range(2, target + 1):
            cost.update(pairs(vehicle[level][1].get(3)))
        add(output, "载具", f"载具等级1→{target}", "逐级累计", cost,
            f"Z_载具/载具等级!4:{vehicle[target][0]}", "解锁奖励含100齿轮，库存模型中另计到账")

    for system, file, sheet, group, targets in (
        ("载具零件", "Z_载具养成_vehicle_data.xml", "零件升级", 4, (5, 10)),
        ("藏品", "C_藏品_antique_data.xml", "升星消耗", 4, (5, 10)),
    ):
        levels = grouped_levels(file, sheet)[group]
        for target in targets:
            upgrade_cost: Counter[int] = Counter()
            fragments = 0
            for level in range(2, target + 1):
                row = levels[level][1]
                upgrade_cost.update(pairs(row.get(3)))
                fragments += int(row.get(4) or 0)
            upgrade_cost[0] = fragments
            add(output, system, f"组{group}已激活→{target}{'级' if system == '载具零件' else '星'}",
                "升级增量", upgrade_cost,
                f"{file.split('_')[0]}_{'载具' if system == '载具零件' else '藏品'}/{sheet}!{levels[2][0]}:{levels[target][0]}",
                "资源ID0表示该目标本体专属碎片；激活本体或10碎片另计")

    with OUT.open("w", newline="", encoding="utf-8-sig") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(output[0]), delimiter="\t")
        writer.writeheader()
        writer.writerows(output)
    print(f"Wrote {len(output)} rows: {OUT}")


if __name__ == "__main__":
    main()
