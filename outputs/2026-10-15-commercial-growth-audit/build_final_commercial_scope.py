"""Rebuild the 2026-10-15 configuration-only commercial scope ledger.

The output deliberately separates purchasable slots, repeat-buy tiers, rotating
pool candidates and spend milestones.  A reachable configuration is not proof
of live exposure or of a particular pay_id transaction.
"""

from __future__ import annotations

import collections
import csv
import datetime as dt
import re
from pathlib import Path

from inspect_remaining_sources import path as xml_path, sheets


HERE = Path(__file__).parent
OUT = HERE / "final_commercial_scope.tsv"
ITEM_OUT = HERE / "final_item_anchor_ledger.tsv"
QUARANTINED_OUT = HERE / "isolated_seven_day_direct.tsv"
ROOKIE_QUARANTINED_OUT = HERE / "isolated_rookie_gift.tsv"
TRIGGER_QUARANTINED_OUT = HERE / "isolated_limited_time_gift.tsv"
AS_OF = dt.date(2026, 10, 15)
PAIR = re.compile(r"\{\s*(\d+)\s*,\s*([\d.]+)\s*\}")
TIMES = re.compile(r"(\d+)×([\d.]+)")


def read_tsv(name: str) -> list[dict[str, str]]:
    with (HERE / name).open(encoding="utf-8-sig", newline="") as handle:
        return list(csv.DictReader(handle, delimiter="\t"))


def sheet(suffix: str, name: str) -> list[dict[str, str]]:
    file = (Path("E:/x1/配置/trunk/xml_gy/normal/D_道具_item_data.xml")
            if suffix == "item_data" else xml_path(suffix))
    found = [rows for sheet_name, rows in sheets(file) if sheet_name == name]
    assert len(found) == 1, (suffix, name)
    return found[0]


def reward_pairs(raw: str) -> list[tuple[str, float]]:
    # Dynamic reward expressions in the limited-time module are not item lists.
    raw = raw.split(";动态原文=", 1)[0]
    if "×" in raw:
        return [(item, float(qty)) for item, qty in TIMES.findall(raw)]
    return [(item, float(qty)) for item, qty in PAIR.findall(raw)]


def fmt(value: float | str | None) -> str:
    if value is None or value == "":
        return ""
    return f"{float(value):g}"


def pair_text(raw: str) -> str:
    return ";".join(f"{item}×{fmt(qty)}" for item, qty in reward_pairs(raw))


def dates(raw: str) -> list[dt.date]:
    return [dt.date(*map(int, x)) for x in re.findall(r"\{\s*(20\d\d)\s*,\s*(\d+)\s*,\s*(\d+)\s*\}", raw or "")]


def day(raw: str) -> int | None:
    match = re.search(r"\{\s*server_open_day\s*,\s*(\d+)\s*\}", raw or "")
    return int(match.group(1)) if match else None


def activity_candidate(row: dict[str, str]) -> bool:
    start, end = day(row["begin_time"]), day(row["end_time"])
    server_dates = dates(row.get("server_condition", ""))
    if start is not None and end is not None:
        # Existence of one eligible opening date, not proof a server exists.
        low = AS_OF - dt.timedelta(days=end - 1)
        high = AS_OF - dt.timedelta(days=start - 1)
        if server_dates:
            low, high = max(low, server_dates[0]), min(high, server_dates[-1])
        return low <= high and start < 999
    begins, ends = dates(row["begin_time"]), dates(row["end_time"])
    return bool(begins and ends and begins[0] <= AS_OF <= ends[0]
                and (not server_dates or server_dates[0] <= AS_OF))


anchors = {r["道具ID"]: r for r in read_tsv("item_anchor_ledger.tsv")}
item_rows = {r["id"]: r for r in sheet("item_data", "道具信息")}
pay_rows = {r["id"]: r for r in sheet("pay_data", "支付表")}
shop_names = {r["shop_id"]: r["shop_name"] for r in sheet("shopping_new_data", "商店列表") if r["shop_id"]}

# These are substitute costs in the named currently eligible activities, not
# global sale prices.  5600112 is an optional one-die diamond purchase.
TICKET_COSTS = {
    "100050": (60.0, "祈星转盘 40008：A_活动抽奖_activity_draw_data.xml/活动抽奖!11；活动100281!活动配置396"),
    "100067": (60.0, "许愿奖池 40010：A_活动抽奖_activity_draw_data.xml/活动抽奖!15；活动100290!活动配置409"),
    "100109": (60.0, "星海寻礼 40014：A_活动抽奖_activity_draw_data.xml/活动抽奖!25；活动100486!活动配置653"),
    "5600077": (60.0, "梦境售票窗 40017：A_活动抽奖_activity_draw_data.xml/活动抽奖!24；A_活动配置_activity_data.xml/活动配置!736:737"),
    "5600112": (30.0, "山河巡游 310100：A_大富翁_activity_monopoly_data.xml/活动配置!10；索引 server:src/mod/union_monopoly/role_activity_union_monopoly.erl:L2632-L2641"),
}

