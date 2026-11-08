#!/usr/bin/env bash
# Report the state of an installation: profiles, versions, keys, gateway, kanban, schedules, workspace.
# Read-only; never prints secret values.
#
# Usage: scripts/healthcheck.sh
set -uo pipefail
# shellcheck source=scripts/lib.sh
. "$(dirname "$0")/lib.sh"

require_hermes
problems=0
expected="$(cat "$REPO_ROOT/VERSION")"

log "Hermes: $(hermes --version 2>/dev/null | head -n 1)"
log "repo VERSION: $expected"

printf '\n%-14s %-10s %-8s %s\n' PROFILE VERSION KEY SOURCE
for p in $PROFILES; do
  manifest="$(profile_dir "$p")/distribution.yaml"
  if [ ! -f "$manifest" ]; then
    printf '%-14s %-10s %-8s %s\n' "$p" "-" "-" "NOT INSTALLED"
    problems=$((problems + 1))
    continue
  fi
  version="$(manifest_field "$manifest" version)"
  key="ok"
  env_has "$p" OPENROUTER_API_KEY || key="MISSING"
  [ "$key" = ok ] || problems=$((problems + 1))
  [ "$version" = "$expected" ] || problems=$((problems + 1))
  printf '%-14s %-10s %-8s %s\n' "$p" "$version" "$key" "$(manifest_field "$manifest" source)"
done

printf '\n'
log "gateway"
hermes gateway status 2>&1 | head -n 3 || problems=$((problems + 1))

log "kanban (root profile)"
for k in auto_decompose review_dispatch orchestrator_profile default_assignee; do
  printf '  kanban.%s = %s\n' "$k" "$(hermes config get "kanban.$k" 2>/dev/null)"
done

log "tro-ly schedules"
hermes -p tro-ly cron list 2>&1 | head -n 20

log "workspace: $WORKSPACE"
if [ -d "$WORKSPACE/clients" ]; then
  clients="$(find "$WORKSPACE/clients" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
  printf '  %s client folder(s)\n' "$clients"
else
  warn "workspace missing; run scripts/bootstrap.sh"
  problems=$((problems + 1))
fi

printf '\n'
if [ "$problems" -eq 0 ]; then log "healthy"; else warn "$problems problem(s) found"; fi
exit $((problems > 0))
