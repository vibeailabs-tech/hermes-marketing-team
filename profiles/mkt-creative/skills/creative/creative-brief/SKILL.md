---
name: creative-brief
description: Writes production briefs for designers or image AI.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: creative
    tags: [marketing, vietnam, creative]
    related_skills: [branded-deck]
---

# Creative Brief Skill

Your job is to write complete creative briefs for all brand visual assets — thumbnails, cover images, presentation decks, branded graphics, email headers, and ad creatives. A brief is not a mood board. It is a production document: specific enough that a designer can execute without a single follow-up question.

## When to Use

- A designer or image AI needs a production brief for a visual asset.
- Owned by `mkt-creative`; writes to `assets/creative/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/creative-brief` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice and personality (Section 5) — visual tone must match written voice
- Target audience (Section 6) — what visuals resonate with them
- Core offer (Section 9) — what the asset is ultimately supporting
- USP (Section 8) — what should be visually communicated

If a video script exists in `assets/creative/`: read it — thumbnail briefs must match the video's hook.
If `assets/ads/ad-creative-*.md` exists: check for visual direction already established.

If brand.md doesn't exist: ask user for brand personality, colors, and asset type before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User specified asset type and purpose**
Use their input. Go to Step 3.

**Path B — No direction provided**
Ask:
"Để viết creative brief, mình cần biết:
1. **Asset type:** Thumbnail / Cover image / Presentation deck / Social graphic / Email header / Ad banner?
2. **Purpose:** Video thumbnail / Blog featured image / Pitch deck / Social post visual?
3. **Dimensions:** [platform will determine this — or user specifies]
4. **Tone:** Professional / Casual / Bold / Minimal / Warm?
5. **Có người thật không:** Founder, team, hay chỉ graphic/text-based?"

Wait for answer before continuing.

### Step 3 — Write creative briefs

#### Brief types and their specific requirements

**YouTube / Video thumbnail**
The thumbnail's only job: make someone click. It competes with every other thumbnail on the page.
- Size: 1280×720 (16:9)
- Rule: Can be understood in 0.5 seconds at small size
- Elements: Face (with expression) + text (max 5 words) + contrasting background
- Emotion: Curiosity, surprise, or "I need this" — not neutral
- Text must be readable at 180px wide (mobile YouTube)
- Avoid: Clickbait that doesn't match video content (hurts CTR long-term)

**Blog / Article featured image**
- Size: 1200×630 (Open Graph standard — works for Facebook share too)
- Elements: Topic signal + brand color presence
- Text: Optional — headline can be on image or left to the article title
- Style: Should feel like the article's tone — not a generic stock photo

**Social media graphics (Facebook/Instagram feed)**
- Size: 1080×1080 (square) or 1080×1350 (portrait — more real estate)
- Hierarchy: One focal point — eye lands on the most important element first
- Text on image: Max 20% of frame — keep to 5–7 words
- Brand consistency: Same color palette and font family across all graphics

**Presentation / Pitch deck slides**
- Size: 1920×1080 (16:9 widescreen standard)
- Slide density: One idea per slide — no walls of text
- Visual hierarchy: Title → Supporting visual → Data point (if any)
- Template consistency: Same grid, same font sizes, same margin rules throughout

**Email header**
- Size: 600px wide × 200px tall (standard email width)
- Mobile: Must look good at 320px wide (half the email clients open on mobile)
- Text: Keep minimal — email clients sometimes block images, so critical info shouldn't be image-only
- Brand recognition: Logo + brand color — viewer should know who sent this in 1 second

#### The 8 elements of every creative brief

**1. Asset name and purpose**
What is this, and what job does it do?

**2. Dimensions and format**
Exact pixel dimensions. File format needed (PNG/JPG/PDF/MP4).

**3. Visual concept**
One sentence describing the overall look and feel.

**4. Subject / focal point**
What is the first thing the eye should land on? Person, number, object, or graphic element?

**5. Color direction**
Primary color, accent color, background color. Use hex codes if brand colors are defined.

**6. Typography**
Font family (or "match brand fonts"), size hierarchy, weight. What text appears and in what order.

**7. Mood / reference**
3 adjectives describing the visual mood. Optional: describe a reference (not a specific image — a style or concept).

**8. What NOT to do**
The most important element. Prevents the brief from being misinterpreted. List 2–3 specific things to avoid.

#### Vietnamese visual design considerations
- Vietnamese text is longer than English equivalents — budget more space for text
- Vietnamese audiences respond to warm tones (amber, orange, red) in consumer content; blue/navy in B2B
- Avoid white backgrounds for Facebook ads — blends into Facebook UI
- Founder/personal photos outperform stock photos significantly in Vietnamese market
- Mobile-first review: always check brief against 375px screen width

### Step 4 — Write output

Save to `assets/creative/creative-brief-[slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Creative Brief — [Asset Name]
> Generated: [date] | Type: [asset type] | Platform: [where it's used]

---

## Brief 1 — [Asset name]

**Purpose:** [What job this asset does]
**Dimensions:** [W×H px] | **Format:** [PNG/JPG/PDF]

**Visual Concept:**
[One sentence]

**Focal Point:**
[What the eye lands on first]

**Color Direction:**
- Primary: [color / hex]
- Accent: [color / hex]
- Background: [color / hex]

**Typography:**
- Headline: "[exact text]" — [font weight, size guidance]
- Subtext: "[exact text]" — [smaller, lighter]
- Brand element: [logo placement]

**Mood:** [3 adjectives]

**Do NOT:**
- [Specific thing to avoid]
- [Specific thing to avoid]
- [Specific thing to avoid]

**Production notes:**
- Software: [Canva / Figma / Photoshop / any]
- Deadline: [if applicable]
- Deliverable: [final file format + where to save]

---

## Brief 2 — [Asset name]
[Repeat structure]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Creative briefs cho '[Project]' đã hoàn chỉnh.**

**Briefs created:** [n] — [asset types]
**Total assets:** [n] files to produce
**Priority asset:** [name] — [why it's first]

📁 Đã lưu vào: `assets/creative/creative-brief-[slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/branded-deck` nếu cần pitch deck hoàn chỉnh, hoặc chuyển brief này cho designer để produce."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/creative/creative-brief-[slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
