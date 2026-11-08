---
name: newsletter
description: Writes one broadcast email for ongoing subscriber updates.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: email
    tags: [marketing, vietnam, email]
    related_skills: [subject-line-ab]
---

# Newsletter Skill

Your job is to write a single broadcast newsletter — educational, valuable, and with a natural CTA. Not a promotional blast. A newsletter people actually read.

## When to Use

- The client needs one broadcast email to their list.
- Owned by `mkt-growth`; writes to `assets/email/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/newsletter` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice and tone (Section 5)
- Target audience (Section 6)
- Content pillars (Section 12)
- Core offer (Section 9) — for the CTA

Check if `assets/content/` has recent blog posts or thought leadership — these can be repurposed or linked in the newsletter.

If brand.md doesn't exist: ask user for brand, audience, and newsletter topic before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User specified topic or content to include**
Use their direction. Go to Step 3.

**Path B — No direction**
Ask:
"Để viết newsletter, mình cần biết:
1. **Chủ đề số này:** Topic hoặc insight chính bạn muốn share với subscribers
2. **Có content gốc không?** Bài blog, case study, hay research nào bạn muốn link vào?
3. **CTA:** Bạn muốn reader làm gì sau khi đọc? (Book call / đọc bài full / reply email / xem sản phẩm)
4. **Tone số này:** Giáo dục / storytelling / behind-the-scenes / contrarian opinion?"

Wait for answer.

### Step 3 — Write the newsletter

#### Newsletter formats (choose based on content)

**Format 1 — The Insight Letter**
One idea, explored deeply. 300–500 words. Best for thought leadership brands.
Structure: Hook → The insight → Why it matters → One actionable takeaway → CTA

**Format 2 — The Curation Letter**
3–5 curated items (articles, tools, observations) + brief commentary on each. 250–400 words.
Structure: Intro (1 sentence) → 3–5 items with 2–3 sentence commentary each → CTA

**Format 3 — The Story Letter**
A story from behind the scenes, a client situation (anonymized), or a personal experience. 400–600 words.
Structure: Scene-setting opening → The conflict or tension → The lesson → Application to reader → CTA

**Format 4 — The Number Letter**
Lead with a surprising stat or data point, unpack it, connect to reader's situation. 300–450 words.
Structure: The number (bold) → Context → What most people miss → What this means for you → CTA

#### Vietnamese newsletter standards

**Subject line for newsletters (different from sequences):**
- Can be more personal/curious than sales emails
- Works well: "[số thứ tự] | [topic]" format (e.g., "#12 | Tại sao 86% doanh nghiệp dùng AI sai cách")
- Or direct value: "3 điều mình học được từ khách hàng tuần này"

**Opening:**
- For newsletters: can open with a personal observation or story — readers subscribed to hear *your* perspective
- Still keep it short: context in 2–3 sentences, then into the substance

**Length:**
- Vietnamese newsletter sweet spot: 300–500 words
- Mobile read time: 2–3 minutes max
- If longer: use headers to let skimmers navigate

**The "one thing" rule:**
Every newsletter should leave the reader with one thing they can think about or do differently. If there are 5 takeaways, pick the best one and cut the rest.

**CTA for newsletters:**
- Softer than sales emails: "Đọc full tại đây", "Reply và cho mình biết bạn nghĩ gì", "Book tư vấn nếu điều này relevant với bạn"
- Never: "MUA NGAY" in a newsletter — it breaks trust

#### Brand voice check:
- Does it sound like a person writing to another person?
- Would the reader feel this was written for them specifically?
- Is there one original insight — something they wouldn't get from a generic AI newsletter?

### Step 4 — Write output

Save to `assets/email/newsletter-[topic-slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Newsletter — [Title/Topic]
> Generated: [date] | Format: [format type] | Issue: #[n if known]

**Subject:** [subject line]
**Preview:** [preview text]
**Send date:** [recommended send day/time]

---

[Full newsletter content]

---

## Newsletter Notes
- Format used: [format name + why]
- CTA: [what action + where it goes]
- Repurpose opportunity: [can this become a LinkedIn post / Facebook post / blog section?]
```

### Step 5 — Confirm

After writing:

---
"✅ **Newsletter '[Topic]' hoàn chỉnh.**

**Format:** [format name]
**Subject:** [subject line]
**Word count:** ~[n] từ (~[x] phút đọc)
**CTA:** [CTA text]

📁 Đã lưu: `assets/email/newsletter-[topic-slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/subject-line-ab` để test subject line, hoặc `social-copy` (`mkt-social`) để atomize newsletter thành posts."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/email/newsletter-[topic-slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
