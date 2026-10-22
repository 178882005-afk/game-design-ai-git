"""Read-only inspection of commerce configuration candidates."""

from pathlib import Path
import xml.etree.ElementTree as ET

XML = Path("E:/x1/配置/trunk/xml_gy/normal")
NS = "{urn:schemas-microsoft-com:office:spreadsheet}"


def path(suffix):
    match = list(XML.glob("*" + suffix + ".xml"))
    if suffix == "recommend_gift_data":
        match = [p for p in match if p.name.startswith("G_")]
    if suffix == "pay_data":
        match = [p for p in match if p.name.startswith("C_")]
    assert len(match) == 1, (suffix, match)
    return match[0]


def sheets(file):
    root = ET.parse(file).getroot()
    for ws in root.findall(NS + "Worksheet"):
        name = ws.get(NS + "Name")
        table = ws.find(NS + "Table")
        if table is None:
            continue
        out, names, number = [], {}, 0
        for row in table.findall(NS + "Row"):
            number = int(row.get(NS + "Index") or number + 1)
            cells, col = {}, 1
            for cell in row.findall(NS + "Cell"):
                col = int(cell.get(NS + "Index") or col)
                data = cell.find(NS + "Data")
                cells[col] = (data.text or "") if data is not None else ""
                col += 1
            if number == 2:
                names = {k: v for k, v in cells.items() if v}
            elif number > 2 and names and any(cells.values()):
                out.append({"_row": number, **{v: cells.get(k, "") for k, v in names.items()}})
        yield name, out


if __name__ == "__main__":
    for suffix in [
        "activity_shop_data",
        "activity_recommend_gift_data",
        "recommend_gift_data",
        "activity_data",
        "shopping_new_data",
        "activity_aim_shop_data",
        "limited_time_gift_data",
    ]:
        file = path(suffix)
        print("\nFILE", file.name)
        for name, data in sheets(file):
            print("SHEET", name, len(data))
            if suffix == "activity_shop_data" and "base_id" in (data[0] if data else {}):
                from collections import Counter
                print("BASE", Counter(x.get("base_id") for x in data))
                for x in data:
                    if x.get("base_id") in {"25002", "25003", "25004"}:
                        print(x)
            elif suffix == "activity_recommend_gift_data":
                for x in data:
                    print(x)
            elif suffix == "recommend_gift_data" and "pay_id" in (data[0] if data else {}):
                for x in data:
                    print(x)
            elif suffix == "activity_data" and "base_id" in (data[0] if data else {}):
                for x in data:
                    if x.get("data_cfg") in {"activity_shop_data", "activity_recommend_gift_data", "activity_aim_shop_data"} and ("2026" in str(x) or "2035" in str(x)):
                        print(x)
            elif suffix == "shopping_new_data" and "shop_id" in (data[0] if data else {}):
                if "reward" in data[0] and "need" in data[0]:
                    for x in data:
                        print(x)
                else:
                    print(data[:3])
            elif suffix == "activity_aim_shop_data":
                print(data)
            elif suffix == "limited_time_gift_data":
                print(data)
