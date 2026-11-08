#!/usr/bin/env python3
"""Report which marketing workflow layers exist for one client folder (read-only)."""
import json
import re
import sys
from datetime import date, datetime
from pathlib import Path

PLACEHOLDER = "[To be filled]"


def files(root: Path, pattern: str) -> list[str]:
    return sorted(str(p.relative_to(root)) for p in root.glob(pattern) if p.is_file() and p.name != ".gitkeep")


def last_updated(brand: Path):
    match = re.search(r"Last updated:\s*(\d{4}-\d{2}-\d{2})", brand.read_text(encoding="utf-8"))
    if match:
        return date.fromisoformat(match.group(1))
    return datetime.fromtimestamp(brand.stat().st_mtime).date()


def layer(found: list[str], partial: bool = False) -> dict:
    status = "missing" if not found else ("partial" if partial else "done")
    return {"status": status, "files": found}


def check(root: Path) -> dict:
    brand = root / "brand" / "brand.md"
    report = {"client": root.name}
    if brand.is_file():
        unfilled = brand.read_text(encoding="utf-8").count(PLACEHOLDER)
        report["foundation"] = layer(["brand/brand.md"], partial=unfilled > 0)
        report["foundation"]["unfilled_sections"] = unfilled
    else:
        report["foundation"] = layer([])

    market = files(root, "research/market-research-*")
    competitors = files(root, "research/competitor-analysis-*")
    research = files(root, "research/*")
    report["research"] = layer(research, partial=not (market and competitors))
    report["strategy"] = layer(files(root, "strategy/campaign-brief-*"))
    report["strategy"]["other_files"] = [f for f in files(root, "strategy/*") if "campaign-brief-" not in f]
    report["execution"] = layer(files(root, "assets/**/*"))
    report["distribution"] = layer(files(root, "distribution/**/*"))

    monthly = files(root, "performance/monthly-review-*")
    report["performance"] = layer(files(root, "performance/weekly-report-*") + monthly)

    feedback = {"status": "missing", "files": []}
    if brand.is_file() and monthly:
        latest_review = max(datetime.fromtimestamp((root / m).stat().st_mtime).date() for m in monthly)
        updated = last_updated(brand)
        feedback = {
            "status": "done" if updated >= latest_review else "partial",
            "files": ["brand/brand.md"],
            "brand_last_updated": updated.isoformat(),
            "latest_monthly_review": latest_review.isoformat(),
            "days_since_brand_update": (date.today() - updated).days,
        }
    report["feedback"] = feedback
    return report


def main() -> int:
    if len(sys.argv) != 2:
        print("usage: state_check.py <client-folder>", file=sys.stderr)
        return 2
    root = Path(sys.argv[1]).expanduser().resolve()
    if not root.is_dir():
        print(json.dumps({"error": f"client folder not found: {root}"}))
        return 1
    print(json.dumps(check(root), ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    sys.exit(main())
