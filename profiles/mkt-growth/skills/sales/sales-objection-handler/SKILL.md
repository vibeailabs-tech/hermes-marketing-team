---
name: sales-objection-handler
description: Writes objection answers for email, Zalo and calls.
version: 1.0.0
author: Vibe AI Labs
license: Proprietary
platforms: [linux, macos]
metadata:
  hermes:
    category: sales
    tags: [marketing, vietnam, sales]
    related_skills: [proposal-writer, sales-case-study]
---

# Sales Objection Handler Skill

Your job is to write responses to sales objections — for email, Zalo, and sales calls. An objection is not a rejection. It's a request for more information or reassurance. The right response doesn't argue — it acknowledges, clarifies, counters with evidence, and re-opens the conversation.

## When to Use

- The sales process needs FAQ and objection answers for pages, Zalo and calls.
- Owned by `mkt-growth`; writes to `assets/sales/` in the active client folder.

## Prerequisites

- Work inside the active client folder `clients/<slug>/` of the marketing workspace; every path below is relative to it (see the workspace `AGENTS.md`).
- `brand/brand.md` with the sections this skill reads. If it is missing or still `[To be filled]`, use the fallback in the first step; as a Kanban worker, call `kanban_block` and say `brand-setup` (`mkt-brand`) must run first.

## How to Run

- **Chat:** `/sales-objection-handler` plus your request; the skill asks for anything it still needs.
- **Kanban worker:** the card body and comments are the user's answers. Where a step says to ask the user and
  wait, use them; if something essential is still missing, call `kanban_block` with the exact questions instead
  of guessing. Close with `kanban_complete` (summary plus output paths as `artifacts`), or
  `kanban_request_review` when the output must be approved before it ships.
- Skills written as `skill` (`profile`) belong to another specialist: suggest them as next steps, never run them here.

## Procedure

### Step 1 — Read inputs

Read `brand/brand.md`. Extract:
- Core offer (Section 9) — what you're defending
- USP (Section 8) — the differentiation that counters most objections
- Target audience (Section 6) — their fears and hesitations
- Key messages (Section 11) — proof points to use in responses

If `assets/sales/case-study-*.md` exists: pull specific results to use as counter-evidence.
If brand.md doesn't exist: ask user for offer, price, and common objections heard before continuing.

### Step 2 — Collect input

Look at what the user has already provided. Then choose the right path:

**Path A — User specified objections to handle**
Write responses for those specific objections. Go to Step 3.

**Path B — No direction provided**
Write responses for the 7 universal objections. Go to Step 3.

### Step 3 — Write objection responses

#### The ACCA framework for every objection

**A — Acknowledge:** Validate the concern. Never argue or dismiss immediately.
**C — Clarify:** Ask one question to understand the real objection behind the surface one. Most surface objections ("giá cao") hide a deeper one ("I don't see the ROI yet").
**C — Counter:** Provide specific evidence, reframe, or address the real concern.
**A — Ask:** Re-open with a low-friction question that moves the conversation forward.

#### The 7 universal objections

**Objection 1: "Giá cao quá"**
Real concern: "I don't see the ROI clearly enough to justify this."
Counter: Anchor to cost of alternative. "Bạn đang trả $X/tháng cho agency × 12 tháng = $X — và bạn không sở hữu gì. Setup một lần $X — bạn sở hữu mãi mãi."

**Objection 2: "Để suy nghĩ thêm / Để xem xét"**
Real concern: Insufficient conviction — something wasn't clear or compelling enough.
Counter: Surface the real hesitation. "Hoàn toàn hợp lý. Thường khi mọi người nói vậy, có một điều cụ thể chưa rõ — là phần nào bạn muốn mình giải thích thêm?"

**Objection 3: "Đang dùng [Competitor] rồi"**
Real concern: Switching cost, or genuinely satisfied (rare).
Counter: Acknowledge their choice, ask about gaps. "Tốt — [Competitor] có điểm mạnh riêng. Bạn đang dùng cho phần nào? Mình hay gặp nhất là [specific gap] — đó có phải vấn đề với bạn không?"

**Objection 4: "Không có budget lúc này"**
Real concern: Sometimes true. Often means "I don't see enough value yet."
Counter: Distinguish between the two. "Mình hiểu. Nếu budget thật sự là vấn đề — mình có thể suggest cách tiếp cận nhỏ hơn để bắt đầu. Nhưng nếu câu hỏi thật sự là ROI — bạn muốn mình walk through số không?"

**Objection 5: "AI không phù hợp với ngành/công ty mình"**
Real concern: Fear of change, or genuine industry-specific concern.
Counter: Ask for specifics. "Điều gì về ngành của bạn khiến bạn nghĩ vậy? Mình đã setup cho [relevant industry example] — và vấn đề chính thường không phải là ngành mà là [common real issue]."

