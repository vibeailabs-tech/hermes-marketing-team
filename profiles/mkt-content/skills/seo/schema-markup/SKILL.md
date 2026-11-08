---
name: schema-markup
description: Writes JSON-LD structured data for rich results.
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

# Schema Markup Skill

Your job is to write valid JSON-LD structured data for Vietnamese business pages — helping Google understand page content and display rich results (FAQs, reviews, business info, breadcrumbs).

## When to Use

- A page needs JSON-LD structured data for rich results.
- Owned by `mkt-content`; writes to `assets/seo/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/schema-markup` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand name, location, industry (Sections 1–3)
- Core offer and pricing (Section 9)

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User specified page type and content**
Use what they gave. Go to Step 3.

**Path B — No specifics**
Ask:
"Để viết schema markup, mình cần biết:
1. **Loại trang:** Homepage / Service page / Blog post / FAQ page / Contact page
2. **Nội dung trang:** Paste nội dung chính (hoặc mô tả ngắn)
3. **Thông tin business:** Địa chỉ, phone, email, giờ mở cửa (nếu relevant)
4. **Đã có schema chưa?** Nếu có, paste code để mình check"

Wait for answer.

### Step 3 — Select schema types

#### Vietnamese business schema priority:

**Always include on every page:**
- `WebPage` or page-specific type
- `BreadcrumbList` (if site has navigation depth)

**By page type:**

**Homepage / About:**
- `Organization` — business name, URL, logo, contact, social profiles
- `LocalBusiness` (if physical location or serving local area)
  - Vietnamese specific: use `addressRegion` for tỉnh/thành, `addressLocality` for quận/huyện

**Service/Product pages:**
- `Service` — name, description, provider, areaServed
- `Product` (if e-commerce) — name, description, offers, aggregateRating
- `Offer` — price, priceCurrency (VND), availability

**Blog posts:**
- `Article` or `BlogPosting` — headline, author, datePublished, dateModified, image
- `BreadcrumbList`

**FAQ pages (high value for Vietnamese market):**
- `FAQPage` with `Question` and `Answer` — this generates FAQ rich results in SERP, which significantly improves CTR

**Local business:**
- `LocalBusiness` with full address, openingHoursSpecification, geo coordinates
- `PostalAddress` with Vietnamese address format

**Reviews/Testimonials pages:**
- `AggregateRating` — ratingValue, reviewCount, bestRating

#### Vietnamese-specific schema notes:
- `addressCountry`: "VN"
- `priceCurrency`: "VND"
- Phone format: "+84-xxx-xxx-xxxx"
- Language: `inLanguage`: "vi" for Vietnamese content

### Step 4 — Write schema code

For each applicable schema type:
1. Write valid JSON-LD (not Microdata or RDFa — JSON-LD is Google's preferred format)
2. Fill in real values from brand.md and user input
3. Add implementation instructions (where to paste in HTML)
4. Validate mentally against Google's requirements (check for required vs. recommended properties)

**JSON-LD format:**
```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "...",
  ...
}
</script>
```

**Where to place:** Inside `<head>` tag or at bottom of `<body>` — both work for Google.

### Step 5 — Write output

Save to `assets/seo/schema-markup-[page-name]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Schema Markup — [Page Name]
> Generated: [date] | Page type: [type] | Schema types: [list]

## Implementation Instructions

Paste each block inside the `<head>` section of [page name]. 
Test with Google's Rich Results Test after implementation.

---

## Schema Block 1 — [Type]

**Purpose:** [what this schema does / what rich result it enables]

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "[Type]",
  ...
}
</script>
```

---

## Schema Block 2 — [Type] (if applicable)

**Purpose:** 

```html
<script type="application/ld+json">
{
  ...
}
</script>
```

---

## Validation Checklist

- [ ] Test with Google Rich Results Test (search.google.com/test/rich-results)
- [ ] No errors in Google Search Console after deploying
- [ ] JSON is valid (no syntax errors)
- [ ] Required fields for [schema type] are all present

## Expected Rich Results

After implementing and Google indexing:
- [What rich result should appear in SERP]
- [Estimated CTR improvement]
```

### Step 6 — Confirm

After writing:

---
"✅ **Schema markup cho [page name] hoàn chỉnh.**

**Schema types viết:** [list]
**Rich results có thể xuất hiện:** [what Google might show]
**Cách test:** Google Rich Results Test

📁 Đã lưu: `assets/seo/schema-markup-[page-name]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/technical-seo-audit` để check toàn bộ site, hoặc `/on-page-seo` để optimize page content."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/seo/schema-markup-[page-name]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
