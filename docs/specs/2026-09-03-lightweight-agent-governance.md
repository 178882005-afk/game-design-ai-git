# Lightweight Agent Governance

## Problem Statement

The Agent repository has useful skills, but its governance guidance is spread across entry files and long process documents. Repeated rules increase context cost and make it unclear which guidance is mandatory, which is PRD-specific, and which belongs to a separate domain project. The result is unnecessary reading, duplicated instructions, and a risk that external project rules are treated as part of this Agent's runtime contract.

## Solution

Adopt a small, project-independent governance layer with one entry pointer and two focused documents:

- A short governance guide containing the internal loop `Route -> Evidence -> Decide (when needed) -> Deliver -> Close`.
- A PRD-only guide loaded only for PRD creation or material revision.
- Minimal entry pointers in the repository's Agent instruction files.

The governance guide should tell an Agent to locate the task, read current evidence, ask only for choices that evidence cannot settle, deliver confirmed behavior, and perform a small close check. It should preserve source boundaries and distinguish current facts, pending choices, historical material, and proposals without requiring visible phase labels or a decision ledger for ordinary tasks.

The PRD guide should keep confirmed scope in the PRD body and acceptance checks. A pending section should contain only undecided items, their reason for being pending, their impact, and the next confirmation point.

## User Stories

1. As an Agent, I want one short governance entry point, so that I can choose the correct reading path without loading unrelated process documents.
2. As an Agent, I want to distinguish current facts, historical material, proposals, and pending decisions, so that I do not present an unconfirmed idea as a current rule.
3. As a user, I want the Agent to ask questions only when sources cannot settle a real product or business choice, so that routine lookups and mechanical revisions remain fast.
4. As a designer, I want confirmed PRD scope to be written once in the scope and acceptance sections, so that MVP guidance does not repeat the same content in a separate checklist.
5. As an implementer or reviewer, I want each stateful PRD flow to describe ownership, transitions, exceptions, and observable acceptance, so that the document can be implemented and checked without chat context.
6. As a maintainer, I want domain-specific rules to remain in the owning project or knowledge source, so that this Agent repository remains reusable and project-independent.
7. As a maintainer, I want superseded requirements and unresolved dependencies to remain visibly marked, so that later work does not silently revive old or incomplete behavior.
8. As a reviewer, I want the governance change to be validated at the documentation boundary, so that unrelated code, data, and external project content are not pulled into the change.

## Implementation Decisions

- Keep one short governance document as the source of truth for the default task loop, source precedence, decision boundary, and close check.
- Keep PRD guidance in a separate on-demand document because most tasks do not create or revise PRDs.
- Put only a pointer in Agent instruction files; do not copy the governance body into multiple entry files.
- Do not require an Agent to print the five lifecycle stages in every response.
- Use a decision note only when a decision must survive across documents or sessions; do not create one for a one-turn choice.
- Treat unresolved dependencies as pending items that need an owner or next action, not as permission to infer.
- Keep current behavior, proposed behavior, historical behavior, rejected proposals, and pending choices separately labeled.
- Make PRD scope a delivery promise: current behavior belongs in scope and acceptance; undecided work belongs only in pending notes.
- Keep the governance layer independent from any particular game, domain data source, schema, XML/table layout, code convention, runtime protocol, or memory service.

## Testing Decisions

- Test the external documentation contract rather than the wording implementation: entry pointers resolve, the governance document contains the five-step loop, and the PRD document contains pending-item, state, acceptance, and revision rules.
- Verify that no governance or PRD document contains an external project's absolute path or domain-specific rule.
- Verify that ordinary Agent instructions point to the governance guide and that PRD instructions point to the PRD guide.
- Verify that the change is limited to Agent instruction and documentation files; no source code, configuration, game data, or runtime behavior is part of the test seam.
- Use repository-wide text search and Git diff checks as the primary validation because the deliverable is documentation-only.

## Out of Scope

- Implementing or changing any game feature, code, configuration, XML/table, numeric model, or runtime protocol.
- Copying a separate domain project's directory hierarchy, current rules, historical conclusions, or external worklog into this repository.
- Adding a database, memory service, multi-Agent orchestration, or mandatory interview workflow.
- Creating a decision ledger, glossary, ADR, or issue file for a one-turn change.
- Publishing or modifying GitHub Issues without available repository authorization.

## Further Notes

The repository currently declares GitHub Issues as its tracker, but publication requires an authenticated issue client or token. The specification can be published after that access is available and should receive the `ready-for-agent` label. Until then, the local specification is the reviewable source for the proposed change and should not be treated as an implementation approval.
