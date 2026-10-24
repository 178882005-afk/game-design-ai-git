# 本地保留的大文件清单

> 单文件超过 5 MB 的产物未推送到 GitHub，只存在于本地工作区。

| 大小 | 路径 |
| --- | --- |
| 60.5 MB | `outputs/2026-10-22-resource-closure/统一收支明细.tsv` |
| 58.4 MB | `outputs/2026-10-19-resource-closure/统一收支明细.tsv` |
| 21.4 MB | `outputs/2026-10-19-resource-closure/统一逐日资源账.tsv` |
| 21.2 MB | `outputs/2026-10-22-resource-closure/统一逐日资源账.tsv` |
| 14.9 MB | `outputs/2026-10-22-resource-closure/统一来源流水.tsv` |
| 14.7 MB | `outputs/2026-10-19-resource-closure/统一来源流水.tsv` |
| 13.9 MB | `outputs/2026-10-19-resource-closure/资源分配流水.tsv` |
| 11.5 MB | `outputs/01a0bddf-f90c-7af2-a6cc-a7ef653175d8/sources/supp.xlsx` |

合计 8 个文件，约 216.3 MB。

另有两类内容同样只在本地（体积大或属可重算的中间态）：

- `.scratch/`（约 481 MB）、`.tmp_prd_template/`（约 7.9 MB）
- `**/_work/`、`**/.workbook_tmp/`、`*.inspect.ndjson` 等算表中间产物

`game-design-ai-git/` 是独立 git 仓库，其内容已发布在本仓库 `main` 分支，故不在本分支重复提交。
