"""Find exact item-ID appearances in current local XML sheet cells."""

import re
import sys

from inspect_remaining_sources import XML, sheets


ids = sys.argv[1:] or ["100091", "100110"]
patterns = {item: re.compile(rf"(?<!\d){re.escape(item)}(?!\d)") for item in ids}
for file in sorted(XML.glob("*.xml")):
    for sheet, rows in sheets(file):
        for row in rows:
            for field, value in row.items():
                if field == "_row":
                    continue
                for item, pattern in patterns.items():
                    if pattern.search(value):
                        print(item, file.name, sheet, row["_row"], field, value[:160], sep="\t")
