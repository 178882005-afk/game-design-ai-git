# 商业化与成长线数值底稿

基准日：2026-10-15（北京时间）；SVN 核查时 HEAD r65300。

用户已确认最终版范围为**最新配置中现行及满足条件后可购买的商品及其奖励道具**；历史、占位、索引实现停用的配置另列。现行筛选后的全量账为 **771 条配置候选记录、138 个去重奖励 ID**；候选记录含随机池和购买阶梯，不是同时在售 SKU 数。

## 交付物

- `00_先看这里.md`：给策划阅读的入口，先看定价规则、盘点进度、关键成长节点和“实测／预测／暂无日数”的区别，再进入明细。
- `剩余道具定价决策.md`：本期门票同店条件价、两款品质 7 礼盒新规划价的证据与限制，以及首充服务权益、两件合价外观为何不拆成单件价。
- `commercial_ratio_ranking_note.md`、`commercial_ratio_ranking.tsv`、`build_commercial_ratio_ranking.py`：将可算完整返比的商品按人民币／钻石／金币分别排序；区分配方名义值与实际购买、领取条件。
- `梦境护卫队_商业化与成长线数值账_2026-10-15.xlsx`：可筛选工作簿，含总览、771 商品候选、138 道具价态、411 条同币种返比排序、85 成长配置节点及三组既有实测；新增“分层进度／分层资源／分层节点”三页，将 `v260928` 同版正式基线与跨版本历史参考分列，小样本数值留空。首页统计与本次明细同步写入，工作簿为本日快照。
- `growth_top10_online_baseline_20261015.md`：按用户确认的首周 8 个付费档、D7 主线优先／等级打平，固定每档前 10% 同一批玩家；报告最新完整 D7 同版本的进度、道具产销和养成首达，以及 D25 跨版本参考、样本与右删失。`growth_top10_*tsv` 为逐档逐日、逐道具、节点和质量核查明细；同名前缀 `.sql` 可复跑。
- `final_commercial_scope_note.md`、`final_commercial_scope.tsv`、`final_item_anchor_ledger.tsv`、`build_final_commercial_scope.py`：**现行全量商品与道具主账**。138 ID 中 36 个直接／严格映射锚、99 个条件锚、0 个真未价、1 个按实际使用计的服务权益，以及 2 件只按整套合计 7000 钻、不拆单价的首充外观。771 条候选中 764 条可算完整规划名义奖励钻价、411 条可算数值返比；余下 7 条为 6 档首购／复购分列的直充和 1 条首充服务权益。新确认 `57` 本期 200 钻／张、`100092`／`100111` 各 15000 钻／盒已入账，三条商品因代币成本缺统一钻价，返比仍空。限时金骰 `5600114` 仅本期有效期间按 200 钻／枚；海拉本体 `1410200` 按品质 6 类目价 480 钻作条件锚，其配置 `value=160` 只作内部点数参考。脚本可重建两账。
- `isolated_seven_day_direct.tsv`、`isolated_rookie_gift.tsv`、`isolated_limited_time_gift.tsv`：三组本地配置仍存在、但服务端索引的整模块支付或发奖实现停用的候选；原先主账 7／7／9 条分别隔离，运行服状态待复核。
- `commercial_decision_framework.md`：后续改价、改商品内容、改投放时的四层决策表及可填写模板；返比、目标提前日与商业结果各有独立口径。
- `conditional_retail_ranges_note.md`、`conditional_retail_ranges.tsv`、`build_conditional_retail_ranges.py`：从单一奖励的钻石购买候选提取 45 个道具的格位／期次零售报价区间；只作条件参考，不升级为全局道具锚。
- `unpriced_core_evidence.md`、`unpriced_special_evidence.md`：突破核心、金骰子、自选 UR 箱、衣橱盒 V 等高影响道具的逐项证据、可用规则与尚缺的输入；已确认并适用现行范围的条件锚同步到主账。
- `商业化与成长线基线.md`：来源优先级、道具锚、商品结构、成长线、线上校准和待决策。
- `commercial_products.tsv`：已逐项核价的六类 58 个商品／达标档位；空返比表示不应据此出完整倍率。
- `commercial_reward_lines.tsv`：按商品和奖励 ID 合并的 89 条明细，保留锚价、估值方法和来源。
- `item_anchor_ledger.tsv`、`build_item_anchor_ledger.py`、`validate_item_anchor_ledger.py`：较早四份目录的 **84 ID 阶段账**，保留原始核查和溯源；与现行 138 ID 仅交集 52 个，**不再作为全量道具统计或核价主账**。其脚本按本地 SVN 工作副本的 6-1 价值表和道具定义表读取；可用 `--root` 指定其他工作副本。
- `rebuild_commercial_ledger.py`、`commercial_coverage_scan.py`：重建以上两张 TSV 的只读脚本。前者从给定的本地 SVN 工作副本读取正式 XML 与 6-1 表，输出到本目录；运行命令为 `python rebuild_commercial_ledger.py`。脚本对特定有效方案 ID 和已核道具价有显式规则，SVN 更新后必须先复核规则、奖池与时间窗，再解释新结果。
- `event_cash_catalog.tsv`、`rebuild_event_cash_catalog.py`：五组新服现金礼包 15 个 SKU 和一条活动战令付费轨；票券价是同次抽取的条件替代成本，须在当期抽奖机制内使用。
- `additional_cash_catalog.tsv`、`build_additional_cash_catalog.py`：基金／新手／七日直购／职业／钻石直充的 60 条配置目录。时间窗有效但条件不可达、无奖励或近 30 日未见交易的条目仍保留在目录，不能认作在售。
- `extended_cash_pricing.tsv`、`rebuild_extended_cash_pricing.py`、`extended_cash_pricing_note.md`：对上述 60 个 pay_id 按奖励节点和开放条件继续核价；直充本金、首购赠钻、复购赠钻单列。`extended_cash_payments_20261015.sql/.tsv` 是六档直充的近 30 日支付读数；`extended_cash_package_aliases_20261015.sql/.tsv` 是支付库当前别名，均不能证明每笔交易时版本或实际发奖。
- `targeted_pay_groups_result.tsv`、`targeted_pay_groups_20261015.sql`、`targeted_pay_groups_query_note.md`：配置目录对应支付 ID 的定向近 30 日只读核对及其限制。
- `commercial_module_status.tsv`、`6-1页签现行性核对.md`：6-1 全部 30 张可见页逐页接到正式方案、开放窗口与当前用途；同一活动跨页关联的 SKU 不可重复相加。
- `remaining_current_skus.tsv`、`build_remaining_current_skus.py`：核心商品和五组新服活动以外的 60 条阶段配置候选，含现金、钻石和活动代币；其中 9 条限时触发因索引实现停用转入隔离账，其余进入全量主账。`remaining_cash_payments_20261015.sql/.tsv` 只证实支付 ID 有无匹配交易，不直接归因活动 SKU。随机商店池另待运行展示记录。
- `growth_dependency_map.md`：1-0 至 7-1 主要成长线的库存、来源、消耗、解锁和版本冲突图；可据此联算改价后的资源瓶颈与达成时间。
- `growth_player_stage_note.md`、`growth_player_stage.tsv`、`build_growth_player_stage.py`：将主线目标、关卡体力与配置 `press_days`、玩家等级、分层体力／钻石预算及线上窗口观察分列；索引开战路径未把 `press_days` 当作硬门槛，规划日龄也不等于实际达成日。
- `growth_dreamling_equip_rune.md`、`growth_quantify.py`：按正式配置复算单个梦灵升级、六部位装备强化及同部位符文合成的关键成本，保留随机图纸箱和特殊梦灵成本组边界。
- `growth_late_systems.md`、`growth_late_milestones.tsv`、`rebuild_growth_late_summary.py`：武器研究前置闭包、秘宝洗炼／技能、载具和藏品的代表节点成本；研究划断组、秘宝双算和零件本体转碎片已消歧。
- `growth_config_caps_note.md`、`growth_config_caps.tsv`、`build_growth_config_caps.py`：主要成长轴的 85 行阶段／最高配置终点累计账，包含主线 400 关、玩家 300 级等；技能、词条、套装是另算的子轴。数值是配置终点，不是实际毕业日。远端 r65300 的 `xml_gy/normal` 在本地 r65276 后无新增提交，相关本地 XML 无修改。
- `growth_cap_feasibility_20261015.md`：将 D7 固定前 10% 同一批玩家的阶段实测日与配置上限的可识别情景预测分开；用跨版 D25 历史资源筛查短期上限可行性，材料条件未满足或长期轨迹不足时不编造毕业第 N 天。
- `growth_observed_cohort.md`、`growth_observed_cohort_milestones.tsv`、`growth_observed_cohort_hist.tsv` 及同名前缀 SQL：微信小游戏官方入口开服首日建角 9,656 角色的主线／等级六节点 D1／D7／D14 首达实测、付费层和右删失；历史队列跨线上版本。
- `growth_runtime_coverage.md`、`growth_runtime_milestones_20261015.tsv`、`growth_runtime_coverage_20261015.sql`：装备、符文、武器研究、秘宝、载具、藏品六线的操作状态覆盖和同队列节点首达；9/30 宽渠道 778 角已完整观察滚动 D7/D14，非统一版本的全系统毕业日不能从中推出。
- `growth_dreamling_runtime.md`、`growth_dreamling_runtime_milestones.tsv`、`growth_dreamling_runtime_first_day.tsv` 及同名前缀 SQL：与主线／等级完全相同的官方入口 9,656 角，梦灵等级 D1/D7/D14 首次跨级；8 名达到任一梦灵 30 级的角色全为吟游诗人，橙梦灵 30 级为 0。历史日志版本与当前成本配置分别标注。
- `最终版缺口与取证计划.md`、`growth_data_coverage_probe_20261015.sql/.tsv`：记录用户已确认的最终版范围和估值口径、尚缺的商品／运行／成长证据，以及后台各类日志在 10 月 1–14 日的覆盖探针。
- 其他目录表随盘点补充，不能把目录行数当全服同时在售数。

