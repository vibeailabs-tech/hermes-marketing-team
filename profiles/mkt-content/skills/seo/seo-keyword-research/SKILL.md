---
name: seo-keyword-research
description: Builds a keyword map with SERP gaps and PAA questions.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: seo
    tags: [marketing, vietnam, seo]
    related_skills: [content-brief, on-page-seo]
required_environment_variables:
  - name: SERPAPI_KEY
    prompt: SerpAPI key
    help: https://serpapi.com/manage-api-key
    required_for: real Google SERP data
---

# SEO Keyword Research Skill

Your job is to find keywords the brand should rank for — including gaps competitors own that this brand doesn't. Uses SerpAPI to pull real SERP data.

## When to Use

- SEO work needs a keyword map with SERP data, competitor gaps and PAA questions.
- Owned by `mkt-content`; writes to `assets/seo/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.
- `SERPAPI_KEY` for SerpAPI requests via `terminal`. Without it, use `web_search` and label every volume as an estimate.

## How to Run

- **Chat:** `/seo-keyword-research` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Industry, location, language (Sections 1–3)
- Core offer and target audience (Sections 6 + 9)
- Competitors (Section 10)

If brand.md doesn't exist: ask user to provide brand name, industry, location, and 3 competitor URLs manually.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User provided seed keywords or a topic**
Use those as starting seeds. Go to Step 3.

**Path B — No seeds provided**
Ask:
"Để research keyword, mình cần biết:
1. **Chủ đề chính:** Bạn muốn rank cho chủ đề gì? (VD: 'AI marketing', 'phần mềm kế toán', 'spa tại TPHCM')
2. **Mục tiêu:** Bạn muốn keyword cho trang nào? (homepage / blog / landing page cụ thể)
3. **Ưu tiên:** Volume cao, competition thấp, hay intent mua hàng?"

Wait for answer.

### Step 3 — Run keyword research

#### SerpAPI calls to make (3 rounds):

**Round 1 — Seed keyword SERPs**
For each seed keyword, call SerpAPI Google Search:
- `q`: seed keyword (+ "Vietnam" or location if local)
- `gl`: vn, `hl`: vi (or en depending on brand language)
- `num`: 10

Extract from each SERP:
- Top 10 organic results (title, URL, snippet)
- People Also Ask questions
- Related searches at bottom of SERP

**Round 2 — Competitor keyword gaps**
For each competitor domain from brand.md, call SerpAPI:
- Search `site:[competitor-domain] [seed topic]` to see what they rank for
- Note recurring themes and angles they cover

**Round 3 — Long-tail variations**
Based on PAA and related searches from Round 1, pick the 5 most promising long-tail terms and run SerpAPI searches on those too.

#### Analyze results:

**Keyword scoring criteria:**
1. **Search intent alignment** — does searcher intent match the brand's offer?
   - Informational: research phase (blog content)
   - Commercial: comparing options (comparison pages, case studies)
   - Transactional: ready to buy (landing pages, service pages)
2. **Competitor difficulty** — how strong are current top 10 results?
   - Check: are top results big brand domains (hard) or thin content (opportunity)?
3. **Topic cluster fit** — does this keyword belong in a logical cluster around a pillar topic?
4. **Vietnamese market specificity** — is there a Vietnamese-specific angle that global content misses?

**Classify each keyword:**
- Quick win: lower competition, clear intent, brand can rank in 60–90 days
- Strategic: higher volume, worth pursuing with strong content over 6+ months
- Skip: dominated by huge brands or irrelevant intent

### Step 4 — Build keyword map

Organize into 3 tiers:

**Tier 1 — Pillar keywords (1–3 keywords)**
High-volume, defines the brand's main topic. Hard to rank immediately but anchor the whole strategy.

**Tier 2 — Cluster keywords (5–10 keywords)**
Medium difficulty, support the pillar. Each one becomes a piece of content.

**Tier 3 — Quick wins (10–20 keywords)**
Low competition, clear intent. Start ranking here to build authority for Tier 1.

### Step 5 — Write output

Save to `assets/seo/keyword-research-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Keyword Research — [Brand Name]
> Generated: [date] | Tools: SerpAPI | Location: [location]

## Executive Summary
- Pillar keyword: [main keyword]
- Total keywords mapped: [n]
- Quick wins identified: [n]
- Biggest competitor gap: [what they rank for that you don't]

---

## Tier 1 — Pillar Keywords

| Keyword | Est. Monthly Searches | Intent | Difficulty | Notes |
|---|---|---|---|---|
| | | | | |

---

## Tier 2 — Cluster Keywords

| Keyword | Intent | Content Type | Priority |
|---|---|---|---|
| | | | |

---

## Tier 3 — Quick Wins

| Keyword | Why It's a Quick Win | Recommended Page |
|---|---|---|
| | | |

---

## People Also Ask (High Value)
Questions from SERPs that represent content opportunities:
1. 
2. 
3. 

---

## Competitor Keyword Gaps
Keywords competitors rank for that [Brand] currently doesn't:

| Keyword | Competitor That Ranks | Opportunity |
|---|---|---|
| | | |

---

## Content Recommendations
Based on keyword clusters, these are the next 5 content pieces to create:
1. [Title] — targets [keyword] — [intent] — [page type]
2. 
3. 
4. 
5. 
```

### Step 6 — Confirm

After writing:

---
"✅ **Keyword research cho [Brand Name] hoàn chỉnh.**

**Highlights:**
- [n] pillar keywords, [n] cluster keywords, [n] quick wins
- Top quick win: '[keyword]' — [why]
- Biggest gap vs competitors: '[keyword]'

📁 Đã lưu: `assets/seo/keyword-research-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/on-page-seo` để tối ưu trang hiện có cho các keywords này, hoặc `/content-brief` để brief bài viết nhắm vào quick wins."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/seo/keyword-research-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
