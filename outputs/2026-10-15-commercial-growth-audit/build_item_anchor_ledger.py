"""Build the item-centred price ledger from the four commercial catalogs.

The 6-1 upper value block is the direct ID anchor. Other values come only from
the reviewed base reward ledger or same-draw ticket alternatives in the event
catalog. A blank price is deliberate; no item value is inferred from a bundle.

Run after rebuilding the four input catalogs from the same SVN snapshot.
"""

from __future__ import annotations

import argparse
import collections
import csv
import re
import xml.etree.ElementTree as ET
from pathlib import Path

import openpyxl


HERE = Path(__file__).resolve().parent
DEFAULT_ROOT = Path("E:/x1/配置/trunk")
NS = "{urn:schemas-microsoft-com:office:spreadsheet}"
REWARD_PAIR = re.compile(r"(?<!\d)(\d+)×[\d.]+")
TICKET_PRICE = re.compile(r"(?<!\d)(\d+)=([\d.]+)钻/([^;]+)")

CONFLICT_NOTES = {
    1: "用户确认 6 元直充得 60 钻，现金换算为 1 元=10 钻；此处 1 钻=1 钻，现金换算不可误读成道具价格。",
    44: "现行 6-1 上半区 F7=10 钻；同表 G7 的 1.4 元和旧 3-7 的 14 钻口径不作为现行锚价。",
    50001: "0.1 钻为道具直锚；日礼包 1012 的标称折扣与奖励价值不匹配，应检查该商品，不能反推改写道具单价。",
    100040: "当日特权卡是当日权益服务；无独立直售价和固定保底道具流入。索引代码 dg-server-engineering/server:src/mod/month_card/role_month_cards.erl:L706-L717,L538-L549；运行服未验证。不可按 18 元月卡/30 天分摊。",
    10140370: "用户确认首充是特殊促销；咕勇者服饰单列为促销权益，暂不设跨商品基础锚，也不套用攻击代理价。",
    10340370: "用户确认首充是特殊促销；咕勇者头饰单列为促销权益，暂不设跨商品基础锚，也不套用攻击代理价。",
    6200012: "6-1 下半区的人民币/钻石栏位颠倒且缺现行直接 ID 锚；4800 钻经隐藏商店与历史藏品表交叉验证，仅作条件锚，不能用下半区 F 列。",
    6220021: "6-1 下半区的人民币/钻石栏位颠倒且缺现行直接 ID 锚；2400 钻经隐藏商店交叉验证，仅作条件锚，不能用下半区 F 列。",
}


def read_tsv(filename: str) -> list[dict[str, str]]:
    with (HERE / filename).open("r", encoding="utf-8-sig", newline="") as stream:
        return list(csv.DictReader(stream, delimiter="\t"))


def reward_ids(value: str) -> set[int]:
    return {int(item_id) for item_id in REWARD_PAIR.findall(value or "")}


def formatted_price(value: float) -> str:
    return f"{value:.8f}".rstrip("0").rstrip(".")


def direct_anchors(book_path: Path) -> dict[int, tuple[float, str]]:
    book = openpyxl.load_workbook(book_path, read_only=True, data_only=True)
    sheet = book["价值表"]
    anchors = {}
    for row in range(4, 125):
        item_id, price = sheet[f"D{row}"].value, sheet[f"F{row}"].value
        if not isinstance(item_id, (float, int)) or not isinstance(price, (float, int)):
            continue
        key = int(item_id)
        proof = f"《梦境护卫队》6-1商业化数值.xlsx/价值表!D{row},F{row}"
        if key in anchors and anchors[key][0] != float(price):
            raise ValueError(f"Duplicate direct anchor for {key}: {anchors[key]} vs {price}")
        anchors[key] = (float(price), proof)
    book.close()
    if anchors.get(1, (None,))[0] != 1:
        raise ValueError("Diamond self-anchor is not 1; review the workbook before using this ledger")
    return anchors


