# AI Engineering Framework

A reusable AI-engineering framework for **Claude Code**, packaged as plugins. Install it into any project to get a spec-first development workflow, quality skills, reviewer subagents, and enforcement templates (CI gates, hooks) — independent of any single project.

## Why this framework exists

Agentic coding is good at producing working happy-path code, fast. That is precisely the problem: the failure modes are no longer syntax errors you would catch immediately, but untested assumptions, missing negative cases, and the wrong feature built quickly and convincingly. Quality becomes a function of the model's behavior on a given day and of whether your carefully written instructions survive a long context. A prompt that held for the first hour of a session quietly stops holding in the third.

The core thesis of this framework: **prompts ask, enforcement decides.** An instruction in `CLAUDE.md` or a skill is a request the model usually honors — until the context gets long or the task gets ambiguous. Anything that *must* hold therefore needs a layer that cannot be talked out of it. The framework splits responsibility accordingly:

- the **plugin** ships the *process* — portable, versioned, updated centrally;
- the project **`CLAUDE.md`** ships the *specifics* — stack, domain invariants, requirement IDs;
- **CI + branch protection** ship the *enforcement* — deterministic and model-independent.

This separation is also what makes the framework reusable: nothing project-specific lives in the plugin, nothing process-generic lives in the project, and the gates do not care which model (or human) produced the diff. Improve the process once, and every project picks it up with the next plugin update.

The workflow is spec-first with a deliberately manual gate: implementation starts only when a human has set `Status: APPROVED` on the spec — the model never sets that line, and CODEOWNERS plus a CI guard make sure nobody else slips it through. The reasoning is economic. The cheapest moment to catch a wrong feature is between spec and implementation, when changing course costs a paragraph instead of a rewrite, and a model will build the wrong thing just as fluently as the right one. For a solo developer this single step matters most: it is the one point in the loop where a second pair of eyes is forced into existence — even if both pairs are your own, separated by a deliberate pause.

Reviews run as separate read-only subagents rather than as the implementing model critiquing itself. A model reviewing its own work inside the same context is systematically lenient — it carries the justification history of every shortcut it just took. A fresh context that only sees the diff, the spec, and a checklist finds different findings. Read-only is enforced through tool restriction, not instruction: the reviewer agents simply have no edit tools.

Cost-consciousness is a design principle, not an afterthought. Multi-agent reviews cost roughly 4–7x the tokens of a single pass, so the framework selects reviewer subsets per diff and right-sizes process to risk: trivial change → just chat; small feature → `/implement-feature` + `qa-tester` + commit; large or risky → the full spec-to-deployment path. Running all thirteen phases on a CRUD endpoint is a process failure, not diligence.

Finally, all generated artifacts — code, comments, commits, specs, docs — are English, regardless of conversation language. A repository asset that is reusable across clients and contributors cannot depend on everyone sharing the author's native language; the conversation stays free.

## What's inside
- **ai-eng-framework** (lean core): lifecycle and quality skills, 3 core reviewers, and templates for project setup, CI quality gates, and opt-in hooks. Use this in every project.
- **ai-eng-reviewers-extended** (optional): extra specialized reviewers. Add only when a project needs them (multi-agent reviews cost ~4-7x tokens).

## Install
```bash
claude
/plugin marketplace add https://github.com/innogrators/AI-Engineering-Framework
/plugin install ai-eng-framework@ai-eng-marketplace
# optional:
/plugin install ai-eng-reviewers-extended@ai-eng-marketplace
```
For local development of the framework itself: `/plugin marketplace add <path-to-this-repo>`. After editing a skill/agent in a running session: `/reload-plugins`; new agent files are picked up on session start. Refresh an installed marketplace with `/plugin marketplace update ai-eng-marketplace`.

## Per-project setup (important)
The plugin ships the **process**; each project keeps its **specifics**; CI keeps the **enforcement**. In every new project (templates live in `plugins/ai-eng-framework/templates/`):
1. Copy `CLAUDE.base.md` to the project root as `CLAUDE.md` and fill in the project sections (stack, domain invariants, requirement IDs, gate commands).
2. Create a `specs/` folder (templates: `spec.template.md`, `design.template.md`). Specs/designs start as `Status: DRAFT`; a human flips them to `Status: APPROVED` — the skills check that line before building.
3. Copy `ci/quality-gates.yml` to `.github/workflows/`, replace the placeholder commands, and require the workflow via branch protection. **Prompts ask, CI enforces — without this step the gates are advisory.** (The workflow is written for GitHub Actions, but the gates and guard jobs are plain shell — the concept ports directly to GitLab CI or Azure DevOps.)
4. Copy `ci/CODEOWNERS` to `.github/CODEOWNERS`, set real owners for `specs/`, and enable "Require review from Code Owners" in branch protection. Together with the `spec-approval-guard` CI job this makes `Status: APPROVED` an enforced human decision — the line itself is just text that skills and hooks read.
5. Optional (strict spec-first mode): copy `hooks/spec-gate.sh` to `.claude/hooks/` and merge `hooks/settings.example.json` into `.claude/settings.json`.

**Template drift:** copied templates (`CLAUDE.md`, CI workflow, hooks, CODEOWNERS) are snapshots — they do not update when the plugin updates. After a framework update, diff your copies against `templates/`. Skills and agents are unaffected; they always come from the installed plugin version.

## Repository layout
```
.claude-plugin/marketplace.json     # marketplace manifest (repo root = marketplace)
plugins/ai-eng-framework/           # core plugin: skills, agents, rules, templates, workflow
plugins/ai-eng-reviewers-extended/  # optional extra reviewer agents
```

## When NOT to use it

Skip the framework for throwaway scripts, one-off analyses, and prototypes whose explicit purpose is to be discarded — spec-first ceremony on disposable code is pure overhead, and the right-sizing rule already says so: just chat.

Be equally honest about projects without CI: if you do not set up the quality-gates workflow and branch protection, the framework degrades to advisory prose — well-structured prompts that the model will mostly follow and occasionally won't, which is exactly the failure mode it was built to eliminate. Install the gates, or know that you are running on convention.

## Official docs (verify schema if something fails)
- Plugins & marketplaces: https://code.claude.com/docs/en/plugin-marketplaces
- Subagents: https://code.claude.com/docs/en/sub-agents
- Hooks: https://code.claude.com/docs/en/hooks
