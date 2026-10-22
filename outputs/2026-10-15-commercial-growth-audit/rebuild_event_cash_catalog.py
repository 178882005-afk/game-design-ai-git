"""Rebuild the current-new-server cash event catalog from local SVN sources.

Scope: servers opened 2026-09-04 through 2035-12-31, five named shop
activities and the 120008 paid activity pass. Values describe configured
diamond-equivalent access costs, not observed runtime or attained rewards.
"""

from __future__ import annotations

import collections
import csv
import re
import xml.etree.ElementTree as ET
from pathlib import Path

import openpyxl


BASE = Path("E:/x1/配置/trunk/xml_gy/normal")
WORKBOOK = Path("E:/x1/配置/trunk/策划文档/数值文档/《梦境护卫队》6-1商业化数值.xlsx")
OUT = Path(__file__).with_name("event_cash_catalog.tsv")
NS = "{urn:schemas-microsoft-com:office:spreadsheet}"
NEW_SERVERS = "{{2026,9,4},{2035,12,31}}"
SHOP_BASES = {"21037", "21902", "21901", "21020", "21032"}
ACTIVITY_NAMES = {"21037": "许愿补给", "21902": "炼梦礼包", "21901": "星轨礼包", "21020": "寻梦礼包", "21032": "寻珍礼包", "120008": "寻珍助礼战令"}
TICKET_DRAW_BASE = {100104: "40015", 5600083: "24007", 5600070: "49001", 5600200: "10001", 100090: "40012"}


def xml_table(filename: str, sheet_index: int) -> list[dict[str, str]]:
    ws = ET.parse(BASE / filename).getroot().findall(NS + "Worksheet")[sheet_index]
    rows = ws.find(NS + "Table").findall(NS + "Row")

    def cells(row):
        data = {}
        column = 1
        for cell in row.findall(NS + "Cell"):
            column = int(cell.get(NS + "Index") or column)
            value = cell.find(NS + "Data")
            data[column] = value.text if value is not None and value.text is not None else ""
            column += 1
        return data

    header = cells(rows[1])
    result = []
    # SpreadsheetML omits empty rows and jumps with ss:Index; the list index
    # is not necessarily the Excel row address used by the design team.
    number = 2
    for row in rows[2:]:
        number = int(row.get(NS + "Index") or number + 1)
        values = cells(row)
        if values:
            result.append({"_row": number, **{key: values.get(index, "") for index, key in header.items() if key}})
    return result


def pairs(value: str) -> list[tuple[int, int]]:
    return [(int(item), int(float(count))) for item, count in re.findall(r"\{\s*(\d+)\s*,\s*([\d.]+)\s*\}", value or "")]


def aggregate_rewards(values: list[str]) -> dict[int, int]:
    counts = collections.Counter()
    for value in values:
        counts.update(dict(pairs(value)))
    return dict(sorted(counts.items()))


def reward_text(rewards: dict[int, int]) -> str:
    return ";".join(f"{item}×{count}" for item, count in rewards.items())


def display(value: float | int) -> str:
    return str(int(value)) if value == int(value) else f"{value:.3f}".rstrip("0").rstrip(".")


