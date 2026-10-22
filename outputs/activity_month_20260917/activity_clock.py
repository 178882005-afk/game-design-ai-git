#!/usr/bin/env python3
"""Parse activity_data.erl and calculate configured activity states for a server."""

from __future__ import annotations

import json
import re
from dataclasses import dataclass
from datetime import datetime, timedelta
from pathlib import Path
from typing import Any
from zoneinfo import ZoneInfo


TIMEZONE = ZoneInfo("Asia/Shanghai")
DAY_SECONDS = 86_400
STATUS_LABELS = {
    "future": "未开始",
    "preview": "预览期",
    "open": "开启中",
    "expire": "展示期",
    "deleted": "已结束",
}
ACTIVITY_TYPE_NAMES = {
    1: "目标任务", 2: "商城", 3: "兑换", 4: "抽奖", 5: "每日充值",
    6: "累计充值", 7: "签到豪礼", 8: "排行", 9: "目标任务",
    10: "入口活动", 11: "天赋卡池", 12: "战令", 13: "轮循任务",
    14: "连充豪礼", 15: "职业特卖", 16: "目标商城", 17: "收藏",
    18: "特惠商城", 19: "梦灵试炼", 20: "首月活动", 21: "每日分享",
    22: "试炼抽奖", 23: "推送礼包", 24: "轮次抽奖", 25: "实物抽奖",
    26: "掉落活动", 27: "盲盒拼图", 28: "公会首领", 29: "储蓄罐",
    30: "次月抽奖", 31: "大富翁", 32: "赐福", 34: "抽卡打折",
    35: "直播庆典", 36: "限时UP卡池", 37: "大小奖池抽奖",
    38: "单次领奖", 39: "悬赏宝藏", 40: "焕新工坊", 41: "跨服公会首领",
}


class ErlangTermParser:
    def __init__(self, source: str):
        self.source = source
        self.index = 0

    def parse(self) -> Any:
        value = self._parse_value()
        self._skip_space()
        if self.index != len(self.source):
            raise ValueError(f"无法解析的 Erlang term: {self.source!r}")
        return value

    def _skip_space(self) -> None:
        while self.index < len(self.source) and self.source[self.index].isspace():
            self.index += 1

    def _parse_value(self) -> Any:
        self._skip_space()
        if self.index >= len(self.source):
            raise ValueError("Erlang term 为空")
        char = self.source[self.index]
        if char == "{":
            return self._parse_sequence("{", "}", tuple)
        if char == "[":
            return self._parse_sequence("[", "]", list)
        number = re.match(r"[+-]?\d+", self.source[self.index :])
        if number:
            self.index += len(number.group(0))
            return int(number.group(0))
        atom = re.match(r"[a-zA-Z_][a-zA-Z0-9_@]*", self.source[self.index :])
        if atom:
            self.index += len(atom.group(0))
            return atom.group(0)
        raise ValueError(f"不支持的 Erlang term: {self.source!r}")

    def _parse_sequence(self, opener: str, closer: str, factory):
        self.index += 1
        values = []
        self._skip_space()
        if self.index < len(self.source) and self.source[self.index] == closer:
            self.index += 1
            return factory(values)
        while True:
            values.append(self._parse_value())
            self._skip_space()
            if self.index >= len(self.source):
                raise ValueError(f"Erlang term 缺少 {closer}")
            char = self.source[self.index]
            self.index += 1
            if char == closer:
                return factory(values)
            if char != ",":
                raise ValueError(f"Erlang term 期望逗号或 {closer}")


def parse_term(value: str | None, default: Any = None) -> Any:
    if value is None:
        return default
    parsed = ErlangTermParser(value.strip()).parse()
    return default if parsed == "undefined" else parsed


def find_matching(source: str, start: int, opener: str, closer: str) -> int:
    depth = 0
    quote = None
    escaped = False
    comment = False
    for index in range(start, len(source)):
        char = source[index]
        if comment:
            if char == "\n":
                comment = False
            continue
        if quote:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == quote:
                quote = None
            continue
        if char == "%":
            comment = True
        elif char in ('"', "'"):
            quote = char
        elif char == opener:
            depth += 1
        elif char == closer:
            depth -= 1
            if depth == 0:
                return index
    raise ValueError(f"配置在偏移 {start} 处缺少 {closer}")


