"""从本地 SVN XML 重建基金等五组现金目录；仅使用 6-1 上半区 ID 锚价。"""

from __future__ import annotations

import collections
import csv
import re
import sqlite3
import xml.etree.ElementTree as ET
from datetime import datetime, timedelta, timezone
from pathlib import Path

import openpyxl


ROOT = Path("E:/x1/配置/trunk")
XML = ROOT / "xml_gy/normal"
BOOK = ROOT / "策划文档/数值文档/《梦境护卫队》6-1商业化数值.xlsx"
OUT = Path(__file__).with_name("additional_cash_catalog.tsv")
NS = "{urn:schemas-microsoft-com:office:spreadsheet}"
PAIR = re.compile(r"\{\s*(\d+)\s*,\s*([\d.]+)\s*\}")


def rows(filename: str, sheet: str) -> list[dict[str, str | int]]:
    root = ET.parse(XML / filename).getroot()
    for ws in root.findall(NS + "Worksheet"):
        if ws.get(NS + "Name") != sheet:
            continue
        table = ws.find(NS + "Table")
        if table is None:
            return []
        out = []
        names = {}
        row_number = 0
        for row in table.findall(NS + "Row"):
            row_number = int(row.get(NS + "Index") or row_number + 1)
            cells = {}
            column = 1
            for cell in row.findall(NS + "Cell"):
                column = int(cell.get(NS + "Index") or column)
                data = cell.find(NS + "Data")
                cells[column] = (data.text or "") if data is not None else ""
                column += 1
            if row_number == 2:
                names = {column: value for column, value in cells.items() if value}
            elif row_number > 2 and names and any(cells.values()):
                out.append({"_row": row_number, **{name: cells.get(column, "") for column, name in names.items()}})
        return out
    raise ValueError(f"Missing sheet: {filename}/{sheet}")


def item_pairs(value: str) -> list[tuple[int, float]]:
    return [(int(item), float(count)) for item, count in PAIR.findall(str(value))]


def grouped_items(*values: str) -> dict[int, float]:
    items = collections.defaultdict(float)
    for value in values:
        for item, count in item_pairs(value):
            items[item] += count
    return dict(items)


def describe_items(items: dict[int, float]) -> str:
    return ";".join(f"{item}×{count:g}" for item, count in sorted(items.items()))


def source(filename: str, sheet: str, cells: str) -> str:
    return f"{filename}/{sheet}!{cells}"


def svn_revisions() -> dict[str, tuple[str, str]]:
    db = ROOT / ".svn/wc.db"
    connection = sqlite3.connect(f"file:{db.as_posix()}?mode=ro", uri=True)
    out = {}
    for path, revision, changed_us in connection.execute(
        "SELECT local_relpath, changed_revision, changed_date FROM NODES "
        "WHERE local_relpath LIKE 'xml_gy/normal/%' AND op_depth=0"
    ):
        stamp = datetime.fromtimestamp(changed_us / 1_000_000, timezone.utc)
        stamp = stamp.astimezone(timezone(timedelta(hours=8))).strftime("%Y-%m-%d")
        out[Path(path).name] = (str(revision), stamp)
    connection.close()
    return out


revisions = svn_revisions()
pay_file = "C_充值_pay_data.xml"
pay = {int(d["id"]): d for d in rows(pay_file, "支付表") if str(d.get("id", "")).isdigit()}

workbook = openpyxl.load_workbook(BOOK, read_only=True, data_only=True)
value_sheet = workbook["价值表"]
anchor = {}
for row_number in range(4, 125):
    item_id = value_sheet[f"D{row_number}"].value
    price = value_sheet[f"F{row_number}"].value
    if isinstance(item_id, (int, float)) and isinstance(price, (int, float)):
        anchor[int(item_id)] = (float(price), f"价值表!D{row_number},F{row_number}")

items_file = "D_道具_item_data.xml"
item_names = {
    int(d["id"]): str(d.get("name", ""))
    for d in rows(items_file, "道具信息")
    if str(d.get("id", "")).isdigit()
}


