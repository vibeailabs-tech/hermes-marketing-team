---
name: ad-creative
description: Briefs visual concepts for Meta, TikTok and Google ads.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: ads
    tags: [marketing, vietnam, ads]
    related_skills: [ad-copy, audience-targeting]
---

# Ad Creative Skill

Your job is to write creative direction briefs for paid ad visuals — Facebook/Instagram ads, TikTok ads, and Google Display. What to show, what text overlay to use, what the first frame communicates, and why the creative will stop a paid scroll. Not the design itself — the brief that makes production fast and output consistent.

## When to Use

- A paid campaign needs visual concepts and creative direction.
- Owned by `mkt-ads`; writes to `assets/ads/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/ad-creative` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice (Section 5) — ad creative must match brand personality
- Target audience (Section 6) — what stops their scroll, what they fear, what they want
- Core offer (Section 9) — what the ad is ultimately selling
- USP (Section 8) — the unique claim the creative should communicate

If `strategy/campaign-brief-*.md` exists: read it — align creative to campaign goal and offer.
If `assets/social/social-creative-*.md` exists: check for existing creative direction to extend, not duplicate.

If brand.md doesn't exist: ask user for brand info before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User specified campaign, offer, or creative angle**
Use their input. Go to Step 3.

**Path B — No direction provided**
Ask:
"Để viết ad creative brief, mình cần biết:
1. **Campaign mục tiêu:** Awareness / Lead gen / Conversion / Retargeting?
2. **Platform:** Facebook feed / Instagram / TikTok ads / Google Display?
3. **Offer cụ thể:** Bạn đang quảng cáo gì? (tư vấn miễn phí / gói dịch vụ / lead magnet)
4. **Budget range:** Nhỏ (<5tr/tháng) / Trung bình (5–20tr) / Lớn (>20tr)?
5. **Cold hay warm audience:** Người chưa biết brand, hay người đã tương tác rồi?"

Wait for answer before continuing.

### Step 3 — Write ad creative briefs

#### Ad creative principles for Vietnamese market

**What makes Vietnamese users stop scrolling on paid ads:**
- Specific numbers in the first frame: "Từ $500/tháng xuống $80/tháng" stops scroll faster than "tiết kiệm chi phí"
- Before/after contrast — show the transformation, not the feature
- Familiar pain point stated directly: "Bạn đang trả agency mỗi tháng nhưng không sở hữu gì"
- Social proof signal visible immediately: "47 doanh nghiệp đã setup", "4.9/5 từ 63 khách"
- Vietnamese faces and context — foreign stock photos underperform significantly

**What kills Vietnamese ad performance:**
- Generic stock photos (especially Western business settings)
- Text-heavy creative (Meta penalizes >20% text, Vietnamese audiences scan fast)
- No clear focal point — too much going on
- Corporate visual language that looks like every other ad
- Headline that doesn't match the landing page promise

#### Creative formats by platform

**Facebook/Instagram Feed (Static)**
- Ratio: 1:1 (1080×1080) for feed, 4:5 (1080×1350) for better real estate
- Text on image: max 20% of frame — keep headline to 5–7 words
- Focal point: one clear subject — person, product, or number
- Color: high contrast vs Facebook's white/blue UI — avoid white backgrounds
- CTA button: always include — Facebook auto-adds but brief the copy

**Facebook/Instagram Video Ad**
- Hook: First 3 seconds must work with sound OFF (significant % watch muted)
- Captions: Always include — use as visual element not just accessibility
- Length: 15–30 seconds for cold traffic. 60–90 seconds for warm/retargeting.
- End card: Brand name + CTA visible for last 3 seconds

**TikTok Ad (In-feed)**
- Looks like organic content — overly polished ads underperform
- Hook: Text overlay on first frame, before any voiceover starts
- Native feel: phone filming, real environment, real person beats studio
- Sound ON — TikTok audience expects audio, design for it
- Length: 9–15 seconds for awareness. 21–34 seconds for conversion.

**Google Display**
- Multiple sizes needed: 300×250, 728×90, 160×600, 320×50 (mobile)
- Responsive Display Ads: provide 5 headlines, 5 descriptions, 5 images, 1 logo
- Text must be legible at small sizes — simplicity wins
- Brand color dominance — recognition over cleverness

#### Brief structure (6 elements)

For each creative brief:

**1. Concept** — What story is this ad telling in one sentence?

**2. Visual** — Describe the scene: subject, background, composition, mood, colors. Be specific enough that someone can execute without asking follow-up questions.

**3. Hook / First Frame** — What does the viewer see in the first 1.5 seconds? For video: what's the opening shot? For static: where does the eye land first?

**4. Text Overlay** — Exact copy that appears on the creative:
- Headline (max 7 words, on image)
- Supporting line (optional, smaller)
- CTA text (button or overlay)

**5. Production Notes** — Equipment, location, props, what to avoid, estimated shoot time.

**6. Why This Will Work** — One sentence on the specific insight about the audience that makes this concept effective. Forces the brief writer to justify the creative choice.

### Step 4 — Write output

Save to `assets/ads/ad-creative-[campaign-slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Ad Creative Brief — [Campaign Name]
> Generated: [date] | Platform: [platform] | Goal: [awareness/leads/conversion] | Audience: [cold/warm]

---

## Creative 1 — [Format: Static / Video / Carousel]

**Concept:** [One sentence]

**Visual:**
[Scene description]

**Hook / First Frame:**
[What viewer sees first]

**Text Overlay:**
- Headline: "[max 7 words]"
- Supporting: "[optional]"
- CTA: "[button text]"

**Production Notes:**
- Format/ratio: [specs]
- Equipment: [needed]
- Location: [where]
- Avoid: [mistakes]
- Est. time: [X min]

**Why This Works:**
[One sentence audience insight]

---

## Creative 2 — [Format]
[Repeat structure]

---

## Creative 3 — [Format]
[Repeat — aim for 3 concepts minimum to test]

---

## Testing Priority
- Creative to test first: Creative [X] — [reason]
- Hypothesis: [what you expect to outperform and why]
- Signal to watch: [CTR / CPC / hook rate / landing page CVR]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Ad creative briefs cho '[Campaign]' đã hoàn chỉnh.**

**Briefs created:** [n] concepts — [formats]
**Platform:** [platform]
**Primary creative to test first:** Creative [X] — [one-line reason]

📁 Đã lưu vào: `assets/ads/ad-creative-[slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/ad-copy` để viết headlines và primary text cho từng creative, hoặc `/audience-targeting` để xác định audience cho campaign này."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/ads/ad-creative-[campaign-slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
