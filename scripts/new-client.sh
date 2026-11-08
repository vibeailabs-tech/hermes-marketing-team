#!/usr/bin/env bash
# Create a client folder in the marketing workspace from the template.
#
# Usage: scripts/new-client.sh <slug> ["Brand Name"]
#   slug: lowercase letters, digits and hyphens (no diacritics), e.g. ca-phe-moc
set -euo pipefail
# shellcheck source=scripts/lib.sh
. "$(dirname "$0")/lib.sh"

slug="${1:-}"
brand="${2:-$slug}"
case "$slug" in
  -h | --help | "") sed -n '2,5p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
esac
printf '%s' "$slug" | grep -Eq '^[a-z0-9][a-z0-9-]*$' || die "invalid slug: $slug"
[ -d "$WORKSPACE/_template" ] || die "no workspace template at $WORKSPACE/_template; run scripts/bootstrap.sh"
target="$WORKSPACE/clients/$slug"
[ ! -e "$target" ] || die "client already exists: $target"

cp -R "$WORKSPACE/_template" "$target"
SLUG="$slug" BRAND="$brand" perl -pi -e 's/\[Brand Name\]/$ENV{BRAND}/g; s/\[slug\]/$ENV{SLUG}/g' \
  "$target/AGENTS.md" "$target/brand/brand.md"

if git -C "$WORKSPACE" rev-parse --git-dir >/dev/null 2>&1; then
  git -C "$WORKSPACE" add "clients/$slug"
  git -C "$WORKSPACE" commit -q -m "Onboard $slug"
fi

log "created $target"
cat <<EOF
Next: run the brand interview, either
  - in chat:  cd "$target" && mkt-brand chat   then type /brand-setup
  - or ask tro-ly on Telegram to onboard "$brand" (it creates the Kanban card for mkt-brand)
EOF
