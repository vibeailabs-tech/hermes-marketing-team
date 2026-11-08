---
name: email-sequence
description: Writes welcome, nurture and conversion email flows.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: email
    tags: [marketing, vietnam, email]
    related_skills: [newsletter, subject-line-ab]
---

# Email Sequence Skill

Your job is to write a complete email nurture sequence — from first contact to conversion. Every email has one job. No filler emails.

## When to Use

- The client needs a welcome, nurture, sales or onboarding email flow.
- Owned by `mkt-growth`; writes to `assets/email/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/email-sequence` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice and tone (Section 5) — every email must sound like this brand
- Target audience and pain points (Section 6)
- Core offer and pricing (Section 9)
- Key messages (Section 11)
- USP (Section 8)

Check if `strategy/campaign-brief-*.md` exists — if so, align sequence to campaign goal.

If brand.md doesn't exist: ask user for brand name, offer, audience, and tone before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User specified sequence type and goal**
Use their direction. Go to Step 3.

**Path B — No direction provided**
Ask:
"Để viết email sequence, mình cần biết:
1. **Loại sequence:** Welcome / Lead nurture / Post-purchase onboarding / Sales / Re-engagement
2. **Trigger:** Người đăng ký nhận được email này sau khi làm gì? (đăng ký form, download lead magnet, mua hàng...)
3. **Mục tiêu cuối:** Conversion mong muốn là gì? (book call, mua sản phẩm, upgrade, để lại review...)
4. **Số email:** 3 / 5 / 7 emails?
5. **Khoảng cách:** Gửi hàng ngày, cách 2 ngày, hay theo trigger?"

Wait for answer.

### Step 3 — Write the sequence

#### Email sequence principles

**One email = one job**
Each email does exactly one thing: introduce, educate, overcome an objection, share proof, or ask for the sale. Never combine jobs.

**The job order for a 5-email sales sequence:**
1. Welcome + set expectations (what's coming, why it matters)
2. Educate on the problem (make them feel understood)
3. Introduce the solution (not the pitch — the concept)
4. Social proof (case study, testimonial, specific result)
5. The offer (clear ask, urgency if real, risk-reversal)

**For a 7-email sequence:** add objection handling (email 5) and a soft follow-up (email 7 = "last chance" or value recap).

#### Vietnamese email writing rules

**Subject lines:**
- 35–50 characters (mobile preview)
- Curiosity or specificity — not both
- No ALL CAPS, no excessive punctuation
- Test: would you open this if you didn't write it?

**Preview text (50–90 chars):**
- Continues the subject line, doesn't repeat it
- Completes the curiosity gap or adds context

**Opening line:**
- Never start with "Chào [Tên]," on its own — add immediate value in the same sentence or next line
- First line = reason to keep reading
- Mirror their situation: "Nếu bạn đang [pain point]..."

**Body:**
- Short paragraphs: 1–3 sentences
- One bold key sentence per email (the thing you want them to remember)
- No walls of text — Vietnamese mobile readers scroll fast
- Conversational, not corporate: "bạn/mình", not "quý khách"

**CTA:**
- One CTA per email — never two
- Specific and action-oriented: "Book 30 phút miễn phí" not "Liên hệ với chúng tôi"
- CTA as a text link or button — not buried in a paragraph

**Timing (Vietnamese market):**
- Best open times: Tuesday–Thursday, 8–9am or 7–9pm
- Avoid Monday morning and Friday afternoon
- If using Zalo broadcast: same timing applies

#### Sequence structure per email:

```
Subject: [35–50 chars]
Preview: [50–90 chars]

[Opening — 1–2 sentences, immediate value or mirror]

[Body — 3–5 short paragraphs, one idea each]

[Transition sentence leading to CTA]

[CTA — one, clear, specific]

[Sign-off]
[P.S. — optional, adds one more hook or addresses an objection]
```

### Step 4 — Write output

Save to `assets/email/email-sequence-[name]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Email Sequence — [Sequence Name]
> Generated: [date] | Type: [sequence type] | Emails: [n] | Goal: [conversion goal]

## Sequence Overview
- Trigger: [what starts this sequence]
- Goal: [desired end action]
- Cadence: [timing between emails]
- Total length: [n] emails over [x] days

---

## Email 1 — [Job: e.g., Welcome]
**Send:** Immediately after trigger
**Subject:** [subject line]
**Preview:** [preview text]

---

[Email body]

---

## Email 2 — [Job]
**Send:** Day [n]
**Subject:**
**Preview:**

---

[Email body]

---

[Repeat for all emails]

---

## Sequence Notes
- A/B test opportunities: [which subjects or CTAs to test]
- Personalization tokens: [first name, company name, etc.]
- Segmentation: [if applicable — who gets which version]
```

### Step 5 — Confirm

After writing:

---
"✅ **Email sequence '[Name]' hoàn chỉnh.**

**Sequence stats:**
- [n] emails over [x] days
- Goal: [conversion goal]
- Trigger: [trigger event]

**Subjects:**
1. [Email 1 subject]
2. [Email 2 subject]
...

📁 Đã lưu: `assets/email/email-sequence-[name]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/subject-line-ab` để test subject lines, hoặc `/newsletter` để viết broadcast email cho list hiện có."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/email/email-sequence-[name]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
