---
name: system-state-check
description: Diagnoses which workflow layers a client is missing.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: orchestration
    tags: [marketing, vietnam, orchestration]
    related_skills: [marketing-router]
---

# System State Check Skill

Reads one client folder and reports which layers of the marketing workflow exist, which are partial and
which are missing, then recommends the single next step. It reads files only; it never changes them.

## When to Use

- Before routing any request (`/marketing-router` step 2).
- The client or `tro-ly` asks "what should we do next?" or "where are we at?".

## Prerequisites

- The client folder `clients/<slug>/` in the marketing workspace (default `~/marketing-workspace`).
- Python 3 for the helper script `scripts/state_check.py` (skill-relative; `skill_view` shows the skill
  directory).

## How to Run

Run the helper with `terminal`:

```bash
python3 <skill-dir>/scripts/state_check.py ~/marketing-workspace/clients/<slug>
```

It prints JSON: one entry per layer with `status` (`done`, `partial`, `missing`) and the files it found.
If Python is unavailable, inspect the same paths with `search_files target='files'` and `read_file`.

## Quick Reference

| Layer | Evidence | Next step when missing |
|---|---|---|
| Foundation | `brand/brand.md` with no `[To be filled]` | `brand-setup` (`mkt-brand`) |
| Research | `research/market-research-*`, `research/competitor-analysis-*` | `market-research` + `competitor-analysis` (`mkt-research`) |
| Strategy | `strategy/campaign-brief-*` | `campaign-planning` → `campaign-brief` (`mkt-strategy`) |
| Execution | files under `assets/*/` | the execution skill the brief calls for |
| Distribution | files under `distribution/` | `content-atomizer` (`mkt-social`) |
| Performance | `performance/weekly-report-*` or `performance/monthly-review-*` | `weekly-report` (`mkt-analyst`) |
| Feedback | brand.md `Last updated` within 30 days of the latest monthly review | `audience-update` (`mkt-brand`) |

## Procedure

1. Run the helper (or inspect manually) for the client folder.
2. Map each layer to ✅ done, ⚠️ partial or ❌ missing.
3. Pick the earliest layer that is not done; that is the recommendation. Exception: if execution assets exist
   but nothing is distributed, recommend distribution even when strategy is partial.
4. Reply in Vietnamese with this shape:

```
📊 Tình trạng hệ thống — <Brand Name>
✅ Brand foundation: <status>
⚠️ Research: <status>
❌ Strategy: <status>
❌ Execution: <what is missing>
❌ Distribution: <status>
❌ Performance: <status>
❌ Feedback loop: <status>

Đề xuất tiếp theo: <one action, with the skill and profile>
```

## Pitfalls

- Count a brand.md that still contains `[To be filled]` as partial, not done.
- Dates in filenames are `YYYY-MM-DD`; older files may differ, so fall back to modification time.
- Report what exists; never assume a layer is done because the client said so.

## Verification

- Every layer appears in the reply with one status.
- The recommendation names exactly one next skill and its profile.
