"""按配置目录与只读交易结果，重建主台账外 60 个现金 pay_id 的核价表。

上游 additional_cash_catalog.tsv 由 build_additional_cash_catalog.py 从 SVN XML 与
《6-1商业化数值》上半区 ID 锚价重建。支付证据只用于确认近期有交易，不验证到账。
"""

from __future__ import annotations

import collections
import csv
from pathlib import Path


HERE = Path(__file__).parent
CATALOG = HERE / "additional_cash_catalog.tsv"
TARGETED = HERE / "targeted_pay_groups_result.tsv"
DIRECT = HERE / "extended_cash_payments_20261015.tsv"
ALIASES = HERE / "extended_cash_package_aliases_20261015.tsv"
OUTPUT = HERE / "extended_cash_pricing.tsv"


def read_tsv(path: Path) -> list[dict[str, str]]:
    with path.open(encoding="utf-8-sig", newline="") as handle:
        return list(csv.DictReader(handle, delimiter="\t"))


def num(value: str) -> float:
    return float(value) if value else 0.0


def tidy(value: float | str) -> str:
    if value == "":
        return ""
    return f"{value:.4f}".rstrip("0").rstrip(".") if isinstance(value, float) else str(value)


catalog = read_tsv(CATALOG)
assert len(catalog) == 60 and len({r["支付ID"] for r in catalog}) == 60
aliases = {r["name"]: r["current_alias"] for r in read_tsv(ALIASES)}
assert len(aliases) == 9

# targeted 查询覆盖其他 54 个支付 ID；结果表只列有交易的 ID。
evidence = {}
for path in (TARGETED, DIRECT):
    for row in read_tsv(path):
        pay_id = row["package_id"]
        if pay_id not in {record["支付ID"] for record in catalog}:
            continue
        key = (pay_id, row["pay_category"])
        assert key not in evidence, key
        evidence[key] = row

columns = [
    "模块", "方案", "商品ID", "支付ID", "支付库当前别名", "人民币售价", "近30日实付订单", "近30日代金券订单",
    "售卖证据状态", "核价状态", "完整名义价值_钻", "完整名义返比", "已锚定部分_钻",
    "充值本金_钻", "首次额外_钻", "复购额外_钻", "首次到账_钻", "首次到账倍率",
    "复购到账_钻", "复购到账倍率", "付费奖励ID×数量", "分期奖励ID×数量",
    "缺价奖励ID", "开放或达成条件", "价值口径及限制", "配置来源", "支付价格来源", "交易证据来源",
]

