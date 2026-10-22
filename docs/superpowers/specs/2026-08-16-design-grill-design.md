# design-grill Skill Design

Date: 2026-08-16
Status: Implemented and validated

## Summary

Create a reusable Codex skill named `design-grill` for game-design clarification and early design shaping. The skill generalizes the useful part of `grill-me` / `grilling`: model the request as a decision tree, separate facts from user-owned decisions, ask the current dependency-free frontier, and wait for shared-understanding confirmation before producing a full design.

This skill is independent from the initial game-planning agent architecture. MarkItDown remains an ingestion adapter only:

```text
local planning files
-> MarkItDown Markdown conversion
-> knowledge base / source context
-> design-grill clarification
-> structured game-design output
```

## Goals

- Provide a portable clarification framework for game designers.
- Support multiple design domains through adapters, starting with numeric design and system design.
- Keep the universal core domain-neutral so it can later support level design, narrative design, events, monetization, and live-ops planning.
- Preserve source boundaries: confirmed facts, inferences, user decisions, and open questions must not be merged.
- Default to session-only work. Persist files only when the user explicitly asks.

## Non-Goals

- Do not turn MarkItDown into the agent runtime, database, retrieval system, numeric solver, or design framework.
- Do not copy `grill-me` as-is. Its one-line delegation is useful as an entry point pattern, but not enough for game-design work.
- Do not encode one game's rules, formulas, config fields, or production process into the universal core.
- Do not generate full PRDs, numeric sheets, or implementation plans before the decision tree is closed and the user confirms the shared understanding.

## Source Basis

- Microsoft MarkItDown: file-to-Markdown conversion for LLM/text workflows. Use it behind an ingestion boundary, such as `convert_local(path)`.
- `grill-me`: lightweight explicit trigger that delegates to the reusable grilling primitive.
- `grilling`: reusable clarification primitive based on decision trees, frontier questioning, fact/decision separation, and confirmation before action.
- `grill-with-docs`: example of adding repository/project state on top of the same grilling primitive through persisted context.

Primary links:

- https://github.com/microsoft/markitdown
- https://github.com/mattpocock/skills/blob/main/skills/productivity/grill-me/SKILL.md
- https://github.com/mattpocock/skills/blob/main/skills/productivity/grilling/SKILL.md
- https://github.com/mattpocock/skills/blob/main/skills/productivity/grill-with-docs/SKILL.md

## Recommended Architecture

Use Option 2: universal clarification core plus domain adapters plus optional persistence.

```text
design-grill
├── universal-core
│   ├── scope framing
│   ├── fact / inference / decision / open-question separation
│   ├── design tree + frontier questioning
│   └── shared-understanding confirmation gate
├── adapters
│   ├── game-numeric-design
│   ├── game-system-design
│   ├── level-design
│   └── narrative-design
└── optional-persistence
    ├── session-only default
    ├── glossary
    ├── decision-log
    └── design-spec
```

## Core Workflow

```text
understand the user's design goal
-> collect available facts and constraints
-> model the request as a design decision tree
-> identify the current frontier
-> ask 1-3 frontier questions with recommendations
-> update facts, inferences, decisions, and open questions
-> repeat until direction-changing uncertainty is closed
-> restate shared understanding
-> wait for user confirmation
-> produce the requested design artifact
```

The core must follow these rules:

- Investigate verifiable environment facts instead of asking the user.
- Ask the user for product, business, creative, or priority decisions.
- Give a recommendation with each question.
- Prefer one question at a time for complex design work; allow 2-3 questions only when they are simple and independent.
- Recompute the decision tree after every user answer.
- Stop before full solution output when any unresolved decision can change the design direction.

## Data Categories

Every intermediate and final answer must keep these categories separate:

| Category | Meaning | Example |
| --- | --- | --- |
| Confirmed Facts | Verified from user statements, source documents, or local project context | The feature is for D1-D7 onboarding |
| Inferences | Reasoned conclusions that are not directly confirmed | The target likely needs low cognitive load |
| User Decisions | Choices explicitly made by the user | Use dual mode: session-only default, optional persistence |
| Open Questions | Missing choices or facts that still matter | Should paid-user assumptions be included? |
| Recommendation | Agent's suggested path and reason | Start with numeric-design adapter because it has concrete validation cases |

## Domain Adapters

