---
slug: (6) KRAFT
order: 6
name:
  ko: 'KRAFT: 코스피 선물 RL 트레이더'
  en: 'KRAFT: KOSPI 200 Reinforcement-learning Agent for Futures Trading'
tools:
- Python
- Pytorch
- Pandas
- NumPy
- Custom Futures Market Simulator
image: ../assets/images/ProjectThumbnail/theFuturess.png
description:
  ko: PPO 알고리즘을 활용해 KOSPI 200 미니 선물 시장에서 스윙 트레이더 에이전트를 개발했습니다. 실제 거래를 반영하기 위해 슬리피지와
    수수료를 포함한 강화학습 환경을 구축하고, Sharpe Ratio 0.8과 최대 낙폭 -12%를 기록했습니다. 복합 보상 설계와 KL Penalty를
    통해 정책 안정화를 구현했으며, 현재는 xAI 적용 및 성능 향상을 위한 개선을 진행 중입니다.
  en: Developed a swing trader agent for the KOSPI 200 mini futures market using the
    PPO algorithm. Built a reinforcement learning environment that incorporates slippage
    and commissions to reflect actual trading conditions, achieving a Sharpe Ratio
    of 0.8 and a maximum drawdown of -12%. Implemented complex reward design and KL
    Penalty for policy stabilization, and currently working on xAI application and
    performance improvement.
pinned: false
---

{% capture ko_content %}
# {{ page.name.ko | default: '프로젝트 이름(한글)' }}

## 1. 🔗 프로젝트 개요 & 링크
PPO 알고리즘을 활용해 KOSPI 200 미니 선물 시장 스윙 트레이더 에이전트를 개발했습니다. 실제 거래 환경과 유사성을 높이기 위해 수수료와 슬리피지를 반영한 시뮬레이터를 기초부터 직접 구현했습니다.

{% include url.html
     variant="github"
     num="01"
     title="YOLO_Futures"
     description="최초 구현 버전이지만 코드를 효과적으로 정리하고, xAI를 도입하고자 아래 KRAFT로 이전했습니다."
     url="https://github.com/KanghwaSisters/YOLO-Futures.git" %}

{% include url.html
     variant="github"
     num="02"
     title="KRAFT"
     description="라이브러리화, 자잘한 오류 수정 후 클린 코드 지향, xAI 도입한 코드"
     url="https://github.com/Tonnonssi/KRAFT.git" %}

## 2. ✨ 핵심 역량 & 문제 해결
{% include elements/callout.html
     variant="default"
     icon="👩‍💻"
     title="역할: 리더 · 강화시스터즈(25-1)" %}

-	단순 가격 예측을 넘어, 매수·매도 강도와 자산 운용 전략을 하나의 통합 정책으로 학습하는 강화학습 에이전트를 설계했습니다.
-	PPO 기반 알고리즘을 적용하고 CNN·Transformer·Informer·DLinear 등 다양한 네트워크 구조를 실험하며 시장 적용 가능성과 한계를 검토했습니다.
-	금융 시계열 데이터를 RL 환경에 적합하게 변환하기 위해 종료 조건, 데이터 흐름 구조를 다각도로 구현했습니다.
-	실제 거래에 가까운 시뮬레이션을 위해 슬리피지·수수료·만기일 로직을 추가했습니다.
-	수익·리스크·기회비용을 동시에 고려한 복합 보상 설계와 정책 안정화를 위한 KL Penalty를 도입해 성능을 개선했습니다.
-	코드 재사용성과 확장성을 고려한 구조를 설계하고 문서화를 강화했습니다.
-	리더로서 구현 범위 배분·코드 리뷰를 주도하며 협업 효율성을 높였습니다.

## 3. ⚙️ 개발 과정 
{% include url.html
     num="PR"
     title="Transformer 논문리뷰"
     description="'Attention Is All You Need' 논문을 리뷰하고 Attention, LayerNorm, Positional Encoding에 관한 세부사항을 보완한다."
     url="../blog/transformer" %}  

{% include url.html
     variant="github"
     num="issue"
     title="YOLO_Futures"
     description="프로젝트를 진행하며 남긴 이슈"
     url="https://github.com/KanghwaSisters/YOLO-Futures/issues" %}

