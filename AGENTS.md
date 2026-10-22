# xitongAGENT Agent Rules

## Agent Governance

For non-trivial design, planning, implementation, or review tasks, read [governance.md](game-design-ai-git/docs/agents/governance.md). For any PRD creation, revision, or delivery, also read [prd-rules.md](game-design-ai-git/docs/agents/prd-rules.md).

## DreamGuard Knowledge

When a task asks about DreamGuard game code, client/server behavior,策划配置, Lua, data, or an implementation detail that is not established by the local files, use the `dreamguard_knowledge` MCP before forming a conclusion. Follow [the query contract](docs/knowledge/dreamguard-knowledge-mcp.md).

Use local repository files as the authority for the current working tree. Use DreamGuard Knowledge as the authority for indexed DreamGuard source and configuration snapshots. When they disagree, report both states and prefer the newer, directly inspected source; do not silently merge them.

Every knowledge-backed claim must include the knowledge project/repository, repository-relative path, and line range when the tool provides them. Label snapshot evidence as indexed evidence, and label runtime or balance conclusions as unverified unless a live test or a separate authoritative runtime record supports them.
