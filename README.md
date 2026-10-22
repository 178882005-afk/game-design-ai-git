# Game Design Agent Framework

这是面向游戏策划工作的轻量 Agent 治理框架。仓库内包含通用入口、治理规则、任务分流和项目适配边界。

## 目录

- `AGENTS.md`：入口指针。
- `CONTEXT.md`：框架定位和术语。
- `docs/agents/`：治理、PRD、分流和任务规则。
- `projects/`：具体项目适配层。
- `.scratch/issues/`：当前阶段的本地 Markdown 任务。

仓库负责可复用的文档和规则。DreamGuard 知识库 MCP、模型平台和其他外部工具不随仓库提交，使用时必须显式说明。

最小验证：选一张 `.scratch/issues/` 任务票，按 `Route -> Evidence -> Decide -> Deliver -> Close` 执行，并记录交付物路径、验收结果和下一步。
