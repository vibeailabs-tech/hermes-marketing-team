---
name: website-copy
description: Writes homepage, about, service and product page copy.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: content
    tags: [marketing, vietnam, content]
---

# Website Copy Skill

Your job is to write complete, conversion-ready website copy — homepage, about page, services page, or any other page. Every word earns its place. Visitor lands, reads, understands, and acts.

## When to Use

- Homepage, about, service or product page copy is needed.
- Owned by `mkt-content`; writes to `assets/content/website/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/website-copy` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice and tone (Section 5)
- ICP and pain points (Section 6)
- Positioning and core promise (Section 7)
- USP and transformation (Section 8)
- Core offer and packages (Section 9)
- Key messages (Section 11)

If `assets/cro/landing-page.md` or `assets/cro/sales-page.md` exist: read them — avoid duplicating copy, ensure consistent messaging across pages.

If brand.md doesn't exist: ask user for brand info before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User specified which page**
Use their direction. Go to Step 3.

**Path B — No direction provided**
Ask:
"Bạn muốn mình viết copy cho trang nào?
1. Homepage (trang chủ)
2. About / Story page (trang giới thiệu)
3. Services / Packages page (trang dịch vụ)
4. Contact page
5. Tất cả"

Wait for answer before continuing.

### Step 3 — Write the page copy

#### Homepage structure

**Hero section**
- Headline: what you do + for whom + outcome. One sentence. Specific.
- Subheadline: expand — how it works and why it's different. 2 sentences max.
- Primary CTA: one action, benefit-framed
- Secondary CTA (optional): lower commitment option ("Xem demo")
- Social proof line: one stat or trust signal below CTA

**Problem section**
- "Nếu bạn đang..." — mirror the ICP's current situation
- 3 pain points in the reader's own language (from brand.md Section 6)
- Cost of inaction: one sentence on what happens if nothing changes

**Solution section**
- Transition: "Có một cách khác"
- What it is (outcome-first, not feature-first)
- How it works: 3-step process (simple, visual)
- Outcome: what their business/life looks like after

**Social proof bar**
- 1–2 stats, 1 client result, 1 guarantee teaser
- If no clients yet: market data + demo availability

**Services / Packages preview**
- 3-tier overview with names, one-line descriptions, prices
- Link to full services page
- Recommended package highlighted

**About / Credibility section**
- Why this brand exists (founder story in 3–4 sentences)
- What makes the methodology different
- One specific proof point or credential

**Final CTA section**
- Restate core promise
- Primary CTA
- Risk removal: guarantee or zero-commitment signal

---

#### About page structure

**Opening: Why this exists**
Not "We are a company that..." — Start with the problem the founder saw and couldn't ignore.
"Mình build [Brand] vì [specific reason — personal story, not mission statement]."

**The story**
- Before: what was wrong / what the founder saw
- Turning point: the realization or moment that changed direction
- After: what was built and why it works differently

**The methodology**
- What makes the approach unique (the mechanism from brand.md Section 8)
- Why competitors do it differently (without being negative)
- What the brand genuinely believes about the market

**Who it's for**
- Specific description of the right client (ICP from brand.md)
- Who it's NOT for (honest — builds trust)

**CTA**
"Nếu bạn là [ICP description], [CTA to consultation]"

---

#### Services page structure

**Page headline:** Outcome-focused, not "Dịch vụ của chúng tôi"

**Each package:**
- Package name (outcome-driven)
- Who it's for: one sentence
- What's included: bullet list (deliverables, not features)
- Outcome: what they have after
- Timeline
- Price + installment option
- CTA: package-specific keyword trigger

**Comparison table:** Side-by-side all packages
**Guarantee section:** Full guarantee statement
**FAQ:** 5–6 objection-handling questions

---

#### Copy rules for all pages
- Vietnamese: "bạn/mình" throughout — not "quý khách"
- No corporate speak: "đội ngũ chuyên nghiệp", "giải pháp toàn diện" — forbidden
- Specific numbers everywhere: prices, timelines, agent counts
- Short sentences for mobile: 15–20 words max per sentence
- One CTA per section — no competing actions

### Step 4 — Write output

Save to `assets/content/website/[page-name]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Website Copy — [Page Name]
> Generated: [date] | Page: [homepage/about/services/contact]

---

## [Section name]

[Full copy for this section]

---

## [Next section]

[Full copy]

---

## Page Notes
- Recommended layout: [description]
- Images/visuals needed: [list]
- A/B test suggestions: [2 elements to test]
- SEO: Title tag + meta description included below

## SEO
**Title tag:** [60 chars max]
**Meta description:** [150–160 chars]
**Primary keyword:** [keyword]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Website copy cho [page name] đã hoàn chỉnh.**

**Pages written:** [list]
**Total sections:** [count]
**Primary CTA:** [CTA text]

📁 Đã lưu vào: `assets/content/website/[page]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `page-audit` (`mkt-strategy`) để score trang vừa viết, hoặc `lp-builder` (`mkt-strategy`) nếu bạn cần landing page riêng cho campaign."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/content/website/[page-name]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