**Objection 6: "Đã thử AI rồi, không hiệu quả"**
Real concern: Real past experience — this deserves genuine respect, not dismissal.
Counter: Dig into what they tried. "Mình muốn hiểu thêm — bạn đã thử gì cụ thể? Thường khi AI không work, nguyên nhân là [no brand memory / no system / wrong tool for the job] — và đó chính xác là thứ mình build khác."

**Objection 7: "Tự làm được / Không cần thuê ngoài"**
Real concern: They want control and ownership (actually aligned with your offer).
Counter: Agree with the goal, redirect to the method. "Hoàn toàn đúng — đó là lý do mình không bán dịch vụ retainer. Mình setup để bạn tự chạy và sở hữu toàn bộ. Câu hỏi là bao lâu bạn tự build được vs setup sẵn trong 9 ngày."

#### Response formats by channel

**Email response (3–5 sentences):**
- Acknowledge in 1 sentence
- Clarifying question OR counter in 2 sentences
- Re-ask in 1 sentence
- Never over-explain — one strong counter beats three weak ones

**Zalo response (2–3 sentences):**
- Even shorter — Zalo is conversational
- Acknowledge + one question or one counter
- Emoji OK if brand voice allows (1 max)

**Call script (spoken format):**
- Pause after they finish — don't rush to respond
- "Mình hiểu..." + 1 sentence acknowledge
- "Bạn có thể nói thêm về..." (clarify) OR go straight to counter if clear
- Counter with one proof point — don't over-defend
- "Điều đó có giải quyết được lo ngại của bạn không?"

#### Vietnamese sales culture specifics

**"Để xem xét" is rarely a hard no:** Vietnamese buyers avoid direct rejection. "Để suy nghĩ thêm" can mean genuine consideration, soft no, or "I need to talk to my partner/co-founder." Always clarify which.

**Price negotiation is expected:** Vietnamese buyers often negotiate on price even if they intend to buy. Don't drop price immediately — offer value-add (extra session, extended support) before discounting.

**Decision makers:** In Vietnamese SMBs, the founder often decides alone but may consult a spouse or business partner. "Để hỏi thêm" sometimes means this. Offer to join a second call with both.

**Never argue:** Vietnamese business culture avoids confrontation. Arguing with an objection — even when you're right — creates resistance. Agree partially, then redirect.

### Step 4 — Write output

Save to `assets/sales/objection-handler-[YYYY-MM-DD].md`:

> **Date format:** today's date as `YYYY-MM-DD` (get it with `terminal`: `date +%F`).

```markdown
# Objection Handler — [Brand Name]
> Generated: [date]

---

## Objection 1: "Giá cao quá"

**Real concern:** [what's actually behind this]

**Email response:**
[3–5 sentences, ACCA]

**Zalo response:**
[2–3 sentences]

**Call script:**
[Spoken format with pause notes]

---

[Repeat for all 7 objections]

---

## Quick Reference Cheat Sheet

| Objection | Real concern | One-line counter |
|---|---|---|
| Giá cao | ROI unclear | [anchor to alternative cost] |
| Suy nghĩ thêm | Something unclear | "Phần nào bạn muốn mình giải thích thêm?" |
| Đang dùng competitor | Switching cost | "Bạn đang dùng cho phần nào?" |
| Không có budget | May be value issue | "ROI hay thật sự là budget?" |
| AI không phù hợp | Fear of change | "Điều gì cụ thể khiến bạn nghĩ vậy?" |
| Đã thử AI rồi | Real bad experience | "Bạn đã thử gì cụ thể?" |
| Tự làm được | Want control | "Đó là lý do mình không bán retainer" |
```

### Step 5 — Confirm

After writing, reply:

---
"✅ **Objection handler cho '[Brand]' đã hoàn chỉnh.**

**Objections covered:** 7 universal + [any additional requested]
**Formats:** Email / Zalo / Call script
**Quick reference:** Cheat sheet included

📁 Đã lưu vào: `assets/sales/objection-handler-[YYYY-MM-DD].md`

**Bước tiếp theo:** Chạy `/sales-case-study` để build proof that counters objections, hoặc `/proposal-writer` để write customized proposals."

---

## Pitfalls

- Never invent numbers, quotes, testimonials or sources; label representative examples as such.
- Never edit `brand/brand.md`; only `mkt-brand` writes it. If findings should change the brand profile, say so in your summary.
- Match the voice and Vietnamese register in `brand/brand.md` Section 5 and avoid its forbidden vocabulary.
- Save only to the path given in the output step; the next specialist reads it from there.

## Verification

- `assets/sales/objection-handler-[YYYY-MM-DD].md` exists with every placeholder filled.
- The output follows the template in the procedure and uses today's date (`YYYY-MM-DD`) where a date is asked for.
- The reply, or the Kanban summary, lists the saved path and one recommended next step.
