---
name: content-atomizer
description: Breaks one long-form piece into a month of platform posts.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: distribution
    tags: [marketing, vietnam, distribution]
    related_skills: [platform-formatter, social-calendar]
---

# Content Atomizer Skill

Your job is to take one piece of long-form content — blog post, video script, webinar, case study — and break it into all the smaller assets it contains. One input, maximum output. A 2,000-word blog post contains at least 10 social posts, 3 email angles, 2 video hooks, and 5 quote cards. This skill finds them all.

## When to Use

- One approved long-form piece should become many platform assets.
- Owned by `mkt-social`; writes to `distribution/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/content-atomizer` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice (Section 5) — all atomized pieces stay in brand voice
- Content pillars (Section 12) — confirm which pillar this content falls under
- Target audience (Section 6) — who each atomized piece is for

Read the source content from `assets/content/blog/` or wherever the user points to.

If brand.md doesn't exist: ask user for brand voice and source content before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User provided source content or file path**
Use their input. Go to Step 3.

**Path B — No source provided**
Ask:
"Để atomize content, mình cần:
1. **Source content:** Paste bài blog / video script / case study bạn muốn atomize
2. **Platforms cần:** Facebook / TikTok / Zalo / LinkedIn / Email / tất cả?
3. **Priority:** Bạn muốn mình ưu tiên format nào nhất?"

Wait for answer before continuing.

### Step 3 — Atomize the content

#### The atomization framework

Every piece of long-form content contains these extractable assets:

**Tier 1 — Direct extracts (no rewriting needed)**
- Pull quotes: 3–5 sentences that stand alone as insights
- Statistics or numbers: every specific data point becomes a stat card
- Key argument: the central thesis = LinkedIn thought leadership post
- List items: any numbered list = carousel or thread

**Tier 2 — Light adaptation (same idea, new format)**
- Hook sentences: first paragraph → TikTok hook text
- Problem section → Facebook pain post
- Solution section → Zalo broadcast summary
- Case study or proof → email story sequence
- FAQ section → Twitter/X thread or community FAQ post

**Tier 3 — Repurposed angle (same topic, new entry point)**
- Contrarian take on the main argument
- "What I got wrong" version (builds trust through vulnerability)
- "The one thing most people miss" angle
- Behind-the-scenes of how the content was created

#### Output map per content type

**Blog post (2,000 words) → minimum 12 assets:**
- 3 Facebook posts (different hooks: stat / story / question)
- 2 TikTok captions (hook-led, short)
- 1 Zalo broadcast
- 1 LinkedIn post (insight angle)
- 3 pull quotes (for graphic design)
- 1 email teaser (drive traffic to blog)
- 1 short video script hook (15–30 seconds)

**Video script (60 seconds) → minimum 8 assets:**
- 1 TikTok caption
- 1 Facebook post (expand the argument)
- 1 Zalo broadcast
- 3 pull quotes from spoken lines
- 1 thumbnail headline
- 1 email subject line (using video hook)

**Case study → minimum 10 assets:**
- 1 Facebook story post (before/after narrative)
- 1 LinkedIn post (professional insight)
- 1 TikTok caption (result-first hook)
- 1 Zalo broadcast (social proof)
- 3 quote cards (client direct quotes)
- 1 email subject line ("How [name] went from X to Y")
- 1 ad headline (result stat)
- 1 cold email proof line

#### Vietnamese atomization rules

- Keep register consistent — if source is bạn/mình, all atoms stay bạn/mình
- Numbers survive atomization: "45 phút/tuần", "$80/tháng" stay exact in every version
- Facebook version is always longest; Zalo always shortest
- TikTok caption must work as caption (video does the work) not standalone post
- LinkedIn: adapt to professional context — same data, more analytical framing

### Step 4 — Write output

Save to `distribution/atomized-[source-slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Content Atomization — [Source Title]
> Generated: [date] | Source: [file path] | Total assets: [n]

---

## Facebook Posts

### Post 1 — [Angle: stat/story/question]
[Full post with hashtags]

### Post 2 — [Angle]
[Full post]

### Post 3 — [Angle]
[Full post]

---

## TikTok Captions

### Caption 1
[Caption + hashtags]

### Caption 2
[Caption + hashtags]

---

## Zalo Broadcast
[Message text — no hashtags]

---

## LinkedIn Post
[Full post + hashtags]

---

## Pull Quotes (for graphic design)
1. "[Quote]" — [Source]
2. "[Quote]"
3. "[Quote]"

---

## Email Teaser
**Subject:** [Subject line]
**Preview:** [Preview text]
**Body:** [2–3 sentences + link CTA]

---

## Video Script Hook (15–30 sec)
VISUAL: [description]
SPOKEN: "[hook line]"
TEXT OVERLAY: "[text]"

---

## Ad Assets
**Headline:** [result-led headline]
**Proof line:** [for cold email use]

---

## Asset Inventory
| Asset | Platform | Status |
|---|---|---|
| Facebook Post 1 | Facebook | Ready |
| TikTok Caption 1 | TikTok | Ready |
[etc.]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Content atomization cho '[Source]' hoàn chỉnh.**

**Total assets produced:** [n]
**Platforms covered:** [list]
**Highest priority to publish first:** [asset + reason]

📁 Đã lưu vào: `distribution/atomized-[slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/platform-formatter` để format từng asset đúng spec của từng platform, hoặc schedule qua `/social-calendar`."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `distribution/atomized-[source-slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
