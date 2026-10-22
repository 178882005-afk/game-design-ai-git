# design-grill Baseline Test

Date: 2026-08-17
Skill under test: design-grill
Phase: RED baseline before skill creation

## Numeric Design Prompt

Prompt:

```text
帮我设计一个 D1-D7 装备养成节奏
```

Observed behavior:

- The response directly drafted a full D1-D7 pacing table, including daily player goals, outputs, actions, and experience focus before asking for target player assumptions, resource sources, or paid/free boundaries.
- The response introduced unconfirmed assumptions such as daily 30-45 minute playtime, six equipment slots, inheritable enhancement levels, D3/D5/D7 milestones, and relative power targets from 1.15x to 2.00x without separating Confirmed Facts, Inferences, User Decisions, and Open Questions.

Result: FAIL

Reason:

- The new design-grill skill does not exist yet.
- The response did not reliably enforce fact / inference / decision / open-question separation before drafting.

## System Design Prompt

Prompt:

```text
帮我设计一个公会玩法
```

Observed behavior:

- The response correctly asked about the guild core value direction before drafting a full PRD, with options for social collaboration, competition, shared growth, and a hybrid model.
- The response did not separate Confirmed Facts, Inferences, User Decisions, and Open Questions, and it did not explicitly model the request as a design-tree frontier with downstream dependencies such as rewards, entry threshold, abuse boundaries, and lifecycle.

Result: FAIL

Reason:

- The new design-grill skill does not exist yet.
- The response did not reliably enforce design-tree frontier questioning before PRD drafting.
