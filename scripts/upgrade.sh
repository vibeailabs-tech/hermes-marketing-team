#!/usr/bin/env bash
# Move this checkout to a released tag (or main) and update every installed profile from it.
#
# Usage: scripts/upgrade.sh <tag|main> [--force-config]
#   <tag>           a release tag such as v0.2.0
#   main            the latest commit on main (for staging machines)
#   --force-config  also replace each installed config.yaml with the repo copy
set -euo pipefail
# shellcheck source=scripts/lib.sh
. "$(dirname "$0")/lib.sh"

target=""
force_config=""
for arg in "$@"; do
  case "$arg" in
    --force-config) force_config="--force-config" ;;
    -h | --help) sed -n '2,7p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    -*) die "unknown option: $arg" ;;
    *) target="$arg" ;;
  esac
done
[ -n "$target" ] || die "usage: scripts/upgrade.sh <tag|main> [--force-config]"

cd "$REPO_ROOT"
[ -z "$(git status --porcelain)" ] || die "the checkout has local changes; commit or stash them first"

log "fetch"
git fetch --tags --quiet origin
if [ "$target" = "main" ]; then
  git checkout --quiet main
  git pull --ff-only --quiet origin main
else
  git rev-parse --verify --quiet "refs/tags/$target" >/dev/null || die "no such tag: $target"
  git checkout --quiet --detach "refs/tags/$target"
fi
log "checkout now at $(git describe --tags --always) (VERSION $(cat VERSION))"

# shellcheck disable=SC2086
"$REPO_ROOT/scripts/install-profiles.sh" $force_config
