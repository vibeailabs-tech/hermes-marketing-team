---
name: cold-email
description: Writes 3-version first-touch emails to prospects.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: outreach
    tags: [marketing, vietnam, outreach]
    related_skills: [follow-up-sequence, personalization-framework]
---

# Cold Email Skill

Your job is to write cold outreach emails that get replies — not opens, not clicks, replies. A cold email that gets opened but ignored is worthless. Every word in a cold email must earn its place by moving the reader one step closer to replying.

## When to Use

- The client wants first-touch cold emails to prospects.
- Owned by `mkt-growth`; writes to `assets/outreach/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/cold-email` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice (Section 5) — cold emails must match brand tone
- Core offer (Section 9) — what you're ultimately selling
- Target audience (Section 6) — who you're reaching out to
- USP (Section 8) — the one claim that makes this worth their time

If `assets/outreach/personalization-framework-*.md` exists: use it to personalize each email.
If brand.md doesn't exist: ask user for offer, ICP, and sender name before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User provided prospect info or campaign context**
Use their input. Go to Step 3.

**Path B — No direction provided**
Ask:
"Để viết cold email, mình cần biết:
1. **Prospect:** Họ là ai? (role, company type, industry)
2. **Pain point cụ thể:** Vấn đề nào của họ mà offer của bạn giải quyết được?
3. **Personalization:** Bạn có thông tin gì về prospect không? (recent post, company news, job change)
4. **CTA:** Bạn muốn họ làm gì? (15-min call / reply với câu hỏi / xem case study)
5. **Sender:** Email này gửi từ tên ai và vai trò gì?"

Wait for answer before continuing.

### Step 3 — Write cold emails

#### The cold email rules

**Rule 1: Short wins every time**
- Subject line: 3–6 words
- Body: 5–8 sentences max
- Total reading time: under 30 seconds
- If you can cut a sentence without losing meaning, cut it

**Rule 2: One ask only**
Never ask for a call AND a reply AND to check out your website. One email, one ask. The ask should be the lowest-friction possible action.

**Rule 3: It's about them, not you**
Every sentence that starts with "Mình" or "[Your Brand]" is a sentence that's not about the prospect. Flip it: what do THEY get, what do THEY care about, what did THEY do that prompted this email.

**Rule 4: No pitching in the first email**
The goal of email 1 is a reply. Not a sale. Not a demo. A reply. Pitch when they respond.

**Rule 5: Specific beats generic every time**
"Mình thấy bạn vừa đăng bài về AI marketing trên LinkedIn" beats "Mình đang liên hệ các doanh nghiệp trong ngành của bạn." Specificity signals you're not spamming.

#### Cold email structure (PASTE framework)

**P — Problem (1 sentence)**
Name their specific problem. Not a generic industry problem — their actual situation.

**A — Acknowledge (1 sentence)**
Show you understand why it's hard. Credibility signal.

**S — Solution hint (1–2 sentences)**
What you do — framed as the outcome they get, not the features you offer. Don't over-explain.

**T — Tease proof (1 sentence)**
One result or social proof signal. Specific number if possible.

**E — Easy ask (1 sentence)**
The lowest-friction CTA. "Worth a 15-minute call?" or "Có muốn mình gửi case study không?"

#### Subject line formulas

- **Question:** "Bạn đang trả bao nhiêu cho content mỗi tháng?"
- **Specific reference:** "[Tên công ty] + AI marketing"
- **Result:** "Từ $500 xuống $80/tháng — case study"
- **Mutual connection:** "[Tên người] gợi ý mình liên hệ bạn"
- **Direct:** "Ý tưởng cho [company] re: marketing automation"

Avoid: "Cơ hội hợp tác", "Giới thiệu dịch vụ", "Partnership proposal" — these are deleted unread.

#### Vietnamese cold email specifics

**Register:** Start with "Chào [Tên]," — more personal than "Kính gửi". Use "bạn/mình" throughout.

**Zalo alternative:** Many Vietnamese B2B contacts respond faster on Zalo than email. If you have their Zalo, a short Zalo message before the email warms it up. Reference this in the email: "Mình vừa nhắn Zalo bạn nữa."

**Timing:** Tuesday–Thursday, 8–9am or 2–3pm GMT+7 — highest open rates for Vietnamese B2B.

**Length in Vietnamese:** Vietnamese cold emails can be slightly longer than English equivalents — 6–10 sentences is acceptable. Vietnamese readers expect a bit more context before the ask.

**Cultural note:** Vietnamese B2B decision makers respond well to peer referrals and social proof from Vietnamese companies. If you have a Vietnamese client they'd recognize, name them.

#### Write 3 versions

Always write 3 versions for testing:
- **Version A:** Problem-led — opens with their pain
- **Version B:** Result-led — opens with a specific outcome
- **Version C:** Referral/trigger-led — references something specific about them

### Step 4 — Write output

Save to `assets/outreach/cold-email-[prospect-slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Cold Email — [Prospect/Campaign Name]
> Generated: [date] | Prospect: [role + company type] | CTA: [ask]

---

## Version A — Problem-led

**Subject:** [3–6 words]
**Preview text:** [30–40 chars — what shows after subject in inbox]

---

Chào [Tên],

[Body — 5–8 sentences, PASTE structure]

[Signature]
[Name] | [Title]
[Zalo number]

---

## Version B — Result-led

**Subject:** [3–6 words]

---

[Body]

---

## Version C — Referral/Trigger-led

**Subject:** [3–6 words]

---

[Body]

---

## Testing Notes
- Send A/B split: Version [X] vs [Y] first
- Reply rate benchmark: >5% = good, >10% = excellent for cold B2B
- If no reply after 3 days: trigger follow-up sequence
- Best send time: Tuesday–Thursday, 8–9am GMT+7
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Cold emails cho '[Prospect/Campaign]' đã hoàn chỉnh — 3 versions.**

**Versions:** Problem-led / Result-led / Referral-led
**CTA:** [ask]
**Recommended test:** Version [X] first — [one-line reason]

📁 Đã lưu vào: `assets/outreach/cold-email-[slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/follow-up-sequence` để build chuỗi follow-up, hoặc `/personalization-framework` để personalize cho từng prospect."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/outreach/cold-email-[prospect-slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
