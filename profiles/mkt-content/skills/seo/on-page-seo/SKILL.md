---
name: on-page-seo
description: Audits and rewrites titles, metas, headings and links.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: seo
    tags: [marketing, vietnam, seo]
    related_skills: [blog-writer, technical-seo-audit]
---

# On-Page SEO Skill

Your job is to optimize a specific page for a target keyword — titles, meta, headings, internal links, content structure. No APIs needed; pure analysis and rewrite.

## When to Use

- A page's titles, metas, headings, structure or internal links need optimizing.
- Owned by `mkt-content`; writes to `assets/seo/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/on-page-seo` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand name, language, location (Sections 1–3)
- Core offer and audience (Sections 6 + 9)

Check if `assets/seo/keyword-research-*.md` exists. If it does, reference the keyword map for recommended pages and keywords.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User provided page content + target keyword**
Use what they gave. Go to Step 3.

**Path B — Missing page content or keyword**
Ask:
"Để tối ưu on-page SEO, mình cần:
1. **Nội dung trang:** Paste full content của trang cần tối ưu (hoặc URL nếu mình có thể scrape)
2. **Keyword mục tiêu:** Keyword chính bạn muốn trang này rank cho
3. **Loại trang:** Blog post / Landing page / Homepage / Service page / Product page"

Wait for answer.

### Step 3 — Audit current on-page signals

Check each element:

**Title tag**
- Length: 50–60 characters optimal (not truncated in SERP)
- Primary keyword: ideally in first 3 words
- Brand name: at end, separated by " — " or "|"
- Click appeal: does it make someone want to click?

**Meta description**
- Length: 150–160 characters
- Primary keyword present
- Contains a clear benefit or hook
- Ends with implicit or explicit CTA

**H1**
- Only one H1 per page
- Contains primary keyword
- Different from title tag (but on the same topic)
- Clear, specific, answers "what is this page about?"

**H2s and H3s**
- Are secondary keywords and LSI terms included naturally?
- Does heading structure create a clear content outline?
- Are PAA-style questions addressed as H2s or H3s?

**Content body**
- Keyword density: 1–2% (not stuffed, not absent)
- First 100 words: does primary keyword appear?
- LSI terms: related vocabulary used naturally throughout?
- Content length vs. top-ranking competitors (too short = thin content signal)
- Readability: short paragraphs, bullet points where appropriate for Vietnamese readers

**Internal links**
- Does the page link OUT to relevant deeper content?
- Do other pages link IN to this page with relevant anchor text?
- Is the internal link structure logical for crawlability?

**Images**
- Alt text contains keyword or relevant description?
- File names descriptive (not IMG_001.jpg)?
- Images compressed for page speed?

**URL slug**
- Short, contains keyword, no stop words, no underscores
- Vietnamese-friendly (avoid diacritics in URLs)

### Step 4 — Rewrite and optimize

Produce optimized versions of every element that scored below standard:

**Rewrites to include:**
1. Optimized title tag (3 variations, pick best)
2. Optimized meta description
3. Optimized H1
4. Revised H2 structure (just the headings, not rewriting full content)
5. First paragraph rewrite (keyword in first 100 words)
6. Internal link suggestions (2–3 specific pages to link to/from with anchor text)
7. Image alt text suggestions

**What NOT to do:**
- Don't change the core message or brand voice
- Don't stuff keywords — if it reads awkward, it's wrong
- Don't recommend things that require technical access (canonical tags, structured data — those go to technical-seo-audit)

### Step 5 — Write output

Save to `assets/seo/on-page-seo-[page-name]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# On-Page SEO Audit — [Page Name]
> Generated: [date] | Target keyword: [keyword] | Page type: [type]

## Audit Score

| Element | Current State | Score | Action Required |
|---|---|---|---|
| Title tag | | /10 | |
| Meta description | | /10 | |
| H1 | | /10 | |
| Heading structure | | /10 | |
| Keyword in first 100 words | | /10 | |
| Internal links | | /10 | |
| **Overall** | | **/10** | |

---

## Optimized Elements

### Title Tag
**Current:** [current title]
**Option 1:** [optimized — recommended]
**Option 2:** [alternative]
**Option 3:** [alternative]

### Meta Description
**Current:** [current]
**Optimized:** [new — 150–160 chars]

### H1
**Current:** [current]
**Optimized:** [new]

### Heading Structure
**Current structure:**
- H1: ...
- H2: ...

**Recommended structure:**
- H1: ...
- H2: [includes target keyword or LSI]
  - H3: [PAA question if applicable]
- H2: ...

### First Paragraph
**Current:**
[first 100 words]

**Optimized:**
[rewritten with keyword in first sentence]

---

## Internal Link Opportunities

| Link FROM | Link TO | Anchor Text |
|---|---|---|
| | | |

---

## Image Alt Text
| Image | Recommended Alt Text |
|---|---|
| | |

---

## Quick Wins (implement today)
1. 
2. 
3. 

## Medium Term (implement this week)
1. 
2. 
```

### Step 6 — Confirm

After writing:

---
"✅ **On-page SEO audit cho [page name] hoàn chỉnh.**

**Overall score:** [n]/10
**Biggest issues:** [top 2 problems]
**Quick wins:** [2 things to fix today]

📁 Đã lưu: `assets/seo/on-page-seo-[page-name]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/technical-seo-audit` để kiểm tra site-wide issues, hoặc `/blog-writer` để tạo thêm content nhắm vào keyword clusters đã identify."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/seo/on-page-seo-[page-name]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
