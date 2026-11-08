---
name: brand-setup
description: Runs the full 18-question onboarding to build brand.md.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: brand-foundation
    tags: [marketing, vietnam, brand-foundation]
---

# Brand Setup Skill

This is the starting point for every new client. You will guide them through building their complete brand profile — all 12 sections of brand.md — in one session.

You are not running 4 separate skills back to back mechanically. You are running one smooth onboarding conversation. Collect everything you need, then build everything at once at the end.

## When to Use

- A new client needs the full brand profile built from zero, or the user asks to redo brand.md entirely.
- Owned by `mkt-brand`; writes `brand/brand.md`.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` (pre-created from the workspace template) and `references/brand-md-schema.md` for the 12-section schema.

## How to Run

- **Chat:** `/brand-setup` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### What this command does

Runs the full Brand Foundation Agent workflow in sequence:
1. **brand-voice** → Sections 1–5 (Brand Name, Industry, Location, Language, Voice & Tone)
2. **audience-profile** → Sections 6 + 12 (Target Audience, Content Pillars)
3. **positioning** → Sections 7 + 9 + 10 (Positioning, Core Offer, Competitors)
4. **usp-definition** → Sections 8 + 11 (USP, Key Messages)

At the end: all 12 sections of brand.md are filled.

---

### Step 1 — Welcome

Open with:

---
"Chào mừng bạn đến với Brand Foundation Setup! 🎯

Mình sẽ giúp bạn xây dựng toàn bộ hồ sơ thương hiệu — từ giọng nói, khách hàng mục tiêu, định vị cạnh tranh, đến điểm bán hàng độc nhất — tất cả trong một buổi làm việc.

**Kết quả cuối:** File `brand.md` hoàn chỉnh với 12 sections — nền tảng để mọi agent trong hệ thống hoạt động.

Bắt đầu với thông tin cơ bản nhé:"

*(Welcome to Brand Foundation Setup! I'll help you build your complete brand profile — voice, audience, positioning, USP — all in one session. Result: a complete brand.md with 12 sections.)*

---

### Step 2 — Collect all input at once

Ask everything in one message. Don't split into multiple rounds:

---
"Để hoàn thành toàn bộ brand profile, mình cần bạn trả lời các câu hỏi sau. Càng chi tiết càng tốt — mình sẽ xử lý và xây dựng mọi thứ từ câu trả lời của bạn.

---

**PHẦN 1 — Thương hiệu & Giọng nói**
1. Tên doanh nghiệp và lĩnh vực kinh doanh?
2. Bạn hoạt động ở đâu? (TP.HCM / Hà Nội / toàn quốc...)
3. Nếu thương hiệu là một người, họ sẽ như thế nào? Chọn 3 từ: (vui vẻ / nghiêm túc / ấm áp / chuyên nghiệp / trẻ trung / đáng tin / táo bạo / thân thiện...)
4. Dán 2–3 bài đăng hoặc đoạn nội dung bạn đã viết — hoặc mô tả cách bạn hay nói chuyện với khách.
5. Ngôn ngữ nội dung: Tiếng Việt / Tiếng Anh / Cả hai?

---

**PHẦN 2 — Khách hàng**
6. Mô tả người khách hàng tốt nhất của bạn — họ là ai, làm gì, bao nhiêu tuổi?
7. Trước khi tìm đến bạn, họ đang gặp khó khăn gì?
8. Tại sao họ chọn bạn? Họ nói gì khi giới thiệu bạn cho người khác?
9. Họ dùng mạng xã hội nào nhiều nhất và vào lúc nào?
10. Điều gì khiến họ do dự trước khi mua?

---

**PHẦN 3 — Định vị & Cạnh tranh**
11. Kể tên 2–3 đối thủ chính. Điểm mạnh và yếu của họ là gì?
12. Bạn làm được điều gì mà đối thủ không làm được?
13. Sản phẩm/dịch vụ chủ lực của bạn là gì? Mức giá?
14. Bạn muốn được nhớ đến như thế nào trong 3 năm tới?

---

**PHẦN 4 — USP & Bằng chứng**
15. Bạn có quy trình, phương pháp, hay cam kết nào đặc biệt không?
16. Khách hàng trông như thế nào TRƯỚC và SAU khi dùng sản phẩm/dịch vụ của bạn?
17. Bạn có con số, giải thưởng, hay review nổi bật nào không?
18. Nếu phải đưa ra một lời hứa với khách hàng — bạn tự tin nhất điều gì?

---

*(Take your time — the more detail you give, the stronger your brand profile will be.)*"

---

Wait for all answers before proceeding.

### Step 3 — Build everything

From the answers, build all 4 skill outputs simultaneously:

**Brand Voice (Sections 1–5):**
- Extract personality traits, tone, vocabulary, writing style
- Determine Vietnamese register (bạn/mình vs anh/chị vs quý khách)
- Platform adaptations for Facebook, TikTok, Zalo
- 3 example sentences in their voice

**Audience Profile (Sections 6 + 12):**
- Full demographics and psychographics
- Top 5 pain points
- Buying triggers and online behavior
- ICP as a real Vietnamese person (give them a name)
- 3–5 content pillars derived from what they care about

**Positioning (Sections 7 + 9 + 10):**
- Positioning statement using the formula: "For [audience], [brand] is the only [category] that [benefit] — unlike [competitors] who [weakness]"
- Core promise (one sentence)
- Market category and competitive angle
- Core offer defined precisely
- Competitor table filled

**USP (Sections 8 + 11):**
- Unique mechanism named and explained
- Before/after transformation (emotional, specific)
- Proof points framed for maximum credibility
- 5 headline directions in Vietnamese
- 3 key messages the brand always comes back to

### Step 4 — Create brand.md

Check if `brand/brand.md` exists.

- If it does not exist: create it using the full 12-section schema from `references/brand-md-schema.md`
- If it exists: overwrite only the sections this command owns (all 12 — this is a full setup)

Write all 12 sections. Set `Last updated` to today's date.

### Step 5 — Confirm

After writing, reply:

---
"✅ **Brand profile của [Brand Name] đã hoàn chỉnh!**

---

**Tóm tắt nhanh:**

🎨 **Giọng thương hiệu:** [3 personality traits] — [one sentence on tone]
👥 **Khách hàng mục tiêu:** [one sentence ICP summary]
🎯 **Định vị:** [positioning statement in one sentence]
💡 **USP:** [unique mechanism in one sentence]

---

**ICP:**
[The one-paragraph real person description]

**Câu định vị:**
"[Full positioning statement in Vietnamese]"

**5 Headline directions:**
1. [Headline 1]
2. [Headline 2]
3. [Headline 3]
4. [Headline 4]
5. [Headline 5]

**Content Pillars:**
1. [Pillar 1]
2. [Pillar 2]
3. [Pillar 3]

---

📁 Đã lưu vào: `brand/brand.md` — Tất cả 12 mục

**Bước tiếp theo:**
- Chạy `market-research` (`mkt-research`) để nghiên cứu thị trường với dữ liệu thực
- Hoặc chạy `blog-writer` (`mkt-content`), `social-copy` (`mkt-social`), `email-sequence` (`mkt-growth`) để bắt đầu tạo nội dung ngay"

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Only change the brand.md sections this skill owns and refresh `Last updated`; log each change in `brand/changelog.md`.
- If brand.md already has content, confirm before overwriting all 12 sections.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- The brand.md sections this skill owns contain no `[To be filled]` and `Last updated` is today.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
