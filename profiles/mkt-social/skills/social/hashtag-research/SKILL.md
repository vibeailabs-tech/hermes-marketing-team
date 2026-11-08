---
name: hashtag-research
description: Builds hashtag clusters per platform and pillar.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: social
    tags: [marketing, vietnam, social]
    related_skills: [social-calendar, social-copy]
---

# Hashtag Research Skill

Your job is to find the right hashtag clusters for each platform — Vietnamese-specific, niche-targeted, and sized correctly for the brand's current reach. Not a generic list of popular hashtags. A strategic set organized by platform and content type that gives posts the best chance of discovery.

## When to Use

- Posts need platform-specific hashtag clusters.
- Owned by `mkt-social`; writes to `assets/social/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/hashtag-research` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Industry and business type (Section 2) — defines the niche hashtag clusters
- Location (Section 3) — Vietnamese-specific hashtags where relevant
- Target audience (Section 6) — what communities they're in
- Content pillars (Section 12) — one hashtag cluster per pillar

If brand.md doesn't exist: ask user for industry, location, and 3 content topics before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User provided topic or platform**
Use their context. Go to Step 3.

**Path B — No direction provided**
Ask:
"Để research hashtags, mình cần biết:
1. **Platform chính:** Facebook / TikTok / Instagram / LinkedIn — hay tất cả?
2. **Nội dung loại gì:** Tips & education / Behind the scenes / Promotional / Trending?
3. **Mục tiêu:** Tăng reach với người mới / Engage community hiện tại / Reach khách hàng cụ thể?"

Wait for answer before continuing.

### Step 3 — Build hashtag clusters

#### Platform-specific hashtag rules

**Facebook**
- Hashtags have lower impact than TikTok — use 3–5 max
- Vietnamese niche hashtags outperform global ones (smaller pool, less competition)
- Best placement: end of post, after a line break
- Avoid: overly generic (#marketing, #business) — too broad, no community
- Best performing types: industry-specific + location + content format
- Example cluster for AI marketing: `#AImarketing #doanhnghiepviet #marketingvietnam #automationAI #vibeailabs`

**TikTok**
- Hashtags drive discovery more than any other platform — use 5–8
- Mix: 1–2 mega tags (1M+ posts) + 2–3 mid-size (100K–1M) + 2–3 niche (<100K)
- Vietnamese TikTok has its own trending hashtags — different from global TikTok
- Content-type hashtags work well: #learnontiktok #tiktoktutorial #tipsandtricks
- Location optional: #tphcm #hcmc #vietnam for local reach
- Update monthly — trending hashtags on TikTok expire fast

**Instagram**
- 5–10 hashtags is the current sweet spot (Instagram has reduced hashtag reach)
- Mix niche + community hashtags
- Vietnamese Instagram is smaller than Facebook/TikTok — community hashtags matter more
- Story hashtags: 1–2 max, they're not clickable the same way

**LinkedIn**
- 3–5 hashtags max — LinkedIn penalizes hashtag stuffing
- Professional, topic-based: #AImarketing #B2Bmarketing #startupvietnam #marketingautomation
- No location hashtags unless you're doing local hiring
- Follow the hashtags you use — comment early on trending posts

**Zalo**
- No hashtags — Zalo OA and broadcasts don't use them
- Skip for Zalo content

#### Hashtag size guide (Vietnamese market)

| Size | Vietnamese posts (est.) | When to use |
|---|---|---|
| Mega | 500K+ | 1 per post — for broad reach |
| Large | 100K–500K | 1–2 per post — good balance |
| Mid | 10K–100K | 2–3 per post — your community lives here |
| Niche | 1K–10K | 2–3 per post — least competition, most relevant |
| Brand | <1K | Always include your own brand hashtag |

#### Core hashtag clusters to research

For each content pillar, build a cluster of 8–10 hashtags across the size spectrum:

**Vietnamese market-specific hashtags to always check:**
- Industry: `#[ngành]việtnam`, `#[ngành]vn`, `#[ngành]tphcm`, `#[ngành]hanoi`
- Business: `#doanhnghiepviet`, `#startupsaigon`, `#kinhdoanhonline`, `#marketingvietnam`
- AI/Tech: `#AIvietnam`, `#chuyen​đổi​số`, `#congngheAI`, `#AImarketing`
- Education: `#hocmarketing`, `#kiếnthứcmarketing`, `#digital​marketing​việt​nam`
- Founder/SMB: `#khởi​nghiệp`, `#entrepreneur​việt​nam`, `#SMBvietnam`

**Platform-specific trending tags to check (Vietnamese):**
- Facebook: Focus on niche over trending — Facebook hashtags are community, not discovery
- TikTok: Check trending page weekly — Vietnamese TikTok trends fast and dies fast
- LinkedIn: Industry + role-based (#CMO #marketingmanager #startupfounder)

#### If SerpAPI is available (optional upgrade)
Run searches like `site:facebook.com "#AImarketing"` and `site:tiktok.com "#AImarketing"` to see post volumes. Otherwise use the size framework above based on known Vietnamese social media patterns.

### Step 4 — Write output

Save to `assets/social/hashtag-research-[topic-slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Hashtag Research — [Brand/Topic]
> Generated: [date] | Platforms: [platforms covered] | Industry: [industry]

---

## Master Hashtag Bank

### Cluster 1 — [Content Pillar / Topic]
**Use for:** [what type of posts]

| Hashtag | Platform | Est. Size | Type |
|---|---|---|---|
| #[hashtag] | FB/TT/IG/LI | Mega/Large/Mid/Niche | Industry/Location/Community/Brand |

**Recommended combo (Facebook):** `#tag1 #tag2 #tag3 #tag4 #tag5`
**Recommended combo (TikTok):** `#tag1 #tag2 #tag3 #tag4 #tag5 #tag6 #tag7`
**Recommended combo (LinkedIn):** `#tag1 #tag2 #tag3`

---

### Cluster 2 — [Content Pillar / Topic]
[Repeat structure]

---

### Cluster 3 — [Content Pillar / Topic]
[Repeat structure]

---

## Brand Hashtag
`#[brandhashtagname]` — use on every post across all platforms

---

## Hashtags to AVOID
- [Hashtag] — [why: too broad / wrong audience / banned / dying]

---

## Update Schedule
- TikTok clusters: review monthly (trends expire fast)
- Facebook/LinkedIn: review quarterly
- Next review date: [date]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Hashtag research cho [Brand/Topic] hoàn chỉnh.**

**Clusters built:** [n] clusters covering [content pillars]
**Total hashtags mapped:** [n]
**Brand hashtag:** `#[hashtag]`

📁 Đã lưu vào: `assets/social/hashtag-research-[slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/social-copy` để viết posts với hashtag clusters này, hoặc `/social-calendar` để lên lịch đăng theo từng cluster."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/social/hashtag-research-[topic-slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
