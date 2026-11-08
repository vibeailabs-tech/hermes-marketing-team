---
name: case-study-writer
description: Turns a customer result into a structured success story.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: content
    tags: [marketing, vietnam, content]
---

# Case Study Writer Skill

Your job is to write a structured customer success story — the kind that turns skeptical prospects into buyers. Not a testimonial. Not a vague "client achieved great results." A real before/after story with specific numbers, honest challenges, and a clear proof of outcome.

## When to Use

- A real (or clearly labeled composite) customer result should become a story.
- Owned by `mkt-content`; writes to `assets/content/case-studies/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/case-study-writer` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice (Section 5) — case study must sound like the brand, not corporate
- ICP and pain points (Section 6) — hero of the story should mirror the ICP
- Core offer (Section 9) — which package/service is featured
- Key messages (Section 11) — the case study should reinforce at least one key message
- USP and proof points (Section 8) — use the before/after transformation framework

If brand.md doesn't exist: ask user for brand info before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User provided client details**
Use their information. Go to Step 3.

**Path B — No client details provided**
Ask:
"Để viết case study, mình cần một số thông tin về khách hàng này:

1. Họ làm ngành gì? Quy mô doanh nghiệp?
2. Tình trạng trước khi dùng dịch vụ của bạn là gì?
3. Họ dùng package/service nào?
4. Kết quả cụ thể sau khi dùng là gì? (số liệu nếu có)
5. Có quote nào từ khách hàng không?
6. Mình có thể dùng tên thật không, hay dùng tên giả?"

Wait for answer before continuing.

**If no real client yet:** Offer to write a composite case study based on the ICP from brand.md — clearly labeled as "representative example" not a real client. This is honest and still useful for sales.

### Step 3 — Write the case study

#### Case study structure (SPSR framework)

**S — Situation (Tình huống)**
- Who is the client? (industry, size, role of decision-maker — match ICP from brand.md)
- What was their marketing situation before? (specific, not vague)
- What had they already tried that didn't work?
- What was the cost of the problem? (time, money, or emotional toll)

**P — Problem (Vấn đề)**
- The specific thing that was broken
- Why existing solutions hadn't solved it
- The moment they realized they needed something different

**S — Solution (Giải pháp)**
- Which package/service they chose and why
- How the setup process went (honest — including any challenges)
- What was built for them specifically
- Timeline from start to handover

**R — Result (Kết quả)**
- Specific, measurable outcomes (numbers preferred)
- Before vs after comparison
- Unexpected benefits they didn't anticipate
- Their own words (quote if available)

#### Writing rules for Vietnamese case studies
- Write in third person about the client, first person about the brand
- Avoid: "Sau khi sử dụng dịch vụ, khách hàng đã đạt được kết quả vượt trội" — too vague
- Use: "Tuần đầu tiên sau handover, Minh Tuấn tự chạy Research Agent và ra được competitor analysis hoàn chỉnh trong 20 phút — việc mà trước đó tốn cả ngày nếu tự làm."
- Honest about timeline: if it took 10 days not 7, say 10 days
- Include one moment of friction or challenge — makes the story credible
- End with the client's emotional state, not just the metric

#### Format options
- **Long form (800–1,200 words):** For website, blog, sales conversations
- **Short form (300–400 words):** For social proof section on landing page
- **One-page PDF format:** For sales calls — visual layout with sidebar stats

### Step 4 — Write output

Save to `assets/content/case-studies/[client-slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Case Study — [Client Name or Industry + Outcome]
> Published: [date] | Industry: [industry] | Package: [package used]

## The Quick Version
**Client:** [1-line description]
**Problem:** [1-line]
**Solution:** [package + key agents]
**Result:** [1-line with specific number]

---

## Situation
[Full situation section — 150–200 words]

## The Problem
[Full problem section — 150–200 words]

## The Solution
[Full solution section — 200–250 words]

## The Result
[Full result section — 150–200 words]

## In Their Words
> "[Client quote if available]"
> — [Name/title], [Company]

---

## Key Numbers
| Before | After |
|---|---|
| [metric] | [metric] |
| [metric] | [metric] |

---

## What Made the Difference
[1–2 sentences on the single most important factor in the outcome]

---
*[If composite: "This case study is based on a representative client in [industry]. Details have been generalized to protect privacy."]*
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Case study '[Title]' đã hoàn chỉnh.**

**Highlights:**
- Client: [industry/description]
- Key result: [primary outcome with number]
- Format: [long/short/PDF-ready]
- Quote included: [yes/no]

📁 Đã lưu vào: `assets/content/case-studies/[slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `sales-page` (`mkt-growth`) để embed case study này vào proof section, hoặc `social-copy` (`mkt-social`) để viết post Facebook/TikTok từ story này."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/content/case-studies/[client-slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
