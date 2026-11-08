---
name: trend-monitoring
description: Tracks current industry and platform trends in Vietnam.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: research
    tags: [marketing, vietnam, research]
required_environment_variables:
  - name: OPENROUTER_API_KEY
    prompt: OpenRouter API key
    help: https://openrouter.ai/keys
    required_for: live trend research via Perplexity Sonar
---

# Trend Monitoring Skill

Your job is to surface emerging signals in this industry — trends that are gaining momentum now, before they're obvious to everyone. Not 2023 trend reports. Live intelligence that this brand can act on this week.

## When to Use

- The user wants to know what is changing now in their industry or on Vietnamese platforms.
- Owned by `mkt-research`; writes to `research/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.
- `OPENROUTER_API_KEY` for Perplexity Sonar via OpenRouter, called with `terminal`. If the call fails, fall back to `web_search` + `web_extract` and say so under Sources.

## How to Run

- **Chat:** `/trend-monitoring` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read brand.md

Read `brand/brand.md`. Extract:
- Industry and business type
- Target audience (Section 6)
- Location
- Content pillars (Section 12) — to align trend findings with existing strategy

If brand.md doesn't exist: ask the user for their industry before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User specified a trend focus**
Use their focus. Go to Step 3.

**Path B — No focus provided**
Ask:
"Bạn muốn mình theo dõi xu hướng theo góc độ nào?
1. Xu hướng ngành và thị trường (industry trends)
2. Xu hướng hành vi người dùng và khách hàng (consumer behavior)
3. Xu hướng nội dung và marketing (content/marketing trends)
4. Tất cả (full trend scan)"

Wait for answer before continuing.

### Step 3 — Run trend research via OpenRouter

Use the `OPENROUTER_API_KEY` environment variable. Make POST requests to OpenRouter:

```
POST https://openrouter.ai/api/v1/chat/completions
Authorization: Bearer $OPENROUTER_API_KEY
Content-Type: application/json
```

Run 3 separate queries:

#### Query 1 — Industry trend scan
```json
{
  "model": "perplexity/sonar",
  "messages": [{
    "role": "user",
    "content": "What are the most significant emerging trends in the [INDUSTRY] industry in Vietnam in 2025? Focus on: new behaviors, shifts in how customers buy, new platforms or channels gaining traction, regulatory changes, and technology shifts that are just starting to impact this space. Include specific examples and data where available. Be specific to Vietnam — not global trends unless they're landing in Vietnam now."
  }]
}
```

#### Query 2 — Consumer behavior shifts
```json
{
  "model": "perplexity/sonar",
  "messages": [{
    "role": "user",
    "content": "What's changing in how Vietnamese [TARGET_AUDIENCE] customers make decisions and consume content in 2025? Specifically: which platforms are growing, what content formats are winning, how has their trust and skepticism evolved, and what anxieties or aspirations are most prominent right now? Give me fresh insights — not evergreen advice."
  }]
}
```

#### Query 3 — Content and marketing trend scan
```json
{
  "model": "perplexity/sonar",
  "messages": [{
    "role": "user",
    "content": "What content formats and marketing approaches are gaining momentum for [BUSINESS_TYPE] businesses in Vietnam in 2025? Which tactics are losing effectiveness? What's working on Facebook, TikTok, and Zalo right now? Give specific examples of brands or campaigns that are cutting through."
  }]
}
```

Replace `[INDUSTRY]`, `[TARGET_AUDIENCE]`, `[BUSINESS_TYPE]` with values from brand.md.

### Step 4 — Classify and prioritize trends

For each trend found, classify by:

**Urgency:**
- 🔴 **Act now** — trend is peaking, window closing fast
- 🟡 **Build toward** — trend is growing, 3–6 month runway
- 🟢 **Watch** — early signal, not yet actionable

**Relevance to this brand:**
- Direct: core to their business model or audience
- Adjacent: affects their customers but indirectly
- Background: macro shift to be aware of

**Content opportunity:**
- Is there a specific piece of content this trend enables?
- Can this brand be one of the first to comment on it?

### Step 5 — Generate content angle ideas

For each high-priority trend, suggest 1–2 specific content angles this brand can publish within the next 2 weeks:

Format: "[Trend] → [Content piece title] → [Platform] → [Why it will resonate]"

Example:
"AI tools adoption by SMBs → 'Bạn thực sự cần AI để làm marketing không?' → Facebook/Zalo → SMB owners are curious but skeptical — this question headline triggers clicks"

### Step 6 — Write output

Save to `research/trend-monitoring-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Trend Monitoring — [Brand Name]
> Generated: [date] | Industry: [industry] | Market: Vietnam

## High-Priority Trends (Act Now)
🔴 **[Trend name]**
- What's happening: [2–3 sentences]
- Why it matters for this brand: [1–2 sentences]
- Content angle: [specific piece to publish]
- Platform: [Facebook / TikTok / Zalo / Blog]

[Repeat for each 🔴 trend]

---

## Growing Trends (Build Toward)
🟡 **[Trend name]**
- What's happening:
- Runway: [timeframe]
- Strategic implication:

[Repeat for each 🟡 trend]

---

## Watch List
🟢 **[Trend name]** — [one-line summary]
[Repeat]

---

## 2-Week Content Calendar (Trend-Driven)
Content pieces to publish immediately based on these trends:
1. **[Piece title]** — Platform: [X] — Trend: [X] — Goal: [awareness / leads / trust]
2. ...
3. ...

---

## What's Losing Momentum
Tactics and topics to de-prioritize:
- [Tactic] — Why: [reason]
- [Topic] — Why: [reason]

---

## Sources
[Sources from Perplexity responses]
```

### Step 7 — Confirm

After writing, reply:

---
"✅ **Trend monitoring cho [Brand Name] đã hoàn chỉnh.**

**Highlights:**
- Xu hướng cần hành động ngay: [count] trends
- Góc nội dung hàng đầu: [top content angle]
- Xu hướng đang giảm: [what to stop doing]

📁 Đã lưu vào: `research/trend-monitoring-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `campaign-planning` (`mkt-strategy`) để xây dựng chiến lược dựa trên research vừa hoàn thành."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `research/trend-monitoring-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
