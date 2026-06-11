# CLAUDE.md (project template)

Copy this to your project root and fill the `<...>` sections. The installed `ai-eng-framework` plugin provides the skills and reviewer agents; this file provides the project-specific rules they rely on.

## Project
- **Name:** <project name>
- **Purpose:** <one or two sentences>
- **Stack:** <languages, frameworks, datastore, key libraries>
- **Run/test commands:** <e.g. install, dev, test, lint, typecheck, dependency audit>

## Language & artifacts (non-negotiable)
- **All repository artifacts are in English:** code comments, identifiers (variables, functions, files), documentation, README, commit messages, branch names, and PR/MR descriptions.
- Conversations with the user may be in any language; everything written to the repo is English.
- **Commit messages:** Conventional Commits, imperative mood (e.g. `feat: add login endpoint`, `fix: handle empty CSV rows`). Subject <= 72 chars; explain the *why* in the body when non-trivial.

## Domain invariants (project-specific, enforced server-side)
List the rules that must never be violated. The skills (implement-feature, review-change, secure-coding) will treat these as hard constraints. Examples to adapt:
- <e.g. state changes only via the central StateService; never scatter status writes>
- <e.g. every write operation appends an immutable audit entry>
- <e.g. every endpoint has an authorization guard; deny by default>
- <e.g. validate all input at the boundary>

## Working principles
- **Spec-first:** non-trivial features need a `specs/<feature>.md` with `Status: APPROVED` before implementation. No approved spec -> run `/write-spec`, do not build on guesswork. Approval is set by a human, never by Claude.
- **Plan-before-code:** show the concrete file-change plan before editing; implement only after approval.
- **Assumptions:** never fill gaps silently — make a justified default assumption AND mark it as such.
- **Smallest viable diff:** touch only relevant files; change public signatures/tests only if the spec requires it; never turn green tests red.
- **Docs = Done:** update affected docs (README, env example, API docs, changelog/ADR) in the same change.

## Quality gates (must be green before merge)
<your CI commands, e.g.: typecheck, lint, tests + coverage thresholds, dependency audit, e2e for critical paths>
- Enforced in CI: `.github/workflows/quality-gates.yml` (from the plugin's `templates/ci/quality-gates.yml`) + branch protection on the default branch.
- Optional strict spec-first mode: hooks in `.claude/settings.json` (from the plugin's `templates/hooks/`).

## Definition of Done
Acceptance criteria met; tests per `unit-testing` skill (coverage thresholds); review per `review-change` skill with no open Blockers/Major; for security-relevant changes the `secure-coding` checklist done; gates green; docs updated.

## Requirement IDs
This project uses `<FR-AREA-NNN>` / `<NFR-CATEGORY-NNN>`. Authoritative source: `<docs/requirements.md or similar>`.
