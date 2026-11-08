---
name: client-onboarding
description: Creates a client folder and schedules brand setup.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: orchestration
    tags: [marketing, vietnam, orchestration, onboarding]
    related_skills: [marketing-router, system-state-check]
---

# Client Onboarding Skill

Sets up a new client (or brand) in the marketing workspace: copies the folder template, records the basics,
and creates the first Kanban card so `mkt-brand` can run the brand interview. It does not run the interview.

## When to Use

- A request names a client or brand that has no folder under `clients/`.
- The customer adds a second brand (agency customers).

## Prerequisites

- The marketing workspace (default `~/marketing-workspace`) with `_template/`.
- The `kanban` toolset.

## How to Run

- **Kanban:** from `/marketing-router` step 1, or a card titled "Onboard <brand>".
- **Chat:** `/client-onboarding <brand name>`.

## Procedure

1. **Pick the slug:** lowercase ASCII, hyphens only, no diacritics ("Cà Phê Mộc" → `ca-phe-moc`). Confirm it
   in chat; in Kanban use it and mention it in your summary.
2. **Create the folder** with `terminal`, from the workspace root:

   ```bash
   cp -R ~/marketing-workspace/_template ~/marketing-workspace/clients/<slug>
   ```

   Refuse if `clients/<slug>` already exists; route to `/marketing-router` instead.
3. **Record the basics** in `clients/<slug>/AGENTS.md` with `patch`: brand name, website, main contact
   channel, language, anything the request already says. Leave `brand/brand.md` to `mkt-brand`.
4. **Commit** in the workspace with `terminal`: `git add clients/<slug> && git commit -m "Onboard <slug>"`.
5. **Create the brand setup card** with `kanban_create`:
   - `assignee: "mkt-brand"`, `skills: ["brand-setup"]`, `tenant: <slug>`.
   - `workspace_kind: "dir"`, `workspace_path: <home>/marketing-workspace/clients/<slug>` (absolute; get
     `<home>` with `echo "$HOME"`).
   - `idempotency_key: "onboard-<slug>"`.
   - `body`: everything already known about the brand (website, offer, competitors, sample posts) and the line
     "If the 18 intake answers are not in this card, block with the full question list so tro-ly can ask the
     client."
6. **Report**: the slug, the folder path and the brand-setup card id. Other work for this client waits on
   that card (pass it as a parent).

## Pitfalls

- Never put two brands in one folder; one client folder per brand.
- Don't fill brand.md yourself, even with information you already have; put it in the card body instead.
- Never delete or overwrite an existing client folder.

## Verification

- `clients/<slug>/brand/brand.md` exists (template copy) and `clients/<slug>/AGENTS.md` names the brand.
- `kanban_show` on the new card shows assignee `mkt-brand`, skill `brand-setup`, tenant `<slug>`.
