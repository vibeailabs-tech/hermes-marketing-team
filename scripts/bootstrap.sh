#!/usr/bin/env bash
# Set up the AI marketing department on a machine that already runs Hermes (`hermes setup` done).
# Safe to re-run: every step skips what already exists.
#
# Usage: scripts/bootstrap.sh [--non-interactive]
#   --non-interactive  never prompt; missing keys are reported instead
# Env:   MARKETING_WORKSPACE  workspace location (default: ~/marketing-workspace)
set -euo pipefail
# shellcheck source=scripts/lib.sh
. "$(dirname "$0")/lib.sh"

interactive=1
for arg in "$@"; do
  case "$arg" in
    --non-interactive) interactive=0 ;;
    -h | --help) sed -n '2,8p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) die "unknown option: $arg" ;;
  esac
done
[ -t 0 ] || interactive=0

require_hermes
log "Hermes: $(hermes --version 2>/dev/null | head -n 1)"

# 1. Profiles
"$REPO_ROOT/scripts/install-profiles.sh"

# 2. Workspace (client data lives outside this repo)
if [ -d "$WORKSPACE" ]; then
  log "workspace exists: $WORKSPACE"
else
  log "create workspace: $WORKSPACE"
  mkdir -p "$(dirname "$WORKSPACE")"
  cp -R "$REPO_ROOT/templates/workspace" "$WORKSPACE"
  git -C "$WORKSPACE" init -q
  if [ -z "$(git -C "$WORKSPACE" config user.email || true)" ]; then
    git -C "$WORKSPACE" config user.name "Hermes Marketing"
    git -C "$WORKSPACE" config user.email "marketing@localhost"
  fi
  git -C "$WORKSPACE" add -A
  git -C "$WORKSPACE" commit -q -m "Initialize marketing workspace"
fi

# 3. Kanban: the root profile's gateway runs the dispatcher, so these live in its config.
log "configure kanban (root profile)"
hermes config set kanban.auto_decompose false >/dev/null
hermes config set kanban.review_dispatch false >/dev/null
hermes config set kanban.orchestrator_profile mkt-lead >/dev/null
hermes config set kanban.default_assignee mkt-lead >/dev/null

# 4. Model key: every profile needs its own .env (workers don't inherit the root one).
key="$(env_value "$HERMES_ROOT/.env" OPENROUTER_API_KEY)"
for p in $PROFILES; do
  env_has "$p" OPENROUTER_API_KEY && continue
  if [ -z "$key" ] && [ "$interactive" = 1 ]; then
    printf 'OpenRouter API key (input hidden): '
    read -rs key
    printf '\n'
  fi
  if [ -n "$key" ]; then
    set_env_var "$p" OPENROUTER_API_KEY "$key"
  else
    warn "$p: OPENROUTER_API_KEY missing; add it to $(profile_dir "$p")/.env"
  fi
done

# 5. Optional research keys
ask_optional() { # profile NAME prompt
  env_has "$1" "$2" && return 0
  [ "$interactive" = 1 ] || return 0
  local value
  printf '%s (Enter to skip, input hidden): ' "$3"
  read -rs value
  printf '\n'
  [ -n "$value" ] && set_env_var "$1" "$2" "$value"
  return 0
}
ask_optional mkt-research SERPAPI_KEY "SerpAPI key for keyword research"
serp="$(env_value "$(profile_dir mkt-research)/.env" SERPAPI_KEY)"
if [ -n "$serp" ] && ! env_has mkt-content SERPAPI_KEY; then
  set_env_var mkt-content SERPAPI_KEY "$serp"
fi
ask_optional mkt-research FIRECRAWL_API_KEY "Firecrawl key for competitor scraping"

cat <<EOF

$(log "bootstrap complete")
Next steps:
  1. Telegram for the assistant:   tro-ly gateway setup
  2. Run the gateway as a service: hermes gateway install   (Linux VPS: sudo "\$(command -v hermes)" gateway install --system)
     or restart it if it already runs: hermes gateway restart
  3. Review and resume the shipped schedules:
       hermes -p tro-ly cron list
       hermes -p tro-ly cron resume <job-id>
  4. Add the first client:        $REPO_ROOT/scripts/new-client.sh <slug> "Brand Name"
  5. Check everything:            $REPO_ROOT/scripts/healthcheck.sh
EOF
