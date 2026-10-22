"""Merge the seven 2026-10-16 星旅寻梦 worksheet fragments in OOXML.

Only the added worksheet and its package references are rewritten.  All 34
pre-existing worksheet parts (and their charts, links, etc.) retain their
original uncompressed bytes.
"""

from __future__ import annotations

from copy import deepcopy
from pathlib import Path
import re
from zipfile import ZipFile

from lxml import etree as ET
from openpyxl.formula.translate import Translator
from openpyxl.utils.cell import get_column_letter


SOURCE = Path(
    r"E:\x1\配置\trunk\策划文档\数值文档\《梦境护卫队》6-1商业化数值_新期修正版_20261016.xlsx"
)
OUTPUT = Path(
    r"D:\Administrator\Documents\ChatGPT\MJ Game  Design AGENT\outputs\01a13de3-b726-7312-9642-5d6da6bd11b4\《梦境护卫队》6-1商业化数值_新期修正版_20261016_按活动合页.xlsx"
)
SHEET_NAME = "星旅寻梦（现行）"
SECTIONS = [
    (35, "XLYM_ActivityIndex"),
    (36, "XLYM_ActivityProducts"),
    (37, "XLYM_TaskRewards"),
    (38, "XLYM_RecruitDays"),
    (39, "XLYM_DrawCosts"),
    (40, "XLYM_PoolWeights"),
    (41, "XLYM_PoolRewards"),
]

M = "http://schemas.openxmlformats.org/spreadsheetml/2006/main"
R = "http://schemas.openxmlformats.org/officeDocument/2006/relationships"
P = "http://schemas.openxmlformats.org/package/2006/relationships"
CT = "http://schemas.openxmlformats.org/package/2006/content-types"
APP = "http://schemas.openxmlformats.org/officeDocument/2006/extended-properties"
VT = "http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes"
Q = lambda namespace, local: f"{{{namespace}}}{local}"
CELL = re.compile(r"(?P<col>[A-Z]{1,3})(?P<row>\d+)")


def xml_bytes(root: ET._Element) -> bytes:
    return ET.tostring(root, encoding="UTF-8", xml_declaration=True, standalone=True)


def shift_ref(ref: str, offset: int) -> str:
    def replace(match: re.Match[str]) -> str:
        return f"{match.group('col')}{int(match.group('row')) + offset}"

    return CELL.sub(replace, ref)


def cell_text(cell: ET._Element) -> str:
    inline = cell.find(Q(M, "is"))
    if inline is not None:
        return "".join(inline.itertext())
    value = cell.find(Q(M, "v"))
    return value.text or "" if value is not None else ""