# Exact item IDs in the current 6-1 value table that were outside the earlier
# 84-item partial ledger.  The lower collectible block has F/G currency labels
# transposed; its G prices are corroborated by the hidden shop P/Q columns.
SIX_ONE_EXPLICIT_ANCHORS = {
    "28": (200.0, "直接锚", 14),
    "5800004": (30.0, "直接锚", 10),
    "63": (1.0, "直接锚", 115),
    "13101001": (6.0, "直接锚", 27),
    "14202001": (12.0, "直接锚", 28),
    "11301001": (24.0, "直接锚", 29),
    "6200015": (4800.0, "条件锚", 152),
    "6200016": (9600.0, "条件锚", 153),
    "6210006": (480.0, "条件锚", 162),
    "6220001": (2400.0, "条件锚", 175),
    "6220002": (4800.0, "条件锚", 176),
    "6220013": (9600.0, "条件锚", 180),
}
UNIT_FRAGMENT_CLASS_ANCHORS = {
    "3": (6.0, 27), "4": (12.0, 28), "5": (24.0, 29),
    "6": (48.0, 30), "7": (96.0, 31),
}
VEHICLE_FRAGMENT_CLASS_ANCHORS = {
    "4": (200.0, 116), "5": (400.0, 117),
    "6": (800.0, 118), "7": (1600.0, 119),
}
PART_DRAWING_ANCHORS = {str(item_id): 3.0 for item_id in range(50003, 50009)}
SIX_ONE_UNIQUE_NAME_ANCHORS = {
    "5505010": ("奇异权杖", 4000.0, "2.0次月活动!E38,G38;D87,F87"),
    "10150030": ("神秘影袍", 8000.0, "2.0次月活动!E44,G44;D86,F86"),
}
# User-approved planning values for same-quality skins, outfit sets and choice
# boxes. They are reward-side nominal anchors; ownership, choice and redemption
# currency remain separate.  The last element is the formal pool/choice evidence.
CONFIRMED_CLASS_ANCHORS = {
    "100053": (8000.0, "品质6梦灵皮肤箱，类比已确认100020", "B_宝箱奖励_chest_data.xml/宝箱!273、奖池!592:596、奖励内容!3063:3071"),
    "100065": (6000.0, "品质5秘宝皮肤箱，类比已确认100012；宝箱备注误写Ⅰ，按同ID奖池Ⅱ关联", "B_宝箱奖励_chest_data.xml/宝箱!278、奖池!599:603、奖励内容!3120:3128"),
    "100119": (4000.0, "品质5梦灵皮肤自选箱，类比已确认100022", "D_道具_item_data.xml/自选内容!329:331"),
    "100121": (4000.0, "品质5梦灵皮肤自选箱，类比已确认100022", "D_道具_item_data.xml/自选内容!332:335"),
    "100123": (8000.0, "品质6梦灵皮肤自选箱，类比已确认100020", "D_道具_item_data.xml/自选内容!336:338"),
    "100125": (8000.0, "品质6梦灵皮肤自选箱，类比已确认100020", "D_道具_item_data.xml/自选内容!339:341"),
    "5506001": (4000.0, "品质5武器皮肤，6-1/价值表!F99类别规划价", "D_道具_item_data.xml/道具信息!125"),
    "5505016": (4000.0, "品质5武器皮肤，6-1/价值表!F99类别规划价", "D_道具_item_data.xml/道具信息!122"),
    "100095": (4000.0, "品质5武器皮肤自选箱，6-1/价值表!F99类别规划价", "D_道具_item_data.xml/自选内容!276:278"),
    "5505014": (8000.0, "品质6武器皮肤，6-1/价值表!F100类别规划价", "D_道具_item_data.xml/道具信息!123"),
    "5506002": (8000.0, "品质6武器皮肤，6-1/价值表!F100类别规划价", "D_道具_item_data.xml/道具信息!126"),
    "100035": (7000.0, "品质5主角时装套装箱，6-1/价值表!F102类别规划价", "B_宝箱奖励_chest_data.xml/宝箱!267、奖池!682、奖励内容!2980:2981"),
    "100069": (7000.0, "品质5主角时装套装箱，6-1/价值表!F102类别规划价", "B_宝箱奖励_chest_data.xml/宝箱!279、奖池!691、奖励内容!3172:3173"),
    "100146": (7000.0, "品质5主角时装套装箱，6-1/价值表!F102类别规划价", "B_宝箱奖励_chest_data.xml/宝箱!532、奖池!803、奖励内容!3674:3675"),
    "100062": (12000.0, "品质6主角时装套装箱，6-1/价值表!F103类别规划价", "B_宝箱奖励_chest_data.xml/宝箱!275、奖池!687、奖励内容!3097:3100"),
    "100145": (6000.0, "品质5秘宝皮肤自选箱，类比已确认100012", "D_道具_item_data.xml/自选内容!365:367"),
    "100094": (8000.0, "混合时装自选箱，按最优选项的规划名义上界；可选结果7000–8000", "D_道具_item_data.xml/自选内容!273:275"),
}

OUTFIT_PAIR = {"10140370", "10340370"}
OUTFIT_PAIR_VALUE = 7000.0


