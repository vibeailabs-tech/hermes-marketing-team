---
name: campaign-brief
description: Packages strategy into the brief execution agents follow.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: strategy
    tags: [marketing, vietnam, strategy]
---

# Campaign Brief Skill

Your job is to produce a single, structured brief that every execution agent reads before creating any content for this campaign. Think of it as the "single source of truth" for a specific campaign — just like brand.md is the source of truth for the brand.

## When to Use

- Strategy is done and the execution specialists need one brief to work from.
- Owned by `mkt-strategy`; writes to `strategy/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/campaign-brief` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read:
- `brand/brand.md` — voice, audience, positioning, key messages
- `strategy/campaign-plan-*.md` — campaign goals, monthly themes (if exists)
- `strategy/content-calendar-*.md` — specific content pieces planned (if exists)
- `strategy/lead-magnets-*.md` — lead magnet being promoted (if exists)
- `research/competitor-analysis-*.md` — angles to counter (if exists)

If brand.md doesn't exist: stop and ask user to run `brand-setup` (`mkt-brand`) first.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User described the campaign**
Use their description. Go to Step 3.

**Path B — No campaign described**
Ask:
"Brief này cho chiến dịch nào?
1. Mô tả ngắn: tên chiến dịch, mục tiêu, thời gian chạy
2. Sản phẩm/dịch vụ đang quảng bá trong chiến dịch này?
3. Có offer đặc biệt không? (giảm giá, bonus, deadline)
4. Kênh chính: Facebook / TikTok / Email / Zalo / Tất cả?"

Wait for answers before continuing.

### Step 3 — Build the campaign brief

A campaign brief has 8 components:

#### 1. Campaign Overview
- Campaign name (memorable, internal use)
- Campaign goal (one primary goal — awareness / leads / conversion)
- Duration (start date → end date)
- Budget range (if known)

#### 2. The Offer
- What exactly is being promoted
- Price + any special incentive
- Deadline or scarcity (if applicable)
- Guarantee or risk-reversal

#### 3. Target Audience (from brand.md + campaign-specific)
- Primary segment for this campaign
- Where they are in the buying journey (cold / warm / hot)
- Their #1 pain point this campaign addresses
- Their biggest objection to buying

#### 4. Core Message
- The single sentence this campaign comes back to
- Tone direction for this campaign (urgent / educational / inspirational / proof-driven)
- What NOT to say (off-brand angles for this campaign)

#### 5. Proof Points
- 2–3 specific stats, results, or testimonials to reference
- The strongest single proof point — the one that closes skeptics

#### 6. Content Direction
- Hook angles to test (3 different opening lines/hooks)
- Content formats for each platform
- Emotional arc: awareness → interest → desire → action
- CTAs at each stage

#### 7. Platform-Specific Instructions
For each active platform:

**Facebook:**
- Post frequency
- Format mix (text / image / video / carousel)
- Targeting notes (if running ads)
- Boosting budget recommendation

**TikTok:**
- Video length and style
- Hook structure (first 3 seconds)
- Trending sounds or formats to use
- Hashtag strategy

**Zalo:**
- Broadcast timing
- Message tone (more personal)
- ZNS or OA notes if applicable

**Email:**
- Sequence length
- Subject line direction
- Send timing

#### 8. Success Metrics
- Primary KPI (the one number that defines success)
- Secondary metrics to track
- What "good" looks like vs "needs adjustment"
- Review checkpoint: when to evaluate and optimize

### Step 4 — Write output

Save to `strategy/campaign-brief-[campaign-name]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Campaign Brief — [Campaign Name]
> Brand: [Brand Name] | Created: [date] | Status: Active

---

## 1. Campaign Overview
- **Name:** 
- **Goal:** 
- **Duration:** [start] → [end]
- **Budget:** 

---

## 2. The Offer
- **What:** 
- **Price:** 
- **Incentive:** 
- **Deadline:** 
- **Guarantee:** 

---

## 3. Target Audience
- **Segment:** 
- **Funnel stage:** Cold / Warm / Hot
- **Primary pain point:** 
- **Primary objection:** 

---

## 4. Core Message
- **Campaign headline:** 
- **One-sentence core message:** 
- **Tone:** 
- **Do NOT say:** 

---

## 5. Proof Points
- 
- 
- **Strongest single proof:** 

---

## 6. Content Direction

**3 Hook angles to test:**
1. 
2. 
3. 

**Emotional arc:**
- Awareness → [emotion/insight to trigger]
- Interest → [what makes them lean in]
- Desire → [what makes them want it]
- Action → [what removes final hesitation]

**CTAs by stage:**
- Cold audience: 
- Warm audience: 
- Hot audience: 

---

## 7. Platform Instructions

### Facebook
- Frequency: 
- Format mix: 
- Targeting: 
- Boost budget: 

### TikTok
- Video length: 
- Hook structure: 
- Hashtags: 

### Zalo
- Broadcast timing: 
- Tone: 

### Email
- Sequence: 
- Subject direction: 
- Send timing: 

---

## 8. Success Metrics
- **Primary KPI:** 
- **Secondary metrics:** 
- **Review checkpoint:** 
- **"Good" benchmark:** 
- **"Needs adjustment" signal:** 
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Campaign brief cho '[Campaign Name]' đã hoàn chỉnh.**

**Overview:**
- Goal: [goal]
- Duration: [dates]
- Core message: [one sentence]
- Primary platform: [platform]

📁 Đã lưu vào: `strategy/campaign-brief-[name]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chia sẻ file này với execution agents:
- `blog-writer` (`mkt-content`) — để viết bài blog theo brief này
- `social-copy` (`mkt-social`) — để viết caption Facebook/TikTok
- `email-sequence` (`mkt-growth`) — để viết chuỗi email"

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `strategy/campaign-brief-[campaign-name]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
