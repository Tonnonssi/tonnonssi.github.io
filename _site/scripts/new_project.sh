#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"
if [ $# -lt 1 ]; then
  echo "Usage: $0 \"Project Name (English)\" [slug]" >&2
  exit 1
fi
TITLE_EN="$1"
if [ ${#TITLE_EN} -lt 1 ]; then
  echo "Title must not be empty" >&2
  exit 1
fi
if [ $# -ge 2 ]; then
  SLUG="$2"
else
  SLUG=$(echo "$TITLE_EN" \
    | tr '[:upper:]' '[:lower:]' \
    | sed 's/[^a-z0-9 -]//g' \
    | tr ' ' '-' \
    | sed 's/-\+/-/g' \
    | sed 's/^-\|-$//g')
fi
if [ -z "$SLUG" ]; then
  echo "Unable to derive slug from title. Please provide a slug explicitly." >&2
  exit 1
fi
OUTPUT="_projects/${SLUG}.md"
if [ -e "$OUTPUT" ]; then
  echo "Error: $OUTPUT already exists." >&2
  exit 1
fi
TITLE_EN_LIQUID_ESC=$(NEW_PROJECT_TITLE_TMP="$TITLE_EN" python3 <<'PY'
import os
value = os.environ.get("NEW_PROJECT_TITLE_TMP", "")
print(value.replace("'", "\\'"))
PY
)

export NEW_PROJECT_DATA_FILE="$REPO_ROOT/_data/project.yml"
export NEW_PROJECT_SLUG="$SLUG"
export NEW_PROJECT_TITLE_EN="$TITLE_EN"
export NEW_PROJECTS_DIR="$REPO_ROOT/_projects"

python3 <<'PY' > "$OUTPUT"
import os
import re
import sys

try:
    import yaml
except ImportError:
    sys.stderr.write("PyYAML is required to run this script.\n")
    sys.exit(1)

data_file = os.environ.get("NEW_PROJECT_DATA_FILE")
slug = os.environ["NEW_PROJECT_SLUG"]
title_en = os.environ["NEW_PROJECT_TITLE_EN"]
placeholder_name = "<<프로젝트 이름(한글)>>"
placeholder_image = "../assets/images/ProjectThumbnail/placeholder.png"

records = []
if data_file and os.path.exists(data_file):
    with open(data_file, "r", encoding="utf-8") as handle:
        loaded = yaml.safe_load(handle) or []
        if isinstance(loaded, list):
            records = [item for item in loaded if isinstance(item, dict)]

projects_dir = os.environ.get("NEW_PROJECTS_DIR")
max_order = 0
if projects_dir and os.path.isdir(projects_dir):
    for entry in os.scandir(projects_dir):
        if entry.is_file() and entry.name.endswith(".md"):
            with open(entry.path, "r", encoding="utf-8") as handle:
                header = []
                in_header = False
                for line in handle:
                    if line.strip() == "---":
                        if not in_header:
                            in_header = True
                            continue
                        else:
                            break
                    if in_header:
                        header.append(line)
                if header:
                    try:
                        data = yaml.safe_load("".join(header))
                    except yaml.YAMLError:
                        data = None
                    if isinstance(data, dict):
                        order_value = data.get("order")
                        try:
                            order_int = int(order_value)
                        except (TypeError, ValueError):
                            order_int = None
                        if order_int is not None and order_int > max_order:
                            max_order = order_int
next_order = max_order + 1 if max_order >= 0 else 1

slug_normaliser = re.compile(r"[^a-z0-9]+")

def normalise(text: str) -> str:
    lowered = text.lower()
    return slug_normaliser.sub("-", lowered).strip("-")

title_input_norm = normalise(title_en) if title_en else ""

def extract_link_slug(value):
    if not isinstance(value, str):
        return ""
    candidate = value.strip()
    if not candidate:
        return ""
    candidate = candidate.rstrip("/")
    candidate = re.sub(r"\.html$", "", candidate)
    parts = candidate.split("/")
    return parts[-1] if parts else ""

candidates = []
for idx, item in enumerate(records):
    if not isinstance(item, dict):
        continue

    title_field = item.get("title")
    if isinstance(title_field, dict):
        title_en_value = (title_field.get("en") or "").strip()
        title_ko_value = (title_field.get("ko") or "").strip()
    else:
        title_en_value = (title_field or "").strip()
        title_ko_value = ""

    norm_en = normalise(title_en_value) if title_en_value else ""
    norm_ko = normalise(title_ko_value) if title_ko_value else ""
    link_slug = extract_link_slug(item.get("article_link"))

    priority = None
    if slug and link_slug == slug:
        priority = 0
    elif slug and norm_en == slug:
        priority = 1
    elif slug and norm_ko == slug:
        priority = 2
    elif title_en and title_en_value and title_en_value.lower() == title_en.lower():
        priority = 3
    elif title_en and title_ko_value and title_ko_value.lower() == title_en.lower():
        priority = 4
    elif title_input_norm and norm_en == title_input_norm:
        priority = 5
    elif title_input_norm and norm_ko == title_input_norm:
        priority = 6
    elif title_input_norm and norm_en and title_input_norm in norm_en:
        priority = 7
    elif title_input_norm and norm_ko and title_input_norm in norm_ko:
        priority = 8
    elif slug and norm_en and slug in norm_en:
        priority = 9
    elif slug and norm_ko and slug in norm_ko:
        priority = 10

    if priority is not None:
        candidates.append((priority, idx, item))

record = None
if candidates:
    candidates.sort(key=lambda entry: (entry[0], entry[1]))
    record = candidates[0][2]

if isinstance(record, dict):
    title_dict = record.get("title")
    abstract_dict = record.get("abstract")
    dev_tools = record.get("dev_tool")
    image_value = record.get("image")
else:
    title_dict = {}
    abstract_dict = {}
    dev_tools = []
    image_value = None

if not isinstance(title_dict, dict):
    title_dict = {}
if not isinstance(abstract_dict, dict):
    abstract_dict = {"ko": abstract_dict, "en": abstract_dict}
if not isinstance(dev_tools, list):
    dev_tools = []
else:
    dev_tools = [str(tool) for tool in dev_tools]

name_ko = title_dict.get("ko") or placeholder_name
name_en = title_dict.get("en") or title_en

description_ko = (abstract_dict.get("ko") or "").strip()
description_en = (abstract_dict.get("en") or "").strip()

image_path = (image_value or "").strip() or placeholder_image

front_matter = {
    "slug": slug,
    "order": next_order,
    "name": {
        "ko": name_ko,
        "en": name_en,
    },
    "tools": dev_tools,
    "image": image_path,
    "description": {
        "ko": description_ko,
        "en": description_en,
    },
    # "external_url": "",
    "pinned": False,
}

print("---")
yaml.safe_dump(front_matter, sys.stdout, allow_unicode=True, sort_keys=False)
print("---")
PY

cat <<TEMPLATE >> "$OUTPUT"

{% capture ko_content %}
# {{ page.name.ko | default: '프로젝트 이름(한글)' }}

## 1. 🔗 프로젝트 개요 & 링크
> 여기에 프로젝트 개요를 한국어로 작성하세요.

{% include url.html
     variant="website"
     num="01"
     title="Website"
     description="프로젝트 공식 웹사이트"
     url="링크" %}

{% include url.html
     variant="github"
     num="02"
     title="GitHub"
     description="학습, 실험 코드 저장소"
     url="링크" %}

## 2. ✨ 핵심 역량 & 문제 해결
- 핵심 포인트 1
- 핵심 포인트 2

## 3. ⚙️ 개발 과정 (옵션, 협업/실험 기록용)
- 진행 과정, 협업 메모 등을 기록하세요.

## 4. 📊 결과 & 성과
- 주요 성과를 요약하세요.

## 5. 💡 배운 점 & 다음 단계
- 느낀 점과 향후 계획을 정리하세요.
{% endcapture %}

{% capture en_content %}
# {{ page.name.en | default: '$TITLE_EN_LIQUID_ESC' }}

## 1. 🔗 Overview & Links
> Write the project overview in English here.

{% include url.html
     variant="website"
     num="01"
     title="Website"
     description="Official project website"
     url="링크" %}

{% include url.html
     variant="github"
     num="02"
     title="GitHub"
     description="Learning and experiment code repository"
     url="링크" %}

## 2. ✨ Core Strengths & Problem Solving
- Key point 1
- Key point 2

## 3. ⚙️ Development Process (Optional)
- Document collaboration notes or experiment logs.

## 4. 📊 Results & Outcomes
- Summarize the major outcomes.

## 5. 💡 Learnings & Next Steps
- Capture what you learned and future plans.
{% endcapture %}

<div class="lang-content" data-lang="ko" data-lang-group="project-body">
  {{ ko_content | markdownify }}
</div>

<div class="lang-content" data-lang="en" data-lang-group="project-body">
  {{ en_content | markdownify }}
</div>
TEMPLATE

echo "Created $OUTPUT"
