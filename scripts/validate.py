#!/usr/bin/env python3
"""Validate the profile distributions and skills in this repo. Exit 1 on any error.

Checks: distribution manifests, configs, SOUL files, SKILL.md frontmatter and section order
(Hermes authoring standards), cross-profile slash references, cron store, machine-local paths
and obvious secrets. Needs Python 3.9+ and PyYAML.
"""
import json
import re
import sys
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parents[1]
PROFILES = ROOT / "profiles"
DESC_LIMIT = 60
NAME_RE = re.compile(r"^[a-z][a-z0-9-]*$")
MARKETING = re.compile(r"\b(powerful|comprehensive|seamless|revolutionary|cutting-edge|state-of-the-art)\b", re.I)
SECTION_ORDER = ["When to Use", "Prerequisites", "How to Run", "Quick Reference", "Procedure", "Pitfalls",
                 "Verification"]
REQUIRED_SECTIONS = {"When to Use", "Procedure", "Pitfalls", "Verification"}
REQUIRED_FIELDS = ("name", "description", "version", "author", "license", "platforms")
MACHINE_LOCAL = re.compile(r"/Users/[A-Za-z0-9_.-]+/|/home/(?!runner\b)[a-z0-9_-]+/|[A-Z]:\\Users\\")
SECRET = re.compile(r"sk-or-v1-[0-9a-f]{20,}|sk-ant-[A-Za-z0-9_-]{20,}|ghp_[A-Za-z0-9]{30,}|gho_[A-Za-z0-9]{30,}"
                    r"|xox[abp]-[A-Za-z0-9-]{20,}|AKIA[0-9A-Z]{16}|\b\d{8,10}:AA[A-Za-z0-9_-]{30,}")
SLASH_REF = re.compile(r"`/([a-z][a-z0-9-]*)`")

errors: list[str] = []


def err(path: Path, msg: str) -> None:
    errors.append(f"{path.relative_to(ROOT)}: {msg}")


def frontmatter(path: Path):
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        err(path, "must start with YAML frontmatter")
        return None, text
    end = text.find("\n---\n", 4)
    if end == -1:
        err(path, "unclosed frontmatter")
        return None, text
    data = yaml.safe_load(text[4:end])
    if not isinstance(data, dict):
        err(path, "frontmatter must be a mapping")
        return None, text
    return data, text[end + 5:]


def sections(body: str) -> list[str]:
    found, fence = [], None
    for line in body.splitlines():
        m = re.match(r"^\s*(`{3,}|~{3,})", line)
        if m:
            fence = m.group(1) if fence is None else (None if line.strip().startswith(fence) else fence)
            continue
        if fence is None and line.startswith("## "):
            found.append(line[3:].strip())
    return found


def check_skill(path: Path, profile: str, own: set, owner_of: dict) -> None:
    fm, body = frontmatter(path)
    if fm is None:
        return
    for field in REQUIRED_FIELDS:
        if field not in fm:
            err(path, f"missing frontmatter field: {field}")
    hermes = (fm.get("metadata") or {}).get("hermes") or {}
    if not hermes.get("tags"):
        err(path, "missing metadata.hermes.tags")
    name = fm.get("name", "")
    if name != path.parent.name:
        err(path, f"name {name!r} != directory {path.parent.name!r}")
    if not NAME_RE.match(str(name)):
        err(path, f"invalid skill name {name!r}")
    desc = str(fm.get("description", ""))
    if len(desc) > DESC_LIMIT:
        err(path, f"description is {len(desc)} chars (limit {DESC_LIMIT})")
    if not desc.endswith("."):
        err(path, "description must end with a period")
    if MARKETING.search(desc):
        err(path, f"marketing word in description: {MARKETING.search(desc).group(0)}")
    for rel in hermes.get("related_skills") or []:
        if rel not in own:
            err(path, f"related skill {rel!r} is not in profile {profile}")
    if not re.search(r"^# .+ Skill$", body, re.M):
        err(path, "missing '# <Title> Skill' heading")
    found = [s for s in sections(body) if s in SECTION_ORDER]
    missing = REQUIRED_SECTIONS - set(found)
    if missing:
        err(path, f"missing sections: {sorted(missing)}")
    if found != sorted(found, key=SECTION_ORDER.index):
        err(path, f"sections out of order: {found}")
    for ref in SLASH_REF.findall(body):
        if ref in owner_of and ref not in own:
            err(path, f"`/{ref}` belongs to {owner_of[ref]}; write it as `{ref}` (`{owner_of[ref]}`)")


