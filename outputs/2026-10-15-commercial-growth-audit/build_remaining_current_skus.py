"""Build a dated, configuration-only inventory beyond the earlier three catalogs.

Run after the three anchor/catalog builders. The date test asks whether at least
one server opening date satisfies the configured activity window; it does not
prove a live server, a player's unlock, or a successful purchase.
"""

from __future__ import annotations

import collections
import csv
import datetime as dt
import re
from pathlib import Path

from inspect_remaining_sources import path, sheets


OUT = Path(__file__).with_name("remaining_current_skus.tsv")
ANCHOR = Path(__file__).with_name("item_anchor_ledger.tsv")
EXISTING_EVENT = Path(__file__).with_name("event_cash_catalog.tsv")
PAYMENT_EVIDENCE = Path(__file__).with_name("remaining_cash_payments_20261015.tsv")
TODAY = dt.date(2026, 10, 15)
PAIR = re.compile(r"\{\s*(\d+)\s*,\s*([\d.]+)\s*\}")


def read_tsv(file: Path) -> list[dict[str, str]]:
    with file.open(encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f, delimiter="\t"))


def get_sheet(suffix: str, name: str) -> list[dict[str, str]]:
    found = [data for sheet_name, data in sheets(path(suffix)) if sheet_name == name]
    assert len(found) == 1, (suffix, name)
    return found[0]


def ymds(text: str) -> list[dt.date]:
    found = re.findall(r"\{\s*(20\d\d)\s*,\s*(\d+)\s*,\s*(\d+)\s*\}", text or "")
    return [dt.date(*map(int, match)) for match in found]


def server_day(text: str) -> int | None:
    m = re.search(r"\{\s*server_open_day\s*,\s*(\d+)\s*\}", text or "")
    return int(m.group(1)) if m else None


def activity_reachable(row: dict[str, str]) -> tuple[bool, str]:
    """Existence test over eligible server opening dates, not a live-server test."""
    opened = ymds(row.get("server_condition", ""))
    start_day = server_day(row.get("begin_time", ""))
    end_day = server_day(row.get("end_time", ""))
    if start_day is not None and end_day is not None:
        low = TODAY - dt.timedelta(days=end_day - 1)
        high = TODAY - dt.timedelta(days=start_day - 1)
        if opened:
            low, high = max(low, opened[0]), min(high, opened[-1])
        return low <= high, f"可达开服日={low}至{high}" if low <= high else "活动日与服务器开服窗不相交"
    begins, ends = ymds(row.get("begin_time", "")), ymds(row.get("end_time", ""))
    if begins and ends:
        okay = begins[0] <= TODAY <= ends[0] and (not opened or opened[0] <= TODAY)
        return okay, "自然日期命中；服务器开服窗存在候选" if okay else "自然日期已结束或未开始"
    return False, "未知活动时间表达式，未纳入"


def item_date_reachable(text: str) -> bool:
    if "normal_time_limit" not in text:
        return True
    dates = ymds(text)
    return len(dates) >= 2 and dates[0] <= TODAY <= dates[1]


def item_pairs(raw: str) -> list[tuple[int, float]]:
    return [(int(i), float(q)) for i, q in PAIR.findall(raw or "")]


def format_items(raw: str) -> str:
    return ";".join(f"{i}×{q:g}" for i, q in item_pairs(raw)) or raw


anchors = {int(x["道具ID"]): x for x in read_tsv(ANCHOR)}
pay = {int(x["id"]): x for x in get_sheet("pay_data", "支付表") if x.get("id", "").isdigit()}
existing_event = {(x["活动base_id"], x["SKU_ID"]) for x in read_tsv(EXISTING_EVENT) if x.get("SKU_ID")}
CORE = {("25002", id_) for id_ in ("1806", "1807", "1808")}
pay_evidence = collections.defaultdict(list)
if PAYMENT_EVIDENCE.exists():
    for payment_row in read_tsv(PAYMENT_EVIDENCE):
        pay_evidence[payment_row["package_id"]].append(payment_row)


def valuation(raw: str, denominator: float | None) -> tuple[str, str, str, str]:
    pairs = item_pairs(raw)
    if not pairs:
        return "未闭合_奖励非静态ID×数量", "", "", ""
    total = 0.0
    conditional, missing = [], []
    for item, qty in pairs:
        anchor = anchors.get(item)
        if anchor is None or not anchor["基础单价_钻"]:
            missing.append(item)
            continue
        if anchor["价格状态"] not in ("直接ID锚", "严格映射锚"):
            conditional.append(item)
        total += float(anchor["基础单价_钻"]) * qty
    missing_text = ",".join(map(str, sorted(set(missing))))
    if missing:
        return "未闭合_部分奖励无道具锚", f"{total:g}", "", missing_text
    status = "条件估值_有非全局锚" if conditional else "严格核价_静态奖励"
    ratio = f"{total/denominator:.4f}" if denominator and denominator > 0 else ""
    return status, f"{total:g}", ratio, ""


