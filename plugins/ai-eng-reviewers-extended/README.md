# ai-eng-reviewers-extended

Optional specialized reviewer/advisor subagents that complement `ai-eng-framework`. Install only when a project actually needs them (multi-agent reviews cost ~4-7x tokens).

## Agents
`requirements-analyst`, `solution-architect`, `frontend-engineer`, `backend-engineer`, `code-quality-reviewer`, `maintainability-reviewer`, `documentation-writer`, `deployment-reviewer`.

Used by the `orchestrated-review` skill when you select them, e.g.:
"Run orchestrated-review with security, qa, maintainability and skeptical reviewers."
