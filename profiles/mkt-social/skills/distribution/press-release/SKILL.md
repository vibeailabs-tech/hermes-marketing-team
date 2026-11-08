---
name: press-release
description: Writes a news release for Vietnamese business media.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: distribution
    tags: [marketing, vietnam, distribution]
    related_skills: [content-atomizer]
---

# Press Release Skill

Your job is to write press releases for Vietnamese media — product launches, company milestones, partnerships, and research findings. A press release is not a blog post and not an ad. It is a news document written in journalistic style that gives editors everything they need to run a story without additional research.

## When to Use

- There is news worth announcing to Vietnamese media.
- Owned by `mkt-social`; writes to `distribution/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/press-release` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand name and description (Section 1–2)
- Location (Section 3)
- Core offer (Section 9) — context for the announcement
- Key messages (Section 11) — what the brand always wants associated with its name

If brand.md doesn't exist: ask user for company name, announcement, and spokesperson before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User provided announcement details**
Use their input. Go to Step 3.

**Path B — No direction provided**
Ask:
"Để viết press release, mình cần biết:
1. **Announcement:** Bạn đang announce cái gì? (product launch / milestone / partnership / research)
2. **Newsworthiness:** Tại sao điều này quan trọng với độc giả — không chỉ với công ty bạn?
3. **Numbers:** Có con số cụ thể nào không? (doanh thu, số khách, % tăng trưởng)
4. **Quote:** Ai là người phát ngôn — và họ muốn nói gì?
5. **Target media:** Bạn muốn gửi đến báo/trang nào? (CafeF, VnExpress, Thanh Niên, tech blogs)"

Wait for answer before continuing.

### Step 3 — Write the press release

#### Press release structure

**Headline**
- Newsworthy, not promotional
- States the news, not the benefit
- Bad: "[Brand] Ra Mắt Sản Phẩm AI Marketing Đột Phá"
- Good: "[Brand] Giúp Doanh Nghiệp SMB Giảm 80% Chi Phí Marketing Với Hệ Thống AI"

**Dateline**
TP. Hồ Chí Minh, [Ngày tháng năm] —

**Lead paragraph (the most important)**
Answer 5 questions in 2–3 sentences: Who? What? When? Where? Why does it matter?
Everything important goes here — editors may run only the first paragraph.

**Body paragraphs (2–3)**
- Second paragraph: expand on the lead with context and detail
- Third paragraph: data, evidence, or additional context
- Quote paragraph: spokesperson quote (must add insight, not just repeat the headline)

**Boilerplate ("About [Company]")**
2–3 sentences: what the company does, who it serves, where it operates, founding year.

**Contact information**
Name, title, email, phone/Zalo — for media follow-up.

#### Vietnamese press release specifics

**Target publications:**
- Tech/business: VnExpress Kinh doanh, CafeF, Báo Đầu Tư, Nhịp Cầu Đầu Tư
- Startup/innovation: Startup Vietnam, e27 Vietnam, Tech in Asia Vietnam
- General: Thanh Niên, Tuổi Trẻ (for significant news only)
- Industry-specific: match to the brand's sector

**What Vietnamese editors want:**
- Vietnamese companies are newsworthy when they solve a local problem
- Numbers that put the story in context: market size, growth rate, customer count
- A quote from a recognizable figure or a satisfied customer
- A "why now" angle — what changed in the market that makes this relevant today

**What kills a Vietnamese press release:**
- Pure promotional language: "giải pháp toàn diện", "đột phá"
- No numbers — vague claims without data
- No clear news hook — "company announces new features" is not news
- Quote that says nothing: "Chúng tôi rất vui khi ra mắt sản phẩm này"

**Language:** Vietnamese for domestic media. English for international tech media. Bilingual for major announcements.

### Step 4 — Write output

Save to `distribution/press-release-[slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Press Release — [Headline]
> Generated: [date] | Type: [launch/milestone/partnership] | Target media: [publications]

**FOR IMMEDIATE RELEASE** / **ĐĂNG NGAY**

---

## [Headline]

**[City], [Date]** — [Lead paragraph — who, what, when, where, why it matters]

[Body paragraph 2 — context and detail]

[Body paragraph 3 — data or additional evidence]

**Quote:**
"[Spokesperson quote — adds insight, not repetition]"
— [Name], [Title], [Company]

[Closing paragraph — what happens next or broader significance]

---

### Về [Company Name]
[2–3 sentence boilerplate]

### Liên hệ báo chí:
**Tên:** [Name]
**Chức vụ:** [Title]
**Email:** [email]
**Điện thoại/Zalo:** [number]

---

## Distribution List
Recommended publications to send to:
- [Publication 1] — [contact/submission URL]
- [Publication 2]
- [Publication 3]

## Embargo note (if applicable)
[Date/time embargo lifts — or "No embargo"]
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Press release '[Headline]' đã hoàn chỉnh.**

**Type:** [announcement type]
**Lead:** '[First 20 words]...'
**Quote by:** [spokesperson]
**Target media:** [publications]

📁 Đã lưu vào: `distribution/press-release-[slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Gửi đến distribution list, hoặc chạy `/content-atomizer` để atomize announcement thành social posts."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `distribution/press-release-[slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
