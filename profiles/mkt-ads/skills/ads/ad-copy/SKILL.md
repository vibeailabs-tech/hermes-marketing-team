---
name: ad-copy
description: Writes headlines, primary text and CTAs in 3 angles.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: ads
    tags: [marketing, vietnam, ads]
    related_skills: [ad-campaign-structure, ads-ab-test]
---

# Ad Copy Skill

Your job is to write all ad copy components — headlines, primary text, descriptions, and CTAs — for Facebook/Instagram ads, TikTok ads, and Google Search ads. Every word is tested against one criterion: does it make the right person click and the wrong person scroll past?

## When to Use

- A paid campaign needs headlines, primary text and CTAs.
- Owned by `mkt-ads`; writes to `assets/ads/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/ad-copy` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice (Section 5) — ad copy must match brand tone exactly
- Target audience (Section 6) — pain points, language they use, what they're afraid of
- Core offer (Section 9) — what you're selling and how it's framed
- USP (Section 8) — the one claim no competitor can make
- Key messages (Section 11) — messages to reinforce

If `strategy/campaign-brief-*.md` exists: read it — use campaign goal and offer framing.
If `assets/ads/ad-creative-*.md` exists: align copy to the creative concept.

If brand.md doesn't exist: ask user for offer, audience pain point, and unique claim before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User specified campaign, offer, or angle**
Use their input. Go to Step 3.

**Path B — No direction provided**
Ask:
"Để viết ad copy, mình cần biết:
1. **Offer:** Bạn đang quảng cáo gì cụ thể? (VD: tư vấn miễn phí, gói $700, lead magnet)
2. **Platform:** Facebook / Instagram / TikTok / Google Search?
3. **Mục tiêu:** Awareness / Lead / Purchase?
4. **Audience stage:** Cold (chưa biết brand) / Warm (đã tương tác) / Hot (đã xem sales page)?
5. **CTA action:** Điền form / Nhắn Zalo / Đọc bài / Xem video / Mua ngay?"

Wait for answer before continuing.

### Step 3 — Write all ad copy components

#### Facebook/Instagram Ad Copy

**Primary text (body copy above the image):**
- Cold audience: 100–150 words — enough to qualify the reader and create desire
- Warm/retargeting: 50–80 words — they already know you, remind and convert
- Structure: Pain → Agitate → Solution → Proof → CTA
- Hook line (first sentence): this is what shows before "see more" — make it earn the click
- Never start with the brand name — start with the reader's problem

**Headline (below image, 40 chars max):**
- Most important copy real estate after the hook
- Formula options:
  - Outcome: "Hệ thống AI marketing chạy không cần agency"
  - Question: "Bạn đang trả bao nhiêu cho content không sở hữu?"
  - Direct: "Setup AI marketing team trong 9 ngày"
  - Number: "16 agents — $80/tháng — bạn sở hữu toàn bộ"

**Description (under headline, 30 chars max):**
- Support the headline — add urgency, specificity, or risk-reversal
- Examples: "Còn 5 slots tháng 5" / "Tư vấn miễn phí 30 phút" / "Không retainer, không lock-in"

**CTA button:**
- Match to funnel stage: "Tìm hiểu thêm" (cold) / "Đăng ký ngay" (warm) / "Liên hệ ngay" (hot)
- Vietnamese-specific: "Nhắn tin" performs well for Zalo-native audiences

#### TikTok Ad Copy

**On-screen text (overlay, first 3 seconds):**
- Max 8 words — readable at a glance
- States the hook before voiceover begins
- High contrast against video background

**Caption (below video):**
- 80–120 words max
- First sentence = hook restatement
- Hashtags: 5–8, end of caption
- CTA: one action — "Link bio" or "Comment [keyword]"

#### Google Search Ad Copy

**Headlines (up to 15, 30 chars each — Google picks best combo):**
Write at least 10 headlines covering:
- Primary keyword match (2–3 headlines)
- Benefit/outcome (3–4 headlines)
- Social proof (1–2 headlines)
- Urgency or offer (1–2 headlines)
- Brand name (1 headline)

**Descriptions (up to 4, 90 chars each):**
- Expand on the headline promise
- Include primary keyword naturally
- One specific proof point per description
- End with implied CTA

**Display URL paths:**
- `/[keyword]/[action]` format — e.g., `/AI-marketing/tu-van-mien-phi`

#### Vietnamese ad copy rules

**Language that converts in Vietnamese B2B:**
- "Trả một lần, dùng mãi mãi" — ownership framing
- "Bạn sở hữu toàn bộ" — Vietnamese buyers hate lock-in
- "Không retainer, không ràng buộc" — removes commitment fear
- Specific VND or USD amounts — vague pricing kills trust
- "Mình setup cho bạn" — personal, not corporate

**Language to avoid:**
- "Giải pháp toàn diện" — overused, meaningless
- "Đội ngũ chuyên nghiệp" — every competitor says this
- "Hỗ trợ 24/7" — unless actually true
- Overpromise: "Tăng doanh thu 300%" without proof

**Negative targeting copy:**
Include a qualifier that filters bad-fit clicks:
- "Dành cho doanh nghiệp đang trả >$300/tháng cho agency"
- "Phù hợp nếu bạn đã có sản phẩm/dịch vụ và muốn scale marketing"
This reduces CPC waste — wrong audience self-selects out.

#### Copy testing framework

For each campaign, write 3 copy angles to test:

| Angle | Approach | Best for |
|---|---|---|
| Pain-led | Open with the problem they're living right now | Cold audience |
| Proof-led | Open with result/number, then explain | Warm audience |
| Contrarian | Challenge a common belief in the industry | Engaged/educated audience |

### Step 4 — Write output

Save to `assets/ads/ad-copy-[campaign-slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Ad Copy — [Campaign Name]
> Generated: [date] | Platform: [platform] | Goal: [goal] | Audience stage: [cold/warm/hot]

---

## Facebook/Instagram — Version A (Pain-led)

**Primary Text:**
[Full body copy]

**Headline:** [max 40 chars]
**Description:** [max 30 chars]
**CTA Button:** [button text]

---

## Facebook/Instagram — Version B (Proof-led)

**Primary Text:**
[Full body copy]

**Headline:** [max 40 chars]
**Description:** [max 30 chars]
**CTA Button:** [button text]

---

## Facebook/Instagram — Version C (Contrarian)

**Primary Text:**
[Full body copy]

**Headline:** [max 40 chars]
**Description:** [max 30 chars]
**CTA Button:** [button text]

---

## Google Search — Headlines (10 minimum)
1. [30 chars]
2. [30 chars]
[...]

## Google Search — Descriptions (4)
1. [90 chars]
2. [90 chars]
3. [90 chars]
4. [90 chars]

**Display URL:** [domain]/[path1]/[path2]

---

## TikTok Ad

**On-screen text hook:** "[max 8 words]"
**Caption:**
[Full caption with hashtags]

---

## Testing Notes
- Test A vs B first — [what you're isolating: hook angle]
- Winner condition: [metric] >[threshold] after [n] impressions
- Loser to pause at: CPC >[amount] or CTR <[%]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Ad copy cho '[Campaign]' đã hoàn chỉnh.**

**Versions written:** [n] — [angle names]
**Platforms:** [list]
**Recommended test order:** Version [X] first — [one-line reason]

📁 Đã lưu vào: `assets/ads/ad-copy-[slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/ad-campaign-structure` để build campaign architecture, hoặc `/ads-ab-test` để design test protocol cho các versions này."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/ads/ad-copy-[campaign-slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
