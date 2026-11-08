---
name: market-research
description: Pulls live Vietnam market size, trends and buyer behavior.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: research
    tags: [marketing, vietnam, research]
    related_skills: [competitor-analysis]
required_environment_variables:
  - name: OPENROUTER_API_KEY
    prompt: OpenRouter API key
    help: https://openrouter.ai/keys
    required_for: live research via Perplexity Sonar
---

# Market Research Skill

Your job is to pull live, specific market intelligence for this business — not generic industry overviews, but data that directly informs their marketing and positioning decisions.

## When to Use

- The client needs market size, growth, buyer behavior or opportunities for their industry in Vietnam.
- Owned by `mkt-research`; writes to `research/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.
- `OPENROUTER_API_KEY` for Perplexity Sonar via OpenRouter, called with `terminal`. If the call fails, fall back to `web_search` + `web_extract` and say so under Sources.

## How to Run

- **Chat:** `/market-research` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read brand.md

Read `brand/brand.md`. Extract:
- Industry and business type
- Location (city/region)
- Target audience
- Competitors already identified

If brand.md doesn't exist: ask the user for their industry and location before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User specified a research focus**
Use their focus. Go to Step 3.

**Path B — No focus provided**
Ask:
"Bạn muốn mình tập trung vào khía cạnh nào của thị trường?
1. Quy mô và tăng trưởng thị trường (market size + growth)
2. Hành vi khách hàng (customer behavior + trends)
3. Cơ hội thị trường (gaps + opportunities)
4. Tất cả (full market overview)"

Wait for answer before continuing.

### Step 3 — Run market research via OpenRouter

Make a POST request to OpenRouter using the Perplexity Sonar model:

```
POST https://openrouter.ai/api/v1/chat/completions
Authorization: Bearer $OPENROUTER_API_KEY
Content-Type: application/json

{
  "model": "perplexity/sonar",
  "messages": [
    {
      "role": "user",
      "content": "Research the [INDUSTRY] market in Vietnam in 2024-2025. Provide: 1) Market size and growth rate with specific numbers, 2) Key customer segments and their behaviors, 3) Major trends shaping the industry, 4) Market gaps and opportunities for [BUSINESS TYPE] targeting [TARGET AUDIENCE]. Focus on Vietnam specifically — Ho Chi Minh City and Hanoi if relevant. Include specific statistics, growth rates, and actionable insights."
    }
  ]
}
```

Replace `[INDUSTRY]`, `[BUSINESS TYPE]`, `[TARGET AUDIENCE]` with values from brand.md.

Run 2 separate queries:
1. **Market size + trends query** — broad industry overview
2. **Customer behavior query** — specific to their target audience in Vietnam

### Step 4 — Synthesize and structure findings

From the API responses, extract and organize:

**Market Overview:**
- Market size (USD or VND)
- Growth rate (CAGR or YoY)
- Key market drivers
- Vietnam-specific dynamics

**Customer Insights:**
- How Vietnamese customers in this segment make buying decisions
- Online vs. offline behavior
- Platform preferences (Facebook, TikTok, Zalo, etc.)
- Price sensitivity and spending patterns

**Market Opportunities:**
- Gaps no one is filling well
- Underserved segments
- Emerging trends to ride early
- Geographic opportunities (HCMC vs Hanoi vs other cities)

**Threats & Risks:**
- Market saturation risks
- Regulatory or economic risks
- Competitor momentum

### Step 5 — Write output

Save findings to `research/market-research-[YYYY-MM-DD].md` using this structure:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Market Research — [Brand Name]
> Generated: [date] | Industry: [industry] | Market: Vietnam

## Market Overview
[size, growth, drivers]

## Customer Behavior
[how they buy, where they are, what they care about]

## Opportunities
[specific gaps and trends]

## Threats
[risks to watch]

## Key Data Points
[bullet list of most important stats to reference in content/strategy]

## Sources
[list sources from Perplexity response]
```

### Step 6 — Confirm

After writing, reply:

---
"✅ **Market research cho [Brand Name] đã hoàn chỉnh.**

**Highlights:**
- Quy mô thị trường: [market size]
- Tăng trưởng: [growth rate]
- Cơ hội lớn nhất: [top opportunity]
- Rủi ro cần chú ý: [top risk]

📁 Đã lưu vào: `research/market-research-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/competitor-analysis` để phân tích đối thủ cụ thể."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `research/market-research-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
