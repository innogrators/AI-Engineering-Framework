---
name: characterization-tests
description: Freezes the CURRENT behavior of existing code in tests before any refactoring — including odd behavior. Invoke via /characterization-tests.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Edit, Write, Bash
---
# characterization-tests

**Goal:** pin down what the code does **today** so refactoring becomes detectable. This differs from the core `unit-testing` skill: that one tests *intended* behavior against a spec; this one tests *observed* behavior, intent unknown. Output language: **English**.

**Priority:** critical paths from `docs/hardening-backlog.md` first (run `/harden-audit` if it does not exist), then code you are about to change.

**Procedure:**
1. Determine current behavior by reading and by running the code (inputs -> actual outputs), not by guessing what it should do.
2. Write tests that assert today's actual output. Use golden-master tests (capture full output, diff against stored snapshot) where behavior is complex or poorly understood.
3. Odd or buggy behavior gets asserted too — mark each such assert with the comment `// characterization: documents current behavior, not intent`.
4. Follow the core `unit-testing` conventions (AAA, determinism, builders) where they apply; coverage targets do not — the ratchet CI handles coverage.
5. Run the suite; all characterization tests must be green against unchanged code by definition.

**Hard rule:** a characterization test that fails after a refactor is a **STOP signal** — behavior changed. Analyze whether the change is intended (then update test + document, ideally via a target spec) or a regression (then fix the code). Never adjust the test silently to make it pass.

**Next step:** with critical paths frozen, backlog fixes run via the core `/implement-feature`.
