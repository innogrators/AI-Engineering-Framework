# Coding Standards (generic)

- **Types:** prefer strict typing; avoid escape hatches (`any`, untyped casts) without a `// reason:` comment.
- **Layering:** business logic in services/use-cases, not in controllers/route handlers or UI components. Controllers stay thin: validate -> delegate -> map.
- **Naming:** descriptive names; small, single-purpose functions; named constants instead of magic values. Identifiers in English.
- **Error handling:** clear status codes; no swallowed errors; background jobs have an error path and retry.
- **Domain invariants:** follow the invariants documented in the project `CLAUDE.md` exactly; they are hard constraints.
- **Simplicity:** smallest viable change; no new dependency without justification; no speculative generalization.
- Enforced by: `review-change` skill + `code-quality-reviewer` agent.