def one_item(item_id: str) -> tuple[float | None, str, str]:
    anchor = anchors.get(item_id)
    if anchor and anchor["基础单价_钻"]:
        # This box has an 80-diamond *pool expectation*, not a fixed outcome.
        status = "条件锚" if item_id == "20038" else "直接锚" if anchor["价格状态"] in ("直接ID锚", "严格映射锚") else "条件锚"
        return float(anchor["基础单价_钻"]), status, anchor["精确估值来源"]
    if item_id in SIX_ONE_EXPLICIT_ANCHORS:
        price, state, row = SIX_ONE_EXPLICIT_ANCHORS[item_id]
        definition = item_rows[item_id]
        assert definition["id"] == item_id and definition["name"], item_id
        if item_id == "63":
            source = ("6-1商业化数值 r65300/价值表!B115,C115,F115,G115；"
                      "2-6载具养成/价值表!E78,F78,H78；"
                      f"D_道具_item_data.xml/道具信息!{definition['_row']}；"
                      "同ID精密齿轮1钻规划基础锚，玩法代币购买成本仍需独立估值")
        elif row < 125:
            source = (f"6-1商业化数值 r65300/价值表!D{row},F{row}；"
                      f"D_道具_item_data.xml/道具信息!{definition['_row']}；"
                      "明确ID规划基础锚，现行商品可见及到账待验")
        else:
            source = (f"6-1商业化数值 r65300/价值表!B{row},G{row}；"
                      f"商店!P{row+5},Q{row+5}；"
                      f"D_道具_item_data.xml/道具信息!{definition['_row']}；"
                      "藏品块F/G货币列反置，按同ID规划条件锚；现行期次与玩家状态另验")
        return price, state, source
    if item_id in PART_DRAWING_ANCHORS:
        definition = item_rows[item_id]
        assert definition["type"] == "8" and "图纸" in definition["name"], item_id
        return 3.0, "直接锚", (
            "用户2026-10-15确认六部位图纸50003–50008统一按3钻/张作跨商品规划基础锚；"
            "6-1商业化数值 r65300/价值表!D41,F41 的50002通用图纸箱3钻作设计参照；"
            "S_商店_shopping_new_data.xml/随机库中25钻/10张为格位折后售价，非基础锚；"
            f"D_道具_item_data.xml/道具信息!{definition['_row']}")
    if item_id in SIX_ONE_UNIQUE_NAME_ANCHORS:
        name, price, location = SIX_ONE_UNIQUE_NAME_ANCHORS[item_id]
        definition = item_rows[item_id]
        assert definition["name"] == name, item_id
        return price, "条件锚", (
            f"6-1商业化数值 r65300/{location} 同名规划价；"
            f"D_道具_item_data.xml/道具信息!{definition['_row']} 正式唯一同名ID；"
            "按名称与正式唯一ID映射的当期规划条件锚，非独立直售价或玩家实得")
    definition = item_rows.get(item_id)
    if definition and definition["type"] == "16" and definition["quality"] in UNIT_FRAGMENT_CLASS_ANCHORS:
        price, row = UNIT_FRAGMENT_CLASS_ANCHORS[definition["quality"]]
        if definition["value"] and float(definition["value"]) == price:
            return price, "条件锚", (
                f"6-1商业化数值 r65300/价值表!F{row} 的品质{definition['quality']}梦灵碎片类目价；"
                f"D_道具_item_data.xml/道具信息!{definition['_row']} 的type=16、quality={definition['quality']}、value={definition['value']}交叉吻合；"
                "按品质类比规划价，非该ID独立直售价")
    if item_id.isdigit() and 6010011 <= int(item_id) <= 6010031:
        assert definition and definition["type"] == "44", item_id
        price, row = VEHICLE_FRAGMENT_CLASS_ANCHORS[definition["quality"]]
        assert float(definition["value"]) == price, item_id
        return price, "条件锚", (
            f"用户2026-10-15确认按同品质单片箱作规划名义条件锚{price:g}钻/片；"
            f"6-1商业化数值 r65300/价值表!B{row},F{row}；"
            "B_宝箱奖励_chest_data.xml/宝箱!510:513、奖池!754:757、奖励内容!3402:3422；"
            f"D_道具_item_data.xml/道具信息!{definition['_row']} 的type=44、quality={definition['quality']}、value={definition['value']}；"
            "同品质等权单片奖池类比，非该ID独立直售价或玩家边际效用")
    if item_id == "50026":
        original, target = item_rows["50002"], item_rows[item_id]
        for key in ("name", "desc", "quality", "type", "item_attr", "icon", "jump_ways"):
            assert original[key] == target[key], (key, original[key], target[key])
        return float(anchors["50002"]["基础单价_钻"]), "条件锚", (
            "等效图纸假设：D_道具_item_data.xml/道具信息!646,670；"
            "6-1/价值表!D41,F41；两ID消耗等效性尚待核")
    if item_id == "5600115":
        definition = item_rows[item_id]
        assert definition["item_attr"] == "{5600112,1}"
        return 30.0, "条件锚", (
            "个人保底：D_道具_item_data.xml/道具信息!1896 的 item_attr；"
            "索引 dg-server-engineering/server:src/mod/union_monopoly/"
            "role_activity_union_monopoly.erl:L867-L885,L908-L914；公会其他成员收益未计")
    if item_id == "5600113":
        assert item_rows[item_id]["name"] == "金骰子"
        return 200.0, "条件锚", (
            "用户2026-10-15确认本期规划名义条件锚200钻/枚；"
            "6-1商业化数值 r65300/价值表!F88、2.0大富翁抽奖!E131；"
            "A_大富翁_activity_monopoly_data.xml/活动配置!10 的310100方案使用同一ID；"
            "非独立直售价或实际格子收益")
    if item_id == "5600114":
        definition = item_rows[item_id]
        assert definition["id"] == item_id and definition["quality"] == "5"
        return 200.0, "条件锚", (
            "用户2026-10-15确认限时金骰子本期有效期间按200钻/枚规划名义条件锚；"
            "6-1商业化数值 r65300/价值表!F88 的普通金骰子同类价；"
            f"D_道具_item_data.xml/道具信息!{definition['_row']} 的到期描述；"
            "过期未使用按0，非跨期直售价或实际格子收益")
    if item_id == "1410200":
        definition = item_rows[item_id]
        assert definition["quality"] == "6" and definition["item_attr"] == "{1410200,6,14102001,10}"
        fragment_price, fragment_state, _ = one_item("14102001")
        assert fragment_price == 48.0 and fragment_state == "条件锚"
        return 480.0, "条件锚", (
            "6-1商业化数值 r65300/价值表!F25 的神话梦灵类目价480钻；"
            "同表!F30 的神话碎片48钻/片，与10片激活对应480钻；"
            f"D_道具_item_data.xml/道具信息!{definition['_row']} 的quality=6与item_attr；"
            "三处规划证据吻合的品质条件锚，非独立直售价；配置value=160仅内部点数")
    if item_id == "57":
        definition = item_rows[item_id]
        assert definition["name"] == "贪吃挑战门票" and definition["quality"] == "4"
        return 200.0, "条件锚", (
            "用户2026-10-15确认本期按200钻/张同店同价规划条件锚；"
            "S_商店_shopping_new_data.xml/常规商店!176、!183 的巡航门票28与本票"
            "同售1000公会贡献、同解锁和每日限购；"
            "6-1商业化数值 r65300/价值表!D14,F14 给28价200钻；"
            f"D_道具_item_data.xml/道具信息!{definition['_row']} 活动结束清除；"
            "仅本期奖励名义价值，不是跨期固定价或玩法实际收益；公会贡献成本另算")
    if item_id in ("100092", "100111"):
        name, chest_row, pool_row, reward_row = {
            "100092": ("落子黑白礼盒", 288, 697, 3445),
            "100111": ("海岸圣域礼盒", 295, 703, 3495),
        }[item_id]
        definition = item_rows[item_id]
        assert definition["name"] == name and definition["quality"] == "7"
        return 15000.0, "条件锚", (
            "用户2026-10-15新指定品质7梦灵皮肤箱规划名义条件锚15000钻/盒；"
            f"D_道具_item_data.xml/道具信息!{definition['_row']}；"
            f"B_宝箱奖励_chest_data.xml/宝箱!{chest_row}、奖池!{pool_row}、"
            f"奖励内容!{reward_row}；"
            "6-1商业化数值 r65300/价值表!F95:F97仅有品质4/5/6价，无品质7价；"
            "15000为用户新定价，不是6-1原价；玩家皮肤状态与活动代币成本另算")
    if item_id == "100022":
        assert item_rows[item_id]["name"] == "绮梦衣橱盒V"
        return 4000.0, "条件锚", (
            "用户2026-10-15确认规划名义条件锚4000钻/盒；"
            "6-1商业化数值 r65300/价值表!F96、2.0次月活动!A90:F90；"
            "B_宝箱奖励_chest_data.xml/宝箱!256、奖池!377:384；"
            "玩家皮肤进度影响实际增量价值；非代币折钻价或固定兑现值")
    if item_id in ("100020", "100012"):
        price, row, chest_row, pool_rows = {
            "100020": (8000.0, 88, 254, "364:368"),
            "100012": (6000.0, 89, 249, "339:343"),
        }[item_id]
        assert item_rows[item_id]["id"] == item_id
        return price, "条件锚", (
            f"用户2026-10-15确认规划名义条件锚{price:g}钻/盒；"
            f"6-1商业化数值 r65300/2.0次月活动!A{row},F{row}；"
            f"B_宝箱奖励_chest_data.xml/宝箱!{chest_row}、奖池!{pool_rows}；"
            "玩家已有皮肤与箱池状态影响实际增量价值；代币成本另算")
    if item_id == "100041":
        definition = item_rows[item_id]
        assert definition["id"] == item_id
        return 12000.0, "条件锚", (
            "当前S_商店_shopping_new_data.xml/常规商店!137格位normal:4:11以1200个ID44报价；"
            "用户已确认ID44基础锚10钻/个，故该格位报价折钻12000；"
            "6-1商业化数值 r65300/价值表!F103神话时装皮肤规划价12000钻交叉吻合；"
            "B_宝箱奖励_chest_data.xml/宝箱!270、奖池!686、奖励内容!3035:3037；"
            f"D_道具_item_data.xml/道具信息!{definition['_row']}；"
            "以现行格位及同类规划价给条件锚，个人皮肤进度下收益另算")
    if item_id in CONFIRMED_CLASS_ANCHORS:
        price, kind, evidence = CONFIRMED_CLASS_ANCHORS[item_id]
        definition = item_rows[item_id]
        assert definition["id"] == item_id and definition["name"], item_id
        if item_id in ("5506001", "5505016", "5505014", "5506002"):
            assert definition["type"] == "17", item_id
            assert definition["quality"] == ("5" if price == 4000 else "6"), item_id
        return price, "条件锚", (
            f"用户2026-10-15确认{price:g}钻规划名义条件锚；{kind}；"
            f"{evidence}；D_道具_item_data.xml/道具信息!{definition['_row']}；"
            "仅计规划奖励价值，玩家持有/选择与代币成本另算；非该ID独立直售价")
    if item_id in TICKET_COSTS:
        price, source = TICKET_COSTS[item_id]
        return price, "条件锚", source
    definition = item_rows.get(item_id)
    if definition and definition["value"]:
        # The server's checker uses item_data.value, but 6-1 direct anchors
        # disagree on several IDs.  Treat this only as a conditional proxy.
        return float(definition["value"]), "配置内价", f"D_道具_item_data.xml/道具信息!{definition['_row']},value"
    return None, "缺价", f"D_道具_item_data.xml/道具信息!{definition['_row']}" if definition else "正式道具表未见此ID/需查其他类型"


