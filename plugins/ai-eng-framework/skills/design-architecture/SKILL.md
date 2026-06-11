---
name: design-architecture
description: Produces a technical design from an APPROVED spec. Invoke explicitly via /design-architecture. Does not implement.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob
---
# design-architecture

**Goal:** derive an implementable design from `specs/<feature>.md`. **Precondition:** the spec contains `Status: APPROVED` (check the line). **Do not implement.** Output language: **English**, written to `specs/<feature>.design.md` (template: `templates/design.template.md`; starts as `Status: DRAFT`).

**Assumption check:** verify the spec against the project's architecture docs and existing code; flag conflicts with documented domain invariants immediately.

**Design content:**
- **Architecture decisions** (each: rationale + rejected alternative).
- **Affected components** (concrete paths).
- **Data model:** required schema changes + migration sketch; impact on audit/invariants.
- **Interfaces:** new/changed endpoints (method, path, DTO, role), events/jobs.
- **Invariant impact:** new states/required fields?
- **Performance & scale:** expected load on touched paths; pagination/caching/async-jobs where lists or heavy work are involved; avoid N+1 by design.
- **Observability:** what gets logged (structured, no PII), which metric/health signal shows the feature works in production.
- **Risks** (incl. security/performance) and mitigations.
- **Implementation plan:** ordered, small, individually testable steps; map requirement IDs -> step -> test type.

**Rules:** smallest viable change; no new dependency without justification; every new write must append audit; every new endpoint needs an authorization guard.
