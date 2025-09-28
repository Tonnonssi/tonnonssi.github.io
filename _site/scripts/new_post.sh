#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

if [ $# -ge 1 ]; then
  SLUG_RAW="$1"
else
  read -r -p "Post slug (URL-friendly, e.g. actor-critic): " SLUG_RAW || true
fi
SLUG_RAW="${SLUG_RAW:-}"
SLUG_RAW="$(printf '%s' "$SLUG_RAW" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
if [ -z "$SLUG_RAW" ]; then
  echo "Error: slug must not be empty." >&2
  exit 1
fi

SLUG=$(printf '%s' "$SLUG_RAW" |
  tr '[:upper:]' '[:lower:]' |
  sed 's/[^a-z0-9-]/-/g' |
  sed 's/-\+/-/g' |
  sed 's/^-\|-$//g')

if [ -z "$SLUG" ]; then
  echo "Error: unable to derive slug from '$SLUG_RAW'." >&2
  exit 1
fi

DATE="$(date +%Y-%m-%d)"
OUTPUT="_posts/${DATE}-${SLUG}.md"
if [ -e "$OUTPUT" ]; then
  echo "Error: $OUTPUT already exists." >&2
  exit 1
fi

read -r -p "Korean title: " TITLE_KO || true
TITLE_KO="${TITLE_KO:-}"
read -r -p "English title: " TITLE_EN || true
TITLE_EN="${TITLE_EN:-$TITLE_KO}" 

read -r -p "Korean description (optional): " DESC_KO || true
DESC_KO="${DESC_KO:-}"
read -r -p "English description (optional): " DESC_EN || true
if [ -z "$DESC_EN" ]; then
  DESC_EN="$DESC_KO"
fi

read -r -p "Comma-separated tags (optional): " TAGS_INPUT || true
TAGS_INPUT="${TAGS_INPUT:-}"

# Prepare environment variables for python template
export NEW_POST_TITLE_KO="$TITLE_KO"
export NEW_POST_TITLE_EN="$TITLE_EN"
export NEW_POST_DESC_KO="$DESC_KO"
export NEW_POST_DESC_EN="$DESC_EN"
export NEW_POST_TAGS="$TAGS_INPUT"
export NEW_POST_OUTPUT="$OUTPUT"
export NEW_POST_DATE="$DATE"

python3 <<'PY'
import os
import yaml
from datetime import datetime

output = os.environ['NEW_POST_OUTPUT']
title_ko = os.environ.get('NEW_POST_TITLE_KO', '').strip()
title_en = os.environ.get('NEW_POST_TITLE_EN', '').strip() or title_ko
desc_ko = os.environ.get('NEW_POST_DESC_KO', '').strip()
desc_en = os.environ.get('NEW_POST_DESC_EN', '').strip() or desc_ko
tags_raw = os.environ.get('NEW_POST_TAGS', '').strip()

if not title_ko and not title_en:
    raise SystemExit('At least one of Korean or English title must be provided.')

front_matter = {
    'title': {
        'ko': title_ko or title_en,
        'en': title_en or title_ko,
    },
    'tags': [tag.strip() for tag in tags_raw.split(',') if tag.strip()] or [],
    'style': 'border',
    'img': '',
}
if desc_ko or desc_en:
    front_matter['description'] = {
        'ko': desc_ko,
        'en': desc_en,
    }

with open(output, 'w', encoding='utf-8') as handle:
    handle.write('---\n')
    yaml.dump(front_matter, handle, allow_unicode=True, sort_keys=False)
    handle.write('---\n\n')
    handle.write('<!-- 한국어 콘텐츠 -->\n')
    handle.write('{% capture ko_content %}\n')
    handle.write('# {{ page.title.ko | default: "포스트 제목(한글)" }}\n\n')
    handle.write('여기에 한국어 본문을 작성하세요.\n')
    handle.write('{% endcapture %}\n\n')
    handle.write('<!-- 영어 콘텐츠 -->\n')
    handle.write('{% capture en_content %}\n\n')
    handle.write('# {{ page.title.en | default: "Post Title" }}\n\n')
    handle.write('Write the English content here.\n')
    handle.write('{% endcapture %}\n\n')
    handle.write('<div class="lang-content" data-lang="ko" data-lang-group="post-body">\n')
    handle.write('  {{ ko_content | markdownify }}\n')
    handle.write('</div>\n\n')
    handle.write('<div class="lang-content" data-lang="en" data-lang-group="post-body">\n')
    handle.write('  {{ en_content | markdownify }}\n')
    handle.write('</div>\n')
PY

printf 'Created %s\n' "$OUTPUT"
