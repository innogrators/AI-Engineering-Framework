---
name: qa-review
description: Verifies an implemented feature against its spec and acceptance criteria. Composes review-change, unit-testing, and secure-coding (no duplication). Invoke via /qa-review.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash
---
# qa-review

**Goal:** verify the implementation satisfies the approved `specs/<feature>.md` across all quality dimensions by **composing** the existing lenses (not repeating them): architecture/domain/readability -> `review-change`; tests/coverage -> `unit-testing`; security -> `secure-coding`. Output language: **English**.

**Steps:**
1. Run gates: the project's typecheck, lint, tests (+coverage), dependency audit.
2. Tick each acceptance-criterion line of the spec (met / partial / open).
3. Apply the three lens skills and merge findings.
4. Check edge cases & regression: invariants enforced? existing flows unchanged?

**Severity:** Blocker / Major / Minor / Nit.

**Output:**
```
## QA review: <feature>
Gates: typecheck/lint/tests(cov%)/audit
Acceptance criteria: X of Y met
### Blocker / Major / Minor / Nit  (file:line, finding, fix, requirement ID)
Recommendation: GO / NO-GO + concrete next steps
```
**Abort:** no spec -> QA not possible, point to `/write-spec`.
