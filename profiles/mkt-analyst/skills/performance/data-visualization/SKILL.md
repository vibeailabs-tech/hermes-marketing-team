---
name: data-visualization
description: Specs charts and KPI cards for marketing data.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: performance
    tags: [marketing, vietnam, performance]
    related_skills: [monthly-performance-review]
---

# Data Visualization Skill

Your job is to turn raw marketing data into clear visual descriptions and chart specifications that a human or designer can build in Google Sheets, Canva, or any visualization tool. You don't render charts — you spec them with precision so whoever builds them gets it right on the first try.

## When to Use

- Data needs charts or KPI cards specified for a report or dashboard.
- Owned by `mkt-analyst`; writes to `performance/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/data-visualization` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice (Section 5) — chart titles and labels should match brand tone
- Core offer (Section 9) — context for which metrics matter most

Read any available data from `performance/`.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User provided data to visualize**
Use their input. Go to Step 3.

**Path B — No data provided**
Ask:
"Để tạo data visualization, mình cần:
1. **Data:** Paste data bạn muốn visualize (metrics, table, CSV)
2. **Purpose:** Bạn muốn chart này nói lên điều gì? (trend / comparison / funnel / breakdown)
3. **Audience:** Chart này dùng để: báo cáo nội bộ / pitch khách hàng / social post / presentation?
4. **Tool:** Bạn sẽ build chart trong tool nào? (Google Sheets / Canva / Figma / PowerPoint)"

Wait for answer before continuing.

### Step 3 — Design the visualizations

#### Chart selection rules

**Use a line chart when:** showing a trend over time (weekly leads, monthly revenue, follower growth)

**Use a bar chart when:** comparing values across categories (channel performance, campaign comparison, ad creative A/B)

**Use a funnel chart when:** showing drop-off through stages (impression → click → lead → close)

**Use a pie/donut when:** showing composition where parts add to 100% (traffic sources, budget allocation) — never use for more than 5 segments

**Use a scatter plot when:** showing correlation (spend vs. revenue, post frequency vs. engagement rate)

**Use a table when:** data has multiple dimensions that charts can't capture cleanly

#### Visualization principles

**One chart = one insight:** Every chart must have one clear conclusion. If you need to say three things, make three charts.

**Label everything:** Axes, data points, percentages, time periods. Never make the viewer guess.

**Hierarchy:** Title (what this is) → Subtitle (what period/context) → Chart → Source/notes

**Vietnamese charts:**
- Use VND for currency (not $) — format as "triệu đồng" or "tỷ đồng" for large numbers
- Dates: DD/MM/YYYY format
- Week labels: "Tuần 1", "Tuần 2" not "Week 1"
- Platform names: giữ nguyên English (Facebook, TikTok, Google) — these are brand names

#### Chart types to produce

For each dataset, spec:
1. **Primary chart:** Main visualization — the one that tells the story
2. **Supporting chart (optional):** Adds context or drill-down
3. **KPI summary card:** Single-number callouts for dashboards (e.g., "ROAS: 4.2×")

### Step 4 — Write output

Save to `performance/data-viz-[slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Data Visualization Spec — [Topic/Campaign]
> Generated: [date] | Data period: [range] | Target tool: [tool]

---

## Chart 1 — [Title]

**Type:** [Line / Bar / Funnel / Donut / Scatter / Table]
**Title:** [Exact chart title]
**Subtitle:** [Date range and context]
**Insight it communicates:** [One sentence — what conclusion the viewer should draw]

**Data:**
| [Column A] | [Column B] | [Column C] |
|---|---|---|
| [data] | [data] | [data] |

**Axis labels:**
- X-axis: [label]
- Y-axis: [label] (unit: [VND / % / count])

**Colors:**
- Primary series: [hex or description]
- Secondary series: [hex]
- Highlight (peak or key data point): [hex]

**Annotations:**
- Mark: [specific data point to call out] — label: "[annotation text]"

**Build instructions (for [tool]):**
[Step-by-step for the specific tool if provided]

---

## Chart 2 — [Title]

[Same structure as above]

---

## KPI Summary Cards

### Card 1
**Metric:** [Metric name]
**Value:** [Value with unit]
**Context:** [vs. last period or benchmark]
**Color:** [Green = good / Yellow = warning / Red = bad]

### Card 2
[Same structure]

### Card 3
[Same structure]

---

## Dashboard Layout Recommendation

If building a performance dashboard:
```
[Row 1] KPI Cards: [Metric 1] | [Metric 2] | [Metric 3] | [Metric 4]
[Row 2] [Primary trend chart — full width]
[Row 3] [Channel comparison — left half] | [Funnel — right half]
[Row 4] [Table: top performing assets]
```

---

## Export Specifications
- For presentations: export as PNG at 1920×1080 (16:9) or 1080×1080 (square)
- For reports: export as PDF
- For social: 1080×1350 (portrait) for Instagram/Facebook
- Chart background: white (#FFFFFF) for print, dark (#1A1A2E) for social

---

## Narrative Summary
[3–5 sentences: what the data shows, what's driving the numbers, what decision this data supports]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Data visualization spec cho '[Topic]' đã hoàn chỉnh.**

**Charts specified:** [n] charts + [n] KPI cards
**Key insight:** [One-sentence finding from the data]
**Build in:** [recommended tool]

📁 Đã lưu vào: `performance/data-viz-[slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Build charts trong [tool], hoặc chạy `/monthly-performance-review` để present data này trong monthly review."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `performance/data-viz-[slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
