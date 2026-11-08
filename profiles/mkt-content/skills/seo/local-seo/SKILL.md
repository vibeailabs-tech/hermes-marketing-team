---
name: local-seo
description: Plans Google Business Profile, citations and reviews.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: seo
    tags: [marketing, vietnam, seo]
    related_skills: [on-page-seo, technical-seo-audit]
---

# Local SEO Skill

Your job is to optimize a Vietnamese business for local search — Google Business Profile signals, local keyword targeting, location-specific content, and citation strategy. No APIs required; pure analysis and recommendations.

## When to Use

- The business needs local visibility: Google Business Profile, citations, reviews.
- Owned by `mkt-content`; writes to `assets/seo/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/local-seo` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Location (Section 3) — district, city
- Industry and core offer (Sections 2 + 9)
- Target audience (Section 6) — especially how they search locally

If location is blank or "toàn quốc" (nationwide): note that local SEO is less critical but still relevant for Vietnamese search behavior.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User provided Google Business Profile URL or local search info**
Use what they gave. Go to Step 3.

**Path B — No local info provided**
Ask:
"Để tối ưu local SEO, mình cần biết:
1. **Địa chỉ chính xác:** Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố
2. **Google Business Profile:** Bạn đã có chưa? Link nếu có.
3. **Từ khóa địa phương:** Khách hàng thường tìm bạn bằng từ khóa nào? (VD: 'spa quận 7', 'kế toán TPHCM')
4. **Đối thủ local:** 2–3 đối thủ cùng khu vực"

Wait for answer.

### Step 3 — Analyze local SEO opportunities

#### Vietnamese local search context:
- **Google Maps dominance**: Vietnamese users search heavily on Google Maps for local services
- **"Gần đây" searches**: "quán cà phê gần đây", "spa gần đây" — proximity signals matter
- **Zalo as local discovery**: Many Vietnamese businesses are found via Zalo — recommend Zalo Official Account if applicable
- **Facebook local presence**: Facebook is often searched for local businesses in Vietnam — business page optimization is part of local SEO
- **Review platforms**: Google Reviews, Facebook Reviews, and local directories like YellowPages Vietnam

#### Google Business Profile audit checklist:
- Business name matches exactly what's on website
- Primary category is the most specific match available
- Secondary categories added for all services
- Complete address with correct district format for Vietnamese addresses
- Phone number: Vietnamese format (+84 or 0xxx-xxx-xxx)
- Website URL linked
- Business hours complete including holidays (Tết, lễ)
- Photos: exterior, interior, team, products/services (minimum 10)
- Description: 750 characters, keywords in first 250
- Q&A section seeded with common customer questions

#### Local keyword strategy:
Build keyword variations for:
- `[service] [city]` (e.g., "thiết kế website TPHCM")
- `[service] quận [district]` (e.g., "spa quận 7")
- `[service] gần [landmark]` (e.g., "nhà hàng gần Bến Thành")
- Vietnamese question format: "ở đâu", "tại TPHCM", "chất lượng"

#### Local content recommendations:
1. Location landing page: `/[city]/[service]` or `/[service]-[city].html`
2. Local blog content: "[Top X] + [service] + [location]" format
3. Neighborhood/district-specific pages if multiple locations

#### Citation building:
Vietnamese directories to list on:
- Google Business Profile (critical)
- Facebook Business Page (critical)
- Zalo Official Account
- Foody / Eatigo (restaurants/F&B)
- Booking.com / Agoda (hospitality)
- YellowPages Vietnam (yp.vn)
- Vietnam Business Directory (doanhnghiep.vn)
- Industry-specific directories

### Step 4 — Write output

Save to `assets/seo/local-seo-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Local SEO Strategy — [Brand Name]
> Generated: [date] | Location: [city/district]

## Local SEO Score (Current State)

| Factor | Status | Priority |
|---|---|---|
| Google Business Profile | Exists / Missing / Incomplete | High/Med/Low |
| NAP consistency (Name/Address/Phone) | | |
| Local keyword targeting | | |
| Location pages on website | | |
| Local citations | | |
| Reviews strategy | | |

---

## Google Business Profile — Action List

### Must fix immediately:
- 

### Should add this week:
- 

### Ongoing (monthly):
- 

---

## Local Keyword Map

### Primary local keywords (target these first):
| Keyword | Search intent | Recommended page |
|---|---|---|
| | | |

### Secondary (blog/supporting content):
| Keyword | Content angle |
|---|---|
| | |

---

## Location Page Recommendations

**Create these pages:**
1. URL: `/[slug]` — Target keyword: [keyword] — Content brief: [summary]
2. 
3. 

**Template structure for each location page:**
- H1: [Service] tại [City/District]
- Intro: 150 words with local keyword
- Why choose us in [location]: 3 points
- Service details
- Local testimonials / reviews
- Map embed
- Local CTA: "Gọi ngay" or "Book hẹn"

---

## Citation Building — Priority List

| Directory | URL | Status | Priority |
|---|---|---|---|
| Google Business Profile | | | Critical |
| Facebook Business Page | | | Critical |
| Zalo Official Account | | | High |
| [Industry-specific] | | | High |

---

## Reviews Strategy

**Request timing:** [when to ask — after service completion, specific trigger]
**Request method:** [Zalo message template, QR code, email]
**Response template for positive reviews:**
[template]
**Response template for negative reviews:**
[template]

---

## 30-Day Local SEO Quick Win Plan

Week 1:
- 

Week 2:
- 

Week 3–4:
- 
```

### Step 5 — Confirm

After writing:

---
"✅ **Local SEO strategy cho [Brand Name] hoàn chỉnh.**

**Ưu tiên ngay:**
- [Top 1 action]
- [Top 2 action]

**Keywords địa phương quan trọng nhất:** [top 3]

📁 Đã lưu: `assets/seo/local-seo-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/on-page-seo` để optimize location pages, hoặc `/technical-seo-audit` để check site-wide issues."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/seo/local-seo-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