def currency_and_price(pay_id: str, cost: str) -> tuple[str, str, str, float | None, str]:
    if pay_id:
        payment = pay.get(int(pay_id)) if pay_id.isdigit() else None
        if payment and payment.get("real_currency"):
            price = payment["real_currency"]
            return "人民币", price, "元", float(price) * 10, f"C_充值_pay_data.xml/支付表!{payment['_row']}"
        return "人民币", "", "元", None, "支付ID未匹配到现行支付表"
    costs = item_pairs(cost)
    if len(costs) == 1 and costs[0][0] == 1:
        return "钻石", f"{costs[0][1]:g}", "钻", costs[0][1], "商品 cost 字段"
    if costs:
        return "活动代币", format_items(cost), "多币种", None, "商品 cost 字段；不能直接折钻"
    return "免费", "0", "", None, ""


FIELDS = [
    "模块", "方案base_id", "活动配置ID", "商品ID", "商品名", "支付类型", "支付ID", "标价", "币种", "奖励ID×数量",
    "购买次数", "开放及触发条件", "配置可达性", "价锚完整性", "名义奖励价值_钻", "名义返比", "未锚奖励ID",
    "30日支付订单_按pay_id", "30日支付金额_按pay_id", "支付库当前别名", "商品来源", "活动来源", "价格来源", "说明",
]
records: list[dict[str, str]] = []


def append_record(*, module: str, base: str, act_id: str, sku: str, name: str, pay_id: str, cost: str,
                  reward: str, buy_limit: str, condition: str, reachable: str, product_source: str,
                  activity_source: str, note: str = "") -> None:
    kind, price, unit, denominator, price_source = currency_and_price(pay_id, cost)
    if kind == "免费":
        return
    status, known_value, ratio, missing = valuation(reward, denominator)
    if kind == "活动代币":
        ratio = ""
        status += "；多币种成本未换算"
    if not price:
        status += "；缺现行支付价"
    evidence = pay_evidence.get(pay_id, []) if pay_id else []
    orders = str(sum(int(x["orders_30d"]) for x in evidence)) if pay_id else ""
    amount = f"{sum(float(x['amount_30d']) for x in evidence):g}" if pay_id else ""
    aliases = ";".join(sorted({x["current_alias"] for x in evidence if x["current_alias"]}))
    if pay_id in {"2010007", "2010008", "2010009"}:
        note += " 支付库当前别名写许愿礼包，商品 XML 写星海礼包；需按交易时方案确认归属。"
    records.append({
        "模块": module, "方案base_id": base, "活动配置ID": act_id, "商品ID": sku, "商品名": name,
        "支付类型": kind, "支付ID": pay_id, "标价": price, "币种": unit, "奖励ID×数量": format_items(reward),
        "购买次数": buy_limit, "开放及触发条件": condition, "配置可达性": reachable,
        "价锚完整性": status, "名义奖励价值_钻": known_value, "名义返比": ratio, "未锚奖励ID": missing,
        "30日支付订单_按pay_id": orders, "30日支付金额_按pay_id": amount, "支付库当前别名": aliases,
        "商品来源": product_source, "活动来源": activity_source, "价格来源": price_source,
        "说明": note + (" 支付数据只按 pay_id 粗匹配，不证明交易时活动方案或实际发奖；查询窗 2026-09-15 至 2026-10-14。" if pay_id else ""),
    })


activity_rows = get_sheet("activity_data", "活动配置")
eligible_activities = collections.defaultdict(list)
for act in activity_rows:
    if act.get("data_cfg") not in ("activity_shop_data", "activity_recommend_gift_data", "role_shop_activity"):
        continue
    okay, open_range = activity_reachable(act)
    if okay:
        eligible_activities[(act.get("base_id", ""), act.get("data_cfg", ""))].append((act, open_range))


# A_活动商店: all paid rows under an activity with at least one date-eligible cohort.
for item in get_sheet("activity_shop_data", "活动商城"):
    base, sku = item.get("base_id", ""), item.get("id", "")
    if (base, sku) in existing_event | CORE or not item_date_reachable(item.get("condition", "")):
        continue
    acts = eligible_activities.get((base, "activity_shop_data"), [])
    if not acts:
        continue
    act_ids = ",".join(x["id"] for x, _ in acts)
    act_rows = ",".join(str(x["_row"]) for x, _ in acts)
    windows = ";".join(f"活动{x['id']}:{rng}" for x, rng in acts)
    append_record(
        module="活动商城", base=base, act_id=act_ids, sku=sku, name=item.get("name", ""),
        pay_id=item.get("pay_id", ""), cost=item.get("cost", ""), reward=item.get("rewards", ""),
        buy_limit=f"buy_count={item.get('buy_count','')};reset={item.get('reset','')};limit_times={item.get('limit_times','')}",
        condition=f"{windows};活动条件=" + ";".join(x.get("condition", "") for x, _ in acts) + ";商品条件=" + item.get("condition", ""),
        reachable="活动日/开服窗存在配置候选；玩家条件与运行服未验",
        product_source=f"A_活动商店_activity_shop_data.xml/活动商城!{item['_row']}",
        activity_source=f"A_活动配置_activity_data.xml/活动配置!{act_rows}",
        note="若多条活动配置引用同一 base_id，商品只列一次；现金支付流水须按交易时活动方案归因。",
    )


