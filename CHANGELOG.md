# Changelog

All notable changes to the plugins in this marketplace. Format loosely follows
[Keep a Changelog](https://keepachangelog.com); versions are the marketplace's.

## [1.3.0] - 2026-06-11
### Added
- New plugin `ai-eng-hardening` (1.0.0), the brownfield entry path: `/harden-audit` (full-codebase audit producing `docs/hardening-backlog.md`), `/reverse-spec` (as-is specs of actual behavior), `/characterization-tests` (freeze behavior before refactoring), an as-is spec template, and a coverage-ratchet CI variant (`.coverage-baseline`; gates only forbid getting worse). Requires `ai-eng-framework`.

## [1.2.0] - 2026-06-11
### Added
- MIT license (the repository is public).
- `spec-approval-guard` CI job: a PR that flips a spec to `Status: APPROVED` must not contain changes outside `specs/` — approval happens in a separate, reviewed PR.
- `requirement-traceability` CI job: PR title/body must reference a requirement ID (`FR-`/`NFR-`) or declare `No-Req: trivial`.
- `templates/ci/CODEOWNERS` template: owner review required for `specs/` changes, making `Status: APPROVED` an enforced human decision instead of a trusted text line.
- Template-drift note in the READMEs: copied templates are snapshots and need a manual diff after framework updates.

### Changed
- Consolidated the extended reviewers from 8 to 6 agents: `code-quality-reviewer` and `backend-engineer` merged into `maintainability-reviewer` (their checks overlapped the core `review-change` lens; one agent per distinct lens keeps multi-agent token cost justified).
- CI template documents that the gate concept is portable to GitLab CI / Azure DevOps.
- Documented the deliberate `model: sonnet`/`haiku` pinning in the reviewer agents.

## [1.1.0] - 2026-06-11
### Added
- Enforcement templates: CI quality-gates workflow (GitHub Actions) and opt-in spec-gate hooks for strict spec-first mode.
- Missing `design.template.md` and `adr.template.md`.
- Performance/scale and observability lenses in `design-architecture` and `deployment-prep`.

### Changed
- Repository restructured: repo root is the marketplace, so `/plugin marketplace add <git-url>` works directly.
- `code-review` skill renamed to `review-change` (collision with Claude Code's built-in `/code-review`).
- Subagents no longer reference skills they cannot load: core agents read the skill file via `${CLAUDE_PLUGIN_ROOT}` with inline fallback; extended agents are self-contained.
- Lifecycle gates check `Status: APPROVED` lines instead of file existence; approval is explicitly human-set.
- Project-specific examples (printer/label/CSV) genericized.

### Removed
- Duplicated root copies of `CLAUDE.base.md` and `language-and-commits.md`.

## [1.0.0]
### Added
- Initial set: lifecycle skills (write-spec, design-architecture, implement-feature, qa-review, deployment-prep, orchestrated-review), quality skills (code-review, unit-testing, secure-coding), 3 core reviewer agents, 8 extended reviewer agents, project templates, and the feature workflow.
