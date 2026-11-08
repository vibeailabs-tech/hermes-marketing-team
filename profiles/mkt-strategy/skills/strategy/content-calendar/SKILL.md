---
name: content-calendar
description: Maps weekly content topics, formats and hooks to dates.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: strategy
    tags: [marketing, vietnam, strategy]
---

# Content Calendar Skill

Your job is to build a concrete, ready-to-execute content calendar — specific posts with topics, formats, platforms, and goals for each. Not a vague "post 3x per week" recommendation. Actual titles and angles, week by week.

## When to Use

- A campaign exists and weekly content topics, formats and hooks must be scheduled.
- Owned by `mkt-strategy`; writes to `strategy/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/content-calendar` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read the following files:
- `brand/brand.md` — content pillars (Section 12), brand voice (Section 5), ICP (Section 6)
- `strategy/campaign-plan-*.md` — monthly themes and weekly structure (if exists)
- `research/keyword-research-*.md` — keyword targets per tier (if exists)
- `research/trend-monitoring-*.md` — trending angles to inject (if exists)

If brand.md doesn't exist: stop and ask user to run `brand-setup` (`mkt-brand`) first.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User specified a time period or platform**
Use their scope. Go to Step 3.

**Path B — No scope provided**
Ask:
"Bạn muốn mình lập lịch nội dung cho:
1. 2 tuần tới (chi tiết nhất, ready to execute ngay)
2. 1 tháng (4 tuần, tổng quan + chi tiết tuần 1–2)
3. 3 tháng (gắn với campaign plan)

Và nền tảng chính:
- Facebook only
- TikTok only
- Facebook + TikTok + Blog
- Tất cả kênh"

Wait for answer before continuing.

### Step 3 — Build the content calendar

#### Content mix framework (per week)
Follow the 4-1-1 rule adapted for Vietnamese SMB:
- **4 pieces** — educational / value content (builds trust, no sell)
- **1 piece** — proof / social proof (case study, review, result)
- **1 piece** — promotional / CTA (offer, booking, lead magnet)

#### Content types by platform

**Facebook:**
- Long-form storytelling post (300–500 words) — pain point story → insight → CTA
- Short punchy post (50–100 words) — bold statement or contrast
- Image carousel — "X điều về..." or before/after
- Video/Reel — demo, behind-the-scenes, tip

**TikTok:**
- Hook video (15–30s) — starts with conflict or contrast
- Tutorial/tip (30–60s) — practical, actionable
- POV / day-in-life — humanizes the brand
- Trending sound + brand message overlay

**Blog/SEO:**
- Long-form article (800–1500 words) — targets Tier 1–2 keywords
- FAQ page — targets "là gì", "bao nhiêu" searches
- Comparison article — "[Brand] vs [Competitor]" or "[Option A] vs [Option B]"

**Zalo:**
- Personal updates and behind-the-scenes
- Exclusive offers for Zalo contacts
- Quick tips (shorter than Facebook)

**Email (if applicable):**
- Weekly value email — one insight, one story, one CTA
- Nurture sequence for new leads

#### For each content piece, specify:
- **Date / week**
- **Platform**
- **Content type** (post / video / blog / email)
- **Title or hook** (specific — not "tips about skincare" but "3 lý do da bạn vẫn bị kích ứng dù đã dùng sản phẩm đắt tiền")
- **Content pillar** it belongs to (from brand.md Section 12)
- **Keyword target** (if blog/SEO content)
- **Goal** (awareness / trust / leads / conversion)
- **CTA** (what should the reader do next)

#### Assign content to pillars evenly:
Pull content pillars from brand.md Section 12. Distribute content across pillars so no single pillar dominates the calendar. Each pillar should appear at least once per week.

#### Inject trend angles:
From trend-monitoring.md, pick 1–2 trending topics per month and assign them to specific posts. Mark these as "🔴 Publish this week" if trend urgency is high.

### Step 4 — Write output

Save to `strategy/content-calendar-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Content Calendar — [Brand Name]
> Generated: [date] | Period: [date range] | Platforms: [list]

## Calendar Overview
- Total pieces: [X]
- Platforms covered: [list]
- Content mix: [X]% educational / [X]% proof / [X]% promotional
- Primary keyword targets this period: [list top 3]

---

## Week 1 — [Date range] — Theme: [weekly theme]

| # | Date | Platform | Type | Title / Hook | Pillar | Goal | CTA |
|---|---|---|---|---|---|---|---|
| 1 | | Facebook | Story post | [specific title] | [pillar] | Trust | [CTA] |
| 2 | | TikTok | Hook video | [specific hook] | [pillar] | Awareness | [CTA] |
| 3 | | Blog | Long-form | [specific title] | [pillar] | SEO | [CTA] |
| 4 | | Facebook | Proof post | [specific title] | [pillar] | Trust | [CTA] |
| 5 | | Zalo | Update | [specific topic] | [pillar] | Relationship | [CTA] |
| 6 | | TikTok | Tutorial | [specific hook] | [pillar] | Education | [CTA] |

**Week 1 SEO target:** [keyword]
**Week 1 trend angle:** [trend from trend-monitoring.md if applicable]

---

## Week 2 — [Date range] — Theme: [weekly theme]
[same structure]

---

## Week 3 — [Date range] — Theme: [weekly theme]
[same structure]

---

## Week 4 — [Date range] — Theme: [weekly theme]
[same structure]

---

## Content Brief Summaries
For each blog post, add a one-paragraph brief:

**[Blog title]**
- Target keyword: 
- Word count: 
- Structure: [intro / 3 main points / CTA]
- Key message: 
- Internal link to: 
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Lịch nội dung cho [Brand Name] đã hoàn chỉnh.**

**Tổng quan:**
- Số lượng nội dung: [X] pieces trong [X] tuần
- Nền tảng: [list]
- Bài đăng đầu tiên cần publish: [specific title] — [platform] — [date]
- Quick win SEO: [top keyword target]

📁 Đã lưu vào: `strategy/content-calendar-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `blog-writer` (`mkt-content`) để viết bài blog đầu tiên, hoặc `social-copy` (`mkt-social`) để viết caption cho Facebook/TikTok."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `strategy/content-calendar-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
