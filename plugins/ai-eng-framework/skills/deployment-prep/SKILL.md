---
name: deployment-prep
description: Prepares a feature for release/deployment and gives a Go/No-Go decision. Invoke via /deployment-prep.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash
---
# deployment-prep

**Goal:** check and document release readiness. Output language: **English**.

**Pre-deployment checklist:**
- [ ] All gates green (typecheck, lint, tests+coverage, dependency audit); critical-path E2E green.
- [ ] `/qa-review` with no open Blockers/Major.
- [ ] **Migrations** present & idempotent; data-integrity constraints considered.
- [ ] **Env vars:** new keys documented in the env example; no secrets in the repo.
- [ ] **Backup** before migration (datastore + file storage).
- [ ] **Build/runtime** image includes required system dependencies.
- [ ] **Observability:** health endpoint exists; structured logs for the new paths (no secrets/PII); errors visible in monitoring/alerting.

**Rollback plan:** previous image tag/commit; migration rollback or forward-fix strategy; data implications.

**Smoke tests (post-deploy):** health endpoint; auth per role; one core domain action end-to-end.

**Release notes:** what/why, requirement IDs, migrations, config changes, known limitations.

**Output - Go/No-Go report:** status per checklist item, open risks, **decision GO/NO-GO** with rationale and next steps.