def split_top_level(value: str, separator: str = ",") -> list[str]:
    parts, start, index = [], 0, 0
    quote = None
    escaped = comment = False
    depths = {"(": 0, "[": 0, "{": 0, "binary": 0}
    while index < len(value):
        char = value[index]
        next_char = value[index + 1] if index + 1 < len(value) else ""
        if comment:
            if char == "\n":
                comment = False
            index += 1
            continue
        if quote:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == quote:
                quote = None
            index += 1
            continue
        if char == "%":
            comment = True
        elif char in ('"', "'"):
            quote = char
        elif char == "<" and next_char == "<":
            depths["binary"] += 1
            index += 1
        elif char == ">" and next_char == ">" and depths["binary"]:
            depths["binary"] -= 1
            index += 1
        elif char in "([{":
            depths[char] += 1
        elif char == ")":
            depths["("] -= 1
        elif char == "]":
            depths["["] -= 1
        elif char == "}":
            depths["{"] -= 1
        elif char == separator and all(depth == 0 for depth in depths.values()):
            parts.append(value[start:index].strip())
            start = index + 1
        index += 1
    final = value[start:].strip()
    if final:
        parts.append(final)
    return parts


def extract_function_list(source: str, name: str) -> list[int]:
    match = re.search(rf"\b{re.escape(name)}\s*\(\s*\)\s*->", source)
    if not match:
        return []
    start = source.index("[", match.end())
    end = find_matching(source, start, "[", "]")
    return [int(value) for value in re.findall(r"\d+", source[start + 1 : end])]


def extract_maps(source: str) -> dict[int, dict[str, str]]:
    pattern = re.compile(r"^get_activity\s*\((\d+)\)\s*->", re.MULTILINE)
    clauses = list(pattern.finditer(source))
    result: dict[int, dict[str, str]] = {}
    for index, clause in enumerate(clauses):
        body_end = clauses[index + 1].start() if index + 1 < len(clauses) else len(source)
        expression = source[clause.end() : body_end]
        map_start = expression.find("#{")
        if map_start < 0:
            continue
        brace_start = map_start + 1
        map_end = find_matching(expression, brace_start, "{", "}")
        fields = {}
        for part in split_top_level(expression[brace_start + 1 : map_end]):
            if "=>" in part:
                key, raw = part.split("=>", 1)
                fields[key.lstrip(",").strip()] = raw.strip()
        result[int(clause.group(1))] = fields
    return result


def extract_value_clauses(source: str, function: str) -> dict[int, Any]:
    pattern = re.compile(rf"^{re.escape(function)}\s*\((\d+)\)\s*->\s*(.+?);", re.MULTILINE)
    result = {}
    for match in pattern.finditer(source):
        try:
            result[int(match.group(1))] = parse_term(match.group(2).strip())
        except ValueError:
            continue
    return result


def extract_name(raw: str | None) -> str:
    match = re.search(r'\?T\(\s*"((?:\\.|[^"\\])*)"\s*\)', raw or "")
    if not match:
        return "未命名活动"
    return bytes(match.group(1), "utf-8").decode("unicode_escape") if "\\" in match.group(1) else match.group(1)


def timestamp_to_datetime(value: int) -> datetime:
    return datetime.fromtimestamp(value, TIMEZONE)


def datetime_term_to_timestamp(value: Any) -> int | None:
    if not (isinstance(value, tuple) and len(value) == 2):
        return None
    try:
        date, clock = value
        return int(datetime(*date, *clock, tzinfo=TIMEZONE).timestamp())
    except (TypeError, ValueError):
        return None


def day_zero(timestamp: int) -> int:
    value = timestamp_to_datetime(timestamp)
    return int(value.replace(hour=0, minute=0, second=0, microsecond=0).timestamp())


def resolve_time(value: Any, server_open_time: int) -> int | None:
    if isinstance(value, int):
        return value
    if isinstance(value, tuple) and len(value) == 2 and value[0] == "server_open_day":
        day = value[1]
        return day_zero(server_open_time) + (day - 1) * DAY_SECONDS if isinstance(day, int) and day > 0 else None
    return datetime_term_to_timestamp(value)


def duration_seconds(value: Any) -> int:
    if value is None:
        return 0
    if not (isinstance(value, tuple) and len(value) == 2 and isinstance(value[1], tuple)):
        raise ValueError(f"无效时长配置: {value!r}")
    days = value[0]
    hours, minutes, seconds = value[1]
    return days * DAY_SECONDS + hours * 3600 + minutes * 60 + seconds