def main():
    activity = {row["base_id"]: row for row in xml_table("A_活动配置_activity_data.xml", 0)
                if row.get("base_id") in SHOP_BASES | {"120008"}
                and row.get("server_condition") == NEW_SERVERS}
    assert set(activity) == SHOP_BASES | {"120008"}, set(activity)

    wb = openpyxl.load_workbook(WORKBOOK, read_only=True, data_only=True)
    sheet = wb["价值表"]
    anchors = {}
    for row in range(4, 125):
        item_id, value = sheet[f"D{row}"].value, sheet[f"F{row}"].value
        try:
            anchors[int(item_id)] = (float(value), f"6-1/价值表!D{row},F{row}")
        except (TypeError, ValueError):
            pass
    assert anchors[1][0] == 1

    # Conditional ticket anchors: spending one ticket instead of this many
    # diamonds performs the same configured draw action. Keep these separate
    # from the 6-1 direct item-value anchors.
    conditional = {}
    for row in xml_table("A_活动抽奖_activity_draw_data.xml", 0):
        if row.get("base_id") not in {"40015", "49001", "40012"}:
            continue
        ticket = pairs(row.get("single_cost") or "")
        diamond = pairs(row.get("diamond_buy_cost") or "")
        assert len(ticket) == len(diamond) == 1 and diamond[0][0] == 1 and ticket[0][1] == 1
        conditional[ticket[0][0]] = (float(diamond[0][1]), f"A_活动抽奖_activity_draw_data.xml/活动抽奖!{row['_row']}:{row['base_id']}单抽票/钻石替代")
    for row in xml_table("A_活动轮次抽奖_activity_round_draw_data.xml", 1):
        if row.get("base_id") == "24007":
            diamond = pairs(row.get("diamond_buy_cost") or "")
            assert len(diamond) == 1 and diamond[0][0] == 1
            conditional[int(row["item"])] = (float(diamond[0][1]), f"A_活动轮次抽奖_activity_round_draw_data.xml/方案配置!{row['_row']}:24007票/钻石替代")
    for row in xml_table("C_抽卡_draw_card_data.xml", 0):
        if row.get("id") == "10001":
            ticket = pairs(row.get("consume_2") or "")
            diamond = pairs(row.get("consume_1") or "")
            assert len(ticket) == len(diamond) == 1 and ticket[0][1] == 1 and diamond[0][0] == 1
            conditional[ticket[0][0]] = (float(diamond[0][1]), f"C_抽卡_draw_card_data.xml/抽卡!{row['_row']}:10001票/钻石替代")
    assert set(TICKET_DRAW_BASE) <= set(conditional)

    pay = {row["id"]: row for row in xml_table("C_充值_pay_data.xml", 0) if row.get("id")}
    items = {int(row["id"]): row.get("name", "") for row in xml_table("D_道具_item_data.xml", 0)
             if str(row.get("id", "")).isdigit()}
    shop = xml_table("A_活动商店_activity_shop_data.xml", 0)
    war = xml_table("A_活动战令_activity_war_order_data.xml", 0)
    war_nodes = xml_table("A_活动战令_activity_war_order_data.xml", 1)

    fields = ["模块", "活动ID", "活动base_id", "适用服务器开服日", "活动起始", "活动截止", "解锁条件", "SKU_ID", "商品名", "支付ID",
              "现金价_元", "折钻成本", "奖励ID及数量", "奖励名称", "6-1直接锚值_钻", "票券等效锚值_钻", "合计估值_钻", "返比",
              "未定价ID", "估值状态", "直接锚价及来源", "票券单位价及来源", "配置展示折扣", "购买次数配置", "活动来源", "商品来源", "价格来源", "备注"]
    output = []

    def add(base_id: str, sku: str, name: str, pay_id: str, rewards: dict[int, int], source: str,
            discount: str = "", limit: str = "", note: str = ""):
        assert pay_id in pay, pay_id
        a, p = activity[base_id], pay[pay_id]
        cash = float(p["real_currency"])
        direct = 0.0
        indirect = 0.0
        missing = []
        explanations = []
        direct_explanations = []
        for item_id, count in rewards.items():
            if item_id in anchors:
                direct += count * anchors[item_id][0]
                value, proof = anchors[item_id]
                direct_explanations.append(f"{item_id}={display(value)}钻/《梦境护卫队》6-1商业化数值.xlsx/{proof}")
            elif item_id in conditional:
                value, proof = conditional[item_id]
                indirect += count * value
                explanations.append(f"{item_id}={display(value)}钻/{proof}")
            else:
                missing.append(item_id)
        total = direct + indirect
        if missing:
            status = "未闭合"
            ratio = ""
        elif indirect:
            status = "条件估值：同次抽奖票/钻石替代成本"
            ratio = display(total / (cash * 10))
        else:
            status = "6-1直接锚值"
            ratio = display(total / (cash * 10))
        output.append({
            "模块": ACTIVITY_NAMES[base_id], "活动ID": a["id"], "活动base_id": base_id,
            "适用服务器开服日": "2026-09-04至2035-12-31", "活动起始": a.get("begin_time", ""),
            "活动截止": a.get("end_time", ""), "解锁条件": a.get("condition", ""),
            "SKU_ID": sku, "商品名": name, "支付ID": pay_id, "现金价_元": display(cash),
            "折钻成本": display(cash * 10), "奖励ID及数量": reward_text(rewards),
            "奖励名称": ";".join(f"{items.get(i, '未知')}×{count}" for i, count in rewards.items()),
            "6-1直接锚值_钻": display(direct), "票券等效锚值_钻": display(indirect),
            "合计估值_钻": display(total) if not missing else "", "返比": ratio,
            "未定价ID": ",".join(map(str, missing)), "估值状态": status,
            "直接锚价及来源": ";".join(direct_explanations),
            "票券单位价及来源": ";".join(explanations), "配置展示折扣": discount,
            "购买次数配置": limit,
            "活动来源": f"A_活动配置_activity_data.xml/活动配置!{a['_row']}", "商品来源": source,
            "价格来源": f"C_充值_pay_data.xml/支付表!{p['_row']}", "备注": note,
        })

    for row in shop:
        base_id = row.get("base_id")
        if base_id in SHOP_BASES and row.get("pay_id"):
            rewards = aggregate_rewards([row["rewards"]])
            limit = f"buy_count={row.get('buy_count') or ''};reset={row.get('reset') or ''};reset_args={row.get('reset_args') or ''};limit_times={row.get('limit_times') or ''}"
            add(base_id, row["id"], row["name"], row["pay_id"], rewards,
                f"A_活动商店_activity_shop_data.xml/活动商城!{row['_row']}", row.get("discount_show") or "", limit,
                "需达到该开服日与章节；票券估值为相同抽奖的钻石替代成本，运行时是否完全等价未实测。")

    war_row = next(row for row in war if row.get("base_id") == "120008")
    paid_nodes = [row for row in war_nodes if row.get("node_id", "").startswith("120008")]
    assert len(paid_nodes) == 25 and all(row.get("pay_reward") for row in paid_nodes)
    paid_rewards = aggregate_rewards([row["pay_reward"] for row in paid_nodes])
    add("120008", "120008付费轨道25级", "寻珍助礼", war_row["pay_id"], paid_rewards,
        f"A_活动战令_activity_war_order_data.xml/活动方案!{war_row['_row']};活动奖励!{paid_nodes[0]['_row']}:{paid_nodes[-1]['_row']}付费列",
        "", "",
        "按付费轨道25级全领计算，不含免费轨道；需达到活动开启、章节与每级积分条件。配置 buy_cond=" + str(war_row.get("buy_cond") or "") + " 仅限制钻石买积分 buy_exp，不限制现金开付费轨；索引代码 project server/src/mod/operating_activities/role_activity_war_order.erl:L429-L435,L530-L537,L314-L341，运行服未验证。")

    assert len(output) == 16, len(output)
    with OUT.open("w", encoding="utf-8-sig", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=fields, delimiter="\t")
        writer.writeheader()
        writer.writerows(output)
    print(f"Wrote {len(output)} records to {OUT}")
    for row in output:
        print(row["模块"], row["SKU_ID"], row["现金价_元"], row["奖励ID及数量"], row["合计估值_钻"], row["返比"], row["估值状态"])


if __name__ == "__main__":
    main()