def item_definitions(path: Path) -> dict[int, tuple[str, str]]:
    """Read SpreadsheetML with explicit row/cell indexes, not list positions."""
    workbook = ET.parse(path).getroot()
    sheet = next(ws for ws in workbook.findall(NS + "Worksheet")
                 if ws.get(NS + "Name") == "道具信息")
    output = {}
    row_number = 0
    headers = {}
    for row in sheet.find(NS + "Table").findall(NS + "Row"):
        row_number = int(row.get(NS + "Index") or row_number + 1)
        cells = {}
        column = 1
        for cell in row.findall(NS + "Cell"):
            column = int(cell.get(NS + "Index") or column)
            value = cell.find(NS + "Data")
            cells[column] = value.text if value is not None and value.text is not None else ""
            column += 1
        if row_number == 2:
            headers = {value: column for column, value in cells.items() if value}
        if row_number <= 2:
            continue
        item_id = cells.get(headers["id"], "")
        if not item_id.isdigit():
            continue
        output[int(item_id)] = (
            cells.get(headers["name"], ""),
            f"D_道具_item_data.xml/道具信息!{row_number}",
        )
    return output


def catalogue_coverage(
    base: list[dict[str, str]],
    additional: list[dict[str, str]],
    event: list[dict[str, str]],
    remaining: list[dict[str, str]],
) -> dict[int, dict[str, set[str]]]:
    coverage = collections.defaultdict(lambda: collections.defaultdict(set))
    for row in base:
        item_id = int(row["奖励ID"])
        coverage[item_id]["基础商品"].add(f"{row['模块']}:{row['商品ID']}")
    for row in additional:
        for field in ("付费奖励ID×数量", "分期奖励ID×数量"):
            for item_id in reward_ids(row[field]):
                coverage[item_id]["扩展现金目录"].add(f"{row['模块']}:{row['商品ID']}")
    for row in event:
        for item_id in reward_ids(row["奖励ID及数量"]):
            coverage[item_id]["新服活动"].add(f"{row['模块']}:{row['SKU_ID']}")
    for row in remaining:
        for item_id in reward_ids(row["奖励ID×数量"]):
            coverage[item_id]["现行补录商品"].add(f"{row['模块']}:{row['商品ID']}")
    return coverage


def reviewed_base_prices(base: list[dict[str, str]]) -> dict[int, dict[str, str]]:
    prices = {}
    fields = ("单价钻石", "价格等级", "估值方法", "锚价来源")
    for row in base:
        item_id = int(row["奖励ID"])
        record = {key: row[key] for key in fields}
        record["未闭合说明"] = row["未闭合说明"]
        if item_id in prices and any(prices[item_id][key] != row[key] for key in fields):
            raise ValueError(f"Inconsistent reviewed base price for item {item_id}")
        prices[item_id] = record
    return prices


def same_draw_prices(event: list[dict[str, str]]) -> dict[int, tuple[float, str, set[str]]]:
    prices = {}
    for row in event:
        for found in TICKET_PRICE.finditer(row["票券单位价及来源"] or ""):
            item_id = int(found[1])
            value = float(found[2])
            source = found[3]
            if item_id in prices:
                old_value, old_source, modules = prices[item_id]
                if (value, source) != (old_value, old_source):
                    raise ValueError(f"Ticket {item_id} has conflicting draw alternatives")
                modules.add(row["模块"])
            else:
                prices[item_id] = (value, source, {row["模块"]})
    return prices


