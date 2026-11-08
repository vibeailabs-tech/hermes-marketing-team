---
name: cta-optimization
description: Rewrites CTAs to match intent and funnel stage.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: cro
    tags: [marketing, vietnam, cro]
    related_skills: [cro-ab-test]
---

# CTA Optimization Skill

Your job is to rewrite weak, generic CTAs into high-converting calls-to-action — grounded in psychology, intent matching, and the brand's specific offer. Every CTA must earn a click.

## When to Use

- Existing CTAs underperform or don't match the visitor's intent.
- Owned by `mkt-strategy`; writes to `assets/cro/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/cta-optimization` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice (Section 5) — CTAs must match the brand's tone
- Target audience and buying hesitations (Section 6)
- Core offer and packages (Section 9)
- Key messages (Section 11)

If a campaign brief exists at `strategy/campaign-brief-*.md`: read it for campaign-specific CTAs.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User provided existing CTAs to optimize**
Use those CTAs. Go to Step 3.

**Path B — No CTAs provided**
Ask:
"Bạn muốn mình tối ưu CTA ở đâu?
1. Landing page / sales page
2. Facebook / TikTok posts
3. Email subject lines và CTAs
4. Zalo messages
5. Tất cả

Và paste các CTA hiện tại nếu có — mình sẽ rewrite từng cái."

Wait for answer before continuing.

### Step 3 — Audit existing CTAs

For each CTA provided, score it on:

**Problem 1 — Too vague**
"Tìm hiểu thêm", "Liên hệ ngay", "Click here" — these say nothing about what happens next or why the reader should act.
Fix: Name the specific action AND the specific reward.

**Problem 2 — Brand-centric, not reader-centric**
"Mua ngay", "Đăng ký" — these ask for what the brand wants.
Fix: Frame around what the reader gets ("Nhận tư vấn miễn phí 30 phút").

**Problem 3 — No urgency or scarcity**
CTAs with no reason to act NOW get scrolled past.
Fix: Add a real constraint (deadline, limited slots, bonus expiry) — only if true.

**Problem 4 — No risk removal**
Vietnamese buyers hesitate. A CTA that removes risk converts better.
Fix: Add a micro-guarantee or zero-commitment signal ("Miễn phí · Không ràng buộc").

**Problem 5 — Wrong intent match**
Cold audience CTA ≠ hot audience CTA. "Book now" on a cold post kills trust.
Fix: Match CTA intensity to funnel stage.

#### CTA intent ladder:
- **Cold (awareness):** "Save để đọc lại" / "Comment nếu bạn thấy đúng" / "Follow để xem thêm"
- **Warm (consideration):** "Nhắn mình để tư vấn miễn phí" / "Comment 'CHECKLIST' để nhận"
- **Hot (decision):** "Nhắn 'BOOK' để giữ slot — còn [X] chỗ" / "Đặt lịch hôm nay — deadline [date]"

### Step 4 — Rewrite CTAs

For each CTA, produce:
1. **Original:** [the weak CTA]
2. **Problem:** [what's wrong with it — one line]
3. **Rewritten (3 variants):**
   - Variant A — urgency angle
   - Variant B — benefit angle
   - Variant C — risk-removal angle
4. **Recommended:** [which variant to use and why]

#### High-converting CTA formulas for Vietnamese market:

**Formula 1 — Action + Reward**
"[Verb] + [specific thing they get]"
Example: "Nhắn mình để nhận tư vấn miễn phí 30 phút"

**Formula 2 — Action + Scarcity**
"[Verb] + [what they get] + [reason to act now]"
Example: "Nhắn 'BOOK' để giữ slot — chỉ còn 3 chỗ tháng 5"

**Formula 3 — Action + Risk removal**
"[Verb] + [what they get] + [zero risk signal]"
Example: "Book tư vấn miễn phí — không ràng buộc, không chào mời nếu không phù hợp"

**Formula 4 — Keyword trigger**
"Comment/Nhắn '[KEYWORD]' để nhận [thing]"
Example: "Nhắn 'CHECKLIST' để nhận PDF miễn phí"
This works because it filters for intent — only people who want it will act.

**Formula 5 — Contrast CTA**
"[What they're doing now] vs [what they could have] — [action]"
Example: "Đang trả agency $800/tháng? Nhắn mình — mình tính ROI cho bạn trong 10 phút."

### Step 5 — Write output

Save to `assets/cro/cta-optimization.md`:

```markdown
# CTA Optimization — [Brand Name]
> Generated: [date] | Platform: [platforms covered]

## CTA Audit Results

### [Platform / Page name]

**CTA #1**
- Original: "[original CTA]"
- Problem: [one-line diagnosis]
- Rewritten:
  - A (urgency): "[variant A]"
  - B (benefit): "[variant B]"
  - C (risk-removal): "[variant C]"
- Recommended: [A/B/C] — [reason]

[Repeat for each CTA]

---

## CTA Library — Ready to Use

### Cold audience CTAs (awareness stage)
- [CTA 1]
- [CTA 2]
- [CTA 3]

### Warm audience CTAs (consideration stage)
- [CTA 1]
- [CTA 2]
- [CTA 3]

### Hot audience CTAs (decision stage)
- [CTA 1]
- [CTA 2]
- [CTA 3]

---

## Platform-Specific Notes
- Facebook: [specific guidance]
- TikTok: [specific guidance]
- Zalo: [specific guidance]
- Email: [specific guidance]
```

### Step 6 — Confirm

After writing, reply:

---
"✅ **CTA optimization cho [Brand Name] đã hoàn chỉnh.**

**Tóm tắt:**
- CTAs đã audit: [count]
- Vấn đề phổ biến nhất: [issue]
- CTA mạnh nhất: "[top recommended CTA]"

📁 Đã lưu vào: `assets/cro/cta-optimization.md`

**Bước tiếp theo:** Chạy `/cro-ab-test` để setup A/B test cho các CTAs vừa viết."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/cro/cta-optimization.md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
