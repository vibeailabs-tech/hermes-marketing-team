---
name: thought-leadership
description: Writes opinion pieces and industry commentary.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: content
    tags: [marketing, vietnam, content]
---

# Thought Leadership Skill

Your job is to write opinion articles and industry commentary that position this brand as the sharpest, most trustworthy voice in the space. Not content marketing dressed as opinion. Real perspective. A clear point of view. Something worth disagreeing with.

## When to Use

- The user wants an opinion piece or commentary that builds authority.
- Owned by `mkt-content`; writes to `assets/content/thought-leadership/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/thought-leadership` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice (Section 5) — bold, pragmatic, trustworthy — this is where bold matters most
- Positioning and competitive angle (Section 7) — what does this brand genuinely believe?
- Key messages (Section 11) — each thought leadership piece should reinforce one of these
- Content pillars (Section 12) — which pillar does this piece serve?
- USP (Section 8) — the mechanism and belief system behind the brand

If `research/trend-monitoring-*.md` exists: read it — use current trends as the hook or counterpoint.
If `research/market-research-*.md` exists: use market data to support the argument.

If brand.md doesn't exist: ask user for brand info before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User has a topic or angle**
Use their angle. Go to Step 3.

**Path B — No direction provided**
Ask:
"Bài thought leadership này muốn nói điều gì?
1. Quan điểm về ngành (industry commentary — điều mà mọi người đang làm sai)
2. Dự đoán (prediction — điều sắp xảy ra mà ít người thấy)
3. Phản biện (contrarian take — quan điểm ngược với số đông)
4. Bài học rút ra (lessons from experience — điều mình học được)
5. Framework / mental model (cách nhìn mới về vấn đề quen thuộc)

Và topic cụ thể?"

Wait for answer before continuing.

### Step 3 — Write the thought leadership piece

#### What makes thought leadership different from a blog post

A blog post informs. Thought leadership challenges.

A blog post answers "how to." Thought leadership answers "why this matters" or "why everyone else is wrong."

A blog post is safe. Thought leadership has a point of view someone can disagree with.

**Test:** If you removed the author's name and replaced it with any other brand in the space — would it still make sense? If yes, it's not thought leadership. It's content.

#### Structure for a thought leadership piece

**Opening: The provocation (100–150 words)**
Start with the controversial claim, the uncomfortable truth, or the prediction. Don't bury the lede.

Not: "Trong thời đại AI phát triển nhanh chóng, doanh nghiệp cần thích ứng..."
Yes: "73% doanh nghiệp Việt Nam đã dùng AI — và phần lớn trong số đó đang làm sai hoàn toàn."

**The argument (body)**
- H2s as arguments, not topics
- Each section advances the central thesis
- Use: personal observation, market data, specific examples, logical consequence
- Acknowledge the strongest counterargument — then refute it. This builds credibility.
- Avoid: vague claims, unverifiable statements, generic advice

**The implication**
What does this mean for the reader specifically? If the argument is true — what should they do differently starting today?

**The close**
- Restate the central claim — stronger, with more evidence behind it now
- One specific, actionable conclusion
- CTA that flows naturally from the argument

#### Tone calibration for Vietnamese B2B thought leadership
- Direct, but not arrogant — "Mình tin rằng..." not "Rõ ràng là..."
- Back every claim with a specific example or number
- Acknowledge uncertainty where it exists — "Dữ liệu chưa đủ để chắc chắn, nhưng mình thấy pattern này..."
- Vietnamese readers respond to: concrete stories, specific numbers, honest admission of limits
- Avoid: moralizing, lecturing, overpromising

#### Formats
- **Long form (1,000–1,500 words):** LinkedIn article, blog post, Medium
- **Short form (400–600 words):** Facebook long post, newsletter section
- **Thread format:** 8–12 points, each 2–3 sentences — for Facebook/LinkedIn

### Step 4 — Write output

Save to `assets/content/thought-leadership/[slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# [Title — The Claim, Not the Topic]
> Generated: [date] | Format: [long/short/thread] | Pillar: [content pillar] | Platform: [primary platform]

---

[Full article content]

---

## Repurposing Notes
- TikTok angle: [how to turn this into a 60s video]
- Zalo version: [shortened 150-word version for broadcast]
- Facebook short version: [hook + 3 key points + CTA]

## Follow-up content ideas
1. [Related piece this argument leads to]
2. [Counterargument piece to write next]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Thought leadership piece '[Title]' đã hoàn chỉnh.**

**Central claim:** [one sentence — the argument]
**Format:** [long/short/thread]
**Content pillar:** [pillar]
**Strongest point:** [the section that will generate most discussion]

📁 Đã lưu vào: `assets/content/thought-leadership/[slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `social-copy` (`mkt-social`) để atomize bài này thành Facebook post + TikTok script + Zalo message."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/content/thought-leadership/[slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
