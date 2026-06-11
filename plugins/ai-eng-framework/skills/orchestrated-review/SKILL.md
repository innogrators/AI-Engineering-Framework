---
name: orchestrated-review
description: Spawns a SELECTED subset of reviewer subagents (.claude/agents) and consolidates their findings into one recommendation. Invoke via /orchestrated-review.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Task
---
# orchestrated-review

**Goal:** review an implementation from multiple perspectives without flooding the main context — each reviewer runs as a subagent with its own context window. Output language: **English**.

**Cost note:** multi-agent uses roughly 4-7x the tokens. Do **not** start every reviewer by default. Choose based on the diff:
- Default set: `security-reviewer`, `qa-tester`, `skeptical-edge-case-reviewer`.
- + others from the extended plugin (requirements, architecture, frontend, maintainability, deployment) only when their lens is actually relevant to the diff.
Reviewers run **read-only** and cannot change anything.

**Steps:**
1. Determine scope (changed files, the spec, requirement IDs).
2. For each selected reviewer, spawn a subagent via the Task tool. The subagent context starts empty, so pass everything needed in the prompt: changed file paths, the spec path, relevant requirement IDs.
3. Collect each reviewer's severity list.
4. **Consolidate:** merge duplicates; **conflict resolution** = security/invariant findings outrank style; on disagreement, state the facts and decide.
5. Order findings by severity; separate quick wins from real Blockers.

**Output:**
```
## Orchestrated review: <feature>
Reviewers run: [...]
### Consolidated findings (Blocker -> Nit): finding | source(s) | fix | requirement ID
### Conflicts & decision
Recommendation: GO / FIX-FIRST / NO-GO + prioritized next steps
```