def priced_rewards(raw: str, dynamic: bool = False, context_key: str = "") -> tuple[str, str, str, str, str, str, str]:
    pairs = reward_pairs(raw)
    if not pairs:
        return "", "", "", "缺奖励实例", "", "", "配置未列静态 ID×数量"
    anchored, proxy = 0.0, 0.0
    states, missing, proxy_ids, proofs = set(), [], [], []
    pair_quantities = {item_id: qty for item_id, qty in pairs if item_id in OUTFIT_PAIR}
    complete_outfit_pair = (context_key == "core:首充:4"
                            and set(pair_quantities) == OUTFIT_PAIR
                            and all(qty == 1 for qty in pair_quantities.values())
                            and sum(item_id in OUTFIT_PAIR for item_id, _ in pairs) == 2)
    if complete_outfit_pair:
        anchored += OUTFIT_PAIR_VALUE
        states.add("条件锚")
        proofs.append(
            "10140370+10340370:用户2026-10-15确认首充两件整套合计7000钻、不拆单件；"
            "同套装盒100146按7000钻规划名义条件锚；"
            "B_宝箱奖励_chest_data.xml/宝箱!532、奖池!803、奖励内容!3674:3675")
    for item_id, qty in pairs:
        if complete_outfit_pair and item_id in OUTFIT_PAIR:
            continue
        price, state, source = one_item(item_id)
        if price is None:
            missing.append(item_id)
        elif state == "配置内价":
            proxy += price * qty
            proxy_ids.append(item_id)
            proofs.append(f"{item_id}:{source}")
        else:
            anchored += price * qty
            states.add(state)
            if state != "直接锚":
                proofs.append(f"{item_id}:{source}")
    if dynamic:
        return "", fmt(anchored) if states else "", fmt(proxy) if proxy_ids else "", "动态奖励实例缺失", ",".join(sorted(set(missing))), ",".join(sorted(set(proxy_ids))), "触发角色当时的 dynamic_reward 解析结果"
    if missing:
        return "", fmt(anchored) if states else "", fmt(proxy) if proxy_ids else "", "部分奖励缺价", ",".join(sorted(set(missing))), ",".join(sorted(set(proxy_ids))), "逐 ID 核独立直售/兑换/奖池；不得用已知部分算完整返比"
    if proxy_ids:
        return "", fmt(anchored) if states else "", fmt(proxy), "仅配置内代理值", "", ",".join(sorted(set(proxy_ids))), "核道具 value 与独立钻价/奖池；代理值不得算返比"
    status = "严格锚价" if states == {"直接锚"} else "条件估值"
    return fmt(anchored), fmt(anchored), "", status, "", "", ";".join(proofs)


FIELDS = [
    "范围层级", "模块", "商品/档位", "商品键", "付款方式", "标价", "币种", "完整奖励价值_钻", "完整名义返比",
    "配置value点数_未校准",
    "首购到账_钻", "复购到账_钻", "首购返比", "复购返比",
    "核价状态", "缺价/不可比原因", "下一证据", "奖励ID×数量", "已知部分_钻", "缺价奖励ID", "仅配置参考价ID", "配置可达口径",
    "开放/触发条件", "购买/池条件", "支付ID", "活动/方案ID", "配置来源", "估值来源", "备注",
]
records: list[dict[str, str]] = []
quarantined: list[dict[str, str]] = []
rookie_quarantined: list[dict[str, str]] = []
trigger_quarantined: list[dict[str, str]] = []


def add(*, layer: str, module: str, name: str, key: str, pay_way: str, price: str, unit: str,
        rewards: str, source: str, scope: str, conditions: str = "", buying: str = "", pay_id: str = "",
        plan: str = "", note: str = "", dynamic: bool = False, fixed_value: str = "", fixed_ratio: str = "",
        fixed_status: str = "") -> None:
    reward_text = pair_text(rewards) or rewards
    full, partial, proxy_total, status, missing, proxy_ids, next_evidence = priced_rewards(rewards, dynamic, key)
    valuation_evidence = next_evidence if full else ""
    if valuation_evidence:
        next_evidence = ""
    if fixed_status:
        # Existing audited rows override generic parsing, preserving month-card
        # and multi-day collection semantics.  Do not restore an old "unclosed"
        # flag after newly confirmed item anchors close that reward formula.
        if full:
            if not fixed_status.startswith("未闭合"):
                full = fixed_value or full
                status = fixed_status
        elif not proxy_ids:
            status = fixed_status
    reward_ids = {item_id for item_id, _ in reward_pairs(rewards)}
    if "20038" in reward_ids and full:
        status = "条件估值：当期奖池期望"
        next_evidence = "核当前运行服奖池与权重"
    if "50026" in reward_ids and full:
        status = "条件估值：等效图纸假设"
        next_evidence = "核装备升级消耗对 50002 与 50026 是否同效"
    if "5600115" in reward_ids and full:
        status = "条件估值：购买者个人保底；公会收益另计"
        next_evidence = "核运行服公会人数、礼包使用与成员领取"
    if "5600113" in reward_ids and full:
        status = "条件估值：本期巡游规划名义锚"
        next_evidence = "核巡游活动实际格子收益；200钻不作独立直售价"
    if "5600114" in reward_ids and full:
        status = "条件估值：限时金骰本期规划名义锚"
        next_evidence = "核活动结束前是否使用；过期未使用价值按0"
    if OUTFIT_PAIR.issubset(reward_ids) and full:
        status = "条件估值：首充咕勇者两件整套"
        next_evidence = "两件合计7000钻；只适用于该首充专案，不拆单件"
    if "100022" in reward_ids and full:
        status = "条件估值：衣橱箱规划名义锚；实际价值随皮肤进度变"
        next_evidence = "核兑换代币机会成本、角色皮肤进度及实际开箱/满星回收"
    denominator = None
    if pay_way == "人民币" and price:
        denominator = float(price) * 10
    elif pay_way == "钻石" and price:
        denominator = float(price)
    elif pay_way == "金币" and price:
        denominator = float(price) * 0.05
    if fixed_ratio and full:
        ratio = fixed_ratio
    elif full and denominator and not dynamic and layer != "累计消费达标奖励":
        ratio = f"{float(full) / denominator:.4f}"
    else:
        ratio = ""
    if not denominator and pay_way not in ("免费/广告", "累计消费"):
        status += "；支付媒介不可统一折钻"
        next_evidence += "；核代币的独立获取路径和限购机会成本"
    if pay_way == "免费/广告":
        ratio = ""
        status += "；无付款返比"
    if layer == "累计消费达标奖励":
        ratio = ""
        status += "；非独立购买"
    if layer == "随机池候选":
        status += "；展示概率未核"
    if not full and not missing and not proxy_ids and not dynamic:
        missing = "非静态奖励/领取轨道"
    records.append({
        "范围层级": layer, "模块": module, "商品/档位": name, "商品键": key,
        "付款方式": pay_way, "标价": price, "币种": unit,
        "完整奖励价值_钻": full, "完整名义返比": ratio, "配置value点数_未校准": proxy_total,
        "首购到账_钻": "", "复购到账_钻": "", "首购返比": "", "复购返比": "",
        "核价状态": status, "缺价/不可比原因": missing or ("道具 value 仅内部参考，未校准商业钻价" if proxy_ids else "代币机会成本未统一" if denominator is None and pay_way not in ("免费/广告", "累计消费") else ""),
        "下一证据": next_evidence, "奖励ID×数量": reward_text,
        "已知部分_钻": partial, "缺价奖励ID": missing if "," in missing or missing.isdigit() else "", "仅配置参考价ID": proxy_ids,
        "配置可达口径": scope, "开放/触发条件": conditions, "购买/池条件": buying,
        "支付ID": pay_id, "活动/方案ID": plan, "配置来源": source,
        "估值来源": "道具账/正式道具表；条件票券见脚本 TICKET_COSTS" + ("；" + valuation_evidence if valuation_evidence else ""), "备注": note,
    })


