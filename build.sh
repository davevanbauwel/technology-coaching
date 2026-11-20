#!/usr/bin/env bash
# Zip each skill for upload to claude.ai. Usage: ./build.sh [skill-name...]  (no args: every skill)
set -euo pipefail
cd "$(dirname "$0")"
OUT_DIR="${OUT_DIR:-/mnt/c/Users/DaveVanBauwel/Downloads}"
mkdir -p dist
skills=("$@")
if [ ${#skills[@]} -eq 0 ]; then
  for f in */SKILL.md; do skills+=("$(dirname "$f")"); done
fi
for s in "${skills[@]}"; do
  [ -f "$s/SKILL.md" ] || { echo "No skill at $s/SKILL.md" >&2; exit 1; }
  rm -f "dist/$s.zip"
  python3 -c "import shutil,sys; shutil.make_archive('dist/'+sys.argv[1],'zip','.',sys.argv[1])" "$s"
  cp "dist/$s.zip" "$OUT_DIR/"
  echo "Built $s.zip -> $OUT_DIR"
done
echo "Upload in claude.ai (Skills), replacing the existing version."
