---
name: lead-magnet
description: Designs opt-in offers that bridge to the paid offer.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: strategy
    tags: [marketing, vietnam, strategy]
    related_skills: [campaign-brief]
---

# Lead Magnet Skill

Your job is to design 3 lead magnet concepts that attract the exact right buyers — not tire-kickers — and move them toward the core offer. In Vietnam, the best lead magnets solve a specific, immediate problem and can be consumed quickly.

## When to Use

- The client needs a way to capture leads before the paid offer.
- Owned by `mkt-strategy`; writes to `strategy/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/lead-magnet` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read:
- `brand/brand.md` — ICP pain points (Section 6), core offer (Section 9), USP (Section 8), content pillars (Section 12)
- `research/keyword-research-*.md` — "People Also Ask" questions (if exists)
- `research/competitor-analysis-*.md` — what competitors are giving away (if exists)

If brand.md doesn't exist: stop and ask user to run `brand-setup` (`mkt-brand`) first.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User specified a type or topic**
Use their direction. Go to Step 3.

**Path B — No direction provided**
Ask:
"Bạn muốn lead magnet phục vụ mục đích gì?
1. Thu thập email/số điện thoại từ người lạ
2. Warm up khách hàng đang cân nhắc
3. Kích hoạt lại khách hàng cũ
4. Tất cả — đề xuất 3 loại khác nhau"

Wait for answer before continuing.

### Step 3 — Design 3 lead magnet concepts

#### Lead magnet principles for Vietnam market

**What works:**
- Solves ONE specific, named pain point (not "improve your marketing")
- Immediately actionable — consumer can use it today
- Quick to consume — checklist, template, calculator, short guide (not 50-page ebook)
- Creates "aha" moment that makes the paid offer feel obvious
- Vietnamese language, with specific numbers and examples
- Delivery via Zalo or email (not gated PDF nobody downloads)

**What doesn't work:**
- Generic "ultimate guide to X" — too broad, no urgency
- Anything requiring too much setup before seeing value
- Content that competes with what they can Google in 30 seconds
- Ebooks longer than 10 pages

#### Lead magnet formats ranked by conversion rate (Vietnam context):
1. **Calculator / quiz** — interactive, personalized result ("Chi phí thật của bạn là...")
2. **Checklist** — quick scan, immediate value ("10 điều cần check trước khi...")
3. **Template** — copy-paste ready ("Template [X] cho doanh nghiệp Việt Nam")
4. **Mini video / screen-record** — show don't tell (demo, walkthrough, behind-the-scenes)
5. **Cheat sheet** — condensed reference ("Tất cả bạn cần biết về X trong 1 trang")
6. **Free consultation / audit** — highest intent, lowest volume (for high-ticket offers)
7. **Case study / result breakdown** — proof + education combined

#### For each of the 3 concepts, define:

**Concept structure:**
- **Name** — specific, benefit-driven title (not "Free Guide")
- **Format** — checklist / calculator / template / video / consultation
- **Specific problem it solves** — one sentence, exact language the ICP uses
- **What's inside** — 3–5 bullet points of what they get
- **The "aha" moment** — what insight makes them think "I need the paid offer"
- **Delivery method** — Zalo / email / direct download / Facebook Messenger
- **CTA to paid offer** — how it naturally leads to the next step
- **Estimated conversion** — how qualified are the leads this attracts?

#### Lead magnet ladder:
Design the 3 concepts at different funnel stages:
- **Concept 1 — Top of funnel** (broad audience, low commitment, high volume)
- **Concept 2 — Middle of funnel** (problem-aware, moderate commitment, qualified)
- **Concept 3 — Bottom of funnel** (solution-aware, high commitment, highest intent)

### Step 4 — Write output

Save to `strategy/lead-magnets-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Lead Magnet Concepts — [Brand Name]
> Generated: [date]

## Concept 1 — [Name] (Top of Funnel)
**Format:** 
**Problem solved:** 
**What's inside:**
- 
- 
- 
**The "aha" moment:** 
**Delivery:** 
**CTA to paid offer:** 
**Estimated lead quality:** Low-medium (volume play)

---

## Concept 2 — [Name] (Middle of Funnel)
**Format:** 
**Problem solved:** 
**What's inside:**
- 
- 
- 
**The "aha" moment:** 
**Delivery:** 
**CTA to paid offer:** 
**Estimated lead quality:** Medium-high (intent qualified)

---

## Concept 3 — [Name] (Bottom of Funnel)
**Format:** 
**Problem solved:** 
**What's inside:**
- 
- 
- 
**The "aha" moment:** 
**Delivery:** 
**CTA to paid offer:** 
**Estimated lead quality:** High (ready to buy)

---

## Recommended First Build
[Which of the 3 to build first and why — based on current stage, audience size, and fastest path to revenue]

## Promotion Plan
[How to get the lead magnet in front of the right people — organic posts, paid ads, Zalo broadcast, etc.]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **3 lead magnet concepts cho [Brand Name] đã hoàn chỉnh.**

**Đề xuất build trước:**
- [Concept name] — [format] — [why this one first]

**Tóm tắt 3 concepts:**
1. [Name] — [one line description]
2. [Name] — [one line description]
3. [Name] — [one line description]

📁 Đã lưu vào: `strategy/lead-magnets-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/campaign-brief` để đóng gói toàn bộ strategy thành brief cho execution agents."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `strategy/lead-magnets-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
