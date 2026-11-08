# Viết và sửa skill / profile

## Sửa một skill

1. Sửa `profiles/<profile>/skills/<nhóm>/<skill>/SKILL.md`.
2. Giữ chuẩn Hermes (được `scripts/validate.py` kiểm tra):
   - `description` ≤ 60 ký tự, một câu, kết thúc bằng dấu chấm, không dùng từ quảng cáo.
   - Thứ tự mục: `# <Title> Skill` → intro → `When to Use` → `Prerequisites` → `How to Run` →
     `Quick Reference` (tuỳ chọn) → `Procedure` → `Pitfalls` → `Verification`.
   - Đường dẫn tương đối với thư mục khách (`brand/brand.md`, `assets/content/...`), ngày `YYYY-MM-DD`.
   - Gọi skill cùng profile bằng `` `/tên` ``; skill của profile khác viết `` `tên` (`profile`) ``.
   - Nêu công cụ Hermes trong backtick (`read_file`, `patch`, `terminal`, `web_search`, `kanban_block`...).
   - Logic phức tạp → script trong `scripts/` của skill, tham chiếu bằng đường dẫn tương đối.
3. `python3 scripts/validate.py`
4. Thử trên máy dev: `scripts/install-profiles.sh <profile>` rồi `<profile> chat` → `/<skill>`.

## Thêm skill mới

```
profiles/<profile>/skills/<nhóm>/<skill>/
├── SKILL.md
├── references/      # tài liệu nạp khi cần (skill_view)
├── templates/       # mẫu đầu ra
└── scripts/         # script hỗ trợ
```

Nếu là nhóm mới, thêm `skills/<nhóm>` vào `distribution_owned` trong `distribution.yaml`. Cập nhật bảng định
tuyến trong `profiles/mkt-lead/skills/orchestration/marketing-router/SKILL.md` để `mkt-lead` biết giao việc.

## Thêm hoặc đổi profile

- Thư mục `profiles/<tên>/` với `distribution.yaml`, `SOUL.md`, `config.yaml`, `skills/`.
- Thêm tên vào `PROFILES` trong `scripts/lib.sh`, bảng đội hình trong `README.md`, `profiles/mkt-lead/SOUL.md` và
  `marketing-router`.
- `description` trong `distribution.yaml` là mô tả định tuyến (`hermes profile describe`): ghi rõ profile giỏi gì.

## Biến môi trường

- Khai báo trong `env_requires` của `distribution.yaml` (installer tạo `.env.EXAMPLE`).
- Skill gọi API qua `terminal` khai báo `required_environment_variables` trong frontmatter để Hermes chuyển key
  vào môi trường của terminal.
- Không bao giờ commit giá trị key.

## Lịch (cron)

Lịch giao kèm nằm ở `profiles/tro-ly/cron/jobs.json`, `id` cố định (ví dụ `mkt-weekly-review`) để bản cập nhật
ghép đúng job. Cách an toàn nhất để tạo định nghĩa mới: tạo bằng `hermes -p tro-ly cron create ...` trong một
HOME tạm, rồi chép các trường định nghĩa (`id`, `name`, `prompt`, `skills`, `schedule`, `deliver`, `timezone`).

## Phát hành

```bash
# 1. Ghi thay đổi vào CHANGELOG.md dưới "## [X.Y.Z] - YYYY-MM-DD"
# 2. Trên main, sạch:
scripts/release.sh X.Y.Z           # đồng bộ version 11 profile, validate, commit, tag
git push origin main --tags
# 3. Trên từng instance:
scripts/upgrade.sh vX.Y.Z
```

Khuyến nghị: nâng một khách thử trước, rồi mới nâng các khách còn lại.

## Thử cài không đụng Hermes thật

```bash
SB="$(mktemp -d)"; mkdir -p "$SB/.hermes"
HOME="$SB" HERMES_HOME="$SB/.hermes" scripts/bootstrap.sh --non-interactive
HOME="$SB" HERMES_HOME="$SB/.hermes" hermes profile list
```
