# AI Engineering Framework

A reusable AI-engineering framework for **Claude Code**, packaged as plugins. Install it into any project to get a spec-first development workflow, quality skills, reviewer subagents, and enforcement templates (CI gates, hooks) — independent of any single project.

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
3. Copy `ci/quality-gates.yml` to `.github/workflows/`, replace the placeholder commands, and require the workflow via branch protection. **Prompts ask, CI enforces — without this step the gates are advisory.**
4. Optional (strict spec-first mode): copy `hooks/spec-gate.sh` to `.claude/hooks/` and merge `hooks/settings.example.json` into `.claude/settings.json`.

## Repository layout
```
.claude-plugin/marketplace.json     # marketplace manifest (repo root = marketplace)
plugins/ai-eng-framework/           # core plugin: skills, agents, rules, templates, workflow
plugins/ai-eng-reviewers-extended/  # optional extra reviewer agents
```

## Official docs (verify schema if something fails)
- Plugins & marketplaces: https://code.claude.com/docs/en/plugin-marketplaces
- Subagents: https://code.claude.com/docs/en/sub-agents
- Hooks: https://code.claude.com/docs/en/hooks
