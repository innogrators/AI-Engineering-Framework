# Language & Commit Rules

**Language:** All repository artifacts are written in **English** — code comments, identifiers, documentation, README, commit messages, branch names, and PR/MR descriptions. The conversation with the user may be in any language; the artifacts are not.

**Commit messages:** Conventional Commits in imperative mood.
- Format: `type(scope): summary` — types: feat, fix, docs, refactor, test, chore, build, ci, perf.
- Subject <= 72 chars, no trailing period; body explains the *why* for non-trivial changes; reference requirement IDs where useful.
- Examples: `feat(auth): add cookie-based session`, `fix(import): skip malformed CSV rows`.

**Branch names:** `type/short-kebab-summary` (e.g. `feat/auth-rbac`).

Enforced by: `implement-feature` skill and the `documentation-writer` agent.