def base_record(module: str, scheme: str, product_id: str, pay_id: int, filename: str) -> dict[str, str | int | float]:
    payment = pay[pay_id]
    revision, date = revisions[filename]
    return {
        "模块": module,
        "方案": scheme,
        "商品ID": product_id,
        "支付ID": pay_id,
        "人民币售价": float(payment["real_currency"]),
        "开放条件_配置原文": "",
        "付费奖励ID×数量": "",
        "分期奖励ID×数量": "",
        "分期达成条件": "",
        "独立付费奖励ID数": 0,
        "已锚定名义价值_钻": "",
        "未锚定奖励ID": "",
        "未锚定奖励名称": "",
        "可比较完整返比": "",
        "直充本金_钻": "",
        "直充首次额外_钻": "",
        "直充复购额外_钻": "",
        "直充首次到账_钻": "",
        "直充复购到账_钻": "",
        "配置现行性": "",
        "价值口径及疑点": "",
        "配置修订": revision,
        "配置变更日期": date,
        "配置来源": "",
        "价格来源": source(pay_file, "支付表", f"A{payment['_row']},C{payment['_row']}")
        + f" (r{revisions[pay_file][0]})",
    }


def set_item_value(record: dict, immediate: dict[int, float], *, eligible_ratio: bool = False) -> None:
    record["付费奖励ID×数量"] = describe_items(immediate)
    record["独立付费奖励ID数"] = len(immediate)
    known = sum(count * anchor[item][0] for item, count in immediate.items() if item in anchor)
    unknown = sorted(item for item in immediate if item not in anchor)
    record["已锚定名义价值_钻"] = round(known, 4) if any(item in anchor for item in immediate) else ""
    record["未锚定奖励ID"] = ",".join(map(str, unknown))
    record["未锚定奖励名称"] = ";".join(f"{item}:{item_names.get(item, '道具表无ID')}" for item in unknown)
    if eligible_ratio and immediate and not unknown:
        record["可比较完整返比"] = round(known / (float(record["人民币售价"]) * 10), 4)


records = []

# 基金：只按明确 type 键关联付费轨。空 type 的 103–109 奖励块不能臆测绑定。
fund_file = "J_基金_foundation_data.xml"
fund_display = rows(fund_file, "基金显示条件")
fund_rewards = rows(fund_file, "基金")
valid_fund_types = set(range(101, 110)) | {203, 204, 205, 301, 302, 401, 402}
for d in fund_display:
    if not str(d.get("type", "")).isdigit() or int(d["type"]) not in valid_fund_types:
        continue
    fund_type = int(d["type"])
    product_rows = [r for r in fund_rewards if r.get("type") == str(fund_type)]
    assert not any(r.get("high_pay_reward") for r in product_rows), fund_type
    paid = grouped_items(*(str(r.get("low_pay_reward", "")) for r in product_rows))
    record = base_record("基金", str(d["name"]), str(fund_type), int(d["pay_id"]), fund_file)
    set_item_value(record, paid)
    record["开放条件_配置原文"] = f"服务器时窗={d['server_open_time_interval']}; 条件={d['open_condition']}"
    record["分期达成条件"] = (
        f"{len(product_rows)}个节点，{product_rows[0].get('condition','')}…{product_rows[-1].get('condition','')}"
        if product_rows else "无明确type绑定节点"
    )
    if product_rows:
        record["配置现行性"] = "时窗有效_条件与实际展示待验"
        record["价值口径及疑点"] = "付费轨节点累计上限；购买后仍须达成节点，不是即时发放；免费轨不计，完整返比留空。"
        reward_source = source(fund_file, "基金", f"A{product_rows[0]['_row']}:G{product_rows[-1]['_row']}")
    else:
        record["配置现行性"] = "疑点_无明确type绑定奖励"
        record["价值口径及疑点"] = "显示与支付配置存在，但付费奖励表无对应type；不能认作已核在售SKU。"
        reward_source = "基金!无明确type记录"
    record["配置来源"] = source(fund_file, "基金显示条件", f"A{d['_row']}:I{d['_row']}") + "; " + reward_source + f" (r{revisions[fund_file][0]})"
    records.append(record)