## 使用原则

当前 TSV 是 **2026-10-15 配置快照与索引执行路径的核算**，不是游戏运行服、支付结算或未来 SVN 修订的自动真源。先用全量账的 `核价状态`、`缺价原因` 和条件说明：仅有配置 `value` 或已知部分钻价时，完整返比留空。体力战令已按索引代码分别映射 28／68 元奖励轨，仍要验证运行服发奖。首充按用户确认的特殊促销口径单列；累充达标档位不是一笔独立购买，也不计算现金商品倍率。商品的玩家展示折扣与内部按道具锚计算的名义返比各自记录，展示文字不用于改写道具锚。

后续确认新锚或调整投放时，先修改[主账构建脚本](build_final_commercial_scope.py)中的适用条件，再重建两份 TSV，并核对受影响的商品键、返比与缺价状态。XLSX 是这两份主账的**导出快照**，更新 TSV 后还须同步刷新工作簿及本阅读说明；不能把旧 XLSX 与新 TSV 混用。成长上限日需重新取同版本、同一固定入选队列的产销及库存，再按[情景边界](growth_cap_feasibility_20261015.md)回算。

旧 `item_anchor_ledger.tsv` 的“下游商品关联数”只计四份阶段目录，不能外推到全量；新全量账的 138 ID 才是本轮范围分母。`57` 的 200 钻仅为本期同店条件锚，`100092`、`100111` 的各 15000 钻为用户新指定的品质 7 规划条件锚，**不是 6-1 原价**；三者均非跨场景固定直售价。`100040` 是依使用计值的服务权益，咕勇者服饰与头饰只在首充累充 128 元档合计 7000 钻，均不能误当成两件各有单价。活动票券的钻石等效价只能用于对应抽取。

每次修改时按 **来源修订 → 商品有效方案 → 奖励 ID 和数量 → 道具基础价 → 名义返比 → 玩家资源瓶颈 → 线上验证** 顺序更新。只改道具价会影响多个商品；只改奖励数量不会改变道具基础价。免费轨、现金直购、钻石购买、代币购买和权益服务分开记账。

成长线已经完成**结构、正式开放闸门、主要轴的配置阶段及终点成本**，并增加主线／等级／梦灵等级的官方入口同服龄首达、六条系统另一宽渠道队列的操作首达，以及按 D7 进度固定每层前 10% 的同版资源与阶段基线。用户确认的完成日口径是“**阶段节点实测日＋配置上限的可识别情景预测**”：跨版 D25 资源与 D26–D30 五日情景目前只能证明部分上限短期材料条件不满足，不能填精确毕业日。三组样本、版本和筛选条件不同。礼包能提前几天，还需要同一角色的完整库存、分来源可持续产出、购买时点、关卡挑战及发奖记录；不要把策划预算、事后付费层差异或混合建角日的窗口分布代入因果结论。
