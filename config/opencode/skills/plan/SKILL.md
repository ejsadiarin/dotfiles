---
name: plan
description: Transforms a solidified idea, spec file, design doc, exploration output, or grilling session output (from /idea, /grill-me, or /grill-with-docs) into a structured, ticket-ready implementation plan. Use this skill whenever the user wants to turn any requirement, feature idea, spec, or decision into a detailed plan — even if they just say "plan this", "make a plan for", "let's plan out", or pastes raw notes and asks what to build. Always trigger this skill when the input looks like a feature request, system design, product requirement, or grilling output that needs to be broken down into actionable steps. If the user wants to go from idea → plan → build, this is the skill for the plan step.
---

# Plan Skill

Converts input (idea output, spec file, design doc, grilling session, or raw prompt) into a structured, ticket-ready implementation plan that any implementation agent can follow.

## Workflow

### Step 1 — Assess Input

Determine what was given:

| Input type | How to handle |
|---|---|
| Output from `/idea`, `/grill-me`, or `/grill-with-docs` | Use directly — context is already solidified |
| Spec file / design doc / exploration doc | Parse and extract requirements, constraints, and decisions |
| Raw idea / prompt | Proceed, but clarify ambiguities before planning (see Step 2) |
| Plain declarative sentence with no actionable requirement | Ask user to elaborate — do NOT generate a plan |

**If the input is not plannable** (e.g. "The sky is blue", a question with no implied build, or content that's purely informational), stop and ask:
> "I don't have enough to build a plan from this — could you describe what you want to build or implement?"

---

### Step 2 — Clarify (only if input is raw or ambiguous)

If the input is a raw idea or underspecified, ask **at most 3 targeted questions** before drafting. Prefer asking one well-chosen question over several at once. Typical gaps to probe:

- **Scope**: What's in vs. out of this iteration?
- **Tech constraints**: Stack, platform, existing systems to integrate with?
- **Success criteria**: How will we know this is done?

If the input came from `/idea` or `/grill-me`, skip this step — those skills already cover this ground.

---

### Step 3 — Draft the Implementation Plan

Produce a plan using the structure below. Every section is required unless explicitly not applicable.

---

## Plan Output Format

```
# Implementation Plan: [Feature / Project Name]

## Overview
One paragraph: what is being built, why, and what outcome it achieves.

## Goals
- Bullet list of concrete, verifiable goals for this plan.

## Non-Goals / Out of Scope
- Explicit list of what this plan does NOT cover (prevents scope creep).

## Background & Context
[Optional] Key decisions, prior art, or constraints that informed this plan.
Reference the source doc/session if applicable.

## Architecture / Design Summary
High-level description of how the system will be structured.
Include a diagram in plain text or pseudocode if it helps clarity.

## Implementation Phases

### Phase 1 — [Name]
**Goal**: What this phase achieves.

**Tasks**:
- [ ] Task 1 — [Short title]
  - Description: What needs to be done and why.
  - Acceptance criteria: How to verify it's done.
  - Notes / code hints: [Optional — interfaces, patterns, or snippets that guide implementation]

- [ ] Task 2 — ...

### Phase 2 — [Name]
...

## Data Models / Interfaces
[If applicable] Key types, schemas, or API contracts.
Use code blocks. Be specific enough that an agent can implement without guesswork.

## Edge Cases & Error Handling
- List known edge cases and how each should be handled.

## Testing Strategy
- Unit tests: what to test and where.
- Integration tests: what flows to cover.
- Manual checks: what a human should verify before marking done.

## Open Questions
- [ ] Any unresolved decisions that need answering before or during implementation.

## Dependencies
- External services, libraries, or teams this plan depends on.
```

---

### Step 4 — Present and Iterate

After presenting the plan:
- Ask: *"Does this cover everything? Anything to adjust, add, or cut?"*
- Accept edits and revise in place until the user marks it final.
- When iterating, **only modify the sections affected** — don't regenerate the whole plan unless asked.

---

## Quality Checklist (self-review before presenting)

- [ ] Every task has a clear acceptance criterion
- [ ] Non-goals are explicit (no ambiguity about scope)
- [ ] Phases are ordered by dependency (nothing in Phase 2 requires Phase 3)
- [ ] Code examples / interfaces provided for non-trivial technical decisions
- [ ] Edge cases section is non-empty
- [ ] Plan is specific enough that a dev agent could open a ticket for each task
- [ ] No circular dependencies between tasks

---

## Tips

- **Phases over one big list**: Group tasks into phases so a build agent knows what to tackle first.
- **Acceptance criteria are non-negotiable**: Every task needs one. Vague tasks create vague tickets.
- **Code hints accelerate agents**: A type signature or example call is worth a paragraph of prose.
- **Short tasks beat long ones**: If a task description exceeds 5 lines, consider splitting it.
- **Open questions are first-class**: Surface unknowns explicitly rather than papering over them.
