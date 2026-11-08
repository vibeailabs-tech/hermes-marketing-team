---
name: campaign-planning
description: Builds a 90-day campaign plan with goals and channels.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: strategy
    tags: [marketing, vietnam, strategy]
    related_skills: [content-calendar]
---

# Campaign Planning Skill

Your job is to build a focused, actionable 90-day marketing campaign — not a vague strategy document. Every week should have a clear goal, content theme, and measurable output.

## When to Use

- The client needs a 90-day plan: goals, channels, phases and targets.
- Owned by `mkt-strategy`; writes to `strategy/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/campaign-planning` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read the following files:
- `brand/brand.md` — brand positioning, ICP, USP, core offer
- `research/market-research-*.md` — market size, opportunities, threats (if exists)
- `research/competitor-analysis-*.md` — competitor gaps to exploit (if exists)
- `research/keyword-research-*.md` — keyword priorities (if exists)
- `research/trend-monitoring-*.md` — trends to ride (if exists)

If brand.md doesn't exist: stop and ask user to run `brand-setup` (`mkt-brand`) first.
If research files don't exist: proceed with brand.md data only, note the gap.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User specified campaign goal or focus**
Use their goal. Go to Step 3.

**Path B — No goal provided**
Ask:
"Chiến dịch 90 ngày này hướng đến mục tiêu nào?
1. Tăng nhận diện thương hiệu (brand awareness)
2. Tạo leads và khách hàng mới (lead generation)
3. Ra mắt sản phẩm/dịch vụ mới (product launch)
4. Tái kích hoạt khách hàng cũ (re-engagement)
5. Kết hợp (mixed — brand + leads)"

Wait for answer before continuing.

### Step 3 — Build the 90-day campaign structure

#### Campaign Architecture

**Month 1 — Awareness & Trust (Weeks 1–4)**
Goal: Get the right people to know this brand exists and trust it enough to engage.
- Lead with educational content that addresses top pain points
- Build SEO foundation with Tier 3 keywords
- Establish social presence rhythm (consistency > volume)
- No hard selling in Month 1 — build credibility first

**Month 2 — Consideration & Engagement (Weeks 5–8)**
Goal: Move warm audience from "interesting" to "I want this."
- Introduce comparison content (us vs alternatives)
- Publish proof: case studies, testimonials, before/after
- Capture leads with a lead magnet offer
- Start retargeting anyone who engaged in Month 1

**Month 3 — Conversion & Retention (Weeks 9–12)**
Goal: Turn interested prospects into paying customers.
- Direct offer content: pricing, packages, CTA-forward
- Run a limited-time incentive (bonus, discount, free consultation)
- Email sequence for leads captured in Month 2
- Referral or review ask for new customers

#### For each month, define:
- **Theme:** The single narrative thread for the month
- **Primary platform:** Where most energy goes (Facebook / TikTok / Zalo / Blog / LinkedIn)
- **Content mix:** Ratio of educational : proof : promotional content
- **Key milestones:** What must be live by end of month
- **Success metric:** The one number that proves this month worked

#### Weekly breakdown (for Month 1 as example):
- Week 1: [specific theme] → [content type] → [platform] → [CTA]
- Week 2: [specific theme] → [content type] → [platform] → [CTA]
- Week 3: [specific theme] → [content type] → [platform] → [CTA]
- Week 4: [specific theme] → [content type] → [platform] → [CTA]

Use brand.md content pillars to assign weekly themes. Use keyword-research.md to assign SEO targets per week. Use trend-monitoring.md to inject timely angles.

#### Budget allocation framework (if user has a budget):
- 40% — content production (writing, design, video)
- 35% — paid distribution (Facebook/TikTok ads, boosted posts)
- 15% — tools and automation
- 10% — testing and experimentation

### Step 4 — Define campaign KPIs

Set measurable targets for the 90-day period. Base on industry benchmarks for Vietnam:

| Metric | Conservative | Realistic | Aggressive |
|---|---|---|---|
| Organic reach/month | — | — | — |
| Leads generated | — | — | — |
| Email subscribers | — | — | — |
| Conversion rate | — | — | — |
| Revenue target | — | — | — |

Fill in numbers based on the brand's current stage, audience size, and market data from research files.

### Step 5 — Write output

Save to `strategy/campaign-plan-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# 90-Day Campaign Plan — [Brand Name]
> Generated: [date] | Goal: [campaign goal] | Market: Vietnam

## Campaign Overview
- Goal: 
- Primary audience: 
- Core message for this campaign:
- Platforms: 
- Budget range (if provided):

---

## Month 1 — [Theme Name] (Weeks 1–4)
**Goal:** 
**Content ratio:** X% educational / X% proof / X% promotional
**Primary platform:**
**Key milestone:**
**Success metric:**

### Week-by-Week
| Week | Theme | Content Type | Platform | CTA |
|---|---|---|---|---|
| 1 | | | | |
| 2 | | | | |
| 3 | | | | |
| 4 | | | | |

---

## Month 2 — [Theme Name] (Weeks 5–8)
[same structure]

---

## Month 3 — [Theme Name] (Weeks 9–12)
[same structure]

---

## 90-Day KPI Targets
| Metric | Target |
|---|---|
| | |

---

## Quick Wins (Do in Week 1)
[3–5 actions to take immediately that cost nothing but time]

---

## Risks & Contingencies
[What could go wrong and what to do about it]
```

### Step 6 — Confirm

After writing, reply:

---
"✅ **Kế hoạch chiến dịch 90 ngày cho [Brand Name] đã hoàn chỉnh.**

**Tóm tắt:**
- Tháng 1: [theme] — [primary action]
- Tháng 2: [theme] — [primary action]
- Tháng 3: [theme] — [primary action]
- Quick win đầu tiên: [top action for week 1]

📁 Đã lưu vào: `strategy/campaign-plan-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/content-calendar` để lập lịch nội dung chi tiết từng tuần."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `strategy/campaign-plan-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
