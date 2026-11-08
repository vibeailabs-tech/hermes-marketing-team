#!/usr/bin/env bash
# Shared helpers for the hermes-marketing-team scripts. Source this file; don't run it.
# shellcheck disable=SC2034  # the variables below are used by the scripts that source this file

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
WORKSPACE="${MARKETING_WORKSPACE:-$HOME/marketing-workspace}"
# Hermes keeps named profiles under ~/.hermes/profiles regardless of HERMES_HOME.
HERMES_ROOT="$HOME/.hermes"
PROFILES="tro-ly mkt-lead mkt-brand mkt-research mkt-strategy mkt-content mkt-social mkt-creative mkt-ads mkt-growth mkt-analyst"

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*" >&2; }
die() { printf '\033[1;31mxx\033[0m %s\n' "$*" >&2; exit 1; }

require_hermes() {
  command -v hermes >/dev/null 2>&1 ||
    die "hermes not found. Install it first: curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash"
}

profile_dir() { printf '%s/profiles/%s' "$HERMES_ROOT" "$1"; }

# manifest_field FILE KEY -> value of a top-level `KEY: value` (quotes stripped). Hermes folds long
# values onto the next indented line when it rewrites an installed manifest, so follow that too.
manifest_field() {
  awk -v key="$2" '
    found && /^[[:space:]]+[^[:space:]]/ { sub(/^[[:space:]]+/, ""); print; exit }
    found { exit }
    index($0, key ":") == 1 {
      value = substr($0, length(key) + 2); sub(/^[[:space:]]+/, "", value)
      if (value != "") { print value; exit }
      found = 1
    }
  ' "$1" | sed "s/^[\"']\(.*\)[\"']\$/\1/"
}

# real_path DIR -> physical path (symlinks resolved), or DIR unchanged when it does not exist
real_path() { (cd "$1" 2>/dev/null && pwd -P) || printf '%s' "$1"; }

# env_value FILE NAME -> value of NAME=... in a dotenv file (empty when absent)
env_value() {
  [ -f "$1" ] || return 0
  sed -n "s/^$2=//p" "$1" | tail -n 1
}

env_has() { [ -n "$(env_value "$(profile_dir "$1")/.env" "$2")" ]; }

# set_env_var PROFILE NAME VALUE -> writes the profile's .env without printing the value
set_env_var() {
  local file tmp
  file="$(profile_dir "$1")/.env"
  touch "$file"
  chmod 600 "$file"
  tmp="$(mktemp)"
  grep -v "^$2=" "$file" >"$tmp" || true
  printf '%s=%s\n' "$2" "$3" >>"$tmp"
  cat "$tmp" >"$file"
  rm -f "$tmp"
}
