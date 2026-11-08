---
name: lp-builder
description: Writes full landing page copy from hero to final CTA.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: cro
    tags: [marketing, vietnam, cro]
    related_skills: [cro-ab-test, cta-optimization]
---

# Landing Page Builder Skill

Your job is to write a complete, conversion-optimized landing page for this brand — every section, every word, ready to publish. Not a template. Not a framework. Actual copy that converts.

## When to Use

- A landing page needs full copy for a campaign or offer.
- Owned by `mkt-strategy`; writes to `assets/cro/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/lp-builder` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice and tone (Section 5)
- Target audience and pain points (Section 6)
- Core offer and packages (Section 9)
- Positioning and core promise (Section 7)
- USP and proof points (Section 8)
- Key messages (Section 11)

If `strategy/campaign-brief-*.md` exists: read it too — use the campaign's specific offer, hooks, and CTAs.

If brand.md doesn't exist: stop and ask user to run `brand-setup` (`mkt-brand`) first.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User specified the page goal**
Use their direction. Go to Step 3.

**Path B — No direction provided**
Ask:
"Trang landing page này phục vụ mục tiêu nào?
1. Thu lead (book tư vấn / đăng ký nhận thông tin)
2. Bán trực tiếp (khách đọc xong mua luôn)
3. Webinar / event registration
4. Free resource download (lead magnet)

Và offer cụ thể là gì? (ví dụ: Growth Package $700, free consultation, webinar ngày X)"

Wait for answer before continuing.

### Step 3 — Build the landing page

#### Landing page structure (7 sections — use all of them)

**Section 1 — Hero**
- Headline: bold claim + specific outcome. Must answer "what do I get and why should I care?" in one sentence.
- Subheadline: expand on the headline with 1 sentence of supporting detail
- Hero CTA: one button, action-oriented ("Nhắn BOOK để giữ slot" not "Tìm hiểu thêm")
- Trust signal under CTA: social proof or guarantee in one line ("5 slots tháng 5 · Cam kết tự chạy được hoặc làm lại miễn phí")

**Section 2 — Problem (Agitate the pain)**
- Open with: "Nếu bạn đang..." — describe their current situation in their own words
- List 3–4 specific pain points (use language from brand.md Section 6)
- End with: the cost of inaction — what happens if they don't solve this

**Section 3 — Solution (Introduce the offer)**
- Transition: "Có một cách khác..."
- Explain WHAT it is in plain language (not features — what changes for them)
- The mechanism: HOW it works in 3 simple steps
- Outcome: what their life/business looks like after

**Section 4 — Proof**
- Social proof: testimonials, case studies, or before/after results
- Market data: relevant stats that validate the problem and solution
- Credibility: guarantee statement (specific and measurable)
- If no testimonials yet: use market data + demo description + guarantee as proof

**Section 5 — Packages / Offer**
- Present all tiers clearly (use pricing from brand.md Section 9)
- Each tier: name, who it's for, what's included, price, CTA
- Highlight the recommended package ("Most Popular" / "⭐")
- Installment option if available
- Deadline / scarcity if real

**Section 6 — FAQ**
- 6–8 questions that address the top objections from brand.md
- Use the exact objections from Section 6 (buying hesitations) and Section 10 (competitor comparison)
- Each answer: direct, honest, specific. No corporate speak.

**Section 7 — Final CTA**
- Restate the core promise in one line
- One clear CTA button
- Remove all risk: restate guarantee
- Deadline reminder if applicable

#### Copy rules
- Write in the brand's voice from brand.md Section 5
- Vietnamese: use "bạn/mình" register — warm but direct
- Lead every section with the reader's perspective, not the brand's
- Use specific numbers everywhere: prices, timelines, agent counts, hours saved
- No: "giải pháp toàn diện", "đội ngũ chuyên nghiệp", "tăng trưởng mạnh mẽ"
- Yes: "$700 một lần", "16 agents", "3–5 ngày", "tự chạy được hoặc làm lại miễn phí"

### Step 4 — Write output

Save to `assets/cro/landing-page.md`:

```markdown
# Landing Page — [Brand Name]
> Generated: [date] | Offer: [offer name] | Goal: [lead gen / direct sale]

---

## HERO
**Headline:** [headline]
**Subheadline:** [subheadline]
**CTA Button:** [CTA text]
**Trust signal:** [one line below CTA]

---

## PROBLEM
[Full section copy]

---

## SOLUTION
[Full section copy — what it is + 3-step how it works + outcome]

---

## PROOF
[Testimonials / stats / guarantee]

---

## PACKAGES
[Full pricing section with all tiers]

---

## FAQ
**Q: [question]**
A: [answer]
[Repeat for 6–8 questions]

---

## FINAL CTA
[Full final section copy]

---

## Page Notes
- Recommended hero image/visual: [description]
- A/B test suggestions: [2–3 elements worth testing]
- Mobile considerations: [any copy adjustments for mobile]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Landing page cho [Brand Name] đã hoàn chỉnh.**

**Cấu trúc:**
- Hero: [headline preview]
- Offer: [package names]
- FAQ: [count] câu hỏi
- CTA chính: [CTA text]

📁 Đã lưu vào: `assets/cro/landing-page.md`

**Bước tiếp theo:** Chạy `/cta-optimization` để tối ưu từng CTA trên trang, hoặc `/cro-ab-test` để setup A/B test cho headline và CTA."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/cro/landing-page.md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
