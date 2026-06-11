# Documentation Rules (generic)

Documentation is part of the Definition of Done. Update in the same change (all in English):
- **README:** when a setup/run step changes.
- **Env example file:** for every new config/secret variable.
- **API docs:** for every new/changed endpoint (method, path, DTO, role).
- **Changelog:** one entry per feature (what/why, requirement IDs).
- **ADR (`docs/adr/NNNN-title.md`):** for non-trivial architecture decisions (context, decision, consequence, alternatives).
- **Assumptions log:** when a new default assumption is made.
- **Code comments:** explain the *why*, not the *what*.

Enforced by: `documentation-writer` agent.
