---
name: subject-line-ab
description: Generates subject line variants and an A/B test pair.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: email
    tags: [marketing, vietnam, email]
    related_skills: [newsletter]
---

# Subject Line A/B Skill

Your job is to write multiple subject line variants for a single email — with clear hypotheses about why each variant should win, and a framework to pick the winner.

## When to Use

- An email needs subject line variants and a test plan.
- Owned by `mkt-growth`; writes to `assets/email/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/subject-line-ab` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice and tone (Section 5) — subject lines must match brand personality
- Target audience (Section 6) — what language resonates with them

If brand.md doesn't exist: ask user for brand tone and audience before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User provided the email content or current subject line**
Use what they gave. Go to Step 3.

**Path B — No email content provided**
Ask:
"Để viết subject line variants, mình cần:
1. **Email này về gì?** (tóm tắt nội dung trong 1–2 câu)
2. **Subject line hiện tại** (nếu có — mình sẽ cải thiện)
3. **Mục tiêu email:** Open rate / Click rate / Reply rate
4. **Audience segment:** Cold list / warm subscribers / existing customers / re-engagement"

Wait for answer.

### Step 3 — Generate variants

#### The 6 subject line angles

For each email, write one variant per angle — then recommend the best 2 to test:

**Angle 1 — Curiosity gap**
Leave something unresolved that the reader needs to open to close.
Formula: "Tại sao [thing they assumed] không phải lý do thật" or "Điều mình không nói trong bài trước"
Risk: Can feel clickbaity if the email doesn't deliver. Only use if the content actually answers the gap.

**Angle 2 — Specificity**
Numbers, names, and specific situations outperform vague claims.
Formula: "[Specific number] + [specific outcome] + [specific timeframe]"
Example: "45 phút/tuần thay vì 3 giờ/ngày — đây là cách"

**Angle 3 — Direct benefit**
State the outcome plainly. Works best for warm audiences who trust the brand.
Formula: "Cách [achieve outcome] mà không cần [painful alternative]"

**Angle 4 — Question**
Mirrors the reader's internal dialogue. Opens a loop they want closed.
Formula: "[Question that surfaces their exact situation]"
Example: "Bạn có đang trả tiền để không sở hữu gì không?"

**Angle 5 — Contrarian / challenge**
Challenges a belief the reader holds. Creates friction that demands resolution.
Formula: "[Common belief] là sai — đây là lý do"
Risk: Only works if the content actually challenges, not just teases.

**Angle 6 — Personal / story**
Feels like a message from a person, not a brand.
Formula: "Mình vừa học được điều này từ [source]" or "Cuộc trò chuyện với [persona] tuần này"

#### Subject line rules (Vietnamese market)

**Length:**
- Mobile preview: 35–45 chars ideal, 50 max
- Gmail desktop: up to 60 chars visible
- Never truncate mid-word

**Emoji:**
- 1 emoji max, at start or end — never mid-subject
- Use only if it matches brand tone (casual/friendly brands: yes. Professional B2B: sparingly)
- Avoid: 🔥💥🚀 — overused, trigger spam filters

**Spam trigger words to avoid:**
- "Miễn phí", "Giảm giá X%", "Ưu đãi đặc biệt", "Chỉ hôm nay", "Click ngay"
- All caps words
- Multiple exclamation marks

**Preview text:**
- Not an afterthought — 50% of open decision is subject + preview together
- Never repeat the subject line
- Either: continue the curiosity → "...và đây là điều bạn chưa biết"
- Or: add context → "3 khách hàng của mình đã làm điều này tuần trước"

#### Recommend best 2 to test

After writing all 6 variants, identify:
- **Variant A (Control):** The safest, most on-brand option
- **Variant B (Test):** The riskier, higher-upside option

State hypothesis: "Mình dự đoán Variant B sẽ có open rate cao hơn vì [specific reason]. Nếu audience này [characteristic], Variant A có thể win."

**Winner condition:** Open rate difference > 5 percentage points after minimum 200 opens per variant.

### Step 4 — Write output

Save to `assets/email/subject-line-ab-[email-slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Subject Line A/B Test — [Email Name]
> Generated: [date] | Email: [email description]

## Email Summary
[1–2 sentence description of what the email contains]

---

## 6 Subject Line Variants

### Variant 1 — Curiosity Gap
**Subject:** [subject line]
**Preview:** [preview text]
**Hypothesis:** [why this should work]

### Variant 2 — Specificity
**Subject:**
**Preview:**
**Hypothesis:**

### Variant 3 — Direct Benefit
**Subject:**
**Preview:**
**Hypothesis:**

### Variant 4 — Question
**Subject:**
**Preview:**
**Hypothesis:**

### Variant 5 — Contrarian
**Subject:**
**Preview:**
**Hypothesis:**

### Variant 6 — Personal / Story
**Subject:**
**Preview:**
**Hypothesis:**

---

## Recommended Test

**Variant A (Control):** [Variant #] — [Subject line]
**Variant B (Test):** [Variant #] — [Subject line]

**Prediction:** [Which will win and why]
**Winner condition:** Open rate gap > 5pp after 200+ opens per variant
**Recommended send split:** 50/50 or 80/20 depending on list size

---

## Notes
- Spam risk assessment: [any flags in the variants]
- Best send time for this audience: [day + time]
```

### Step 5 — Confirm

After writing:

---
"✅ **Subject line variants cho '[Email]' hoàn chỉnh.**

**6 variants written across:** Curiosity / Specificity / Direct benefit / Question / Contrarian / Personal

**Recommended test:**
- A (Control): [subject]
- B (Test): [subject]
- Prediction: [one sentence]

📁 Đã lưu: `assets/email/subject-line-ab-[email-slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/newsletter` để viết email tiếp theo, hoặc `cro-ab-test` (`mkt-strategy`) để setup tracking cho test này."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/email/subject-line-ab-[email-slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
