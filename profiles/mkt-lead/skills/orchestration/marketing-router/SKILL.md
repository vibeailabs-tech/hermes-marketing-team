---
name: marketing-router
description: Routes marketing requests to the right specialist.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: orchestration
    tags: [marketing, vietnam, orchestration, kanban]
    related_skills: [system-state-check, client-onboarding]
---

# Marketing Router Skill

Turns one marketing request into Kanban cards for the right specialist profiles, in the right order. It
plans, sequences and enforces the workflow; it never writes marketing assets itself.

## When to Use

- A Kanban card assigned to `mkt-lead` carries a client request (usually created by `tro-ly`).
- Someone in chat asks for marketing work, a full campaign, or "what should we do next?".

## Prerequisites

- The `kanban` toolset (`kanban_create`, `kanban_list`, `kanban_show`, `kanban_comment`, `kanban_complete`).
- The marketing workspace (default `~/marketing-workspace`) with the client folder `clients/<slug>/`.
  If the folder does not exist, run `/client-onboarding` first.
- Kanban `dir` workspaces need an absolute path: get the home directory with `terminal` (`echo "$HOME"`)
  and build `<home>/marketing-workspace/clients/<slug>`.

## How to Run

- **Kanban:** read the card with `kanban_show`; the tenant (or body) names the client slug.
- **Chat:** `/marketing-router <request>`; ask which client if more than one folder exists under `clients/`.

## Quick Reference

| Request | Assignee | Skills |
|---|---|---|
| Onboard a client, build or redo brand.md | `mkt-brand` | `brand-setup`, `brand-voice`, `audience-profile`, `positioning`, `usp-definition` |
| Market, competitor, keyword, trend research | `mkt-research` | `market-research`, `competitor-analysis`, `keyword-research`, `trend-monitoring` |
| 90-day plan, calendar, lead magnet, brief, offer | `mkt-strategy` | `campaign-planning`, `content-calendar`, `lead-magnet`, `campaign-brief`, `offer-positioning` |
| Landing page, CTA, page audit, page test | `mkt-strategy` | `lp-builder`, `cta-optimization`, `page-audit`, `cro-ab-test`, `cro-sales-page` |
| Blog, website copy, case study, opinion | `mkt-content` | `content-brief`, `blog-writer`, `website-copy`, `case-study-writer`, `thought-leadership` |
| SEO | `mkt-content` | `seo-keyword-research`, `on-page-seo`, `local-seo`, `schema-markup`, `technical-seo-audit`, `link-building-strategy` |
| Social posts, calendar, hashtags, replies, short video | `mkt-social` | `social-copy`, `social-calendar`, `hashtag-research`, `community-management`, `social-creative`, `short-video-script` |
| Repurposing, PR, podcast, partnerships | `mkt-social` | `content-atomizer`, `platform-formatter`, `press-release`, `podcast-pitch`, `partnership-brief` |
| Long video, design brief, deck, UGC | `mkt-creative` | `video-script`, `creative-brief`, `branded-deck`, `ugc-script` |
| Paid ads | `mkt-ads` | `ad-copy`, `ad-creative`, `audience-targeting`, `ad-campaign-structure`, `ads-ab-test`, `google-pmax-brief` |
| Email | `mkt-growth` | `email-sequence`, `newsletter`, `subject-line-ab`, `re-engagement`, `transactional-email` |
| Cold outreach | `mkt-growth` | `cold-email`, `linkedin-dm`, `follow-up-sequence`, `outreach-objection-handler`, `personalization-framework` |
| Sales enablement | `mkt-growth` | `sales-page`, `proposal-writer`, `sales-objection-handler`, `sales-case-study`, `testimonial-framework` |
| Reports, ROI | `mkt-analyst` | `weekly-report`, `campaign-report`, `roi-calculator`, `data-visualization`, `monthly-performance-review` |
| Update the brand from results | `mkt-brand` | `audience-update`, `messaging-refinement`, `positioning-evolution`, `foundation-review` |

Workflow order: Foundation → Research → Strategy → CRO → Execution → Distribution → client review →
Performance → Feedback.

## Procedure

1. **Identify the client.** Take the slug from the card tenant or body. No folder under `clients/` →
   run `/client-onboarding` and stop routing until brand setup is scheduled.
2. **Check state.** Run `/system-state-check` for the client. It tells you which layers exist.
3. **Enforce the order.**
   - No `brand/brand.md` (or still mostly `[To be filled]`) → the first card is `brand-setup` for `mkt-brand`;
     everything else waits on it through `parents`.
   - Strategy without research: allowed, but add `market-research` + `competitor-analysis` cards as parents
     unless the request says to skip research.
   - Execution without a campaign brief: add a `campaign-brief` card (`mkt-strategy`) as parent, unless the
     request is a one-off (a single post or email).
   - Feedback skills need at least one `monthly-performance-review`; otherwise route to `mkt-analyst` first.
4. **Single task:** one card for the matching assignee and skill.
5. **Full campaign:** build a dependency chain with `parents` (cards with parents wait in `todo`):
   - Research, in parallel: `market-research`, `competitor-analysis`, `keyword-research` (`mkt-research`).
   - Strategy: `campaign-planning` → `campaign-brief` → `content-calendar` (`mkt-strategy`).
   - Execution, in parallel after the brief: `content-brief` → `blog-writer` (`mkt-content`), `social-copy`
     (`mkt-social`), `ad-copy` (`mkt-ads`), `email-sequence` (`mkt-growth`), `lp-builder` (`mkt-strategy`).
   - Distribution: `content-atomizer` (`mkt-social`) with the blog card as parent.
   - Performance and feedback are not part of a launch; the scheduled weekly and monthly jobs cover them.
6. **Create each card** with `kanban_create`:
   - `title`: short and specific, e.g. "Blog: 5 sai lầm khi mở quán cà phê (acme)".
   - `assignee` and `skills: [<skill>]` from the table.
   - `tenant: <slug>`, `workspace_kind: "dir"`, `workspace_path: <home>/marketing-workspace/clients/<slug>`.
   - `parents`: the card ids this one depends on.
   - `idempotency_key`: `<your-card-id>-<skill>` so a retry never duplicates work.
   - `body`: the client's goal in their words, inputs to read (paths), constraints (deadline, budget, platform),
     acceptance criteria, and how to close: client-facing assets end with `kanban_request_review`; internal
     work (research, strategy, briefs, reports) ends with `kanban_complete`.
7. **Close your own card** with `kanban_complete`: a summary listing every card id, its assignee, its
   dependencies, and what the client will be asked to review.

## Pitfalls

- Never write marketing content or edit client files yourself; you only route and sequence.
- Never make positioning or strategic decisions alone; put the options in a card for `mkt-strategy` or
  `mkt-brand`, or ask the client through `tro-ly`.
- Don't run dependent cards in parallel: if B reads A's output, B lists A in `parents`.
- Never create a card without an assignee, a `dir` workspace, and the client tenant.
- In chat, present a full-campaign plan and get confirmation before creating cards.

## Verification

- `kanban_list` with the client tenant shows every planned card with the right assignee and parents.
- Each card body names its input paths and its closing rule (review or complete).
- Your own card is closed with a summary that lists the card ids.