<br>
{% include elements/button.html link="../assets/images/archives/YOLO.pdf" text="📄 Report" block=true %}

## 4. 📊 결과 & 성과
- KL 기반 진입 규제를 적용한 CTTS 모델은 평균 수익률 6.5%, Sharpe Ratio 0.8, 최대 낙폭 -12%, 승률 48% 를 기록하며 수익성과 위험 관리 능력을 동시에 입증했습니다.



## 5. 💡 배운 점 & 다음 단계
- 협업 과정에서 코드 리뷰의 중요성을 깊이 체감했습니다. 깃허브를 활용해 활발히 리뷰를 진행했으며, 다른 사람이 쉽게 이해할 수 있는 코드 작성 습관을 배웠습니다.
- 기존 게임과 달리 금융 시장은 고정된 정보와 에이전트로 인해 변하는 정보가 혼재하는 환경임을 경험했고, 이를 반영한 시뮬레이터 설계 과정에서 큰 즐거움을 느꼈습니다.
- 앞으로는 xAI 기법을 적용해 모델의 의사결정 과정을 해석하고, 금융 AI의 투명성과 신뢰성을 높일 계획입니다.

{% endcapture %}

{% capture en_content %}
# {{ page.name.en | default: 'KRAFT' }}

## 1. 🔗 Overview & Links
Developed a PPO-based swing trading agent for the KOSPI 200 mini futures market, complete with a custom simulator that mirrors real trading costs such as slippage and commissions.

{% include url.html
     variant="github"
     num="01"
     title="YOLO_Futures"
     description="Initial implementation; later refactored and extended in KRAFT"
     url="https://github.com/KanghwaSisters/YOLO-Futures.git" %}

{% include url.html
     variant="github"
     num="02"
     title="KRAFT"
     description="Library-style codebase with bug fixes, cleaner APIs, and xAI integration"
     url="https://github.com/Tonnonssi/KRAFT.git" %}

## 2. ✨ Core Strengths & Problem Solving
{% include elements/callout.html
     variant="default"
     icon="👩‍💻"
     title="Role: Lead · Kanghwa Sisters (Spring 2025)" %}

- Designed a reinforcement-learning policy that unifies entry signals, position sizing, and capital management instead of predicting price alone.
- Experimented with CNN, Transformer, Informer, and DLinear architectures on top of PPO to evaluate what transfers to noisy market data.
- Modeled trading episodes with realistic termination rules, data flows, and delivery schedules to reflect derivatives constraints.
- Simulated slippage, commissions, and contract expiry so backtests match live trading conditions more closely.
- Crafted a composite reward (return, risk, opportunity cost) and added KL-penalty based regulation to stabilize policy updates.
- Structured the project for reusability with modular environments, logging utilities, and thorough documentation.
- As team lead, coordinated task allocation, code reviews, and integration checkpoints for the club.

## 3. ⚙️ Development Process
{% include url.html
     num="PR"
     title="Transformer Paper Review"
     description="Review 'Attention Is All You Need' and fill details of Attention, LayerNorm, Positional Encoding."
     url="../blog/transformer" %}  


{% include url.html
     variant="github"
     num="issue"
     title="YOLO_Futures Issues"
     description="Issue tracker capturing research questions and bug fixes"
     url="https://github.com/KanghwaSisters/YOLO-Futures/issues" %}


<br>
{% include elements/button.html link="../assets/images/archives/YOLO.pdf" text="📄 Report" block=true %}

## 4. 📊 Results & Outcomes
- The KL-regularized CTTS policy produced 6.5% average returns with a Sharpe ratio of 0.8, maximum drawdown of -12%, and a 48% win rate—balancing profitability and risk management.

## 5. 💡 Learnings & Next Steps
- Frequent peer reviews through GitHub underscored how much clearer, well-documented code accelerates collaboration.
- Discovered how financial markets mix stationary references with non-stationary signals, making simulator design both challenging and fun.
- Next steps include applying xAI techniques to interpret trade decisions and improve the transparency of financial AI systems.
{% endcapture %}

<div class="lang-content" data-lang="ko" data-lang-group="project-body">
  {{ ko_content | markdownify }}
</div>

<div class="lang-content" data-lang="en" data-lang-group="project-body">
  {{ en_content | markdownify }}
</div>