# 1. Base products and their separately presented cumulative spend milestones.
for row in read_tsv("commercial_products.tsv"):
    is_milestone = row["模块"] == "首充" and row["商品ID"] != "1"
    if is_milestone:
        layer, pay_way = "累计消费达标奖励", "累计消费"
    else:
        layer = "固定商品/领取轨道"
        pay_way = "钻石" if row["支付币种"] == "钻石" else "人民币"
    add(layer=layer, module=row["模块"], name=row["商品名"], key=f"core:{row['模块']}:{row['商品ID']}",
        pay_way=pay_way, price=fmt(row["支付数值"]), unit="钻" if pay_way == "钻石" else "元",
        rewards=row["奖励列表"], source=row["商品配置来源"], scope="正式配置可达；运行服展示未验",
        conditions=row["口径备注"], plan=row["商品ID"], note="首充专案" if row["模块"] == "首充" else "",
        fixed_value=row["条件估值总价值钻石"] if row["状态"] == "条件估值" else row["严格可核价值钻石"] if row["状态"] == "严格核价" else "",
        fixed_ratio=row["条件返比"] if row["状态"] == "条件估值" else row["严格返比"] if row["状态"] == "严格核价" else "",
        fixed_status=row["状态"],
    )


# 2. Reachable portions of the additional cash catalog.  Placeholder rows are
# retained in their source file, not promoted to current goods.
for row in read_tsv("extended_cash_pricing.tsv"):
    evidence = row["售卖证据状态"]
    module = row["模块"]
    if module == "七日直购":
        quarantined.append({
            "模块": module, "方案": row["方案"], "支付ID": row["支付ID"],
            "人民币售价": row["人民币售价"],
            "奖励ID×数量": ";".join(x for x in (row["付费奖励ID×数量"], row["分期奖励ID×数量"]) if x),
            "配置来源": row["配置来源"],
            "隔离原因": ("第999日触发疑似占位；" if "999" in evidence else "") + "本地礼包配置存在；服务端索引支付检查及发奖模块被注释，近30日该组支付查询为0；现服待复核",
            "索引证据": "dg-server-engineering/server:src/mod/pay_function/role_seven_day_direct_gift_bag.erl:L9-L25,L174-L251;src/mod/payment/payment.erl:L317-L323;src/mod/role/role_static_callback.erl:L140-L147",
        })
        continue
    if module == "新手礼包":
        rookie_quarantined.append({
            "模块": module, "方案": row["方案"], "支付ID": row["支付ID"],
            "人民币售价": row["人民币售价"],
            "奖励ID×数量": ";".join(x for x in (row["付费奖励ID×数量"], row["分期奖励ID×数量"]) if x),
            "配置来源": row["配置来源"],
            "隔离原因": ("开启表错列疑似占位；" if "错列" in evidence else "") + "本地礼包配置存在；服务端索引中支付检查、发奖及RPC整模块被注释，近30日该组支付查询为0；现服待复核",
            "索引证据": "dg-server-engineering/server:src/mod/rookie_gift/role_rookie_gift.erl:L9-L33,L95-L122,L145-L160,L276-L296;src/mod/rookie_gift/rookie_gift_rpc.erl:L9-L27;src/mod/role/role_static_callback.erl:L168,L420",
        })
        continue
    eligible = evidence.startswith("近期有交易") or evidence == "近期未见同口径交易_配置候选"
    if not eligible:
        continue
    rewards = ";".join(x for x in (row["付费奖励ID×数量"], row["分期奖励ID×数量"]) if x)
    if module == "钻石直充":
        full, ratio = "", ""
        status = "首购/复购到账分口径；见右侧四列"
    else:
        full, ratio, status = row["完整名义价值_钻"], row["完整名义返比"], row["核价状态"]
    before = len(records)
    add(layer="固定商品/领取轨道", module=module, name=row["方案"], key=f"extra:{module}:{row['支付ID']}",
        pay_way="人民币", price=fmt(row["人民币售价"]), unit="元", rewards=rewards,
        source=row["配置来源"], scope="配置可达候选；支付ID成交不证此方案交付",
        conditions=row["开放或达成条件"], pay_id=row["支付ID"], plan=row["方案"],
        note=f"{evidence}；{row['价值口径及限制']}", fixed_value=full if module != "钻石直充" else "",
        fixed_ratio=ratio if module != "钻石直充" else "", fixed_status=status if module != "钻石直充" else "",
    )
    if module == "钻石直充":
        records[before]["完整奖励价值_钻"] = ""
        records[before]["完整名义返比"] = ""
        records[before]["首购到账_钻"] = fmt(row["首次到账_钻"])
        records[before]["复购到账_钻"] = fmt(row["复购到账_钻"])
        records[before]["首购返比"] = row["首次到账倍率"]
        records[before]["复购返比"] = row["复购到账倍率"]
        records[before]["核价状态"] = status
        records[before]["缺价/不可比原因"] = ""
        records[before]["下一证据"] = "核首购判定与运行服实际到账"


