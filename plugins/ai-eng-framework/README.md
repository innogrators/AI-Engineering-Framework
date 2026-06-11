# ai-eng-framework

Spec-first AI-engineering workflow for Claude Code. Provides lifecycle skills, quality skills, 3 core reviewer subagents, and enforcement templates (CI gates, opt-in hooks). **All generated artifacts are in English.**

## Skills (invoke as `/name`, or let Claude use the quality ones automatically)
- Lifecycle (explicit): `write-spec`, `design-architecture`, `implement-feature`, `qa-review`, `deployment-prep`, `orchestrated-review`.
- Quality (auto): `review-change`, `unit-testing`, `secure-coding`. (`review-change` is named to avoid colliding with Claude Code's built-in `/code-review`.)

## Agents (shipped by this plugin, own context, read-only)
`security-reviewer`, `qa-tester`, `skeptical-edge-case-reviewer`. (More in `ai-eng-reviewers-extended`.)

## Resources (copy into your project)
- `templates/CLAUDE.base.md` -> your project root as `CLAUDE.md` (fill the project sections incl. domain invariants).
- `templates/spec.template.md` and `templates/design.template.md` -> use under `specs/`. Approval = a human sets `Status: APPROVED`; the lifecycle skills check that line.
- `templates/adr.template.md` -> `docs/adr/NNNN-title.md` for architecture decisions.
- `templates/ci/quality-gates.yml` -> `.github/workflows/` (fill in your commands, add branch protection). **This is the layer that actually blocks bad merges — set it up first.**
- `templates/hooks/` -> optional strict spec-first mode via `.claude/settings.json` hooks (see `spec-gate.sh` header).
- `rules/` and `workflows/feature-workflow.md` -> reference material; the always-on rules live in your project `CLAUDE.md`.

## How it splits work
The plugin ships the **process** (how). Your project `CLAUDE.md` holds the **specifics** (what: stack, domain invariants, requirement IDs). CI and branch protection hold the **enforcement** — skills and reviewers ask for the gates, CI blocks the merge when they are red. That separation is what makes the framework reusable across projects.

## Right-sizing
Trivial change -> just chat. Small feature -> `/implement-feature` + `qa-tester` + commit. Large/risky -> full workflow + `/orchestrated-review` with a selected reviewer subset.