# A_活动推送礼包: 23006 is the only current reachable program on the snapshot date.
for item in get_sheet("activity_recommend_gift_data", "礼包配置"):
    base = item.get("base_id", "")
    acts = eligible_activities.get((base, "activity_recommend_gift_data"), [])
    if not acts:
        continue
    act_ids = ",".join(x["id"] for x, _ in acts)
    act_rows = ",".join(str(x["_row"]) for x, _ in acts)
    append_record(
        module="活动推送礼包", base=base, act_id=act_ids, sku=item.get("gift_id", ""),
        name=item.get("name", ""), pay_id=item.get("pay_id", ""), cost=item.get("buy_cost", ""),
        reward=item.get("reward", ""), buy_limit=item.get("limit_count", ""),
        condition=";".join(f"活动{x['id']}:{rng};{x.get('condition','')}" for x, rng in acts),
        reachable="活动日/开服窗存在配置候选；玩家条件与运行服未验",
        product_source=f"A_活动推送礼包_activity_recommend_gift_data.xml/礼包配置!{item['_row']}",
        activity_source=f"A_活动配置_activity_data.xml/活动配置!{act_rows}",
    )


# G_个推礼包: only rows with a stable ID and diamond need, within server time.
for item in get_sheet("recommend_gift_data", "礼包"):
    if not item.get("id", "").isdigit() or item.get("type") != "钻石":
        continue
    starts, ends = ymds(item.get("start_open_server_time", "")), ymds(item.get("end_open_server_time", ""))
    if not starts or not ends or not starts[0] <= TODAY <= ends[0]:
        continue
    append_record(
        module="章节个推礼包", base="", act_id="", sku=item["id"], name=item.get("name", ""),
        pay_id=item.get("pay_id", ""), cost=item.get("need", ""), reward=item.get("rewards", ""),
        buy_limit=item.get("limit_count", ""),
        condition=f"服务器开服时窗={item.get('start_open_server_time')}至{item.get('end_open_server_time')};触发={item.get('trigger')};持续={item.get('duration')}秒",
        reachable="配置时间窗有效；须达到章节且触发，实际弹出/运行服未验",
        product_source=f"G_个推礼包_recommend_gift_data.xml/礼包!{item['_row']}", activity_source="",
        note="无固定全天在售状态；按章节触发后有 10800 秒倒计时。",
    )


# Limited-time trigger gifts have no calendar window in this XML. Keep as
# explicit candidates rather than promoting them to confirmed current sales.
for item in get_sheet("limited_time_gift_data", "限时礼包"):
    append_record(
        module="限时触发礼包", base="", act_id="", sku=item.get("gift_id", ""), name=f"触发礼包{item.get('gift_id','')}",
        pay_id=item.get("pay_id", ""), cost="", reward=item.get("reward", "") + item.get("dynamic_reward", ""),
        buy_limit=f"is_multiple={item.get('is_multiple','')}",
        condition=f"event={item.get('event')};condition={item.get('condition')};倒计时={item.get('countdown')}秒",
        reachable="仅有触发配置；无日期门槛但触发/展示/运行服均未验",
        product_source=f"limited_time_gift_data.xml/限时礼包!{item['_row']}", activity_source="",
        note="dynamic_reward 非静态道具列表，价值不能按 reward 静态字段完整计算。" if item.get("dynamic_reward") else "",
    )
    if item.get("dynamic_reward"):
        records[-1]["奖励ID×数量"] = f"固定={format_items(item.get('reward',''))};动态原文={item['dynamic_reward']}"
        records[-1]["价锚完整性"] = "未闭合_动态奖励需按触发角色实例确定"
        records[-1]["名义返比"] = ""


with OUT.open("w", encoding="utf-8-sig", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=FIELDS, delimiter="\t")
    writer.writeheader()
    writer.writerows(records)

print(f"{OUT}: {len(records)} paid rows")
print("by module:", collections.Counter(x["模块"] for x in records))
print("by payment type:", collections.Counter(x["支付类型"] for x in records))
print("eligible activity base ids:", sorted({base for base, _ in eligible_activities}))
