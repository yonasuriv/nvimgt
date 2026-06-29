# AGENTS.md

Behavioral guidelines to reduce common LLM coding mistakes. Keep these instructions aligned with project-specific rules, and update them when user feedback reveals new preferences, corrections, or repeated failure patterns.

## The Problems

From Andrej Karpathy’s post:

> "The models make wrong assumptions on your behalf and just run along with them without checking. They don't manage their confusion, don't seek clarifications, don't surface inconsistencies, don't present tradeoffs, don't push back when they should."

> "They really like to overcomplicate code and APIs, bloat abstractions, don't clean up dead code... implement a bloated construction over 1000 lines when 100 would do."

> "They still sometimes change/remove comments and code they don't sufficiently understand as side effects, even if orthogonal to the task."

## The Solution

Four principles in one file that directly address these issues:

| Principle | Addresses |
|-----------|-----------|
| **Think Before Coding** | Wrong assumptions, hidden confusion, missing tradeoffs |
| **Simplicity First** | Overcomplication, bloated abstractions |
| **Surgical Changes** | Orthogonal edits, touching code you shouldn't |
| **Goal-Driven Execution** | Leverage through tests-first, verifiable success criteria |

## The Four Principles in Detail

### 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

LLMs often pick an interpretation silently and run with it. This principle forces explicit reasoning:

- **State assumptions explicitly** — If uncertain, ask rather than guess
- **Present multiple interpretations** — Don't pick silently when ambiguity exists
- **Push back when warranted** — If a simpler approach exists, say so
- **Stop when confused** — Name what's unclear and ask for clarification

### 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

Combat the tendency toward overengineering:

- No features beyond what was asked
- No abstractions for single-use code
- No "flexibility" or "configurability" that wasn't requested
- No error handling for impossible scenarios
- If 200 lines could be 50, rewrite it

**The test:** Would a senior engineer say this is overcomplicated? If yes, simplify.

### 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting
- Don't refactor things that aren't broken
- Match existing style, even if you'd do it differently
- If you notice unrelated dead code, mention it — don't delete it

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused
- Don't remove pre-existing dead code unless asked

**The test:** Every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform imperative tasks into verifiable goals:

| Instead of... | Transform to... |
|--------------|-----------------|
| "Add validation" | "Write tests for invalid inputs, then make them pass" |
| "Fix the bug" | "Write a test that reproduces it, then make it pass" |
| "Refactor X" | "Ensure tests pass before and after" |

For multi-step tasks, state a brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let the LLM loop independently. Weak criteria ("make it work") require constant clarification.

## Tradeoff Note

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.

These guidelines bias toward **caution over speed**. For trivial tasks (simple typo fixes, obvious one-liners), use judgment — not every change needs the full rigor.

The goal is reducing costly mistakes on non-trivial work, not slowing down simple tasks.

## Tasks workflow

> Proposed changes and planned additions should be recorded in `ROADMAP.md`. 
> This include anything observed during any task: suggestions, observations, feedback, improvements, security, rework, and anything else.
> If `TODO.md` has no active tasks, agents should use `ROADMAP.md` as the next source of work.

When working from `TODO.md`, treat each item as an isolated implementation task.

---

For every new task:

1. Add it to `TODO.md` with a clear title, scope, requirements, and acceptance criteria.
2. Keep tasks ordered by dependency. Earlier tasks must not depend on later changes.
3. Avoid referencing files, config names, commands, or behaviors that were removed or replaced by a previous task.
4. If a task changes project behavior, include documentation requirements in that same task.

Before implementing any user request, task, or roadmap item, verify that it is valid, feasible, and safe to execute. If it would cause a large refactor, breaking changes, architectural drift, or unclear side effects, stop and report the risk before making changes.

For non-trivial tasks, create or refine a plan first. Do not blindly execute raw user requests as final specifications. Normalize the request into clear scope, requirements, acceptance criteria, and validation steps.

Favor reliable, working behavior over broad or cosmetic completion. A small feature that works correctly is better than a larger implementation that looks complete but breaks existing behavior or fails the intended use case.

---

When implementing a task:

1. Complete only the current task scope unless a dependency requires a small supporting change.
2. Update or remove stale TODO entries as work is completed.
3. Mark finished tasks clearly, or move them to a completed section if the file uses one.
4. Do not leave duplicated, outdated, or conflicting TODO instructions behind.

---

Before considering a task complete, validate that all references affected by the change are updated, including:

- Any config examples
- Any command examples
- Any scripts or generated artifacts
- `TODO.md`
- `README.md`
- `CHANGELOG.md` updated using Keep a Changelog and Semantic Versioning, including release sections, dates, change categories, migration notes, and comparison links.

Validation must confirm that documentation, examples, and skill instructions match the implemented behavior. 
A task is not complete if the code works but the references still describe old paths, config files, commands, generated names, or workflows.