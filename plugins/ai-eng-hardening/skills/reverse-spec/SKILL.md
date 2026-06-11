---
name: reverse-spec
description: Extracts a spec of ACTUAL current behavior from an existing codebase area into specs/<area>.as-is.md. Invoke via /reverse-spec. Documents, never invents.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Write
---
# reverse-spec

**Goal:** document what a codebase area **actually does today** in `specs/<area>.as-is.md` (template: `templates/spec.as-is.template.md`). Argument: `$ARGUMENTS` = the area. Output language: **English**.

**Hard rule:** never invent intended behavior. Write only what the code observably does — including bugs and quirks, explicitly marked as such. Anything you cannot determine from code/tests/docs goes into **Open questions**, not into prose.

**Steps:**
1. Read the area: entry points, data flow, side effects, error paths; existing tests as behavior evidence.
2. Capture observed behavior per flow; note implicit invariants the code relies on (e.g. "status is only ever set in X").
3. List known quirks/bugs with a keep / fix-candidate assessment — do not fix anything.
4. Write `specs/<area>.as-is.md` with the status line `Status: AS-IS (documented <date>)`. An as-is spec is **never** APPROVED — it cannot satisfy the core `implement-feature` gate, by design.

**Bridge to the core workflow:** divergences between as-is behavior and presumed intent are candidates for a normal `/write-spec` (target spec) — that target spec then goes through the standard approval gate.

**Abort:** area too large to read honestly in one pass -> split, document the sub-area you actually read.
