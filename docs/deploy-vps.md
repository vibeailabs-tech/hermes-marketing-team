# Triển khai lên VPS

Mỗi khách một instance: một VPS (hoặc một container) chạy Hermes với 11 profile. Hướng dẫn dưới đây cho Ubuntu
LTS; macOS dùng cùng lệnh, trừ phần service.

## 1. Chuẩn bị máy

- Ubuntu LTS, nên từ 4 GB RAM (mỗi worker Kanban là một process riêng).
- Kết nối bằng SSH, không dán lệnh qua console web của nhà cung cấp (dễ sai ký tự `:` `@`).
- Mở duy nhất SSH: `sudo ufw allow OpenSSH && sudo ufw enable`. Telegram không cần mở cổng.
- Tạo user riêng, không chạy bằng root:

```bash
sudo adduser hermes
sudo su - hermes
```

Với terminal backend `local`, agent chạy lệnh thật dưới user này; đừng đặt dịch vụ hay dữ liệu khác trên VPS.

## 2. Cài Hermes

```bash
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
hermes setup                  # chọn provider (OpenRouter), nhập key
hermes --version              # cần >= 0.23.0
```

## 3. Cài phòng marketing

```bash
git clone https://github.com/vibeailabs-tech/hermes-marketing-team.git ~/hermes-marketing-team
cd ~/hermes-marketing-team
git checkout v0.1.0           # ghim bản phát hành
scripts/bootstrap.sh
```

`bootstrap.sh`:

1. Cài 11 profile từ thư mục local (`hermes profile install profiles/<name> --alias`), đặt mô tả định tuyến và
   bật toolset `kanban` cho `mkt-lead` / `tro-ly`.
2. Tạo `~/marketing-workspace` (repo git riêng) từ `templates/workspace/`.
3. Cấu hình Kanban ở profile gốc (`review_dispatch: false`, `auto_decompose: false`, `mkt-lead` điều phối).
4. Ghi `OPENROUTER_API_KEY` vào `.env` của từng profile (lấy từ `~/.hermes/.env` hoặc hỏi một lần); hỏi thêm
   SerpAPI / Firecrawl (có thể bỏ qua).

## 4. Telegram, gateway, lịch

```bash
tro-ly gateway setup                                   # bot RIÊNG của khách (BotFather) + user ID được phép
sudo "$(command -v hermes)" gateway install --system   # service khởi động cùng máy
hermes gateway status
hermes -p tro-ly cron list                             # 3 lịch, đang paused
hermes -p tro-ly cron resume mkt-weekly-review
hermes -p tro-ly cron resume mkt-monthly-cycle
hermes -p tro-ly cron resume mkt-daily-digest
```

Một gateway (của profile gốc, chế độ multiplex) phục vụ mọi profile: bot Telegram của `tro-ly`, cron của từng
profile và dispatcher Kanban. Đừng chạy `tro-ly gateway install`. Trong Telegram, gõ `/sethome` một lần để
cron biết gửi kết quả về đâu. Một bot token chỉ chạy được ở một máy.

## 5. Khách hàng đầu tiên

```bash
~/hermes-marketing-team/scripts/new-client.sh ca-phe-moc "Cà Phê Mộc"
```

Rồi chạy phỏng vấn thương hiệu: nhắn Trợ lí "onboard Cà Phê Mộc", hoặc
`cd ~/marketing-workspace/clients/ca-phe-moc && mkt-brand chat` → `/brand-setup`.

## 6. MCP cho competitor-analysis (tuỳ chọn)

Cần Node.js (`npx`). Sau khi thêm `FIRECRAWL_API_KEY` vào `~/.hermes/profiles/mkt-research/.env`:

```bash
mkt-research config set mcp_servers.firecrawl.enabled true
mkt-research config set mcp_servers.playwright.enabled true
```

Không bật thì skill dùng `web_extract` và `browser_exec`.

## 7. Cập nhật

```bash
cd ~/hermes-marketing-team
scripts/upgrade.sh v0.2.0          # thêm --force-config nếu bản mới đổi config.yaml
scripts/healthcheck.sh
```

`hermes profile update` thay SOUL, skill và định nghĩa cron; giữ `.env`, memory, session, `config.yaml` và trạng
thái paused/enabled của từng lịch. Lịch mới thêm vào sẽ ở trạng thái paused.

Cập nhật Hermes: `hermes update` (giữ phiên bản ≥ `hermes_requires` trong `distribution.yaml`).

## 8. Theo dõi và hỗ trợ

- Board: `ssh -L 9119:localhost:9119 hermes@<vps>` rồi trên VPS chạy `hermes dashboard`; hoặc Hermes Desktop →
  Settings → Gateways → thêm kết nối SSH. Không mở cổng 9119 ra internet.
- Log: `hermes logs`; tóm tắt để gửi hỗ trợ: `hermes dump`.
- Chi phí model: `hermes insights`; nên dùng key OpenRouter riêng cho mỗi khách, có giới hạn chi tiêu.

## 9. Sao lưu

```bash
hermes backup                                          # toàn bộ ~/.hermes (gồm profile, memory, cron)
git -C ~/marketing-workspace bundle create ~/workspace-$(date +%F).bundle --all
```

Khi khách ngừng dịch vụ: bàn giao `~/marketing-workspace` (đây là dữ liệu của họ).
