# Hermes Marketing Team

Phòng marketing AI + trợ lí cá nhân, chạy trên [Hermes Agent](https://hermes-agent.nousresearch.com).
Khách hàng nhắn Telegram cho **Trợ lí**; Trợ lí giao việc cho **Trưởng phòng** (`mkt-lead`), Trưởng phòng chia
thành các thẻ Kanban cho 9 chuyên viên. Mọi sản phẩm gửi tới khách đều qua bước duyệt của con người.

> Sản phẩm của Vibe AI Labs. Mã nguồn công khai nhưng **không phải** phần mềm tự do; xem [LICENSE](LICENSE).

## Đội hình

| Profile | Vai trò | Skill |
|---|---|---|
| `tro-ly` | Trợ lí của khách, cổng Telegram, nhận việc / chuyển câu hỏi / ghi nhận duyệt | 2 |
| `mkt-lead` | Trưởng phòng: định tuyến, sắp thứ tự, không tự viết nội dung | 3 |
| `mkt-brand` | Brand strategist, người **duy nhất** ghi `brand.md` | 9 |
| `mkt-research` | Nghiên cứu thị trường, đối thủ, từ khoá, xu hướng | 4 |
| `mkt-strategy` | Chiến lược 90 ngày, campaign brief, lịch nội dung, offer, CRO | 10 |
| `mkt-content` | Blog, website copy, case study, SEO | 11 |
| `mkt-social` | Social, community, tái sử dụng nội dung, PR | 11 |
| `mkt-creative` | Kịch bản video, creative brief, deck, UGC | 4 |
| `mkt-ads` | Quảng cáo Meta / Google / TikTok | 6 |
| `mkt-growth` | Email, cold outreach, sales enablement | 15 |
| `mkt-analyst` | Báo cáo tuần / chiến dịch / tháng, ROI | 5 |

Chi tiết luồng làm việc: [docs/architecture.md](docs/architecture.md).

## Cài đặt nhanh (VPS hoặc máy riêng)

Yêu cầu: Hermes Agent ≥ 0.23 đã chạy `hermes setup`, `git`, Python 3, một OpenRouter API key.

```bash
git clone https://github.com/vibeailabs-tech/hermes-marketing-team.git ~/hermes-marketing-team
~/hermes-marketing-team/scripts/bootstrap.sh
tro-ly gateway setup                                   # bot Telegram của Trợ lí
sudo "$(command -v hermes)" gateway install --system   # Linux VPS: chạy gateway thành service
hermes -p tro-ly cron list                             # duyệt rồi bật các lịch: hermes -p tro-ly cron resume <id>
~/hermes-marketing-team/scripts/new-client.sh ca-phe-moc "Cà Phê Mộc"
```

Hướng dẫn đầy đủ cho VPS (bảo mật, service, cập nhật, sao lưu): [docs/deploy-vps.md](docs/deploy-vps.md).

## Dùng hằng ngày

- Nhắn Trợ lí trên Telegram: "Viết 5 bài Facebook cho tuần này", "Team đang làm gì?", "Duyệt bài blog".
- Thẻ bị **blocked** = chuyên viên cần thêm thông tin → Trợ lí hỏi bạn rồi chuyển câu trả lời.
- Thẻ ở cột **review** = chờ bạn duyệt → trả lời "duyệt" hoặc nêu chỗ cần sửa.
- Xem board: `hermes dashboard` (qua SSH tunnel) hoặc Hermes Desktop kết nối SSH tới VPS.

## Cập nhật

```bash
~/hermes-marketing-team/scripts/upgrade.sh v0.2.0      # hoặc: upgrade.sh main
~/hermes-marketing-team/scripts/healthcheck.sh
```

`upgrade.sh` chuyển repo sang tag rồi chạy `hermes profile update` cho từng profile: SOUL, skill, cron được làm
mới; `.env`, memory, session và `config.yaml` đã tinh chỉnh được giữ nguyên.

## Cấu trúc repo

```
hermes-marketing-team/
├── profiles/<profile>/        # mỗi thư mục = 1 Hermes profile distribution
│   ├── distribution.yaml      # tên, version, biến môi trường cần có
│   ├── SOUL.md                # vai trò, nguyên tắc, giọng
│   ├── config.yaml            # model, terminal.cwd (+ MCP cho mkt-research)
│   ├── skills/<nhóm>/<skill>/SKILL.md
│   └── cron/jobs.json         # chỉ tro-ly
├── templates/workspace/       # khung ~/marketing-workspace (dữ liệu khách, repo git riêng)
├── scripts/                   # bootstrap, install-profiles, upgrade, release, new-client, healthcheck, validate
└── docs/                      # kiến trúc, triển khai VPS, viết skill
```

## Phát triển

Sửa skill/profile theo [docs/authoring.md](docs/authoring.md), chạy `python3 scripts/validate.py`, rồi phát hành
bằng `scripts/release.sh X.Y.Z`. Hướng dẫn cho AI coding assistant: [AGENTS.md](AGENTS.md).
