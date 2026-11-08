---
name: audience-profile
description: Builds the ICP, pain points and content pillars.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: brand-foundation
    tags: [marketing, vietnam, brand-foundation]
    related_skills: [brand-voice, positioning]
---

# Audience Profile Skill

Your job is to build a clear, specific picture of who this business is talking to. Not a vague demographic range — a real person with real motivations, real pain points, and real reasons to buy.

In Vietnam, customers are deeply influenced by community, family expectations, and social proof. A good audience profile captures not just who they are, but how they think and what makes them act.

## When to Use

- Target audience, ICP or content pillars need defining (brand.md Sections 6 and 12).
- Owned by `mkt-brand`; writes `brand/brand.md`.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/audience-profile` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Check brand.md

Read the file `brand/brand.md`.

- If Section 5 (Brand Voice & Tone) is empty: warn the user — "Bạn chưa chạy /brand-voice. Mình vẫn có thể tạo audience profile, nhưng kết quả sẽ tốt hơn nếu chạy `/brand-voice` trước." Then continue anyway.
- Note the Industry and Location already filled in — use these to inform your analysis.
- You will write to Section 6 (Target Audience) and Section 12 (Content Pillars). Never touch other sections.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User already described their customers**
Use what they gave you. Go to Step 3.

**Path B — No customer info provided**
Ask all these questions at once:

---
"Để xây dựng hồ sơ khách hàng mục tiêu, mình cần biết thêm:

1. **Khách hàng hiện tại:** Mô tả người khách hàng tốt nhất của bạn — họ là ai, làm gì, bao nhiêu tuổi?
2. **Vấn đề họ gặp phải:** Trước khi tìm đến bạn, họ đang gặp khó khăn gì? Điều gì khiến họ mất ngủ?
3. **Lý do mua hàng:** Tại sao họ chọn bạn thay vì đối thủ? Họ nói gì khi giới thiệu bạn cho người khác?
4. **Hành vi online:** Họ dùng mạng xã hội nào nhiều nhất? Họ thường lên mạng vào lúc nào?
5. **Rào cản:** Điều gì khiến họ do dự trước khi mua? Họ thường hỏi gì trước khi quyết định?"

*(To build your target audience profile: 1. Describe your best current customer. 2. What problems did they have before finding you? 3. Why do they choose you over competitors? 4. Which social platforms do they use most? 5. What makes them hesitate before buying?)*

---

Wait for the user's answers before continuing.

### Step 3 — Analyze and build the profile

Based on the input and the industry/location from brand.md, build a complete audience profile.

Think carefully — Vietnamese audiences have specific patterns:

**Demographics:**
- Age range (be specific — "25–35" is more useful than "young adults")
- Gender split (if relevant to the business)
- Location (city, district, urban/suburban)
- Income level (framed in Vietnamese context: e.g. "thu nhập 10–20 triệu/tháng")
- Occupation (what they do for work, not just job title)

**Psychographics — Vietnamese context:**
- What do they value? (family, status, convenience, authenticity, savings, experiences)
- What social pressures do they feel? (face/reputation, family expectations, peer comparison)
- What does their daily life look like? (morning routine, commute, lunch break habits)
- What do they aspire to? (what does "success" look like to them)

**Pain points (dig deeper than the obvious):**
- What frustrates them about current solutions?
- What have they already tried that didn't work?
- What do they complain about to friends?

**Buying triggers:**
- What event or feeling makes them start looking for a solution?
- What type of content makes them stop scrolling?
- What pushes them from "interested" to "I'll buy now"?
- Social proof patterns: do they trust reviews, friends' recommendations, influencers, or numbers?

**Online behavior in Vietnam:**
- Facebook: news feed scrolling, groups, Facebook Live
- TikTok: entertainment, discovery, impulse decisions
- Zalo: direct communication, trusted inner circle
- Which platform do they use to discover new products?
- Which platform do they use to verify before buying?

**ICP — write this as a real person:**
One paragraph. Give them a name. Describe a day in their life. Make it feel like someone you could call on the phone.

Example:
> "Minh, 28 tuổi, nhân viên văn phòng ở Bình Thạnh. Tan làm lúc 6 giờ tối, hay ghé quán cà phê trước khi về nhà để 'xả stress' một mình. Scroll TikTok khoảng 45 phút mỗi tối. Thích những quán có 'góc sống ảo' nhưng không muốn bị nhìn như đang cố. Tin vào review của bạn bè hơn quảng cáo."

**Content Pillars — derived from the audience:**
Based on what this audience cares about, what 3–5 content topics would naturally attract and engage them? These should feel like topics they'd share, save, or comment on — not topics the brand just wants to talk about.

### Step 4 — Write to brand.md

Update `brand/brand.md`:
- Write Section 6 (Target Audience) — full profile
- Write Section 12 (Content Pillars) — 3–5 pillars with explanation
- Update the `Last updated` date
- Never touch any other section

### Step 5 — Confirm

After writing, reply:

---
"✅ **Hồ sơ khách hàng của [Brand Name] đã được lưu.**

**Tóm tắt:**
- Đối tượng chính: [one sentence description]
- Nỗi đau lớn nhất: [top pain point]
- Trigger mua hàng: [main buying trigger]
- Nền tảng chính: [Facebook / TikTok / Zalo]

**ICP:**
[The one-paragraph person description]

**Content Pillars:**
1. [Pillar 1]
2. [Pillar 2]
3. [Pillar 3]

📁 Đã lưu vào: `brand/brand.md` — Mục 6 + Mục 12

**Bước tiếp theo:** Chạy `/positioning` để xây dựng định vị cạnh tranh."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Only change the brand.md sections this skill owns and refresh `Last updated`; log each change in `brand/changelog.md`.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- The brand.md sections this skill owns contain no `[To be filled]` and `Last updated` is today.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
