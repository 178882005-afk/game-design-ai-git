# Agent Governance

## Purpose

Lightweight rules for design, planning, implementation, review, and documentation tasks. This file defines process only; domain rules, schemas, code conventions, and runtime facts belong to the owning project.

## Default Loop

```text
Route -> Evidence -> Decide (when needed) -> Deliver -> Close
```

1. **Route**: state the task type, output, scope, non-goals, and smallest reading path.
2. **Evidence**: read current sources; separate current facts, history, proposals, and pending items. Every material fact needs a source or an explicit unknown label.
3. **Decide**: ask only about choices sources cannot settle. Include the choice, recommendation, and impact. A lookup or explicitly requested mechanical revision does not need an interview.
4. **Deliver**: write confirmed behavior, dependencies, and observable acceptance. Do not turn proposals or pending items into current rules.
5. **Close**: run the smallest relevant validation, link the result, and leave the next action visible.

## Source Boundary

- The user's latest explicit decision wins for the current task.
- Current project rules and requirements outrank history and generic advice.
- Local files are authoritative for the working tree.

When sources conflict, report the conflict and the chosen authority. If a required source is unavailable, state the gap and its effect.

## Decision and Scope

Use a decision note only when a choice must survive across documents or sessions. Record the question, evidence, confirmation or pending status, and downstream link. Do not create one for a one-turn decision.

Keep confirmed behavior, pending choices, historical material, and rejected proposals visibly separate. An unresolved dependency is a pending item, not permission to guess.

## Close Check

Before delivery, verify that:

1. the requested output exists in the intended location;
2. current facts and pending choices are distinguishable;
3. in-scope behavior has an observable acceptance check;
4. unresolved dependencies have an owner or next action.