# 新手礼包：第二期的开启时间 2/8/14 写在 D4:F4，而表头在 A:C；重复道具也需复核。
rookie_file = "X_新手礼包_rookie_gift_data.xml"
for d in rows(rookie_file, "礼包"):
    if not d.get("pay_id"):
        continue
    term = int(d["gift_term"])
    record = base_record("新手礼包", f"第{term}期/{d['name']}", str(d["id"]), int(d["pay_id"]), rookie_file)
    paid = grouped_items(str(d["rewards"]))
    set_item_value(record, paid, eligible_ratio=(term == 1))
    record["开放条件_配置原文"] = "第1期开服第1–7天" if term == 1 else "第2期疑似开服第8–14天；开启时间!D4:F4，表头在A:C"
    record["配置现行性"] = "候选_开服第1期" if term == 1 else "疑点_第2期开启时间错列与重复奖励"
    record["价值口径及疑点"] = (
        "即时礼包；上半区ID锚价全覆盖时给完整返比。" if term == 1
        else "原文重复出现 ID11×2，已在数量列汇总；疑似占位，锚定值只用于排错，不计算返比。"
    )
    record["配置来源"] = source(rookie_file, "礼包", f"A{d['_row']}:E{d['_row']}") + "; " + source(rookie_file, "开启时间", "A3:C3" if term == 1 else "D4:F4") + f" (r{revisions[rookie_file][0]})"
    records.append(record)

# 七日直购：保留两套各七条，但第999天的天赋礼包标为疑点，不用钻石面额推返比。
seven_file = "Q_七日直购_seven_day_direct_gift_bag_data.xml"
for d in rows(seven_file, "七日直购礼包"):
    if not str(d.get("id", "")).isdigit() or int(d["id"]) < 15:
        continue
    record = base_record("七日直购", str(d["name"]), str(d["id"]), int(d["pay_id"]), seven_file)
    paid = grouped_items(str(d["rewards"]))
    set_item_value(record, paid)
    record["开放条件_配置原文"] = f"服务器时窗={d['open_server_day']}; 购买={d['can_buy_condition']}; 开始={d['start_condition']}"
    talent = str(d["gift_type"]) == "天赋礼包"
    record["配置现行性"] = "疑点_第999天且奖励异常" if talent else "时窗有效_天数触发待验"
    record["价值口径及疑点"] = (
        "配置奖励仅121–181钻却标价198/328元；create_day=999，疑似占位或关闭，不计算返比。"
        if talent else "非锚定梦灵/道具缺价；无法算完整返比；运营实际展示待验。"
    )
    record["配置来源"] = source(seven_file, "七日直购礼包", f"A{d['_row']}:F{d['_row']}") + f" (r{revisions[seven_file][0]})"
    records.append(record)

