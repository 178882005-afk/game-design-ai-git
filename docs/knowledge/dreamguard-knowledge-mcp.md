# DreamGuard Knowledge MCP

This is a read-only source lookup service for the DreamGuard game. It indexes selected client, server, Lua, data, server-data, and tooling repositories. It does not edit files, run GM commands, operate servers, or expose live runtime state.

## Query sequence

1. Identify the question's source area: client, server, Lua, data, server-data, or tools.
2. Call `knowledge_list_wikis` and select the narrowest matching Wiki/project.
3. Discover ownership with `knowledge_graph_search`, `knowledge_symbol_search`, or `knowledge_grep_code`. Search one to three concrete identifiers before broad terms.
4. Use `knowledge_ask_code` only to orient the search; treat its response as a lead.
5. Use `knowledge_read_code` for bounded exact evidence. Keep reads within the tool's 500-line limit.
6. For dependencies, use `knowledge_trace_code` and state that trace depth is capped at five.
7. Cite project, repository-relative path, and line range for every claim derived from the MCP.

## Evidence rules

- Indexed content is a snapshot. It proves what was present in the indexed source, not what is running now.
- Configuration presence proves configuration presence, not that the feature is enabled, balanced, reachable, or approved at runtime.
- Separate client implementation, server implementation, test-only or compile-gated code, and menu-only/unimplemented entries.
- Treat BattleWiki or other historical material as supplemental. Resolve conflicts in favor of directly inspected DreamGuard Knowledge Hub source, then the local working tree when it is newer.
- If the relevant Wiki is incomplete, pending curation, sanitized, or returns no result, state the coverage gap. An empty symbol search does not prove that a file or symbol is absent when an exact read can still succeed.

## Query templates

Use focused identifiers such as a class/module name, config key, table name, protocol name, or exact file path. Examples:

- `server/src/gm/gm_cmd.erl`
- `BattleLuaUiApi.GmCommand.cs`
- `card_group_unit_count_condition`
- `C_常量_const_data.xml`

For a user-facing answer, distinguish these labels explicitly: `本地工作树事实`, `知识库索引事实`, `规划/参考材料`, `运行时未验证`.
