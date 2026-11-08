---
name: messaging-refinement
description: Rewrites key messages based on what actually converted.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: feedback
    tags: [marketing, vietnam, feedback]
    related_skills: [positioning-evolution]
---

# Messaging Refinement Skill

Your job is to update the brand's key messages and USP based on what's actually resonating with customers. Messaging that was written before launch was a hypothesis. What people click on, respond to, and buy from is the truth. This skill updates the hypothesis with reality.

## When to Use

- Results show which messages resonated and the key messages should change.
- Owned by `mkt-brand`; writes `brand/brand.md`.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/messaging-refinement` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read ALL of the following:
- `brand/brand.md` — current Section 8 (USP) and Section 11 (Key Messages)
- `performance/monthly-review-*.md` — what messaging resonated vs. flopped
- `performance/campaign-report-*.md` — which ad copy, headlines, CTAs performed
- `assets/social/` — top performing social posts
- `assets/email/` — best performing subject lines and email bodies
- `assets/ads/` — best performing ad copy

If no performance data exists: ask user which messages have gotten the strongest response from customers before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User provided messaging feedback or performance data**
Use their input. Go to Step 3.

**Path B — No input provided**
Ask:
"Để refine messaging, mình cần biết:
1. **Top performing:** Content, ad, hay email nào có CTR / engagement / conversion cao nhất?
2. **Resonating phrases:** Câu nói nào khiến khách hàng nói 'đúng rồi, đó chính xác là vấn đề của tôi'?
3. **Flopped messages:** Angle nào hoàn toàn không có phản hồi?
4. **Customer language:** Khách hàng dùng từ gì để mô tả vấn đề của họ? (exact words, not your words)
5. **Objections that messaging didn't overcome:** Khách hàng vẫn nói gì dù đã xem marketing của bạn?"

Wait for answer before continuing.

### Step 3 — Analyze and refine

#### Messaging analysis framework

**What resonated (high CTR, engagement, conversions):**
- What angle was used? (pain / proof / fear / desire / contrarian)
- What exact language was used?
- Was it specific or vague? (specific almost always beats vague)
- What emotion did it trigger?

**What flopped (low CTR, no engagement, no conversion):**
- Was the message too generic?
- Was it solving the wrong pain?
- Was it too early in the funnel for a conversion message?
- Was the language too formal / informal for the audience?

**Customer language mining:**
The most valuable source of messaging data is the exact words customers use. From sales calls, comments, Zalo messages, reviews:
- What words do they use to describe their problem?
- What do they say they want?
- What do they say they're afraid of?
Incorporate this language directly into key messages — don't translate it.

#### Messaging refinement rules

**Rule 1 — Specific beats vague, always**
"Giảm 3 giờ mỗi ngày" beats "tiết kiệm thời gian"
"80% khách hàng thấy kết quả trong 30 ngày" beats "kết quả nhanh chóng"

**Rule 2 — Customer language beats your language**
If customers say "mình không biết bắt đầu từ đâu", your message should say "không biết bắt đầu từ đâu" — not "thiếu lộ trình marketing rõ ràng"

**Rule 3 — Pain before solution**
Messages that name the problem before offering the solution consistently outperform solution-first messages for cold audiences.

**Rule 4 — Proof in the headline, not the footnote**
Social proof embedded in headlines converts better than social proof buried in body copy.

#### What to update in brand.md

**Section 8 — USP:**
- Is the unique mechanism still the right frame?
- Is the transformation promise (before/after) matching what customers actually experience?
- Are the proof points the strongest available? (update with new case study data)

**Section 11 — Key Messages:**
- Remove messages that consistently underperformed
- Add messages that proved effective in the field
- Update the language to match what customers actually say
- Reorder — put highest-converting messages first

### Step 4 — Write updates

Update `brand/brand.md`:
- Section 8 (USP) — update mechanism name, transformation promise, proof points
- Section 11 (Key Messages) — update, reorder, and refine all 3 messages
- Update `Last updated` date

Also save a change log to `performance/messaging-refinement-[YYYY-MM].md`:

```markdown
# Messaging Refinement Log — [Month YYYY]
> Generated: [date] | Based on: [data sources]

## Performance Data Summary
**Top performing message/angle:** [Description + metric]
**Lowest performing message/angle:** [Description + metric]

---

## USP Updates

### Before
[Previous USP text]

### After
[Updated USP text]

### Why changed
[Data or customer feedback that drove this change]

---

## Key Messages — Before vs. After

### Message 1
**Before:** [Previous message]
**After:** [Updated message]
**Why:** [What data supported this change]

### Message 2
[Same structure]

### Message 3
[Same structure]

---

## New Language Discovered (Customer Voice)
Exact phrases from customers to use in future messaging:
- "[Exact customer phrase]" — source: [sales call / comment / review]
- "[Exact customer phrase]"
- "[Exact customer phrase]"

---

## Messages to Retire
- [Message that consistently underperformed] — reason: [why it didn't work]

---

## Hypotheses to Test Next Month
Messages that showed partial signal and should be A/B tested:
1. [Message hypothesis]
2. [Message hypothesis]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Key messages đã được cập nhật dựa trên performance data.**

**Thay đổi chính:**
- USP: [What changed]
- Message 1: [New version]
- Retired: [Message removed]
- Customer language added: [Examples]

📁 brand.md Section 8 + 11 đã cập nhật
📁 Change log lưu tại: `performance/messaging-refinement-[YYYY-MM].md`

**Bước tiếp theo:** Chạy `/positioning-evolution` để xem xét liệu positioning có cần update không, hoặc push messaging mới vào content calendar."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Change `brand/brand.md` only on evidence (patterns over 60-90 days). Flag major pivots and get confirmation before writing; never change Section 5 (voice) unless the client asks.
- Log every brand.md change in `brand/changelog.md`: date, section, what changed, which data drove it.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `brand/brand.md` reflects the evidence-backed changes and `brand/changelog.md` has a matching entry.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
