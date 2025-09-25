---
slug: (2) LoLStrategyInsight
order: 2
name:
  ko: 리그오브레전드 전략 패턴 시각화
  en: 'LoL-StrategyInsight: Visual Analytics of League of Legends Strategy Patterns'
tools:
- Python
- BeautifulSoup
- Selenium
- R
- Tidyverse
- Shiny
- Visualization
image: ../assets/images/ProjectThumbnail/lol.jpg
description:
  ko: 진입 장벽이 높은 게임인 *리그 오브 레전드(LoL)*의 기본적인 게임 양상을 시각화하여 초심자의 이해를 돕는 것을 목표로 했습니다. 파이썬을
    활용한 데이터 크롤링과 전처리를 기반으로, R의 Tidyverse 패키지와 다양한 시각화 기법을 적용했으며, Shiny를 통해 복잡한 네트워크
    관계를 분석·표현했습니다. 이를 통해 LoL의 전략적 패턴을 직관적으로 탐색할 수 있는 시각화 자료를 구축했습니다.
  en: Developed a visual analytics tool to help beginners understand the complex gameplay
    of *League of Legends (LoL)* by visualizing its fundamental game aspects. Leveraged
    Python for data crawling and preprocessing, applied various visualization techniques
    using R's Tidyverse package, and utilized Shiny to analyze and represent complex
    network relationships. This resulted in the creation of a visualization resource
    that allows for intuitive exploration of strategic patterns in LoL.
# external_url: ''
pinned: false
---

{% capture ko_content %}
# {{ page.name.ko | default: '프로젝트 이름(한글)' }}

## 1. 🔗 프로젝트 개요 & 링크
진입 장벽이 높은 게임인 **리그 오브 레전드(LoL)**의 기본적인 게임 양상을 시각화하여 초심자의 이해를 돕는 것을 목표로 했습니다.


## 2. ✨ 핵심 역량 & 문제 해결
{% include elements/callout.html
     variant="default"
     icon="👩‍💻"
     title="역할: 리더 · 23-2 이화여자대학교 빅데이터를이용한통계그래픽스 "
     body="전처리 · Shiny 시각화 · 크롤링 · 세부 항목 시각화" %}
     
- 가독성이 떨어지는 데이터 프레임을 분석할 자료에 맞게 재구성했습니다. 데이터를 분리 및 분류할 때 사용한 모든 정보는 공식 홈페이지 정보를 참고 및 크롤링하여 사용했습니다. 
- 파이썬 · R을 각각 전처리와 시각화에 이용했습니다. 정규 수업 시간에 배운 내용 이외 (라이더 맵, 워드 클라우드, Shiny etc.) 다양한 시각화를 추가적으로 진행했습니다. 
- 전반적인 가독성을 높이기 위해 반복되는 요소들의 색을 고정했습니다. 각 라인 별 5가지의 색과, 상반되는 주황-초록색을 지정했습니다. 

## 3. ⚙️ 개발 과정
1. 데이터 전처리 및 크롤링
2. ggplot과 dplyr을 중심으로 시각화 
3. 시각화를 바탕으로 분석 

## 4. 📊 결과 & 성과

{% include url.html
     variant="website"
     title="프로젝트 보고서"
     description="Notion 문서에서 데이터 전처리와 시각화 결과물을 확인해주세요."
     url="https://recondite-lungfish-fd3.notion.site/27984d3f783080f5bbe1e93a51fbd42d?source=copy_link" %}


## 5. 💡 배운 점 & 다음 단계
- 다양한 시각화를 원없이 만들었습니다. 다음에는 더 잘, 예쁘고 가독성을 챙기면서 만들 수 있을 것 같습니다. 
- 게임에 대해 잘 몰라서 좀 더 확실한 관점을 세우지 못해 주제가 피상적인 수준에 머물렀던 것 같아 아쉽습니다. 이상치를 집중적으로 탐구해봤어도 좋을 것 같습니다. 
{% endcapture %}

{% capture en_content %}
# {{ page.name.en | default: 'LoL-StrategyInsight' }}

## 1. 🔗 Overview & Links
Mapped core match patterns from *League of Legends* and translated them into visual narratives so newcomers can understand the flow of the game faster.

## 2. ✨ Core Strengths & Problem Solving
{% include elements/callout.html
     variant="default"
     icon="👩‍💻"
     title="Role: Project Lead · Ewha Womans University (2023-2)"
     body="Data collection · Shiny dashboards · Detailed tactical visualizations" %}

- Led the entire data pipeline from scraping to preprocessing, ensuring consistent stats across patches and leagues.
- Built interactive Shiny dashboards so users can explore champion pools, lane rotations, and vision control without manual filtering.
- Designed small-multiple visualizations that explain win conditions (lane priority, objective timing, ward density) at a glance.

## 3. ⚙️ Development Process (Optional)
1. Crawled and cleaned match histories with Python, Selenium, and BeautifulSoup.
2. Modeled the dataset in R and crafted visuals with `ggplot2`, `dplyr`, and custom themes.
3. Composed the narrative and packaged the dashboards for live demos and mentoring sessions.

## 4. 📊 Results & Outcomes
{% include url.html
     variant="website"
     title="Project Report"
     description="Read the Notion write-up covering data sourcing, visual design, and insights"
     url="https://recondite-lungfish-fd3.notion.site/27984d3f783080f5bbe1e93a51fbd42d?source=copy_link" %}

- Delivered a guided dashboard that new club recruits used during onboarding to understand macro play fundamentals.
- Identified repeatable macro patterns (fast mid rotations, objective setups) and converted them into training handouts for the team.

## 5. 💡 Learnings & Next Steps
- Learned how to keep fast-changing esports data consistent by versioning scrapers and annotating patch changes.
- Plan to add automated storytelling captions that summarize each chart and to expand coverage to pro play-off series.
{% endcapture %}

<div class="lang-content" data-lang="ko" data-lang-group="project-body">
  {{ ko_content | markdownify }}
</div>

<div class="lang-content" data-lang="en" data-lang-group="project-body">
  {{ en_content | markdownify }}
</div>
