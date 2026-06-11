# ai-eng-hardening

Brownfield entry path into the `ai-eng-framework` quality model: retroactively harden existing, untested, AI-generated ("vibe-coded") or legacy codebases. Requires the core plugin (reviewer agents, severity scale, `/implement-feature`, `/write-spec`). **All generated artifacts are in English.**

## Skills (invoke as `/name`)
- `harden-audit` — full-codebase audit via the core `security-reviewer` + `skeptical-edge-case-reviewer`; produces `docs/hardening-backlog.md`, which replaces the spec as the work-driving artifact during hardening.
- `reverse-spec` — documents ACTUAL current behavior of an area into `specs/<area>.as-is.md`; the on-ramp where intent is unclear. Divergences from presumed intent feed the core `/write-spec`.
- `characterization-tests` — freezes current behavior in tests before any refactoring; a failing characterization test after a refactor is a STOP signal, not a test to fix.

## Resources (copy into your project)
- `templates/spec.as-is.template.md` -> use under `specs/`. As-is specs are never APPROVED.
- `templates/ci/quality-gates-ratchet.yml` -> `.github/workflows/`. Typecheck/lint/audit hard from day one; coverage as a ratchet against `.coverage-baseline` — it only forbids getting worse; raising the baseline is a deliberate commit.

## Workflow
`/harden-audit` -> `/characterization-tests` (critical paths) -> ratchet CI + branch protection -> fix backlog items smallest-first via the core `/implement-feature` -> all NEW features go spec-first through the core plugin from day one.

**Do NOT install the core spec-gate hook during hardening** — no approved specs exist yet; it would block every edit. Install it (and switch to the core `quality-gates.yml`) once the backlog is worked off and spec-first applies.

## Right-sizing
Opportunistic hardening beats big-bang: audit area by area, freeze and fix what you touch, ratchet coverage as you go. A full-codebase rewrite pass is neither required nor recommended.
