---
name: blog-writer
description: Writes a publish-ready SEO blog post in brand voice.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: content
    tags: [marketing, vietnam, content]
    related_skills: [thought-leadership]
---

# Blog Writer Skill

Your job is to write a complete, publish-ready blog post — SEO-optimized, brand-voice-accurate, and genuinely useful to the reader. Not a draft. Not an outline. A finished post.

## When to Use

- The user wants a finished blog post on a topic or from an existing brief.
- Owned by `mkt-content`; writes to `assets/content/blog/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/blog-writer` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice and tone (Section 5) — every sentence must sound like this brand
- Target audience (Section 6) — write for this specific person
- Key messages (Section 11) — weave these in naturally
- Content pillars (Section 12) — confirm this post fits a pillar

If a content brief exists at `assets/content/briefs/`: read the relevant brief first — follow its structure, keyword, and key argument exactly.

If `research/keyword-research-*.md` exists: check keyword difficulty and PAA questions to use as H2s.

If brand.md doesn't exist: ask user for brand info before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — Brief exists or user provided topic + keyword**
Use the brief or their input. Go to Step 3.

**Path B — No direction provided**
Ask:
"Bài blog này về topic gì?
- Topic / keyword cụ thể?
- Độ dài mong muốn? (800 / 1,200 / 2,000 từ)
- Tiếng Việt hay tiếng Anh?
- Mục tiêu: SEO / build trust / convert leads?"

Wait for answer before continuing.

### Step 3 — Write the blog post

#### Blog post structure

**Opening hook (100–150 words)**
First sentence must earn the second. Options:
- Bold claim that challenges a common belief
- Specific story or scenario the reader recognizes themselves in
- Surprising stat with immediate context
- Direct question that surfaces their exact problem

Do NOT open with: "Trong bài viết này, mình sẽ...". Do NOT summarize what you're about to say. Start in the middle of the idea.

**Body sections (H2s)**
- 4–6 H2 sections, each making one clear point
- Each H2 subheading: specific and descriptive (not "Introduction", "Why It Matters")
- Each section: 150–300 words, one argument, one piece of evidence or example
- Use H3s for sub-points when a section has multiple components
- Transition between sections — each one leads naturally to the next

**The key argument**
Every section supports one central argument. If a paragraph doesn't serve that argument, cut it.

**Conclusion (100–150 words)**
- Restate the key argument (different words, same idea)
- One specific, actionable takeaway the reader can use today
- CTA: natural, not jarring — flows from the content

#### Vietnamese blog writing rules
- Register: "bạn/mình" — same as brand voice
- Sentence length: mix short (impact) with medium (explanation). Avoid long compound sentences.
- Numbers: always use specific numbers — "$700", "16 agents", "3–5 ngày", not "một số" or "nhiều"
- Paragraphs: 2–4 sentences max. White space is not waste — it's readability.
- Examples: always Vietnamese context — Vietnamese businesses, Vietnamese market data, Vietnamese buyer behavior

#### SEO requirements
- Primary keyword in: H1 title, first 100 words, at least 2 H2 subheadings, meta description
- Secondary keywords: used naturally in body, not forced
- Meta description: 150–160 characters, includes primary keyword + clear benefit
- Internal links: 2–3 links to relevant brand pages or other content
- Image alt text suggestions: describe what image would accompany each section

#### Brand voice enforcement
Before finalizing, check every paragraph against brand.md Section 5:
- ✓ Uses "bạn/mình" register
- ✓ Leads with specific numbers, not vague claims
- ✗ No forbidden vocabulary ("giải pháp toàn diện", "đội ngũ chuyên nghiệp")
- ✗ No overpromise of AI ("tự động 100%", "AI làm tất cả")
- ✓ Ends with one clear, specific CTA

### Step 4 — Write output

Save to `assets/content/blog/[slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# [Full Title with Primary Keyword]
> Published: [date] | Word count: [count] | Keyword: [keyword] | Pillar: [content pillar]

**Meta description:** [150–160 chars]

---

[Full blog post content]

---

## Internal Link Suggestions
- [Page/post to link to] — anchor: "[anchor text]"

## Image Suggestions
- Hero: [description]
- Section [X]: [description]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Blog post '[Title]' đã hoàn chỉnh.**

**Stats:**
- Word count: ~[count] từ
- Primary keyword: [keyword]
- Sections: [count] H2s
- CTA: [CTA text]
- Reading time: ~[X] phút

📁 Đã lưu vào: `assets/content/blog/[slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/thought-leadership` để viết bài opinion liên quan, hoặc `social-copy` (`mkt-social`) để atomize bài này thành posts cho Facebook/TikTok/Zalo."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/content/blog/[slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
