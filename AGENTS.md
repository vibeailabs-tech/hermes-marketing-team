# AGENTS.md — Hermes Marketing Team

Guide for AI coding assistants working on this repo. It is a set of Hermes Agent **profile distributions**
(not an app): each `profiles/<name>/` is installed with `hermes profile install <dir>` into
`~/.hermes/profiles/<name>/`. Client data never lives here; it lives in the workspace created from
`templates/workspace/` (default `~/marketing-workspace`).

## Layout

- `profiles/<name>/distribution.yaml` — manifest (`name` = directory, `version` = `VERSION`, `env_requires`,
  `distribution_owned`). Never commit `source:` or `installed_at:`; the installer writes them.
- `profiles/<name>/SOUL.md` — identity and rules (English; agents talk to people in Vietnamese).
- `profiles/<name>/config.yaml` — model and `terminal.cwd: ~/marketing-workspace`. Installed copies are preserved
  on update, so config changes reach customers only with `--force-config`.
- `profiles/<name>/skills/<category>/<skill>/SKILL.md` — skills; helper scripts in `scripts/`, schemas in
  `references/`.
- `profiles/tro-ly/cron/jobs.json` — shipped schedules (stable readable `id`s; installs arrive paused).
- `templates/workspace/` — workspace `AGENTS.md`, `_template/` client folder, `brand.md` template.
- `scripts/` — bash 3.2-compatible (macOS default) plus `validate.py` (Python 3 + PyYAML).

## Skill rules (checked by `scripts/validate.py`)

- Frontmatter: `name` (= directory, `^[a-z][a-z0-9-]*$`), `description` (≤ 60 chars, one sentence, ends with a
  period, no marketing words), `version`, `author: Vibe AI Labs`, `license: Proprietary`,
  `platforms: [linux, macos]`, `metadata.hermes.category`, `metadata.hermes.tags`; `related_skills` only from the
  same profile. Skills calling an API declare `required_environment_variables` so the key reaches `terminal`.
- Sections in order: `# <Title> Skill`, intro, `## When to Use`, `## Prerequisites`, `## How to Run`,
  `## Quick Reference` (optional), `## Procedure`, `## Pitfalls`, `## Verification`.
- Paths are relative to the client folder: `brand/brand.md`, `research/`, `strategy/`, `assets/<type>/`,
  `distribution/`, `performance/`. Dates in filenames are `YYYY-MM-DD`.
- `/skill` slash references only for skills in the same profile; another profile's skill is written
  `` `skill` (`profile`) ``.
- Name Hermes tools in backticks (`read_file`, `search_files`, `patch`, `terminal`, `web_search`, `kanban_create`,
  `kanban_block`, `kanban_complete`, `kanban_request_review`), not shell utilities.
- Skill names are unique inside a profile; avoid reusing a name that exists in another profile.

## Invariants

- Only `mkt-brand` writes `brand/brand.md`; every change is logged in `brand/changelog.md`.
- `mkt-lead` routes and sequences; it never writes assets. `tro-ly` relays; it never approves for the client.
- Client-facing work ends in Kanban review; agents never publish, send or spend money.
- No secrets, customer data or machine-local paths (`/Users/...`, `/home/<user>/`) in the repo.

## Workflow

```bash
python3 scripts/validate.py                     # must pass before every commit
for f in scripts/*.sh; do bash -n "$f"; done
scripts/install-profiles.sh mkt-content         # try a change on a dev machine
scripts/release.sh 0.2.0                        # needs a CHANGELOG section; tags, never pushes
```

Test installs without touching the real Hermes home by pointing both `HOME` and `HERMES_HOME` at a temp dir.
