# Marketing Workspace

Client data for the AI marketing department (Hermes profiles `tro-ly` and `mkt-*`). Profiles, skills and
scripts live in the `hermes-marketing-team` repo; this folder holds client data only and is its own git
repository.

## Layout

```
marketing-workspace/
├── AGENTS.md                  # this file: rules for every agent
├── _template/                 # copied for each new client; never edit it for one client
└── clients/
    └── <slug>/                # one brand; also the Kanban tenant
        ├── AGENTS.md          # notes about this client
        ├── brand/
        │   ├── brand.md       # single source of truth (12 sections)
        │   └── changelog.md   # every brand.md change, with evidence
        ├── research/          # market, competitor, keyword, trend research
        ├── strategy/          # campaign plans and briefs, calendars, lead magnets, offers
        ├── assets/
        │   ├── content/       # blog posts, briefs, case studies, website copy
        │   ├── seo/           # keyword maps, audits, schema
        │   ├── email/         # sequences, newsletters
        │   ├── social/        # posts, calendars, hashtags, reply templates
        │   ├── ads/           # ad copy, creative briefs, targeting, structure
        │   ├── creative/      # video scripts, decks, UGC scripts
        │   ├── outreach/      # cold email, LinkedIn, follow-ups
        │   ├── sales/         # sales pages, proposals, case studies
        │   └── cro/           # landing pages, CTAs, page audits, tests
        ├── distribution/      # atomized and formatted content per platform
        └── performance/       # weekly, campaign and monthly reports
```

## Rules for every agent

1. **One client per task.** Every path a skill mentions (`brand/brand.md`, `research/...`) is relative to
   `clients/<slug>/`. Kanban workers start inside that folder. In chat, confirm the client first; if only one
   folder exists under `clients/`, use it.
2. **`brand/brand.md` is the single source of truth.** Read it before any task. Only `mkt-brand` edits it and
   logs each change in `brand/changelog.md`.
3. **Predictable paths.** Write only where your skill says, with dates as `YYYY-MM-DD` in filenames. Never move,
   rename or overwrite another specialist's files.
4. **Human review.** Client-facing assets go to Kanban review. No agent publishes, sends or launches anything.
5. **No secrets** in this folder: no API keys, passwords or tokens in any file.
6. **Git.** Onboarding commits new client folders; the human owner commits approved work. Agents never push.
