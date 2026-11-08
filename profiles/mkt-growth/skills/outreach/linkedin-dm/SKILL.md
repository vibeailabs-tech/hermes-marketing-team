---
name: linkedin-dm
description: Writes connection notes and DM sequences for LinkedIn.
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

# LinkedIn DM Skill

Your job is to write LinkedIn direct messages for cold outreach — connection requests, opening DMs, and follow-up messages. LinkedIn DMs have different rules than cold email: shorter, more conversational, and the connection request note is your first impression in 300 characters.

## When to Use

- The client prospects on LinkedIn and needs connection notes and DMs.
- Owned by `mkt-growth`; writes to `assets/outreach/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/linkedin-dm` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Brand voice (Section 5) — DMs must match brand tone
- Core offer (Section 9) — what you're ultimately moving toward
- Target audience (Section 6) — the roles and industries you're targeting
- USP (Section 8) — the specific value you bring

If `assets/outreach/personalization-framework-*.md` exists: use it.
If brand.md doesn't exist: ask user for offer, sender profile, and prospect type before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User provided prospect context**
Use their input. Go to Step 3.

**Path B — No direction provided**
Ask:
"Để viết LinkedIn DMs, mình cần biết:
1. **Prospect role:** Marketing Manager / Founder / CMO / ...?
2. **Trigger (nếu có):** Họ vừa post gì, vừa thay đổi job, vừa comment gì không?
3. **Connection stage:** Chưa connect / Đã connect nhưng chưa chat / Đã chat rồi?
4. **CTA:** Call / Email / Content share / Just start conversation?
5. **Sender profile:** LinkedIn của bạn có nhiều follower không, hay account mới?"

Wait for answer before continuing.

### Step 3 — Write LinkedIn DMs

#### LinkedIn DM rules

**Connection request note (300 chars max):**
- The most underused real estate on LinkedIn
- Don't: "Xin chào, mình muốn kết nối để mở rộng mạng lưới" — generic, ignored
- Do: Reference something specific + one-line value signal + no ask yet
- Goal: Get the connection accepted, nothing more

**Opening DM after connection (once connected):**
- Max 3–4 sentences
- No pitch in the first message — ever
- Reference the connection request context
- Ask ONE question that invites a reply
- The question should be about them, not about your offer

**Follow-up DM (if no reply to opening):**
- Max 2–3 sentences
- Add new value (share an insight, article, or observation)
- Don't repeat the first message — add something new
- Soft re-engagement: "Mình nghĩ bài này bạn sẽ thấy relevant..."

**The pitch DM (only after conversation has started):**
- Only pitch when they've engaged — replied at least once
- Frame as a natural next step, not a sudden pivot
- Keep it short: what it is, what they get, lowest-friction ask

#### LinkedIn DM formats

**Format 1 — Trigger-based (best open rate)**
Reference something specific about their activity:
- They posted about a topic related to your offer
- They commented on someone else's post
- They changed jobs or got promoted
- They liked a post you or a competitor made

"Chào [Tên], mình vừa đọc bài bạn về [topic] — [one genuine observation]. Mình đang research về [related topic] và curious về góc nhìn của bạn: [one question]?"

**Format 2 — Mutual connection**
Someone introduced you or you share a connection:
"Chào [Tên], mình và [mutual] vừa nói chuyện về [topic] và anh ấy gợi ý mình kết nối với bạn. [One sentence why relevant]. [One easy question]?"

**Format 3 — Content-led**
Share something genuinely useful before asking for anything:
"Chào [Tên], mình vừa viết [article/analysis] về [topic relevant to them] — nghĩ bạn sẽ thấy phần về [specific section] interesting vì [reason specific to their role]. Happy to share nếu bạn muốn?"

**Format 4 — Direct (for warm-ish prospects)**
When they've engaged with your content or you have a strong referral:
"Chào [Tên], mình thấy bạn [specific engagement]. Mình đang work với [type of company] để [outcome] — thường mất [timeframe]. Có phù hợp không nếu mình share thêm?"

#### Connection request note templates (300 chars)

Write 3 variations per prospect type:
- Curiosity angle: Reference their content + genuine question
- Mutual value angle: What you both care about
- Direct angle: Why you specifically want to connect with them

#### Vietnamese LinkedIn specifics

**Language choice:** Vietnamese LinkedIn DMs can be in Vietnamese or English depending on the prospect's profile language. Check their posts — if they post in Vietnamese, DM in Vietnamese. If English, use English.

**Register:** More formal than Zalo but less formal than email. "Bạn/mình" is fine for peer-level outreach. "Anh/chị" for senior prospects.

**LinkedIn activity in Vietnam:** LinkedIn is used primarily by startup founders, corporate marketing managers, and international-facing roles. Pure Vietnamese SMB owners are more active on Facebook and Zalo — LinkedIn DMs may be less effective for that segment.

**InMail vs DM:** If not connected, InMail has higher visibility but costs credits. Connection request + note is free and works if the note is compelling.

### Step 4 — Write output

Save to `assets/outreach/linkedin-dm-[prospect-slug]-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# LinkedIn DM Sequence — [Prospect Type/Campaign]
> Generated: [date] | Prospect: [role] | Stage: [cold/warm] | Language: [VI/EN]

---

## Connection Request Note (300 chars max)

**Version A — Curiosity:**
[Note text] ([char count])

**Version B — Mutual value:**
[Note text] ([char count])

**Version C — Direct:**
[Note text] ([char count])

---

## Opening DM (after connection accepted)

**Version A — Trigger-based:**
[DM text — 3–4 sentences]

**Version B — Content-led:**
[DM text]

---

## Follow-up DM (if no reply after 5–7 days)

[DM text — 2–3 sentences, adds new value]

---

## Pitch DM (after they've replied at least once)

[DM text — short, specific, one ask]

---

## Notes
- Best time to send: Tuesday–Thursday, 9–11am (when LinkedIn is most active)
- Don't send connection request + DM on same day — wait for connection to be accepted
- If no reply after follow-up: move to email outreach
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **LinkedIn DM sequence cho '[Prospect Type]' đã hoàn chỉnh.**

**Messages written:**
- Connection request: 3 versions
- Opening DM: 2 versions
- Follow-up: 1 version
- Pitch DM: 1 version

📁 Đã lưu vào: `assets/outreach/linkedin-dm-[slug]-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/follow-up-sequence` để build full multi-channel sequence, hoặc `/personalization-framework` để scale personalization."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/outreach/linkedin-dm-[prospect-slug]-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
