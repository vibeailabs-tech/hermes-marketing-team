---
name: audience-update
description: Updates the ICP in brand.md from real customer data.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: feedback
    tags: [marketing, vietnam, feedback]
    related_skills: [messaging-refinement]
---

# Audience Update Skill

Your job is to update the target audience profile in brand.md based on what performance data has revealed about who actually buys, what they respond to, and how they behave. The ICP you built at the start was a hypothesis. Real customer data is the truth. This skill closes the gap.

## When to Use

- Performance data shows who really buys and brand.md Section 6 should follow it.
- Owned by `mkt-brand`; writes `brand/brand.md`.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/audience-update` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read ALL of the following:
- `brand/brand.md` — current Section 6 (Target Audience) — this is what you're updating
- `performance/monthly-review-*.md` — what the data revealed about audience behavior
- `performance/campaign-report-*.md` — which audience segments performed
- `performance/weekly-report-*.md` — engagement patterns
- `strategy/campaign-brief-*.md` — original audience assumptions

If no performance data exists: ask user what they've learned from real customers before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User described what they've learned from customers**
Use their input. Go to Step 3.

**Path B — No input provided**
Ask:
"Để cập nhật audience profile, mình cần biết:
1. **Segment hoạt động tốt nhất:** Nhóm khách hàng nào convert tốt nhất trong 30–90 ngày qua?
2. **Insight mới:** Bạn học được điều gì về khách hàng mà trước đây bạn không biết?
3. **Messaging resonated:** Angle nào, headline nào, hay câu nói nào khiến khách hàng phản hồi nhiều nhất?
4. **Objections:** Phản đối phổ biến nhất mà khách hàng tiềm năng đưa ra là gì?
5. **Unexpected buyers:** Có ai mua mà bạn không expect không? Họ là ai?"

Wait for answer before continuing.

### Step 3 — Analyze and update

#### What to update in audience Section 6

**Demographics:** Have you discovered the real buyer is different from who you assumed? Update age range, job title, company size, industry.

**Pain points:** Which pain points drove conversions? Reorder — put the highest-converting pain points first. Remove pain points that consistently failed to resonate.

**Buying triggers:** What event or situation causes someone to start looking for a solution? Update based on sales conversations and conversion data.

**Objections:** What did prospects actually push back on? This is ground-truth data, more reliable than assumptions. Update the objections list.

**ICP (Ideal Customer Profile):** The named persona may need updating. If a new segment is outperforming the original ICP assumption, update the persona description.

**Online behavior:** Where are they actually discovering you? Which platforms drive your best leads? Update platform priorities based on attribution data.

**Content pillars (Section 12):** Which content topics drove the most engagement and conversions? Adjust pillar emphasis accordingly.

#### What NOT to change based on one month of data

Don't change the fundamental ICP based on one unusual month. Look for patterns across at least 60–90 days before making structural changes to the profile.

One strong month from an unexpected segment = interesting signal, not confirmed ICP shift. Note it as an emerging segment, don't overwrite the core profile yet.

#### Vietnamese audience update specifics

**Zalo behavior:** If Zalo is active, Zalo response patterns often reveal more about buying intent than social media engagement. High Zalo response but low email response = audience prefers direct messaging.

**Regional differences:** Note if buyers from different cities (HCM vs Hanoi vs Da Nang) behave differently. Vietnamese buyers in different regions have different decision speeds and trust signals.

**Group/community buyers:** Vietnamese SMBs often buy based on what peers in their industry group are doing. If referrals from specific communities are converting well, note the community as a primary acquisition channel.

### Step 4 — Write updates to brand.md

Update `brand/brand.md`:
- Section 6 (Target Audience) — update demographics, pain points, triggers, objections, ICP, behavior
- Section 12 (Content Pillars) — reorder or adjust based on content performance
- Update `Last updated` date
- Never touch other sections

Also save a change log to `performance/audience-update-[YYYY-MM].md`:

```markdown
# Audience Update Log — [Month YYYY]
> Generated: [date] | Based on: [data sources used]

## What Changed

### ICP Updates
**Before:** [Previous ICP description]
**After:** [Updated ICP description]
**Why:** [Data that drove this change]

### Pain Points — Reordered
**Previous order:**
1. 
2. 
3. 

**New order (based on conversion data):**
1. [Highest converting pain point]
2. 
3. 

**Removed:** [Pain point that consistently underperformed]
**Added:** [New pain point discovered from customer conversations]

### Objections — Updated
**New objection identified:** [Objection + frequency]
**Objection that's less common than assumed:** [Objection]

### Emerging Segments
[Any new audience segment worth watching — not yet confirmed ICP but showing signal]

### Content Pillar Adjustments
**Increased emphasis:** [Pillar] — [why]
**Decreased emphasis:** [Pillar] — [why]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Audience profile đã được cập nhật dựa trên performance data.**

**Thay đổi chính:**
- ICP: [What changed about the persona]
- Pain points: [Reordering or additions]
- New objection: [If any]
- Emerging segment: [If any]

📁 brand.md Section 6 + 12 đã cập nhật
📁 Change log lưu tại: `performance/audience-update-[YYYY-MM].md`

**Bước tiếp theo:** Chạy `/messaging-refinement` để cập nhật key messages dựa trên audience mới này."

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
