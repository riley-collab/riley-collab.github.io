#!/usr/bin/env bash
# Render a resume HTML file to a Letter-size PDF with headless Chromium.
# Usage: resume/render.sh resume/base.html [out.pdf]
set -euo pipefail
in="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
out="${2:-${in%.html}.pdf}"
case "$out" in /*) ;; *) out="$(pwd)/$out" ;; esac
for c in "${CHROME:-}" /opt/pw-browsers/chromium chromium chromium-browser google-chrome \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"; do
  [ -n "$c" ] && command -v "$c" >/dev/null 2>&1 && chrome="$c" && break
done
: "${chrome:?No Chromium/Chrome found; set CHROME=/path/to/chrome}"
"$chrome" --headless --no-sandbox --disable-gpu --no-pdf-header-footer \
  --print-to-pdf="$out" "file://$in" 2>/dev/null
if command -v pdfinfo >/dev/null; then
  pages=$(pdfinfo "$out" | awk '/^Pages:/{print $2}')
  echo "$out ($pages page(s))"
  [ "$pages" = 1 ] || { echo "WARNING: resume is not one page" >&2; exit 2; }
else
  echo "$out"
fi
