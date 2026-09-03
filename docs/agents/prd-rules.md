# PRD Rules

Read this file only when creating a PRD or materially revising one. It defines requirement quality, not a game's schema, XML layout, code style, or numeric values.

## Before Writing

State the problem, intended outcome, audience, current baseline and source, version boundary, non-goals, and dependencies. If the problem, success condition, MVP boundary, or core rule is still a real choice, stop and ask before drafting behavior.

## Required Shape

Use only the sections needed for the feature:

1. **Preview**: entry, primary action, success/failure feedback, and usability target. Do not add unconfirmed mechanics.
2. **Metadata**: owner/module, version, status, source, audience, date, and traceability path.
3. **Problem and goals**: problem, outcome, success signal, and constraints.
4. **Scope**: current-version behavior only.
5. **Flow and states**: prerequisites, normal path, transitions, exits, persistence, and recovery.
6. **Owner behavior**: client/UI, server/domain, content/data, QA, art, or operations as applicable.
7. **Dependencies and data contract**: responsibility, source of truth, contract-level identifiers/fields, and unresolved mappings.
8. **Exceptions**: invalid input, missing data, duplicate/retry, interruption/reconnect, limits, permissions, and inconsistent state.
9. **Acceptance**: observable checks with trigger/input, expected result, and boundary.
10. **Pending and change notes**: unresolved choices, risks, migration/rollback, and material revision history.

Do not fill an inapplicable section with generic text; omit it and state why when needed.

## Writing Rules

- Write behavior and observable results, not aspirations.
- Express a rule with subject, trigger, condition, action, and result where applicable.
- Name the owner and source of truth for cross-owner state.
- Keep current, proposed, historical, rejected, and pending content separately labeled.
- Mark unverified identifiers, values, and mappings as `unverified` or the project's equivalent. A placeholder is not a final contract.
- Put rationale beside the rule it explains and link shared rules instead of copying them.

## MVP and Pending Items

Write confirmed scope directly in the scope and acceptance sections. Keep a pending section only for items whose status is undecided, and record what is undecided, why it is pending, what it affects, and the next confirmation point.

Do not repeat confirmed scope, already deferred work, or explicitly rejected ideas.

## State and Acceptance

For each stateful flow, specify how it starts, who owns the state, valid transitions, visible and persisted results, retry/duplicate/interruption/reconnect behavior, terminal states, and the next action. “Handle normally” is not an acceptance criterion.

Acceptance must cover the happy path, an invalid or missing-input path, persistence/reload where relevant, and cross-owner handoff where relevant. Document inspection alone does not prove runtime verification.

## Revision

When revising a PRD, identify changed sections, update status/version and acceptance, re-check dependencies and non-goals, mark superseded behavior as historical, and record a change note when purpose, scope, behavior, ownership, interface, or acceptance changes.