# 3. New-server activity cash products.
for row in read_tsv("event_cash_catalog.tsv"):
    add(layer="固定商品/领取轨道", module=row["模块"], name=row["商品名"],
        key=f"event:{row['活动base_id']}:{row['SKU_ID']}", pay_way="人民币",
        price=fmt(row["现金价_元"]), unit="元", rewards=row["奖励ID及数量"],
        source=row["商品来源"], scope="当日存在适用开服日的配置候选；运行服未验",
        conditions=f"开服日{row['适用服务器开服日']}；{row['活动起始']}至{row['活动截止']}；{row['解锁条件']}",
        buying=row["购买次数配置"], pay_id=row["支付ID"], plan=row["活动ID"], note=row["备注"],
        fixed_value=row["合计估值_钻"], fixed_ratio=row["返比"], fixed_status=row["估值状态"],
    )


# 4. Other reachable shops and trigger gifts.  Revalue from current anchors;
# this also resolves 5103001 entries left stale in the earlier candidate TSV.
for row in read_tsv("remaining_current_skus.tsv"):
    if row["模块"] == "限时触发礼包":
        trigger_quarantined.append({
            "模块": row["模块"], "商品/档位": row["商品名"],
            "商品键": f"remaining:{row['模块']}:{row['方案base_id']}:{row['商品ID']}",
            "支付ID": row["支付ID"], "标价": row["标价"], "币种": row["币种"],
            "奖励ID×数量": row["奖励ID×数量"], "配置来源": row["商品来源"],
            "隔离原因": "本地限时礼包配置存在；服务端索引中整模块的触发、购买、发奖及回调被注释，现服待复核",
            "索引证据": "dg-server-engineering/server:src/mod/operating_activities/role_limited_time_gift.erl:L10-L24,L160-L183,L197-L295;src/util/event_static_callback.erl:L17-L52,L72-L85;src/mod/role/role_static_callback.erl:L129,L283",
        })
        continue
    way = row["支付类型"]
    pay_way = "人民币" if way == "人民币" else "钻石" if way == "钻石" else "活动代币"
    add(layer="固定商品/领取轨道" if row["模块"] != "限时触发礼包" else "触发后商品候选",
        module=row["模块"], name=row["商品名"], key=f"remaining:{row['模块']}:{row['方案base_id']}:{row['商品ID']}",
        pay_way=pay_way, price=row["标价"], unit=row["币种"], rewards=row["奖励ID×数量"],
        source=row["商品来源"], scope=row["配置可达性"], conditions=row["开放及触发条件"],
        buying=row["购买次数"], pay_id=row["支付ID"], plan=row["活动配置ID"] or row["方案base_id"],
        note=row["说明"], dynamic="动态原文=" in row["奖励ID×数量"],
    )


# 5. Permanent normal shop.  The 245 active config rows include repeat-price
# tiers; only 107 distinct (shop_id, grid_id) slots exist.
for row in sheet("shopping_new_data", "常规商店"):
    if row.get("is_close") != "1" or not row.get("shop_id"):
        continue
    costs = reward_pairs(row["need"])
    if len(costs) == 1:
        currency, amount = costs[0]
        pay_way = {"1": "钻石", "2": "金币"}.get(currency, "玩法代币")
        price, unit = fmt(amount), "钻" if currency == "1" else "金币" if currency == "2" else f"道具{currency}"
    else:
        pay_way, price, unit = "免费/广告" if not costs else "多币种", "0" if not costs else pair_text(row["need"]), ""
    add(layer="常规商店购买档位", module=f"常规商店/{shop_names.get(row['shop_id'],row['shop_id'])}",
        name=row["name"], key=f"normal:{row['shop_id']}:{row['id']}:{row['buy_count_range'] or '0'}",
        pay_way=pay_way, price=price, unit=unit, rewards=row["reward"],
        source=f"S_商店_shopping_new_data.xml/常规商店!{row['_row']}",
        scope="商店格位开放配置；功能/角色解锁与运行服未验",
        conditions=row["condition"] + ";" + row["buy_cond"],
        buying=f"累计购买阈值={row['buy_count_range'] or '0'}；限购={row['buy_count']}；刷新={row['refresh']}",
        plan=f"shop_id={row['shop_id']}", note="同一格位按购买次数分阶价；不得把各阶当同时上架 SKU。" if row["buy_count_range"] else "",
    )


# 6. Random daily-shop candidates.  Only warehouses reachable from the six
# random slots' group ids are included.  They are pool lines, not visible SKUs.
groups = sheet("shopping_new_data", "随机组库")
all_random = sheet("shopping_new_data", "随机库")
warehouse_groups: dict[str, set[str]] = collections.defaultdict(set)
for row in groups:
    warehouse_groups[row["warehouse"]].add(row["group_id"])
for row in all_random:
    if not row.get("id") or row["warehouse"] not in warehouse_groups:
        continue
    costs = reward_pairs(row["need"])
    if len(costs) == 1:
        currency, amount = costs[0]
        pay_way = {"1": "钻石", "2": "金币"}.get(currency, "玩法代币")
        price, unit = fmt(amount), "钻" if currency == "1" else "金币" if currency == "2" else f"道具{currency}"
    else:
        pay_way, price, unit = "免费/广告", "0", ""
    add(layer="随机池候选", module="每日商店/随机格", name=f"池项{row['id']}",
        key=f"random:{row['warehouse']}:{row['id']}", pay_way=pay_way, price=price, unit=unit,
        rewards=row["reward"], source=f"S_商店_shopping_new_data.xml/随机库!{row['_row']}",
        scope="随机组库可引用；实际刷新/展示/抽中未验",
        conditions=row["condition"],
        buying=f"warehouse={row['warehouse']}；group={','.join(sorted(warehouse_groups[row['warehouse']]))}；weight={row['weight']}；限购={row['buy_count']}",
        plan="shop_id=1", note="池候选项，不计入同时在售格位数。",
    )


# 7. Date-reachable activity exchange shops.  Cost is usually an event token.
activities = sheet("activity_data", "活动配置")
active_exchange: dict[str, list[dict[str, str]]] = collections.defaultdict(list)
for row in activities:
    if row.get("data_cfg") == "activity_exchange_data" and activity_candidate(row):
        active_exchange[row["base_id"]].append(row)
