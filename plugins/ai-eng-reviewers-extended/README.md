# ai-eng-reviewers-extended

Optional specialized reviewer/advisor subagents that complement `ai-eng-framework`. Install only when a project actually needs them (multi-agent reviews cost ~4-7x tokens).

## Agents — one per distinct lens or workflow phase
- `requirements-analyst` — spec quality before approval (workflow phase 4).
- `solution-architect` — design decisions vs. architecture and invariants (phase 5).
- `frontend-engineer` — UI/UX lens (responsive, loading/error states, safe HTML); the only client-side lens in the framework.
- `maintainability-reviewer` — code quality and long-term maintainability (coupling, testability, conventions); for larger changes/refactors.
- `documentation-writer` — the docs phase (phase 11); the only writing agent here.
- `deployment-reviewer` — release readiness and Go/No-Go (phase 12).

The value of a subagent over "main agent + checklist" is its separate context window — so each agent here covers a lens the core three reviewers do not. Generic diff reviewers that duplicated the core `review-change` checklist (`code-quality-reviewer`, `backend-engineer`) were merged into `maintainability-reviewer` in 1.2.0.

Models are pinned deliberately (`sonnet`, `haiku` for the cheap lens) to keep multi-agent cost bounded; revisit the pins as models evolve.

Used by the `orchestrated-review` skill when you select them, e.g.:
"Run orchestrated-review with security, qa, maintainability and skeptical reviewers."
