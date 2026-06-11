---
name: unit-testing
description: Use when writing, running, or extending tests, adding a feature that needs coverage, or when the user mentions tests, coverage, or TDD. Defines the test strategy, conventions, and coverage targets.
---
# unit-testing

Produce fast, deterministic tests that secure the spec's acceptance criteria. Tests are part of Definition of Done. Output language: **English**.

**Strategy (pyramid):**
- **Unit (most):** pure domain logic with no I/O — state/transition rules, validation, parsers, calculations. Coverage focus here.
- **Integration (targeted):** endpoints incl. auth guards and datastore; invariants like append-only audit; background jobs.
- **E2E (few, critical):** the end-to-end happy path(s) the product depends on.

**Coverage targets (tune per project in CLAUDE.md):** domain logic >= 90%, overall >= 80%. Enforced in CI; below threshold = gate failure.

**Conventions:**
- AAA (Arrange/Act/Assert); name tests by behavior, not method.
- Negative cases are mandatory (forbidden transition, missing role, invalid input, missing required field).
- Determinism: inject clock/ids; no real external systems in unit tests (e.g. network, mail, print, browser) — mock external sinks behind interfaces.
- Use data builders/factories instead of large inline objects.

**Definition of Done (test part):** required logic covered incl. negative cases; security/invariant behavior covered by an integration test; critical paths covered by E2E; test command green locally and in CI; no skipped tests without justification.
