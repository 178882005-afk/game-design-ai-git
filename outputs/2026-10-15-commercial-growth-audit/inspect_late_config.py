"""Read exported SpreadsheetML with true Excel row/column indexes."""

from pathlib import Path
import sys
import xml.etree.ElementTree as ET

ROOT = Path(r"E:\x1\配置\trunk\xml_gy\normal")
NS = "{urn:schemas-microsoft-com:office:spreadsheet}"


def sheet_rows(path: Path, name: str):
    root = ET.parse(path).getroot()
    for worksheet in root.findall(NS + "Worksheet"):
        if worksheet.get(NS + "Name") != name:
            continue
        actual_row = 0
        for row in worksheet.find(NS + "Table").findall(NS + "Row"):
            actual_row = int(row.get(NS + "Index") or actual_row + 1)
            values = {}
            col = 1
            for cell in row.findall(NS + "Cell"):
                col = int(cell.get(NS + "Index") or col)
                data = cell.find(NS + "Data")
                if data is not None:
                    values[col] = data.text or ""
                col += 1
            yield actual_row, values
        return
    raise ValueError(f"Missing {name} in {path}")


def main() -> None:
    file, sheet, begin, end = sys.argv[1:]
    path = ROOT / file
    for number, row in sheet_rows(path, sheet):
        if int(begin) <= number <= int(end):
            cells = " | ".join(f"{key}:{value[:120]}" for key, value in row.items())
            print(f"{number} | {cells}")


if __name__ == "__main__":
    main()
