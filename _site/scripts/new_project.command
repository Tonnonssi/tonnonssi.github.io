#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_SH="$SCRIPT_DIR/new_project.sh"
if [ ! -f "$SCRIPT_SH" ]; then
  echo "Cannot find $SCRIPT_SH" >&2
  exit 1
fi
if [ $# -ge 1 ]; then
  TITLE_EN="$1"
else
  read -r -p "Project title (English): " TITLE_EN || true
fi
TITLE_EN="${TITLE_EN:-}"
TITLE_EN_TRIMMED="$(printf '%s' "$TITLE_EN" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
if [ -z "$TITLE_EN_TRIMMED" ]; then
  echo "Title must not be empty." >&2
  exit 1
fi
if [ $# -ge 2 ]; then
  SLUG="$2"
else
  read -r -p "Custom slug (optional, leave blank to auto-generate): " SLUG || true
fi
SLUG="${SLUG:-}"
SLUG="$(printf '%s' "$SLUG" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
if [ -n "$SLUG" ]; then
  "$SCRIPT_SH" "$TITLE_EN_TRIMMED" "$SLUG"
else
  "$SCRIPT_SH" "$TITLE_EN_TRIMMED"
fi

if [ -t 0 ]; then
  echo ""
  read -r -p "Press Return to close this window." _ || true
fi
