#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_SH="$SCRIPT_DIR/new_post.sh"
if [ ! -f "$SCRIPT_SH" ]; then
  echo "Cannot find $SCRIPT_SH" >&2
  exit 1
fi
if [ $# -ge 1 ]; then
  SLUG="$1"
else
  read -r -p "Post slug (URL-friendly): " SLUG || true
fi
SLUG="${SLUG:-}"
SLUG="$(printf '%s' "$SLUG" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
if [ -z "$SLUG" ]; then
  echo "Slug must not be empty." >&2
  exit 1
fi
"$SCRIPT_SH" "$SLUG"

if [ -t 0 ]; then
  echo ""
  read -r -p "Press Return to close this window." _ || true
fi
