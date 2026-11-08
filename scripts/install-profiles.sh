#!/usr/bin/env bash
# Install (first run) or update (later runs) every profile distribution from this checkout.
#
# Usage: scripts/install-profiles.sh [--force-config] [profile ...]
#   --force-config  also replace each installed config.yaml with the repo copy
#   profile ...     limit to these profiles (default: all)
set -euo pipefail
# shellcheck source=scripts/lib.sh
. "$(dirname "$0")/lib.sh"

force_config=""
selected=""
for arg in "$@"; do
  case "$arg" in
    --force-config) force_config="--force-config" ;;
    -h | --help) sed -n '2,6p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    -*) die "unknown option: $arg" ;;
    *) selected="$selected $arg" ;;
  esac
done
[ -n "$selected" ] || selected="$PROFILES"

require_hermes

for p in $selected; do
  src="$REPO_ROOT/profiles/$p"
  [ -f "$src/distribution.yaml" ] || die "unknown profile: $p"
  installed="$(profile_dir "$p")"
  if [ -f "$installed/distribution.yaml" ]; then
    recorded="$(manifest_field "$installed/distribution.yaml" source)"
    if [ -n "$recorded" ] && [ "$(real_path "$recorded")" != "$src" ]; then
      die "$p was installed from $recorded, not $src. Re-link it with:
  hermes profile install \"$src\" --name $p --force -y   (keeps memories and .env, resets config.yaml)"
    fi
    log "update $p"
    # shellcheck disable=SC2086
    hermes profile update "$p" -y $force_config
  elif [ -d "$installed" ]; then
    die "$installed exists but was not installed from a distribution; move it aside first"
  else
    log "install $p"
    hermes profile install "$src" --alias -y
  fi
  hermes profile describe "$p" --text "$(manifest_field "$src/distribution.yaml" description)" >/dev/null
done

# Orchestrators drive the board through the kanban toolset, which is off by default.
if [ -d "$(profile_dir mkt-lead)" ]; then
  hermes -p mkt-lead tools enable kanban --platform cli >/dev/null
fi
if [ -d "$(profile_dir tro-ly)" ]; then
  for platform in cli telegram cron; do
    hermes -p tro-ly tools enable kanban --platform "$platform" >/dev/null
  done
fi

log "done: $(echo "$selected" | wc -w | tr -d ' ') profile(s) from $(cat "$REPO_ROOT/VERSION")"
