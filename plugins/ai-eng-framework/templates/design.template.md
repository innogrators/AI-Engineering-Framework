# Design: <feature name>

> Status: DRAFT | IN REVIEW | APPROVED (date / person)
> Spec: `specs/<feature>.md` (must be APPROVED)

## Architecture decisions
| Decision | Rationale | Rejected alternative |
| :-- | :-- | :-- |

## Affected components
<concrete paths>

## Data model
<schema changes + migration sketch; impact on audit/invariants>

## Interfaces
<new/changed endpoints (method, path, DTO, role), events/jobs>

## Invariant impact
<new states/required fields? which CLAUDE.md invariants are touched and how they stay enforced>

## Performance & scale
<expected load on touched paths; pagination/caching/async where needed; N+1 avoided by design>

## Observability
<structured logs (no PII), metric/health signal that shows the feature works in production>

## Risks & mitigations
| Risk (incl. security/performance) | Mitigation |
| :-- | :-- |

## Implementation plan
| Step | Requirement IDs | Test type |
| :-- | :-- | :-- |
