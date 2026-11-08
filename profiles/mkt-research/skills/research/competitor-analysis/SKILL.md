---
name: competitor-analysis
description: Scrapes competitor sites to map messaging gaps.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: research
    tags: [marketing, vietnam, research]
    related_skills: [keyword-research]
---

# Competitor Analysis Skill

Your job is to scrape real competitor data — not guesses — and turn it into actionable intelligence about their messaging, offers, content strategy, and weaknesses.

## When to Use

- The user wants to know what competitors say and offer, and where they are weak.
- Owned by `mkt-research`; writes to `research/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.
- MCP servers `firecrawl` (needs `FIRECRAWL_API_KEY`) and `playwright` in this profile's `mcp_servers`; both ship disabled, see `docs/deploy-vps.md`. Fallback: `web_extract` for page text and `browser_exec` for screenshots.

## How to Run

- **Chat:** `/competitor-analysis` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read brand.md

Read `brand/brand.md`. Extract:
- Industry and business type
- Competitors listed in Section 10
- Positioning and USP

If no competitors are listed in brand.md: ask the user to provide 2–3 competitor URLs or names before continuing.

### Step 2 — Collect competitor URLs

**Path A — Competitors with URLs already in brand.md**
Use those URLs. Go to Step 3.

**Path B — Competitor names but no URLs**
Ask: "Bạn có thể cung cấp URL website của từng đối thủ không? Nếu không có website, mình sẽ dùng tên để tìm kiếm."

**Path C — No competitors identified**
Ask: "Kể tên 2–3 đối thủ chính của bạn (tên thương hiệu hoặc URL website)."

### Step 3 — Scrape competitor websites with Firecrawl

For each competitor, use Firecrawl MCP to scrape their website:

```
Use the firecrawl-mcp tool to scrape [COMPETITOR_URL]
Extract: homepage content, about page, services/products page, pricing page (if exists)
Focus on: headlines, value propositions, CTAs, key messages, offers
```

For each competitor, extract:
- **Hero headline** — what's the first thing they say?
- **Value proposition** — what do they promise?
- **Target audience** — who are they talking to?
- **Key offers** — what are they selling and at what price?
- **CTAs** — what action do they want visitors to take?
- **Content themes** — what topics do they talk about?
- **Tone** — formal/casual, Vietnamese/English?

### Step 4 — Screenshot with Playwright

Use Playwright MCP to take screenshots of each competitor's homepage:

```
Use playwright to navigate to [COMPETITOR_URL] and take a screenshot
```

This captures visual positioning — design quality, color palette, imagery style, above-the-fold layout.

Note for each competitor:
- Design quality (premium / mid-range / basic)
- Visual identity (modern / traditional / minimal / busy)
- Trust signals visible (reviews, numbers, certifications, logos)

### Step 5 — Analyze gaps

After scraping all competitors, synthesize:

**What everyone claims** — the overcrowded positioning angles (avoid or counter these)

**What nobody is saying** — gaps in messaging that this brand can own

**Weaknesses to exploit:**
- Competitor X is strong on [X] but weak on [Y]
- Nobody is talking about [specific pain point]
- All competitors target [segment] but ignore [underserved segment]

**Content gaps:**
- Topics competitors aren't covering
- Questions their audiences are asking that no one is answering

### Step 6 — Write output

Save to `research/competitor-analysis-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Competitor Analysis — [Brand Name]
> Generated: [date]

## Competitor Profiles

### [Competitor 1 Name]
- URL: 
- Hero message: 
- Value proposition: 
- Target audience: 
- Key offer + price: 
- CTA: 
- Tone: 
- Design quality: 
- Trust signals: 
- Strengths: 
- Weaknesses: 

### [Competitor 2 Name]
[same structure]

### [Competitor 3 Name]
[same structure]

---

## Gap Analysis

### Overcrowded angles (avoid)
- 

### Unclaimed positioning opportunities
- 

### Content gaps (topics competitors ignore)
- 

### Underserved audience segments
- 

---

## Strategic Recommendations
[3–5 specific actions this brand should take based on competitor weaknesses]
```

### Step 7 — Confirm

After writing, reply:

---
"✅ **Phân tích đối thủ cho [Brand Name] đã hoàn chỉnh.**

**Highlights:**
- Đã phân tích: [Competitor 1] / [Competitor 2] / [Competitor 3]
- Góc định vị bị bỏ ngỏ: [biggest gap]
- Điểm yếu lớn nhất của đối thủ: [key weakness to exploit]

📁 Đã lưu vào: `research/competitor-analysis-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/keyword-research` để tìm từ khóa đối thủ đang dùng."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `research/competitor-analysis-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