for row in sheet("activity_exchange_data", "活动兑换"):
    acts = active_exchange.get(row.get("base_id", ""), [])
    if not acts or not row.get("id") or row.get("is_show") == "0":
        continue
    # Exchange sheet stores the price as need=item_id and num=quantity, unlike
    # activity_shop_data, which uses a [{item,quantity}] expression.
    currency = row["need"]
    price = fmt(row["num"]) if row["num"] else ""
    pay_way = {"1": "钻石", "2": "金币"}.get(currency, "活动代币") if currency else "免费/广告"
    unit = "钻" if currency == "1" else "金币" if currency == "2" else f"道具{currency}" if currency else ""
    add(layer="活动兑换商品", module="活动兑换", name=row["name"],
        key=f"exchange:{row['base_id']}:{row['id']}", pay_way=pay_way, price=price, unit=unit,
        rewards=row["rewards"], source=f"A_活动兑换_activity_exchange_data.xml/活动兑换!{row['_row']}",
        scope="当日存在适用开服日的配置候选；玩家/运行服未验",
        conditions=";".join(f"活动{a['id']}:{a['begin_time']}至{a['end_time']}:{a['server_condition']}" for a in acts),
        buying=f"reset={row['reset']}；buy_count={row['buy_count']}；condition={row['condition']}；show={row['show_condition']}",
        plan=",".join(a["id"] for a in acts),
    )


# 8. Current monopoly merchant offer pool, keyed through activity project_id.
monopoly_cfg = {r["base_id"]: r for r in sheet("activity_monopoly_data", "活动配置")}
active_monopoly = [r for r in activities if r.get("data_cfg") == "activity_monopoly_data" and activity_candidate(r)]
merchant_projects: dict[str, list[dict[str, str]]] = collections.defaultdict(list)
for act in active_monopoly:
    cfg = monopoly_cfg.get(act["base_id"])
    if cfg:
        merchant_projects[cfg["project_id"]].append(act)
for row in sheet("activity_monopoly_data", "商人"):
    acts = merchant_projects.get(row["project_id"], [])
    if not acts or not row.get("gift_id"):
        continue
    costs = reward_pairs(row["cost"])
    if len(costs) == 1 and costs[0][0] == "1":
        pay_way, price, unit = "钻石", fmt(costs[0][1]), "钻"
    elif not costs:
        pay_way, price, unit = "免费/广告", "0", ""
    else:
        pay_way, price, unit = "多币种", pair_text(row["cost"]), ""
    add(layer="随机商人候选", module="山河巡游商人", name=row["gift_name"],
        key=f"merchant:{row['project_id']}:{row['gift_id']}", pay_way=pay_way, price=price, unit=unit,
        rewards=row["reward"], source=f"A_大富翁_activity_monopoly_data.xml/商人!{row['_row']}",
        scope="活动当日存在配置候选；商人事件随机出现/玩家展示未验",
        conditions=";".join(f"活动{a['id']}:{a['begin_time']}至{a['end_time']}" for a in acts),
        buying=f"pos={row['pos']}；weight={row['weight']}；buy_limit={row['buy_limit']}；period_limit={row['period_limit']}",
        plan=",".join(a["id"] for a in acts), note="同一商人格位的随机报价候选，不同时在售。",
    )


assert len({r["商品键"] for r in records}) == len(records)
assert sum(r["范围层级"] == "常规商店购买档位" for r in records) == 245
assert sum(r["范围层级"] == "随机池候选" for r in records) == 289
assert all(not r["完整奖励价值_钻"] or not (r["缺价奖励ID"] or r["仅配置参考价ID"]) for r in records)
assert all(not r["完整名义返比"] or re.fullmatch(r"\d+(?:\.\d+)?", r["完整名义返比"]) for r in records)
assert sum(bool(r["首购返比"]) for r in records) == 6
assert len(quarantined) == 14
assert len(rookie_quarantined) == 14
assert len(trigger_quarantined) == 9

with OUT.open("w", encoding="utf-8-sig", newline="") as handle:
    writer = csv.DictWriter(handle, fieldnames=FIELDS, delimiter="\t")
    writer.writeheader()
    writer.writerows(records)

with QUARANTINED_OUT.open("w", encoding="utf-8-sig", newline="") as handle:
    writer = csv.DictWriter(handle, fieldnames=list(quarantined[0]), delimiter="\t")
    writer.writeheader()
    writer.writerows(quarantined)

with ROOKIE_QUARANTINED_OUT.open("w", encoding="utf-8-sig", newline="") as handle:
    writer = csv.DictWriter(handle, fieldnames=list(rookie_quarantined[0]), delimiter="\t")
    writer.writeheader()
    writer.writerows(rookie_quarantined)

with TRIGGER_QUARANTINED_OUT.open("w", encoding="utf-8-sig", newline="") as handle:
    writer = csv.DictWriter(handle, fieldnames=list(trigger_quarantined[0]), delimiter="\t")
    writer.writeheader()
    writer.writerows(trigger_quarantined)


# One row per reward ID actually used in the scoped configuration lines.
# A single-item diamond retail quote is shown for comparison but never promoted to a global
# item anchor or used to value another SKU.
item_usage: dict[str, list[dict[str, str]]] = collections.defaultdict(list)
retail_quotes: dict[str, set[float]] = collections.defaultdict(set)
for record in records:
    pairs = reward_pairs(record["奖励ID×数量"])
    for item_id, qty in pairs:
        item_usage[item_id].append(record)
    if len(pairs) == 1 and record["付款方式"] == "钻石" and record["标价"]:
        item_id, qty = pairs[0]
        if qty > 0:
            retail_quotes[item_id].add(float(record["标价"]) / qty)

ITEM_FIELDS = [
    "补证优先级", "道具ID", "道具名", "价态", "商业锚单价_钻", "道具配置value点数_未校准",
    "钻石单品报价_钻每件_非锚", "关联配置行数", "现金商品关联行数", "钻石商品关联行数",
    "随机池候选关联行数", "活动兑换关联行数", "适用条件/限制", "下一证据", "道具定义来源",
    "估值来源", "关联商品键",
]


def item_next_evidence(item_id: str, state: str) -> str:
    if item_id == "50026":
        return "核装备升级消耗对 50002/50026 是否等效；当前3钻只作同效假设"
    if item_id == "5600115":
        return "核实际公会人数与成员领取；当前只计购买者本人1普通骰"
    if item_id == "20038":
        return "核实际奖池及权重；80钻为当期箱期望，不是必得值"
    if item_id in PART_DRAWING_ANCHORS:
        return "基础锚已由用户确认3钻/张；格位2.5钻/张是折后售价，核实际刷新与购买即可"
    if item_id == "10003":
        return "核突破核心的直售/兑换价和阶段消耗；现金礼包不可凭售价倒推单价"
    if item_id == "5600113":
        return "核金骰子指定点数的本期收益区间；当前200钻为用户确认的规划名义条件锚"
    if item_id == "100022":
        return "核玩家皮肤进度与开箱结果；4000钻为用户确认的规划名义锚，满星回收另有2000钻条件兑现值"
    if state == "配置内价":
        return "与6-1道具锚或独立售卖/奖池逐ID校准；value不得直接折钻"
    if state == "缺价":
        return "查独立直售、可兑换来源或箱池/随机概率；若非道具表ID则查对应资产类型"
    return ""


