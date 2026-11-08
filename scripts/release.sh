#!/usr/bin/env bash
# Cut a release: bump VERSION and every distribution.yaml, validate, commit and tag (no push).
#
# Usage: scripts/release.sh <X.Y.Z>
#   Requires a "## [X.Y.Z]" section in CHANGELOG.md and a clean checkout on main.
set -euo pipefail
# shellcheck source=scripts/lib.sh
. "$(dirname "$0")/lib.sh"

version="${1:-}"
case "$version" in
  -h | --help | "") sed -n '2,5p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
esac
printf '%s' "$version" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$' || die "version must be X.Y.Z, got: $version"

cd "$REPO_ROOT"
[ "$(git rev-parse --abbrev-ref HEAD)" = "main" ] || die "release from main"
[ -z "$(git status --porcelain)" ] || die "the checkout has local changes"
git rev-parse --verify --quiet "refs/tags/v$version" >/dev/null && die "tag v$version already exists"
grep -q "^## \[$version\]" CHANGELOG.md || die "add a '## [$version]' section to CHANGELOG.md first"

log "bump to $version"
printf '%s\n' "$version" >VERSION
python3 - "$version" <<'PY'
import re, sys
from pathlib import Path
version = sys.argv[1]
for manifest in sorted(Path("profiles").glob("*/distribution.yaml")):
    text = manifest.read_text(encoding="utf-8")
    manifest.write_text(re.sub(r"(?m)^version: .*$", f"version: {version}", text, count=1), encoding="utf-8")
PY

python3 scripts/validate.py
git add VERSION profiles/*/distribution.yaml
git commit -q -m "Release v$version"
git tag -a "v$version" -m "v$version"
log "tagged v$version. Publish with: git push origin main --tags"