output = []
for row in catalog:
    pay_id = row["支付ID"]
    direct_count = int(evidence.get((pay_id, "1"), {}).get("orders_30d", "0"))
    voucher_count = int(evidence.get((pay_id, "4"), {}).get("orders_30d", "0"))
    observed = direct_count + voucher_count > 0
    module = row["模块"]
    price = num(row["人民币售价"])
    denominator = 10 * price
    unknown = row["未锚定奖励ID"]
    known_value = num(row["已锚定名义价值_钻"])

    if module == "钻石直充":
        assert observed, pay_id
        first = num(row["直充首次到账_钻"])
        repeat = num(row["直充复购到账_钻"])
        assert num(row["直充本金_钻"]) == denominator
        assert first == 2 * denominator
        assert repeat >= denominator
        status = "近期有交易_充值配置可计价"
        valuation = "完整_首购与复购分口径"
        face_value, face_ratio = "", ""
        limit = (
            "原价本金是兑入钻石，首购赠送与复购赠送另计；倍率是配置到账钻/10P，"
            "不能解释为额外礼包价值。实时到账及首购判定未验证。"
        )
    elif module == "基金" and pay_id in {"40101", "40402", "40403"}:
        assert observed and not unknown and known_value > 0
        status = "近期有交易_配置付费轨可计价"
        valuation = "完整_达成全部关卡节点后的上限"
        face_value, face_ratio = tidy(known_value), tidy(known_value / denominator)
        first = repeat = 0.0
        limit = (
            "仅付费轨累计钻石；购买并不立即发齐，需继续通过各章节。"
            "实际领取额、退款及线上发奖均未验证；免费轨不计。"
        )
    elif module == "新手礼包" and pay_id in {"300", "301"}:
        assert not observed and not unknown and known_value > 0
        status = "近期未见同口径交易_配置候选"
        valuation = "配置完整_未证在售"
        face_value, face_ratio = tidy(known_value), tidy(known_value / denominator)
        first = repeat = 0.0
        limit = "开服第1–7日限定；上半区 ID 锚价可完整算名义值，但近30日筛选内无交易，不列现行在售。"
    elif module == "基金" and row["配置现行性"].startswith("疑点_"):
        assert not observed
        status = "无绑定奖励节点_非已核在售"
        valuation = "不可核价"
        face_value = face_ratio = ""
        first = repeat = 0.0
        limit = "显示和支付行存在，但奖励表没有对应 type 节点；create_day=9999；不能认作有效售卖。"
    elif module == "基金" and "create_day,9999" in row["开放条件_配置原文"]:
        assert not observed
        status = "第9999日触发_疑似占位"
        valuation = "缺锚价且不可核在售"
        face_value = face_ratio = ""
        first = repeat = 0.0
        limit = "基金付费轨虽有奖励节点，但展示条件 create_day=9999；近期无交易，不认作现行在售。"
    elif module == "七日直购" and row["配置现行性"].startswith("疑点_"):
        assert not observed
        status = "第999日触发_疑似占位"
        valuation = "不计算返比"
        face_value = face_ratio = ""
        first = repeat = 0.0
        limit = "create_day=999 且 198/328 元礼包仅列 121–181 钻，配置异常；近期无交易。"
    elif module == "新手礼包" and "第2期" in row["方案"]:
        assert not observed
        status = "开启表错列_疑似占位"
        valuation = "不计算返比"
        face_value = face_ratio = ""
        first = repeat = 0.0
        limit = "开启时间写在 D:F 而表头在 A:C；奖励仅重复 ID11，名称与内容不符；近期无交易。"
    elif module == "职业礼包":
        assert not observed
        status = "等级999条件_配置候选未见交易"
        valuation = "缺道具锚价"
        face_value = face_ratio = ""
        first = repeat = 0.0
        limit = "活动条件 level=999；周礼包分期奖励只有单日配置量，未按七日放大；近期无交易。"
    else:
        assert not observed and unknown, (pay_id, unknown)
        status = "近期未见同口径交易_配置候选"
        valuation = "缺道具锚价"
        face_value = face_ratio = ""
        first = repeat = 0.0
        limit = "已锚定部分不能当作礼包全值；具体开放、销售和未锚定奖励仍待实证。"

    proof = (
        "extended_cash_payments_20261015.sql/extended_cash_payments_20261015.tsv"
        if module == "钻石直充" else
        "targeted_pay_groups_20261015.sql/targeted_pay_groups_result.tsv"
    )
    output.append({
        "模块": module,
        "方案": row["方案"],
        "商品ID": row["商品ID"],
        "支付ID": pay_id,
        "支付库当前别名": aliases.get(pay_id, ""),
        "人民币售价": row["人民币售价"],
        "近30日实付订单": str(direct_count),
        "近30日代金券订单": str(voucher_count),
        "售卖证据状态": status,
        "核价状态": valuation,
        "完整名义价值_钻": face_value,
        "完整名义返比": face_ratio,
        "已锚定部分_钻": row["已锚定名义价值_钻"],
        "充值本金_钻": row["直充本金_钻"],
        "首次额外_钻": row["直充首次额外_钻"],
        "复购额外_钻": row["直充复购额外_钻"],
        "首次到账_钻": row["直充首次到账_钻"],
        "首次到账倍率": tidy(first / denominator) if module == "钻石直充" else "",
        "复购到账_钻": row["直充复购到账_钻"],
        "复购到账倍率": tidy(repeat / denominator) if module == "钻石直充" else "",
        "付费奖励ID×数量": row["付费奖励ID×数量"],
        "分期奖励ID×数量": row["分期奖励ID×数量"],
        "缺价奖励ID": unknown,
        "开放或达成条件": row["开放条件_配置原文"] + (
            "; 节点=" + row["分期达成条件"] if row["分期达成条件"] else ""
        ),
        "价值口径及限制": limit,
        "配置来源": row["配置来源"],
        "支付价格来源": row["价格来源"],
        "交易证据来源": proof + (
            "; extended_cash_package_aliases_20261015.sql/extended_cash_package_aliases_20261015.tsv"
            if pay_id in aliases else ""
        ),
    })

assert len(output) == 60
assert sum(r["售卖证据状态"].startswith("近期有交易") for r in output) == 9
assert sum(bool(r["完整名义返比"]) for r in output) == 5  # 3 基金 + 2 新手候选
assert sum(bool(r["首次到账倍率"]) for r in output) == 6
assert all(r["完整名义返比"] == "" for r in output if r["缺价奖励ID"])

with OUTPUT.open("w", encoding="utf-8-sig", newline="") as handle:
    writer = csv.DictWriter(handle, columns, delimiter="\t")
    writer.writeheader()
    writer.writerows(output)

print(OUTPUT)
print("rows", len(output))
print("observed", [r["支付ID"] for r in output if r["售卖证据状态"].startswith("近期有交易")])
print("statuses", dict(collections.Counter(r["核价状态"] for r in output)))
