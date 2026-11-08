---
name: marketing-handoff
description: Hands marketing requests to the team via Kanban.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: assistant
    tags: [marketing, vietnam, kanban, assistant]
    related_skills: [team-status]
---

# Marketing Handoff Skill

Connects the client's chat with the AI marketing department. It turns a chat request into one Kanban card for
`mkt-lead`, relays questions from blocked cards back to the client, and records the client's approvals. It
never writes marketing content itself.

## When to Use

- The client asks for any marketing work: content, ads, research, a campaign, a report.
- A card is blocked waiting for the client's answers.
- The client approves or rejects an asset waiting in review.

## Prerequisites

- The `kanban` toolset (`kanban_create`, `kanban_list`, `kanban_show`, `kanban_comment`, `kanban_unblock`).
- The marketing workspace (default `~/marketing-workspace`); client folders live in `clients/<slug>/`.

## How to Run

- **Chat:** the client just asks ("viết cho mình 5 bài Facebook tuần này"); load this skill when the request is
  marketing work.
- `/marketing-handoff` to load it explicitly.

## Procedure

### A. New request

1. **Which client?** List folder names under `clients/` with `search_files target='files'` (skip names that start
   with `_`). One folder → use it. Several → ask. None → the request starts with onboarding; say so.
2. **Clarify at most two things** that change the work: goal, deadline, platform or budget. Don't interview
   the client; specialists ask for details through the card if they need them.
3. **Confirm scope** for anything bigger than a single asset ("Mình sẽ giao cả chiến dịch: research →
   chiến lược → nội dung → quảng cáo. Ok không?").
4. **Create the card** with `kanban_create`:
   - `title`: the request in a few words, with the client slug.
   - `assignee: "mkt-lead"`, `skills: ["marketing-router"]`, `tenant: <slug>`.
   - `workspace_kind: "dir"`, `workspace_path: <home>/marketing-workspace/clients/<slug>` (get `<home>` with
     `terminal`: `echo "$HOME"`).
   - `body`: the client's words verbatim, then goal, deadline, platform, budget, links, attachments.
5. **Reply** with the card id and what happens next, in one or two sentences.

### B. A card is blocked

1. Find blocked cards with `kanban_list` (status `blocked`, the client's tenant); read the reason with `kanban_show`.
2. Ask the client the exact questions, grouped in one message.
3. When the client answers, post the answers verbatim with `kanban_comment` on that card, then `kanban_unblock` it.

### C. An asset is waiting for review

1. Find cards in `review` with `kanban_list`; read the summary and the output path with `kanban_show`.
2. Show the client the key content: paste short assets; for long documents paste the opening and the
   structure, and give the file path.
3. Approved → with `terminal`: `hermes kanban complete <id> --summary "Client approved via chat"`.
4. Changes requested → with `terminal`: `hermes kanban request-changes <id> "<the client's changes, verbatim>"`.

## Pitfalls

- Never approve, reject or answer on the client's behalf; only relay what they said.
- One request becomes one card for `mkt-lead`; let `mkt-lead` split the work.
- Don't promise deadlines the team has not confirmed.
- Never paste API keys, tokens or other secrets into a card.

## Verification

- The new card shows assignee `mkt-lead`, the client tenant and an absolute `dir` workspace.
- Blocked cards you handled have the client's answers as a comment and are no longer blocked.
- Reviewed cards are `done` (approved) or back with the client's change request.
