---
name: team-status
description: Summarizes open marketing cards and pending reviews.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: assistant
    tags: [marketing, vietnam, kanban, assistant]
    related_skills: [marketing-handoff]
---

# Team Status Skill

Gives the client a short picture of the marketing department: what needs their answer, what waits for their
approval, what is in progress and what finished recently. Read-only on the board.

## When to Use

- The client asks "team đang làm gì?", "có gì cần mình duyệt không?" or similar.
- The scheduled daily digest job runs.

## Prerequisites

- The `kanban` toolset (`kanban_list`, `kanban_show`).

## How to Run

- **Chat:** `/team-status`, optionally with a client slug.
- **Cron:** the daily digest job loads this skill.

## Procedure

1. `kanban_list` per status: `blocked`, `review`, `running`, `ready`, `todo`, and `done` (sort `completed-desc`).
   Filter by tenant when the client names one.
2. For each `blocked` card, read the reason with `kanban_show`; these are questions for the client.
3. Reply in Vietnamese, most urgent first:

```
📋 Phòng marketing — <date>
❓ Cần bạn trả lời (<n>): <card title> — <the question>
👀 Chờ bạn duyệt (<n>): <card title> — <one-line summary>
⏳ Đang làm (<n>): <card title> — <assignee>
✅ Xong gần đây (<n>): <card title>
```

4. End with one suggestion: answer the oldest question, or review the oldest asset.
5. In a scheduled run with nothing blocked and nothing in review, send one line saying the team is on track.

## Pitfalls

- Don't list internal card ids unless the client asks; use titles.
- Keep it under 15 lines; offer details instead of dumping everything.
- Never change card state here; answering and approving go through `/marketing-handoff`.

## Verification

- Every blocked and review card for the tenant appears in the reply.
- The reply ends with exactly one suggested action.