def build(root: Path, output: Path) -> list[dict[str, str | int]]:
    base = read_tsv("commercial_reward_lines.tsv")
    additional = read_tsv("additional_cash_catalog.tsv")
    event = read_tsv("event_cash_catalog.tsv")
    remaining = read_tsv("remaining_current_skus.tsv")
    coverage = catalogue_coverage(base, additional, event, remaining)
    direct = direct_anchors(root / "策划文档/数值文档/《梦境护卫队》6-1商业化数值.xlsx")
    items = item_definitions(root / "xml_gy/normal/D_道具_item_data.xml")
    base_prices = reviewed_base_prices(base)
    tickets = same_draw_prices(event)
    rows = []
    for item_id in sorted(coverage):
        names = {row["道具名"] for row in base if int(row["奖励ID"]) == item_id and row["道具名"]}
        name, item_source = items.get(item_id, ("", "D_道具_item_data.xml/道具信息：查无该ID"))
        if name and names and name not in names:
            raise ValueError(f"Name mismatch for {item_id}: {name} vs {names}")
        name = name or (sorted(names)[0] if names else "（道具表无此 ID，需核类型）")
        base_price = base_prices.get(item_id, {})
        limit = CONFLICT_NOTES.get(item_id, base_price.get("未闭合说明", ""))
        if item_id in direct:
            value, source = direct[item_id]
            if base_price.get("单价钻石") and float(base_price["单价钻石"]) != value:
                raise ValueError(f"Base ledger and direct ID anchor disagree on {item_id}")
            status, confidence, method, scope = "直接ID锚", "高：配置直锚", "6-1 上半区按 ID 直取", "全局基础价；具体发放和可购买性另验"
        elif base_price.get("单价钻石"):
            value = float(base_price["单价钻石"])
            source = base_price["锚价来源"]
            method = base_price["估值方法"]
            if base_price["价格等级"] == "严格":
                status, confidence, scope = "严格映射锚", "中：非直接 ID", "仅同名/同品质或同奖池、相应箱体"
            else:
                status, confidence, scope = "条件估值锚", "中：条件口径", "仅相应品质、箱体或历史藏品口径"
        elif item_id in tickets:
            value, source, modules = tickets[item_id]
            status, confidence, method = "活动条件等效价", "中：同次抽取", "同次抽取票券与钻石替代成本"
            scope = "仅" + "、".join(sorted(modules)) + "的对应抽取；不可作为跨活动全局道具价"
        else:
            value, source, method, scope, confidence = None, "", "未定价", "待定义", "待确认"
            if item_id == 100040:
                status, method, scope = "权益服务未定价", "当日权益，不设固定道具流入", "仅首充赠送的当日服务权益"
            elif item_id in (10140370, 10340370):
                status, method, scope = "首充专案未定价", "特殊促销权益单列", "仅首充累充 128 元档；跨商品销售前另定锚"
            else:
                status = "未定价"
                if not limit:
                    limit = "6-1 上半区价值表 D4:F124 未见该 ID；不由礼包售价或同名道具反推。"
        counts = {group: len(coverage[item_id][group]) for group in ("基础商品", "扩展现金目录", "新服活动", "现行补录商品")}
        all_refs = [f"{group}/{sku}" for group in counts for sku in sorted(coverage[item_id][group])]
        rows.append({
            "道具ID": item_id,
            "道具名": name,
            "基础单价_钻": "" if value is None else formatted_price(value),
            "价格状态": status,
            "置信度": confidence,
            "估值方法": method,
            "适用范围": scope,
            "精确估值来源": source,
            "道具定义来源": item_source,
            "冲突与使用限制": limit,
            "基础商品关联数": counts["基础商品"],
            "扩展现金目录关联数": counts["扩展现金目录"],
            "新服活动关联数": counts["新服活动"],
            "现行补录商品关联数": counts["现行补录商品"],
            "下游商品关联总数": sum(counts.values()),
            "关联商品标识": ";".join(all_refs),
        })
    fields = list(rows[0])
    with output.open("w", encoding="utf-8-sig", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=fields, delimiter="\t")
        writer.writeheader()
        writer.writerows(rows)
    return rows


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=DEFAULT_ROOT, help="local SVN working-copy root")
    parser.add_argument("--output", type=Path, default=HERE / "item_anchor_ledger.tsv")
    args = parser.parse_args()
    result = build(args.root, args.output)
    print(f"{args.output}: {len(result)} distinct item IDs")
    print(collections.Counter(row["价格状态"] for row in result))
