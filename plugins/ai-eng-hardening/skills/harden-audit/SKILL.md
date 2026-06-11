---
name: harden-audit
description: Audits an entire existing codebase (not a diff) and produces a prioritized hardening backlog. Invoke via /harden-audit. Does not fix anything.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Task
---
# harden-audit

**Goal:** assess a brownfield/vibe-coded codebase as a whole and produce `docs/hardening-backlog.md` — the artifact that **replaces the spec** as the work-driving document during hardening. Output language: **English**.

**Cost note:** multi-agent ~4-7x tokens. Scope areas deliberately; for large repos audit area by area across sessions instead of everything at once.

**Steps:**
1. **Map areas:** identify the codebase's areas (e.g. auth, API, jobs, persistence, UI) and their entry points; note which have tests.
2. **Reviewer passes per area:** spawn `security-reviewer` and `skeptical-edge-case-reviewer` (core plugin) via Task. Subagent context starts empty — pass the area's file paths and the project `CLAUDE.md` domain invariants in the prompt.
3. **Structural pass (main agent):** layering (logic in services?), validation at boundaries, error handling (swallowed errors?), current test coverage status.
4. **Merge:** consolidate findings on the core severity scale (Blocker/Major/Minor/Nit); deduplicate; tag each with risk x effort.

**Output (`docs/hardening-backlog.md`):**
```
# Hardening backlog (audited <date>, areas: ...)
| # | Finding | Severity | Risk | Effort | Files | Requirement ID (if any) |
Suggested order: Blockers first, then high-risk/low-effort; note quick wins.
```

**Next steps:** `/characterization-tests` for the critical paths before touching anything; fix items smallest-first via the core `/implement-feature`; re-run `/harden-audit` on an area after major changes.