def item_priority(usage: list[dict[str, str]], state: str) -> tuple[str, int]:
    cash = sum(r["付款方式"] == "人民币" for r in usage)
    diamonds = sum(r["付款方式"] == "钻石" and r["范围层级"] != "随机池候选" for r in usage)
    random_lines = sum(r["范围层级"] == "随机池候选" for r in usage)
    exchanges = sum(r["范围层级"] == "活动兑换商品" for r in usage)
    score = cash * 100 + diamonds * 40 + exchanges * 5 + random_lines
    if state in ("缺价", "配置内价"):
        return ("高" if cash or diamonds else "中" if random_lines or exchanges else "低"), score
    return ("已给条件价" if state == "条件锚" else "已定价"), score


item_records = []
for item_id, usage in item_usage.items():
    price, state, price_source = one_item(item_id)
    definition = item_rows.get(item_id, {})
    old_anchor = anchors.get(item_id, {})
    definition_value = definition.get("value", "")
    priority, score = item_priority(usage, state)
    quotes = sorted(retail_quotes[item_id])
    quote_text = fmt(quotes[0]) if len(quotes) == 1 else f"{fmt(quotes[0])}～{fmt(quotes[-1])}" if quotes else ""
    if state == "配置内价":
        tier, business_price = "仅配置参考价", ""
        limitation = "item_data.value 是内部配置点数；未校准前不参与钻石返比"
    elif state == "缺价" and item_id == "100040":
        tier, business_price = "权益服务（按使用计）", ""
        limitation = "首充当天生效的跳广告、刷新和体力上限权益；实际价值依当日使用，不设固定钻价"
        price_source = ("D_道具_item_data.xml/道具信息!2316；"
                        "用户确认首充礼包按特殊专案核算；"
                        "知识库索引 dg-server-engineering/server:src/mod/month_card/role_month_cards.erl:L538-L549,L706-L717；运行服未验证")
    elif state == "缺价" and item_id in OUTFIT_PAIR:
        tier, business_price = "组合价（不拆单件）", ""
        limitation = "仅当咕勇者服饰与头饰各1件同赠时，两件合计7000钻；单件无通用价"
        price_source = ("用户2026-10-15确认首充两件整套合计7000钻、不拆单件；"
                        "同套装盒100146按7000钻条件锚；"
                        "B_宝箱奖励_chest_data.xml/宝箱!532、奖池!803、奖励内容!3674:3675")
    elif state == "缺价":
        tier, business_price = "未价", ""
        limitation = "无已核实的独立商业锚；格位零售价不自动成为全局道具价值"
    elif state == "条件锚":
        tier, business_price = "条件价", fmt(price)
        limitation = old_anchor.get("适用范围", "") or "仅限证据所示活动/道具功能和当前配置"
    else:
        tier, business_price = "直接/严格映射锚", fmt(price)
        limitation = old_anchor.get("适用范围", "全局名义基础价；实际购买/到账条件另验")
    if item_id == "20038":
        limitation = "80钻是当前箱池期望，实际开箱随机；不可称每箱必得80钻"
    elif item_id == "50026":
        limitation = "仅在50026与50002升级消耗等效时按3钻；两ID不可直接混同"
    elif item_id == "5600115":
        limitation = "30钻只计购买者本人使用后获得1普通骰；公会他人收益另计"
    elif item_id == "5600113":
        limitation = "仅当前山河巡游310100期次的规划名义锚200钻/枚；非独立直售价、非实际收益期望"
    elif item_id == "100022":
        limitation = "4000钻/盒是用户确认的规划名义条件锚；实际增量价值随皮肤进度变化，仅满星后成功回收才有2000钻/张兑现值；代币成本另算"
    elif item_id in SIX_ONE_EXPLICIT_ANCHORS and SIX_ONE_EXPLICIT_ANCHORS[item_id][1] == "条件锚":
        limitation = "同ID藏品规划条件锚；6-1下半价值块F/G货币列反置并由商店页交叉验证；当前期次、箱池与玩家进度另验"
    elif item_id in PART_DRAWING_ANCHORS:
        limitation = "用户确认的跨商品规划基础锚3钻/张；格位2.5钻/张为折后售价，不改基础锚"
    elif definition.get("type") == "16" and state == "条件锚" and item_id not in anchors:
        limitation = "按同品质梦灵碎片类目规划价估值，正式type/quality/value交叉吻合；不是该ID独立直售价"
    elif item_id in TICKET_COSTS:
        limitation = "仅适用脚本所列同一期活动的抽奖/购买替代成本"
    if definition_value and state not in ("配置内价", "缺价") and price is not None and float(definition_value) != price:
        limitation += f"；道具配置value={definition_value}与当前商业锚不一致，勿回填"
    item_records.append({
        "补证优先级": priority, "道具ID": item_id,
        "道具名": definition.get("name", "") or old_anchor.get("道具名", "") or "待核资产类型",
        "价态": tier, "商业锚单价_钻": business_price,
        "道具配置value点数_未校准": definition_value,
        "钻石单品报价_钻每件_非锚": quote_text,
        "关联配置行数": str(len(usage)),
        "现金商品关联行数": str(sum(r["付款方式"] == "人民币" for r in usage)),
        "钻石商品关联行数": str(sum(r["付款方式"] == "钻石" for r in usage)),
        "随机池候选关联行数": str(sum(r["范围层级"] == "随机池候选" for r in usage)),
        "活动兑换关联行数": str(sum(r["范围层级"] == "活动兑换商品" for r in usage)),
        "适用条件/限制": limitation,
        "下一证据": ("若单件跨商品出售再分别定价" if item_id in OUTFIT_PAIR
                   else "用当日实际权益使用日志估条件价值" if item_id == "100040"
                   else item_next_evidence(item_id, state)),
        "道具定义来源": f"D_道具_item_data.xml/道具信息!{definition['_row']}" if definition else "道具信息表未见此ID/需查资产类型",
        "估值来源": price_source,
        "关联商品键": ";".join(r["商品键"] for r in usage),
        "_sort_score": score,
    })

assert len(item_records) == len(item_usage)
sort_order = {"未价": 0, "权益服务（按使用计）": 1,
              "仅配置参考价": 2, "组合价（不拆单件）": 3,
              "条件价": 4, "直接/严格映射锚": 5}
item_records.sort(key=lambda r: (sort_order[r["价态"]], -r["_sort_score"], int(r["道具ID"])))
with ITEM_OUT.open("w", encoding="utf-8-sig", newline="") as handle:
    writer = csv.DictWriter(handle, fieldnames=ITEM_FIELDS, delimiter="\t")
    writer.writeheader()
    writer.writerows({key: value for key, value in record.items() if key != "_sort_score"} for record in item_records)

print("rows", len(records))
print("layers", dict(collections.Counter(r["范围层级"] for r in records)))
print("value complete", sum(bool(r["完整奖励价值_钻"]) for r in records))
print("ratio complete", sum(bool(r["完整名义返比"]) for r in records))
print("missing ids", len({i for r in records for i in r["缺价奖励ID"].split(",") if i}))
print("item price tiers", dict(collections.Counter(r["价态"] for r in item_records)))