Adapters add domain-specific checks. They must not own the overall workflow.

### Game Numeric Design

Use when the user asks for values, economy, growth, resource pacing, probability, progression, rewards, difficulty, or balancing.

Adapter checks:

- target player segment and design period
- core loop and resource sources/sinks
- growth curve and milestone rhythm
- expected value, variance, ceilings, floors, and guarantees
- free/paid assumptions and sensitivity boundaries
- spreadsheet or config outputs requested by the user

### Game System Design

Use when the user asks for gameplay systems, feature PRDs, progression systems, social systems, guilds, events, unlocks, or mechanics.

Adapter checks:

- core loop
- entry and unlock conditions
- actor roles and permissions
- states and transitions
- reward boundaries
- failure, abuse, edge, and rollback paths
- dependencies on config, UI, server, analytics, or live operations

### Level Design

Use when the user asks for stage, map, mission, encounter, onboarding, or difficulty pacing.

Adapter checks:

- teaching objective
- spatial or encounter rhythm
- difficulty ramp
- failure recovery
- player readability
- dependency on existing mechanics and content budget

### Narrative Design

Use when the user asks for story, character arcs, dialogue, world-building, quest writing, or plot structure.

Adapter checks:

- character motivation
- information reveal order
- emotional beat
- player agency
- continuity constraints
- localization or tone constraints

## Persistence Contract

Default mode is session-only. The skill must not write files unless the user explicitly asks to save, generate, record, or persist an artifact.

Allowed persistent artifacts:

```text
glossary.md        terms, definitions, aliases, sources
decision-log.md    question, options, selected choice, reason, timestamp
design-spec.md     goals, constraints, proposal, risks, validation items
```

If the user asks for persistence, the skill must confirm the target artifact type when unclear. If the user names a path, use that path. If the user does not name a path, propose a sensible local project path before writing.

## Output Contract

Default response shape:

```markdown
Confirmed Facts
- ...

Inferences
- ... (basis: ...)

User Decisions
- ...

Open Questions
- ...

Recommendation
- ...

Next Action
- ...
```

For casual or very small requests, the skill may compress this shape into prose, but it must still preserve the distinction between fact, inference, decision, and open question.

## Error Handling

- If source material conflicts, report the conflict and ask which source has priority.
- If the user asks for design output before core decisions are closed, provide the blocking decision tree frontier first.
- If the user asks the agent to decide a user-owned choice, provide a recommended option and ask for confirmation.
- If the user asks for a domain outside current adapters, use the universal core and state that no specialized adapter is being applied.
- If persistence is requested but the path is unsafe or ambiguous, stop and ask for a precise target.

## Initial Validation Scenarios

### Scenario 1: Numeric Design

User prompt:

```text
帮我设计一个 D1-D7 装备养成节奏
```

Expected behavior:

- Do not directly produce a full table.
- Identify missing decisions: target player type, daily activity assumption, resource sources, consumption sinks, desired power curve, paid/free assumptions.
- Ask the most important frontier question first with a recommendation.
- Keep guesses out of `Confirmed Facts`.

### Scenario 2: System Design

User prompt:

```text
帮我设计一个公会玩法
```

Expected behavior:

- Do not directly produce a complete PRD.
- Identify missing decisions: core loop, collaboration model, entry threshold, rewards, social pressure, abuse boundaries.
- Ask frontier questions with recommended defaults.
- Only draft the PRD after the user confirms the shared understanding.

## Implementation Notes For The Future Skill

- Skill folder name: `design-grill`.
- Create it through the official skill initializer, not by hand.
- Keep `SKILL.md` concise and put adapter details in `references/` if it grows too large.
- Include discovery keywords in the description: game design, numeric design, system design, PRD, economy, progression, balancing, level design, narrative design, design clarification.
- Validate the skill with the official quick validator after creation.
- Forward-test the two validation scenarios before treating the skill as ready.

## Implementation Decisions

- Installation location: global Codex skills directory (`C:\Users\Administrator\.codex\skills\design-grill`).
- Initial adapter scope: all four lightweight adapters are included: numeric, system, level, and narrative design.
- Persistence scope: the persistence contract and reference are included without adding extra scripts.

## Current Constraints

- The current workspace is not a Git repository, so the brainstorming skill's commit step cannot be completed without initializing or moving into a repository.
- No existing local project framework files were found in the workspace at design time.