def main() -> None:
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    with ZipFile(SOURCE, "r") as src:
        names = set(src.namelist())
        roots = {
            idx: ET.fromstring(src.read(f"xl/worksheets/sheet{idx}.xml"))
            for idx, _ in SECTIONS
        }

        # Each former page becomes a titled, independently filterable block.
        layout: list[dict] = []
        next_start = 1
        for idx, name in SECTIONS:
            root = roots[idx]
            original_end = int(root.find(Q(M, "dimension")).get("ref").split(":")[-1].lstrip("ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
            offset = next_start - 1
            header_row = 4 + offset
            table_end = original_end + offset
            headers = [cell_text(cell) for cell in root.findall(f".//{Q(M, 'row')}[@r='4']/{Q(M, 'c')}")]
            assert headers and all(headers) and len(set(headers)) == len(headers), (idx, headers)
            layout.append(
                dict(
                    index=idx,
                    name=name,
                    offset=offset,
                    first=next_start,
                    last=table_end,
                    header=header_row,
                    table_ref=f"A{header_row}:{get_column_letter(len(headers))}{table_end}",
                    headers=headers,
                )
            )
            next_start = table_end + 3  # two empty rows before next section
        assert [entry["last"] - entry["header"] for entry in layout] == [3, 9, 20, 7, 2, 9, 55]

        merged = ET.Element(Q(M, "worksheet"), nsmap={None: M, "r": R})
        ET.SubElement(merged, Q(M, "dimension"), ref=f"A1:Z{layout[-1]['last']}")
        sheet_views = deepcopy(roots[35].find(Q(M, "sheetViews")))
        pane = sheet_views.find(f"{Q(M, 'sheetView')}/{Q(M, 'pane')}")
        pane.set("ySplit", "1")
        pane.set("topLeftCell", "A2")
        pane.set("activePane", "bottomLeft")
        merged.append(sheet_views)
        merged.append(deepcopy(roots[35].find(Q(M, "sheetFormatPr"))))

        # A worksheet has one width per column. Retain the widest useful width
        # while capping very long provenance/raw-string columns: their cells
        # already wrap and a 45-character column keeps the 26-column sheet
        # practical to navigate.
        widths: dict[int, float] = {}
        for root in roots.values():
            for col in root.find(Q(M, "cols")):
                for number in range(int(col.get("min")), int(col.get("max")) + 1):
                    widths[number] = max(widths.get(number, 0), min(45, float(col.get("width"))))
        cols = ET.SubElement(merged, Q(M, "cols"))
        for number in sorted(widths):
            ET.SubElement(
                cols,
                Q(M, "col"),
                min=str(number),
                max=str(number),
                width=f"{widths[number]:g}",
                customWidth="1",
            )

        data = ET.SubElement(merged, Q(M, "sheetData"))
        formula_counts: dict[int, int] = {}
        for entry in layout:
            idx, offset = entry["index"], entry["offset"]
            count = 0
            for source_row in roots[idx].find(Q(M, "sheetData")):
                row = deepcopy(source_row)
                row.set("r", str(int(row.get("r")) + offset))
                for cell in row.findall(Q(M, "c")):
                    old_ref = cell.get("r")
                    new_ref = shift_ref(old_ref, offset)
                    cell.set("r", new_ref)
                    formula = cell.find(Q(M, "f"))
                    if formula is not None:
                        original = formula.text or ""
                        transformed = Translator("=" + original, origin=old_ref).translate_formula(new_ref)[1:]
                        if idx == 40:
                            old_absolute = "$E$5:$E$13"
                            new_absolute = f"$E${5 + offset}:$E${13 + offset}"
                            assert old_absolute in transformed, (old_ref, transformed)
                            transformed = transformed.replace(old_absolute, new_absolute)
                        formula.text = transformed
                        count += 1
                data.append(row)
            formula_counts[idx] = count
        assert formula_counts == {35: 0, 36: 44, 37: 20, 38: 0, 39: 0, 40: 9, 41: 55}

        merges = ET.SubElement(merged, Q(M, "mergeCells"))
        merge_count = 0
        for entry in layout:
            element = roots[entry["index"]].find(Q(M, "mergeCells"))
            if element is None:
                continue
            for source_merge in element:
                merge = deepcopy(source_merge)
                merge.set("ref", shift_ref(merge.get("ref"), entry["offset"]))
                merges.append(merge)
                merge_count += 1
        merges.set("count", str(merge_count))
        margins = roots[35].find(Q(M, "pageMargins"))
        if margins is not None:
            merged.append(deepcopy(margins))
        table_parts = ET.SubElement(merged, Q(M, "tableParts"), count="7")
        for number in range(1, 8):
            ET.SubElement(table_parts, Q(M, "tablePart"), {Q(R, "id"): f"rId{number}"})

        table_file_numbers = [int(re.search(r"table(\d+)\.xml$", part).group(1)) for part in names if re.fullmatch(r"xl/tables/table\d+\.xml", part)]
        table_ids = [int(ET.fromstring(src.read(f"xl/tables/table{number}.xml")).get("id")) for number in table_file_numbers]
        assert len(table_file_numbers) == 52 and len(set(table_ids)) == 52
        new_part_first = max(table_file_numbers) + 1
        new_id_first = max(table_ids) + 1
        assert new_part_first == 53 and new_id_first == 76

        table_files: dict[str, bytes] = {}
        for ordinal, entry in enumerate(layout):
            table = ET.Element(
                Q(M, "table"),
                nsmap={None: M},
                id=str(new_id_first + ordinal),
                name=entry["name"],
                displayName=entry["name"],
                ref=entry["table_ref"],
                totalsRowShown="0",
            )
            ET.SubElement(table, Q(M, "autoFilter"), ref=entry["table_ref"])
            columns = ET.SubElement(table, Q(M, "tableColumns"), count=str(len(entry["headers"])))
            for col_idx, title in enumerate(entry["headers"], start=1):
                ET.SubElement(columns, Q(M, "tableColumn"), id=str(col_idx), name=title)
            ET.SubElement(
                table,
                Q(M, "tableStyleInfo"),
                name="TableStyleMedium2",
                showFirstColumn="0",
                showLastColumn="0",
                showRowStripes="0",
                showColumnStripes="0",
            )
            table_files[f"xl/tables/table{new_part_first + ordinal}.xml"] = xml_bytes(table)

        sheet_rels = ET.Element(Q(P, "Relationships"), nsmap={None: P})
        for ordinal in range(7):
            ET.SubElement(
                sheet_rels,
                Q(P, "Relationship"),
                Id=f"rId{ordinal + 1}",
                Type=f"{R}/table",
                Target=f"../tables/table{new_part_first + ordinal}.xml",
            )

        book = ET.fromstring(src.read("xl/workbook.xml"))
        sheets = book.find(Q(M, "sheets"))
        assert len(sheets) == 41
        assert [x.get("name") for x in list(sheets)[34:]] == [
            "现行活动索引", "现行活动商品", "现行任务奖励", "现行招募日期",
            "现行抽卡消耗", "现行奖池权重", "现行奖池奖励",
        ]
        list(sheets)[34].set("name", SHEET_NAME)
        for old in list(sheets)[35:]:
            sheets.remove(old)
        assert len(sheets) == 35

        workbook_rels = ET.fromstring(src.read("xl/_rels/workbook.xml.rels"))
        for rel in list(workbook_rels):
            if re.fullmatch(r"worksheets/sheet(?:3[6-9]|4[01])\.xml", rel.get("Target", "")):
                workbook_rels.remove(rel)

        types = ET.fromstring(src.read("[Content_Types].xml"))
        for part in list(types):
            if re.fullmatch(r"/xl/worksheets/sheet(?:3[6-9]|4[01])\.xml", part.get("PartName", "")):
                types.remove(part)
        for ordinal in range(7):
            ET.SubElement(
                types,
                Q(CT, "Override"),
                PartName=f"/xl/tables/table{new_part_first + ordinal}.xml",
                ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.table+xml",
            )

        app = ET.fromstring(src.read("docProps/app.xml"))
        heading_count = app.find(f"{Q(APP, 'HeadingPairs')}/{Q(VT, 'vector')}/{Q(VT, 'variant')}[2]/{Q(VT, 'i4')}")
        heading_count.text = "35"
        titles = app.find(f"{Q(APP, 'TitlesOfParts')}/{Q(VT, 'vector')}")
        assert int(titles.get("size")) == 34 and len(titles) == 34
        titles.set("size", "35")
        ET.SubElement(titles, Q(VT, "lpstr")).text = SHEET_NAME

        changed = {
            "xl/worksheets/sheet35.xml": xml_bytes(merged),
            "xl/workbook.xml": xml_bytes(book),
            "xl/_rels/workbook.xml.rels": xml_bytes(workbook_rels),
            "[Content_Types].xml": xml_bytes(types),
            "docProps/app.xml": xml_bytes(app),
        }
        added = {
            "xl/worksheets/_rels/sheet35.xml.rels": xml_bytes(sheet_rels),
            **table_files,
        }
        removed = {f"xl/worksheets/sheet{index}.xml" for index in range(36, 42)}
        assert not (set(added) & names)
        with ZipFile(OUTPUT, "w") as dst:
            for info in src.infolist():
                if info.filename in removed:
                    continue
                dst.writestr(info, changed.get(info.filename, src.read(info.filename)))
            for part, payload in added.items():
                dst.writestr(part, payload)

    print("OUTPUT", OUTPUT)
    print("LAYOUT", [(x["index"], x["table_ref"]) for x in layout])
    print("FORMULAS", formula_counts, "TOTAL", sum(formula_counts.values()))
    print("SIZE", OUTPUT.stat().st_size)


if __name__ == "__main__":
    main()
