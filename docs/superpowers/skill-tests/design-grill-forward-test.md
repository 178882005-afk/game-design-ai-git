# design-grill Forward Test

Date: 2026-08-17
Skill under test: design-grill
Phase: GREEN after skill creation

## Numeric Design Prompt

Prompt:

```text
Use $design-grill to help with this request: 帮我设计一个 D1-D7 装备养成节奏
```

Observed behavior:

- The fresh-context response identified this as “数值养成节奏设计” with target period “D1-D7”, which applies the numeric-design adapter rather than treating it as a general writing request.
- It explicitly separated “已知事实” (need to plan equipment progression), “推断” (new-player feedback, resource delivery, and mainline power matching), and “未决问题” (the target player baseline).
- It did not draft a D1-D7 numerical schedule, resource table, or config-ready values while the target-player decision was unresolved.
- Before any table drafting, it asked whether to target zero-spend/high-activity players or include small spenders from the start, recommending the zero-spend/high-activity baseline because it protects mainline experience from payment assumptions.

Result: PASS

Evidence:

- The response used the numeric-design adapter.
- The response separated confirmed facts from inferences.
- The response asked a frontier question before drafting a table.
- The response included a recommendation.

## System Design Prompt

Prompt:

```text
Use $design-grill to help with this request: 帮我设计一个公会玩法
```

Observed behavior:

- The fresh-context response classified the request as a system-design problem, stated that there was no project background to verify, and identified the core loop as the first key decision.
- It separated “已知” (designing guild gameplay) from “推断” (social retention, cooperative goals, or ranking competition), explicitly keeping the latter unconfirmed.
- It did not write a complete PRD. Instead, it offered three core-loop directions: cooperative growth, competitive ranking, and light social benefits.
- It asked the user to choose the primary core loop and recommended cooperative growth, with a concrete rationale: stable daily participation and member mutual help; it deferred entries, roles, reward boundaries, abuse prevention, and operations pacing until the choice was confirmed.

Result: PASS

Evidence:

- The response used the system-design adapter.
- The response separated confirmed facts from inferences.
- The response asked a core-loop frontier question before drafting a PRD.
- The response included a recommendation.