def erlang_div(left: int, right: int) -> int:
    return int(left / right)


def erlang_rem(left: int, right: int) -> int:
    return left - erlang_div(left, right) * right


def server_open_day(server_open_time: int, now: int) -> int:
    return max(1, (day_zero(now) - day_zero(server_open_time)) // DAY_SECONDS + 1)


def server_condition_matches(value: Any, server_open_time: int) -> bool:
    if value is None:
        return True
    if not (isinstance(value, tuple) and len(value) == 2):
        return False
    start = datetime_term_to_timestamp((value[0], (0, 0, 0)))
    end = datetime_term_to_timestamp((value[1], (23, 59, 59)))
    return start is not None and end is not None and start <= server_open_time <= end


def time_to_status(now: int, preview: int, begin: int, end: int, expire: int) -> str:
    if begin <= now < end:
        return "open"
    if preview <= now < begin:
        return "preview"
    if end <= now < expire:
        return "expire"
    if now >= expire:
        return "deleted"
    return "future"


def calc_round(pass_days: int, lasting_days: int, interval: int, expire_seconds: int, now: int) -> int:
    round_number = max(1, erlang_div(pass_days, interval) + 1)
    expire_day, expire_rem = divmod(expire_seconds, DAY_SECONDS)
    today_seconds = now - day_zero(now)
    remainder = erlang_rem(pass_days, interval)
    if remainder < lasting_days + expire_day:
        return round_number
    if remainder == lasting_days + expire_day and today_seconds < expire_rem:
        return round_number
    return round_number + 1


@dataclass(frozen=True)
class ParsedConfig:
    activities: dict[int, dict[str, str]]
    operating_ids: list[int]
    weekly_ids: list[int]
    independent_ids: list[int]
    group_open_times: dict[int, Any]
    group_expire_times: dict[int, Any]
    cycle_open_times: dict[int, Any]
    cycle_expire_times: dict[int, Any]

    @classmethod
    def load(cls, path: Path) -> "ParsedConfig":
        source = path.read_text(encoding="utf-8")
        return cls(
            activities=extract_maps(source),
            operating_ids=extract_function_list(source, "all_activity"),
            weekly_ids=extract_function_list(source, "all_week_activity"),
            independent_ids=extract_function_list(source, "all_independent_cycle_activity"),
            group_open_times=extract_value_clauses(source, "get_group_open_time"),
            group_expire_times=extract_value_clauses(source, "get_group_max_expire_time"),
            cycle_open_times=extract_value_clauses(source, "get_activity_open_time"),
            cycle_expire_times=extract_value_clauses(source, "get_cycle_max_expire_time"),
        )


def cycle_window(open_time: Any, expire_seconds: int, server_open_time: int, now: int) -> tuple[int, int, int]:
    open_base, lasting_days, reopen_days = open_time
    interval_days = lasting_days + reopen_days
    if isinstance(open_base, int):
        pass_days = server_open_day(server_open_time, now) - open_base
        round_number = calc_round(pass_days, lasting_days, interval_days, expire_seconds, now)
        begin = day_zero(server_open_time) + (open_base - 1 + (round_number - 1) * interval_days) * DAY_SECONDS
    else:
        anchor = datetime_term_to_timestamp(open_base)
        if anchor is None:
            raise ValueError(f"无效自然时间活动配置: {open_time!r}")
        pass_days = erlang_div(now - anchor, DAY_SECONDS)
        round_number = max(0, calc_round(pass_days, lasting_days, interval_days, expire_seconds, now))
        begin = day_zero(anchor) if round_number == 0 else day_zero(anchor) + (round_number - 1) * interval_days * DAY_SECONDS
    return round_number, begin, begin + lasting_days * DAY_SECONDS


def serialize_activity(
    activity_id: int,
    fields: dict[str, str],
    category: str,
    now: int,
    begin: int,
    end: int,
    round_number: int | None = None,
) -> dict[str, Any]:
    preview = begin - duration_seconds(parse_term(fields.get("preview_time")))
    expire = end + duration_seconds(parse_term(fields.get("expire_time")))
    status = time_to_status(now, preview, begin, end, expire)
    type_id = parse_term(fields.get("type"), 0)
    return {
        "id": activity_id,
        "base_id": parse_term(fields.get("base_id"), 0),
        "name": extract_name(fields.get("activity_name")),
        "type_id": type_id,
        "type_name": ACTIVITY_TYPE_NAMES.get(type_id, f"类型 {type_id}"),
        "category": category,
        "group_id": parse_term(fields.get("group_id")),
        "round": round_number,
        "status": status,
        "status_label": STATUS_LABELS[status],
        "preview_time": preview,
        "begin_time": begin,
        "end_time": end,
        "expire_time": expire,
    }


def calculate_activities(config: ParsedConfig, server: dict[str, Any], now: int) -> tuple[list[dict[str, Any]], list[dict[str, Any]]]:
    result, skipped = [], []
    server_open_time = int(server["open_time"])
    server_name = str(server["zone_name"])
    category_by_id = {
        **{value: "普通活动" for value in config.operating_ids},
        **{value: "周循环" for value in config.weekly_ids},
        **{value: "独立循环" for value in config.independent_ids},
    }
    for activity_id in config.operating_ids + config.weekly_ids + config.independent_ids:
        fields = config.activities.get(activity_id)
        if not fields:
            skipped.append({"id": activity_id, "reason": "活动配置不存在"})
            continue
        if server_name == "sy_739" and activity_id in {200151, 200152, 200153, 200154}:
            continue
        try:
            condition = parse_term(fields.get("server_condition"))
            if not server_condition_matches(condition, server_open_time):
                continue
            if activity_id in config.operating_ids:
                begin = resolve_time(parse_term(fields.get("begin_time")), server_open_time)
                end = resolve_time(parse_term(fields.get("end_time")), server_open_time)
                if begin is None or end is None:
                    raise ValueError("begin_time/end_time 无法解析")
                item = serialize_activity(activity_id, fields, category_by_id[activity_id], now, begin, end)
            else:
                if activity_id in config.weekly_ids:
                    group_id = parse_term(fields.get("group_id"))
                    open_time = config.group_open_times.get(group_id) or parse_term(fields.get("open_time"))
                    expire_seconds = int(config.group_expire_times.get(group_id, 0) or 0)
                else:
                    open_time = config.cycle_open_times.get(activity_id) or parse_term(fields.get("open_time"))
                    expire_seconds = int(config.cycle_expire_times.get(activity_id, 0) or 0)
                round_number, begin, round_end = cycle_window(open_time, expire_seconds, server_open_time, now)
                round_interval = parse_term(fields.get("round_interval"))
                if isinstance(round_interval, tuple):
                    round_matches = round_interval[0] <= round_number <= round_interval[1]
                else:
                    round_matches = isinstance(round_interval, int) and round_number >= round_interval
                if not round_matches:
                    continue
                end = round_end
                override = datetime_term_to_timestamp(parse_term(fields.get("end_time_override")))
                if activity_id in config.weekly_ids and override is not None:
                    if begin >= override:
                        continue
                    if round_end + round_end - begin > override:
                        end = override
                item = serialize_activity(
                    activity_id, fields, category_by_id[activity_id], now, begin, end, round_number
                )
            if item["status"] != "deleted":
                result.append(item)
        except (TypeError, ValueError, ZeroDivisionError) as error:
            skipped.append({"id": activity_id, "reason": str(error)})
    status_order = {"open": 0, "preview": 1, "expire": 2, "future": 3}
    result.sort(key=lambda item: (status_order[item["status"]], item["begin_time"], item["id"]))
    return result, skipped


def find_servers(server_info_path: Path, query: str, platform: str | None = None) -> list[dict[str, Any]]:
    servers = json.loads(server_info_path.read_text(encoding="utf-8"))
    normalized = query.strip().lower()
    matches = []
    for server in servers:
        candidates = {
            str(server["zone_id"]).lower(),
            str(server["zone_name"]).lower(),
            f"{server['platform']}_{server['zone_id']}".lower(),
        }
        if normalized in candidates and (not platform or str(server["platform"]) == platform):
            matches.append(server)
    return matches


def build_payload(config_path: Path, server_info_path: Path, server: dict[str, Any], now: int) -> dict[str, Any]:
    config = ParsedConfig.load(config_path)
    activities, skipped = calculate_activities(config, server, now)
    counts = {status: sum(item["status"] == status for item in activities) for status in ("open", "preview", "expire", "future")}
    return {
        "server": server,
        "server_open_day": server_open_day(int(server["open_time"]), now),
        "now": now,
        "timezone": "Asia/Shanghai",
        "activities": activities,
        "counts": counts,
        "skipped_count": len(skipped),
        "sources": {"activity": str(config_path), "server": str(server_info_path)},
    }


