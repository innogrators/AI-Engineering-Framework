# Feature Workflow (Claude Code)

Connects maturity levels 2-5: context -> spec -> architecture -> implementation -> review -> deployment. Each phase names the tool (skill `/name`, subagent, gate). Skills are invokable as `/name` and double as autonomous capabilities.

| Phase | Goal | Tool | Example prompt |
| :-- | :-- | :-- | :-- |
| 1. Load context | Lean, targeted context | project `CLAUDE.md`, built-in `Explore` agent | "Read CLAUDE.md and the relevant requirements for area X." |
| 2. Clarify requirement | Sharpen the user problem | - | "We need feature X because ... ask me the open questions." |
| 3. Write spec | Testable spec | `/write-spec` | "Use write-spec for: <feature>." |
| 4. Review & approve spec | Spec quality gate | `requirements-analyst` agent* | "Check specs/feature-x.md." -> then **manual approval** (human sets `Status: APPROVED`) |
| 5. Design architecture | Technical design | `/design-architecture` | "Use design-architecture on specs/feature-x.md." |
| 6. Plan implementation | Steps + file list | (part of implement-feature) | "Produce the implementation plan; do not edit yet." |
| 7. Implement | Write code | `/implement-feature` | "Implement feature X strictly from the approved spec and design." |
| 8. Run tests | Make it green | `qa-tester` agent / project test cmd | "Run the qa-tester for feature X." |
| 9. Orchestrated review | Multi-perspective | `/orchestrated-review` | "Run orchestrated-review with security, qa and skeptical reviewers." |
| 10. Fix findings | Close Blockers/Major | `/implement-feature` | "Fix the Blockers/Major from the report, smallest diffs." |
| 11. Update docs | Docs = Done | `documentation-writer` agent* | "Update docs for feature X per documentation-rules." |
| 12. Prepare deployment | Release readiness | `/deployment-prep` + `deployment-reviewer`* | "Produce a Go/No-Go deployment report for feature X." |
| 13. Final report | Consolidate | (main agent) | "Summarize: what was built, requirements covered, open items, next steps." |

\* = agent from the optional `ai-eng-reviewers-extended` plugin; without it, run the phase with the main agent.

**Gate rule:** Phase 7 starts only with a spec (Phase 4) and design (Phase 5) both marked `Status: APPROVED`. Phase 12 only after a green review (Phase 9) with no open Blockers/Major. **Enforcement:** the merge gate lives in CI (`templates/ci/quality-gates.yml` + branch protection); strict spec-first mode can additionally be enforced with the opt-in hooks in `templates/hooks/`.

**Right-sizing:** match process to risk. Trivial change -> just chat. Small feature/bugfix -> `/implement-feature` + `qa-tester` + commit. Large/risky -> full path. Do not run all 13 phases for a CRUD endpoint.

**Cost:** `orchestrated-review` spawns only a selected subset of reviewers (multi-agent ~ 4-7x tokens). Reviewers run read-only.