def check_profile(pdir: Path, version: str, owner_of: dict) -> None:
    manifest_path = pdir / "distribution.yaml"
    if not manifest_path.is_file():
        err(pdir, "missing distribution.yaml")
        return
    manifest = yaml.safe_load(manifest_path.read_text(encoding="utf-8")) or {}
    if manifest.get("name") != pdir.name:
        err(manifest_path, f"name {manifest.get('name')!r} != directory {pdir.name!r}")
    if str(manifest.get("version")) != version:
        err(manifest_path, f"version {manifest.get('version')!r} != VERSION {version!r}")
    for key in ("description", "hermes_requires", "author", "license"):
        if not manifest.get(key):
            err(manifest_path, f"missing {key}")
    if "source" in manifest or "installed_at" in manifest:
        err(manifest_path, "source/installed_at are written by the installer; don't commit them")
    for owned in manifest.get("distribution_owned") or []:
        if not (pdir / owned).exists():
            err(manifest_path, f"distribution_owned path does not exist: {owned}")
    for env in manifest.get("env_requires") or []:
        if not isinstance(env, dict) or not env.get("name"):
            err(manifest_path, "env_requires entries need a name")

    soul = pdir / "SOUL.md"
    if not soul.is_file() or not soul.read_text(encoding="utf-8").strip():
        err(pdir, "missing or empty SOUL.md")
    config_path = pdir / "config.yaml"
    config = yaml.safe_load(config_path.read_text(encoding="utf-8")) if config_path.is_file() else None
    if not isinstance(config, dict) or not (config.get("model") or {}).get("default"):
        err(config_path, "config.yaml needs model.default")

    jobs_path = pdir / "cron" / "jobs.json"
    if jobs_path.is_file():
        data = json.loads(jobs_path.read_text(encoding="utf-8"))
        jobs = data.get("jobs") if isinstance(data, dict) else data
        for job in jobs or []:
            for key in ("id", "name", "schedule", "prompt"):
                if not job.get(key):
                    err(jobs_path, f"job {job.get('id', '?')} missing {key}")

    own = {p.parent.name for p in pdir.glob("skills/**/SKILL.md")}
    seen = set()
    for skill in sorted(pdir.glob("skills/**/SKILL.md")):
        if skill.parent.name in seen:
            err(skill, "duplicate skill name inside the profile")
        seen.add(skill.parent.name)
        check_skill(skill, pdir.name, own, owner_of)


def check_text_files() -> None:
    for path in ROOT.rglob("*"):
        rel = path.relative_to(ROOT)
        if not path.is_file() or rel.parts[0] in {".git", "general-service"} or path.suffix in {".png", ".pdf"}:
            continue
        if rel.parts[0] not in {"profiles", "templates", "scripts", "docs", ".github"} and len(rel.parts) > 1:
            continue
        try:
            text = path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            continue
        if rel.parts[0] in {"profiles", "templates"} and MACHINE_LOCAL.search(text):
            err(path, f"machine-local path: {MACHINE_LOCAL.search(text).group(0)}")
        if SECRET.search(text):
            err(path, "looks like it contains a secret")


def main() -> int:
    version = (ROOT / "VERSION").read_text(encoding="utf-8").strip()
    owner_of = {}
    for skill in PROFILES.glob("*/skills/**/SKILL.md"):
        owner_of.setdefault(skill.parent.name, skill.relative_to(PROFILES).parts[0])
    pdirs = sorted(p for p in PROFILES.iterdir() if p.is_dir())
    for pdir in pdirs:
        check_profile(pdir, version, owner_of)
    check_text_files()
    skills = sum(1 for _ in PROFILES.glob("*/skills/**/SKILL.md"))
    if errors:
        print("\n".join(errors))
        print(f"\n{len(errors)} error(s)")
        return 1
    print(f"ok: {len(pdirs)} profiles, {skills} skills, version {version}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
