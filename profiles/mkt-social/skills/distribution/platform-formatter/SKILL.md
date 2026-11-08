---
name: platform-formatter
description: Reformats content to each platform's exact specs.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: distribution
    tags: [marketing, vietnam, distribution]
    related_skills: [content-atomizer, social-calendar]
---

# Platform Formatter Skill

Your job is to take any piece of content and format it correctly for each platform's technical and cultural requirements — character limits, hashtag placement, link handling, image specs, and posting conventions. A great post in the wrong format underperforms. This skill ensures every asset is platform-ready before it ships.

## When to Use

- Existing content must be reformatted to a platform's exact specs.
- Owned by `mkt-social`; writes to `distribution/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/platform-formatter` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice (Section 5) — formatting must preserve voice
- Content pillars (Section 12) — context for hashtag selection

If atomized content exists at `distribution/`: read it and format all assets.
If brand.md doesn't exist: use user-provided content and proceed.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User provided content to format**
Use their input. Go to Step 3.

**Path B — No content provided**
Ask:
"Để format content, mình cần:
1. **Content cần format:** Paste text bạn muốn format
2. **Platform:** Facebook / TikTok / Zalo / LinkedIn / Instagram / tất cả?
3. **Có link không:** Bạn muốn include link không — và ở đâu trong post?"

Wait for answer before continuing.

### Step 3 — Format for each platform

#### Platform specifications

**Facebook**
- Text limit: 63,206 chars (practical max: 300 words before "See more" cutoff at ~480 chars)
- First 480 chars: must hook — everything after is hidden behind "See more"
- Links: paste full URL at end of post (Facebook deprioritizes posts with links in body)
- Hashtags: 3–5, end of post, niche-specific
- Images: 1200×630 (landscape) or 1080×1080 (square)
- Video: MP4, max 240 min, 1080p recommended
- Best format: Hook line → line break → body → line break → CTA → line break → hashtags

**TikTok**
- Caption limit: 2,200 chars (practical: 150 words)
- Bio link only — no clickable links in captions
- Hashtags: 5–8, mix trending + niche, placed at end
- Video specs: 9:16 vertical, 1080×1920, 15 sec–10 min
- First line of caption = hook (shows before "more")
- CTA: "Link bio" or "Comment [keyword]"

**Zalo (OA broadcast)**
- Message limit: 1,000 chars recommended max for broadcasts
- No hashtags
- Links: include full URL — Zalo renders previews
- Images: 800×400 minimum for broadcast image
- Format: Short paragraphs, line breaks, one CTA
- Personalization: [Tên] token if available

**LinkedIn**
- Post limit: 3,000 chars
- First 210 chars visible before "See more" — hook must be here
- Links: paste in first comment (not post body) to avoid feed penalty
- Hashtags: 3–5 professional, end of post
- Images: 1200×627 (landscape) or 1080×1080 (square)
- Format: Hook → insight → evidence → takeaway → question CTA → hashtags

**Instagram (if applicable)**
- Caption limit: 2,200 chars
- No clickable links in posts — "Link in bio"
- Hashtags: 5–15, can be in first comment
- Images: 1080×1080 (square) or 1080×1350 (portrait)
- Stories: 1080×1920

**YouTube description**
- First 157 chars show in search results — put key info here
- Timestamps: Add if video is >5 minutes
- Links: Full URLs, subscription link, social links
- Hashtags: 3 hashtags above title in description (shows as clickable tags)

#### Vietnamese platform formatting rules

- "Xem thêm" / "See more" cutoff: Facebook shows ~480 chars before hiding. The hook must land entirely before this cut.
- Zalo link preview: Zalo renders rich link previews — include the full URL on its own line for best preview rendering
- TikTok Vietnamese hashtag mix: Always include both English (#AI, #marketing) and Vietnamese (#AIvietnam, #marketingvietnam) — different discovery paths
- LinkedIn in Vietnam: Most Vietnamese LinkedIn users read both Vietnamese and English posts. Match the language of your target — if targeting corporate, English or bilingual performs well.

### Step 4 — Write output

Save to `distribution/formatted-[slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Platform-Formatted Content — [Topic/Campaign]
> Generated: [date] | Source: [original content] | Platforms: [list]

---

## Facebook
**Character count:** [n] (hook visible: [first 480 chars])

[Formatted post]

**Technical notes:**
- Link placement: [end of post / first comment]
- Image spec: [dimensions]
- Recommended post time: [time GMT+7]

---

## TikTok
**Character count:** [n]

[Formatted caption + hashtags]

**Technical notes:**
- Video spec: [9:16, 1080×1920]
- CTA type: [link bio / comment keyword]

---

## Zalo Broadcast
**Character count:** [n]

[Formatted message]

**Technical notes:**
- Link: [full URL on own line]
- Image: [800×400 minimum]

---

## LinkedIn
**Character count:** [n] (hook visible: [first 210 chars])

[Formatted post]

**Technical notes:**
- Link: [first comment — not post body]
- Image spec: [1200×627]

---

## Formatting Checklist
- [ ] Facebook hook lands before 480-char cutoff
- [ ] LinkedIn hook lands before 210-char cutoff
- [ ] TikTok caption under 150 words
- [ ] Zalo under 1,000 chars
- [ ] All hashtags correct per platform count
- [ ] Links placed correctly per platform
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Platform formatting cho '[Topic]' hoàn chỉnh.**

**Platforms formatted:** [list]
**Facebook hook:** '[first 10 words]...'
**LinkedIn hook:** '[first 10 words]...'

📁 Đã lưu vào: `distribution/formatted-[slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Schedule các posts này qua `/social-calendar`, hoặc chạy `/content-atomizer` để generate thêm assets từ cùng source."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `distribution/formatted-[slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
