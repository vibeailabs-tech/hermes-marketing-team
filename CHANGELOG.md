# Changelog

All notable changes to the Hermes Marketing Team distributions. Versions follow semantic versioning; every
profile ships with the same version (see `VERSION`).

## [Unreleased]

## [0.1.0] - 2026-11-08

### Added
- 11 Hermes profile distributions: `tro-ly` (assistant), `mkt-lead` (orchestrator) and nine specialists
  (`mkt-brand`, `mkt-research`, `mkt-strategy`, `mkt-content`, `mkt-social`, `mkt-creative`, `mkt-ads`,
  `mkt-growth`, `mkt-analyst`).
- 80 skills: 75 converted from the Claude Code blueprint to the Hermes `SKILL.md` standard, plus
  `marketing-router`, `system-state-check`, `client-onboarding`, `marketing-handoff` and `team-status`.
- Kanban-based workflow with human review (`kanban.review_dispatch: false`) and client folders as tenants.
- Scheduled jobs on `tro-ly` (weekly report, monthly strategy cycle, daily digest), installed paused.
- Workspace template with `brand.md` schema and changelog.
- Scripts: `bootstrap.sh`, `install-profiles.sh`, `upgrade.sh`, `release.sh`, `new-client.sh`,
  `healthcheck.sh`, `validate.py`; CI workflow.
