---
name: implement-feature
description: Implements a feature strictly from an approved spec and design. Forbids implementing without a spec. Invoke via /implement-feature.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Edit, Write, Bash
---
# implement-feature

**Preconditions (hard stop):** `specs/<feature>.md` AND `specs/<feature>.design.md` exist, and **both contain a `Status: APPROVED` line** (check it — existence alone is not approval). If either is missing or not APPROVED -> **STOP** and point to `/write-spec` / `/design-architecture` or to the pending approval. Never implement on guesswork. Output language: **English** (code, comments, commit messages).

**Procedure:**
1. **Plan first** (plan-before-code): derive the concrete file-change list from the design and show it before editing.
2. **File analysis:** read affected files; capture existing functions/contracts before changing anything.
3. **Change strategy:** smallest possible diffs; do not touch unrelated files; change public signatures only if the spec requires it.
4. **Honor domain invariants** from project `CLAUDE.md` (e.g. centralized state changes, audit on every write, deny-by-default authorization, input validation).
5. **Tests** alongside the code per the `unit-testing` skill, including negative cases.
6. **Protect existing behavior:** run the project's test command before finishing; never turn green tests red.
7. **Docs & commits in English:** Conventional Commits, imperative mood; update affected docs.

**Final report (required):** changed files + purpose; requirement IDs covered; new tests; open items/assumptions; migration notes; next step (`/qa-review`).