# 职业礼包：周礼包的每日奖励列出单日量；不把未来七日机械计入购买即时价值。
career_file = "Z_职业礼包_life_package_data.xml"
activity_file = "A_活动配置_activity_data.xml"
activities = {str(d.get("base_id")): d for d in rows(activity_file, "独立循环活动配置") if str(d.get("base_id", "")).startswith("15000")}
for d in rows(career_file, "礼包"):
    record = base_record("职业礼包", f"{d['ad']}/" + ("周礼包" if d["type"] == "1" else "日礼包"), f"{d['base_id']}-{d['type']}", int(d["pay_id"]), career_file)
    immediate = grouped_items(str(d["rewards"]))
    daily = grouped_items(str(d.get("day_rewards", "")))
    set_item_value(record, immediate)
    record["分期奖励ID×数量"] = describe_items(daily)
    # 缺价覆盖两条领取轨，但锚定价值仍只表示购买即时奖励。
    all_paid_ids = sorted(set(immediate) | set(daily))
    missing_paid_ids = [item for item in all_paid_ids if item not in anchor]
    record["独立付费奖励ID数"] = len(all_paid_ids)
    record["未锚定奖励ID"] = ",".join(map(str, missing_paid_ids))
    record["未锚定奖励名称"] = ";".join(
        f"{item}:{item_names.get(item, '道具表无ID')}" for item in missing_paid_ids
    )
    activity = activities.get(str(d["base_id"]))
    record["开放条件_配置原文"] = (
        f"职业专场={d['base_id']}; 活动open_time={activity['open_time']}; 条件={activity['condition']}"
        if activity else f"职业专场={d['base_id']}; 未关联活动"
    )
    record["分期达成条件"] = "周礼包：配置每日奖励；活动单次7天，具体发放天数运行时待验" if daily else "即时奖励"
    record["配置现行性"] = "周期配置候选_实际开启待验" if activity else "未关联活动"
    record["价值口径及疑点"] = "只核购买即时奖励；每日领取额外列示，不能直接加七倍；ID41与职业碎片缺直接锚价。"
    record["配置来源"] = source(career_file, "礼包", f"A{d['_row']}:G{d['_row']}") + f" (r{revisions[career_file][0]})"
    if activity:
        record["配置来源"] += "; " + source(activity_file, "独立循环活动配置", f"A{activity['_row']}:K{activity['_row']}") + f" (r{revisions[activity_file][0]})"
    records.append(record)

# 钻石直充：本金、首次赠送与复购赠送分列，不将本金当成商业化额外价值。
shop_file = "S_商店_shopping_new_data.xml"
for d in rows(shop_file, "充值商店"):
    record = base_record("钻石直充", str(d["name"]), f"{d['shop_id']}-{d['id']}", int(d["pay_id"]), shop_file)
    principal = grouped_items(str(d["reward"]))
    first = grouped_items(str(d["first_pay_reward"]))
    repeat = grouped_items(str(d["not_first_pay_reward"]))
    assert set(principal | first | repeat) <= {1}, d
    record["付费奖励ID×数量"] = describe_items(principal)
    record["独立付费奖励ID数"] = 1
    record["直充本金_钻"] = principal.get(1, 0)
    record["直充首次额外_钻"] = first.get(1, 0)
    record["直充复购额外_钻"] = repeat.get(1, 0)
    record["直充首次到账_钻"] = principal.get(1, 0) + first.get(1, 0)
    record["直充复购到账_钻"] = principal.get(1, 0) + repeat.get(1, 0)
    record["开放条件_配置原文"] = f"shop_id={d['shop_id']}; is_close={d['is_close'] or '空'}; verify_show={d['verify_show']}"
    record["配置现行性"] = "充值商店配置候选_实际展示待验"
    record["价值口径及疑点"] = "基础钻石为人民币兑入本金；首次和复购额外分列；不以本金算礼包返比。"
    record["配置来源"] = source(shop_file, "充值商店", f"A{d['_row']}:L{d['_row']}") + f" (r{revisions[shop_file][0]})"
    records.append(record)


columns = list(records[0])
counts = collections.Counter(r["模块"] for r in records)
assert len(records) == 60, counts
assert counts == {"基金": 16, "新手礼包": 14, "七日直购": 14, "职业礼包": 10, "钻石直充": 6}, counts
assert len({r["支付ID"] for r in records}) == 60
assert not any(r["人民币售价"] == "" for r in records)

with OUT.open("w", encoding="utf-8-sig", newline="") as handle:
    writer = csv.DictWriter(handle, fieldnames=columns, delimiter="\t")
    writer.writeheader()
    writer.writerows(records)

missing = sorted({int(item) for r in records for item in str(r["未锚定奖励ID"]).split(",") if item})
print(OUT)
print("records", len(records), dict(counts))
print("missing_anchor_ids", missing)
print("complete_comparable_ratios", sum(bool(r["可比较完整返比"]) for r in records))
