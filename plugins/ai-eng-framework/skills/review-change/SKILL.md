---
name: review-change
description: Use when reviewing a pull request, diff, or branch before merge, or when the user asks for a code review or quality check. Reviews architecture, project domain invariants, validation, tests, and a security cross-check. (Named review-change to avoid colliding with Claude Code's built-in /code-review.)
---
# review-change

Review a change against the project `CLAUDE.md` (domain invariants, standards) and its spec. Output language: **English**.

**Procedure:**
1. Run the project's configured checks first (typecheck, lint, tests + coverage, dependency audit). A red gate is a Blocker.
2. Review the diff against the checklist.
3. Report findings with severity and a concrete fix.

**Severity:** Blocker (do not merge) / Major (fix before merge) / Minor / Nit.

**Checklist:**
- **Layering:** logic in services, not controllers/route handlers/UI; controllers thin.
- **Domain invariants:** rules in project `CLAUDE.md` honored (e.g. centralized state changes, audit on writes, deny-by-default authorization). No scattered violations.
- **Validation & errors:** all input validated at the boundary; clear status codes; no swallowed errors.
- **Data access:** no N+1; no raw query string concatenation with untrusted input; migrations + seed updated when schema changes.
- **Security cross-check:** every endpoint guarded; object-level authorization; no secrets/PII in code or logs (deep dive -> `secure-coding`).
- **Tests:** new/changed logic tested incl. negative cases; coverage thresholds met (-> `unit-testing`).
- **Readability:** clear names, small functions, no dead/commented-out code, no unjustified `any`.
- **Language:** comments/identifiers in English.

**Output:**
```
## Change review: <branch/PR>
Gates: typecheck/lint/tests(cov%)/audit
### Blocker / Major / Minor / Nit  (each: file:line, finding, fix, requirement ID)
Verdict: mergeable after N Blockers/Major.
```
