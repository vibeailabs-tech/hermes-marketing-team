---
name: positioning-evolution
description: Re-tests positioning against market and competitor shifts.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: feedback
    tags: [marketing, vietnam, feedback]
    related_skills: [foundation-review]
---

# Positioning Evolution Skill

Your job is to evaluate whether the brand's market positioning still holds — and update it if the market, competitors, or the brand's own track record have shifted it. Positioning is not permanent. Markets move, competitors copy, and what worked at launch may not be the strongest claim available 6 months in.

## When to Use

- Market or competitor shifts call the current positioning into question.
- Owned by `mkt-brand`; writes `brand/brand.md`.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/positioning-evolution` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read ALL of the following:
- `brand/brand.md` — current Section 7 (Positioning), Section 9 (Core Offer), Section 10 (Competitors)
- `research/competitor-analysis-*.md` — competitor moves (if recent)
- `research/market-research-*.md` — market changes
- `research/trend-monitoring-*.md` — emerging trends
- `performance/monthly-review-*.md` — what positioning claims converted vs. which didn't

If no performance data exists: ask user what's changed in the market before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User described market/competitor changes**
Use their input. Go to Step 3.

**Path B — No input provided**
Ask:
"Để review positioning, mình cần biết:
1. **Competitor moves:** Đối thủ có launch gì mới, thay đổi pricing, hay copy angle của bạn không?
2. **Market shift:** Thị trường hoặc customer behavior có thay đổi gì trong 3 tháng qua?
3. **Your new proof:** Bạn có case study, số liệu, hay milestone mới nào có thể tăng credibility không?
4. **What's not working:** Claim nào trong positioning hiện tại không còn differentiated?
5. **New opportunity:** Có góc cạnh nào trong thị trường mà chưa ai claim chưa?"

Wait for answer before continuing.

### Step 3 — Evaluate positioning health

#### Positioning health checklist

**Is the position still differentiated?**
The strongest positioning becomes weaker when:
- Competitors start making the same claim
- The claim has become generic in the market
- A new entrant has taken the position more credibly

Test: can the positioning statement be applied to any of your top 3 competitors without changing a word? If yes, it's not differentiated enough.

**Is the position still credible?**
Positioning becomes MORE credible when:
- You have new case studies and proof points
- You have more customers and track record
- You have won awards or media coverage
- Your results have become more specific and provable

**Is the position still relevant?**
Positioning becomes LESS relevant when:
- The pain it addresses has been solved by another means
- Customer priorities have shifted
- A market event has made the category less urgent or more urgent

**Is there a stronger position available?**
After 3–6 months of operation, brands often discover:
- A segment they didn't target is converting faster than the original ICP
- A result they didn't emphasize is the most compelling proof point
- A competitor gap they didn't see at launch has opened

#### Vietnamese market positioning dynamics

**What weakens positioning in Vietnam:**
- Competitors copying your angle (common — Vietnamese markets move fast)
- Being too general: "tốt nhất", "số 1" are used by everyone and mean nothing
- Losing trust signals (bad reviews, unmet promises, founder absence)

**What strengthens positioning in Vietnam:**
- Specific numbers: a position backed by proof is hard to copy ("giảm 3 giờ/ngày" beats "tiết kiệm thời gian")
- Community endorsement: if a respected community or influencer references you, lead with that
- Category creation: if you can name a new category you own, you have a durable position
- Vietnamese-specific angle: if your position addresses a specifically Vietnamese constraint (e.g., "cho thị trường không cần agency") it's harder for global competitors to replicate

### Step 4 — Update positioning

If positioning needs updating, make the changes:

**Minor update** (same position, sharper language):
- Update the positioning statement with stronger proof
- Update the competitive angle with new differentiation
- Strengthen the core promise language

**Moderate update** (same territory, new angle):
- The core audience and offer stay the same
- But the claim or competitive angle shifts
- Update Section 7, update key messages in Section 11

**Major update** (new position entirely):
- This is rare and should be flagged to the user before writing
- Ask: "Data suggests bạn nên consider positioning mới hoàn toàn. Mình nên tiếp tục không?"
- Only proceed with explicit confirmation

Update `brand/brand.md`:
- Section 7 (Positioning) — positioning statement, core promise, competitive angle
- Section 9 (Core Offer) — if offer structure has evolved
- Section 10 (Competitors) — update competitor table with new moves
- Update `Last updated` date

Also save a change log to `performance/positioning-evolution-[YYYY-MM].md`:

```markdown
# Positioning Evolution Log — [Month YYYY]
> Generated: [date] | Update type: [Minor / Moderate / Major]

## Positioning Health Assessment

| Dimension | Status | Evidence |
|---|---|---|
| Still differentiated | ✅/⚠️/❌ | [What changed] |
| Still credible | ✅/⚠️/❌ | [New proof or missing proof] |
| Still relevant | ✅/⚠️/❌ | [Market shift evidence] |
| Stronger position available | Yes/No | [Opportunity if yes] |

---

## Competitor Moves
- [Competitor 1]: [What they did — copied angle / new offer / price change]
- [Competitor 2]: [What they did]

---

## Positioning Changes

### Before
**Positioning statement:** [Previous]
**Core promise:** [Previous]
**Competitive angle:** [Previous]

### After
**Positioning statement:** [Updated]
**Core promise:** [Updated]
**Competitive angle:** [Updated]

### Why changed
[Evidence — performance data, competitor move, or market shift]

---

## Competitor Table Updates
| Competitor | Old assessment | New assessment |
|---|---|---|
| [Competitor 1] | [Previous] | [Updated] |

---

## New Proof Points Added
- [Case study or result to add to positioning]
- [New metric that strengthens claims]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Positioning review cho [Brand Name] hoàn chỉnh.**

**Update type:** [Minor / Moderate / Major / No change needed]
**Key change:** [What shifted and why]
**New positioning statement:** '[Updated statement]'

📁 brand.md Section 7 + 9 + 10 đã cập nhật
📁 Change log lưu tại: `performance/positioning-evolution-[YYYY-MM].md`

**Bước tiếp theo:** Chạy `/foundation-review` để tổng hợp tất cả feedback updates, hoặc push positioning mới vào `campaign-brief` (`mkt-strategy`) cho tháng tiếp theo."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Change `brand/brand.md` only on evidence (patterns over 60-90 days). Flag major pivots and get confirmation before writing; never change Section 5 (voice) unless the client asks.
- Log every brand.md change in `brand/changelog.md`: date, section, what changed, which data drove it.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `brand/brand.md` reflects the evidence-backed changes and `brand/changelog.md` has a matching entry.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
