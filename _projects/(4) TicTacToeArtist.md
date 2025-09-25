---
slug: (4) TicTacToeArtist
order: 4
name:
  ko: 'TicTacToeArtist: CV·로보틱스 기반 틱택토 AI'
  en: 'TicTacToeArtist: End-to-End AI for TicTacToe with Vision and Robotics'
tools:
- Python
- C++
- Pytorch
- OpenCV
- Arduino
image: ../assets/images/ProjectThumbnail/TTT.png
description:
  ko: CNC 플로터 제어해 AI와 인간이 직접 상호작용하며 틱택토를 플레이할 수 있는 시스템을 구축했습니다. MCS, MCTS, Min-Max,
    AlphaBeta 등 다양한 방법론을 구현해 비교했고, 특히 AlphaZero 기반 강화학습 모델을 통해 최적의 플레이어 신경망을 학습했습니다.
    실험 결과, AlphaZero 기반 AI가 다른 방법론 대비 가장 높은 승률을 기록했습니다.
  en: Built a system where AI and humans can play TicTacToe interactively using a
    CNC plotter. Implemented and compared various methodologies including MCS, MCTS,
    Min-Max, and AlphaBeta, with a focus on training an optimal player neural network
    using an AlphaZero-based reinforcement learning model. Experimental results showed
    that the AlphaZero-based AI achieved the highest win rate compared to other methodologies.
pinned: false
---

{% capture ko_content %}
# {{ page.name.ko | default: '프로젝트 이름(한글)' }}

## 1. 🔗 프로젝트 개요 & 링크
<br>
**CNC 플로터(로봇) - 틱택토 판 인식(CV) - 듀얼 제로섬 게임 에이전트(RL)**를 개발해 시스템화시켰다. 

{% include url.html
     variant="github"
     title="GitHub"
     description="학습, 실험 코드 저장소"
     url="https://github.com/Tonnonssi/TicTacToeArtist.git" %}

## 2. ✨ 핵심 역량 & 문제 해결

{% include elements/callout.html
     variant="default"
     icon="👩‍💻"
     title="역할: 팀원 · 강화시스터즈(24-2)"
     body="듀얼 에이전트 제로섬 게임 알고리즘 이론 강의 · 로보틱스" %}

- minmax알고리즘부터 알파제로까지 듀얼 제로섬 게임 에이전트 이론을 공부하고 동아리원을 지도했습니다. 
- 아두이노 공부를 학기 초부터 병행해 동아리원들의 CV와 AI 작업 이전에 로보틱스를 완성했습니다. 
- 아두이노에서 발생하는 불안정성을 없애기 위해 C를 공부해 프로젝트에 최적화된 동작 라이브러리를 개발했습니다. 


## 3. ⚙️ 개발 과정
- 듀얼 에이전트 개인 공부, 로보틱스 부분을 작성했습니다. 

{% include url.html
     variant="github"
     title="GitHub"
     description="듀얼 에이전트 기초부터 심화까지 개인 공부 레파지토리"
     url="https://github.com/Tonnonssi/tic_tac_toe.git" %}
{% include url.html num="01" title="CNC Plotter 제작" description="AI와 인간이 현실 세계에서 상호작용하게 만들고자 했고, 그림을 그리는 로봇인 CNC Plotter을 제작했다." url="../blog/TicTacToeRobot" %}  
{% include url.html num="02" title="CNC Plotter 제어" description="C++을 이용해 CNC Plotter을 제어하는 라이브러리를 구현했다." url="../blog/TicTacToeRobotControl" %}  

## 4. 📊 결과 & 성과
- 틱택토는 승리 패턴이 적기 때문에 두 번째 플레이어가 불리합니다. 알파제로를 적용한 틱택토 에이전트는 {% include elements/highlight.html text="두 번째 플레이어일 때도 낮은 패배율을 보였으며 다른 고전 듀얼 제로섬 에이전트보다 높은 승률" %} 을 보였습니다. 

<table class="project-image-grid">
  <tr>
    <td><img src="../assets/images/TicTacToe/Robot/blueprint.png" alt="CNC blueprint" /></td>
    <td><img src="../assets/images/TicTacToe/Robot/circuit.png" alt="Control circuit" /></td>
  </tr>
  <tr>
    <td><img src="../assets/images/TicTacToe/Robot/real.png" alt="Robot assembly" /></td>
    <td><img src="../assets/images/TicTacToe/Robot/realWorld.gif" alt="Real-world play demo" /></td>
  </tr>
</table>

<br>
{% include elements/button.html link="../assets/images/archives/TicTacToe.pdf" text="📄 Report" block=true %}

## 5. 💡 배운 점 & 다음 단계
- 싱글 에이전트와 달리 듀얼 에이전트는 상대까지 고려해 행동해야하기 때문에 사용하는 이론도, 난이도도 상이했습니다. 제로섬 게임 플레이어 이론이 어떻게 발전되어 왔고, 강화학습에서 어떻게 구현되었는지 배우는 과정이 새로웠습니다. 
- 전체 구조를 짤 때는 어렵지 않을 거라 생각하고 호기롭게 시작한 프로젝트였습니다. 하지만 로보틱스에 대한 지식이 아예 없어 아주 단순한 현상이라도 문제를 명확히 규정하는 것부터가 많은 시간이 소요됐습니다. 문제를 인지하는 것부터가 해결의 시발점이라는 걸 알게 되었습니다. 

{% endcapture %}

{% capture en_content %}
# {{ page.name.en | default: 'TicTacToeArtist' }}

## 1. 🔗 Overview & Links
<br>
Built an end-to-end loop that blends **CNC plotter robotics, TicTacToe board perception, and dual zero-sum reinforcement learning agents**.

{% include url.html
     variant="github"
     title="GitHub"
     description="Source code for robotics, CV pipeline, and RL agents"
     url="https://github.com/Tonnonssi/TicTacToeArtist.git" %}

## 2. ✨ Core Strengths & Problem Solving

{% include elements/callout.html
     variant="default"
     icon="👩‍💻"
     title="Role: Team Member"
     body="Led dual-agent zero-sum algorithm sessions and engineered the robotics stack" %}

- Mentored club members through the progression from Minimax/MCTS to AlphaZero, distilling the theory into practical agent implementations.
- Completed the robotics layer early so teammates could focus on CV and AI, integrating hardware, firmware, and calibration.
- Eliminated Arduino instability by authoring a C/C++ motion library tailored to the CNC plotter’s mechanics.

## 3. ⚙️ Development Process
- Authored the dual-agent research notes and implemented the robotics subsystem.

{% include url.html
     variant="github"
     title="Study Notes"
     description="Personal repository covering dual-agent theory and experiments"
     url="https://github.com/Tonnonssi/tic_tac_toe.git" %}
{% include url.html num="01" title="[TicTacToe/01] Building the CNC Plotter" description="How we constructed a drawing robot so the AI could interact with humans in the physical world." url="../blog/TicTacToeRobot" %}  
{% include url.html num="02" title="[TicTacToe/02] Controlling the CNC Plotter" description="Implemented a C++ library to drive the plotter precisely for turn-by-turn play." url="../blog/TicTacToeRobotControl" %}  

## 4. 📊 Results & Outcomes
- Because TicTacToe offers few winning lines, the second player is typically disadvantaged. The AlphaZero-inspired agent maintained {% include elements/highlight.html text="a low loss rate even when playing second and outperformed classical zero-sum baselines" %}.

<table class="project-image-grid">
  <tr>
    <td><img src="../assets/images/TicTacToe/Robot/blueprint.png" alt="CNC blueprint" /></td>
    <td><img src="../assets/images/TicTacToe/Robot/circuit.png" alt="Control circuit" /></td>
  </tr>
  <tr>
    <td><img src="../assets/images/TicTacToe/Robot/real.png" alt="Robot assembly" /></td>
    <td><img src="../assets/images/TicTacToe/Robot/realWorld.gif" alt="Real-world play demo" /></td>
  </tr>
</table>

<br>
{% include elements/button.html link="../assets/images/archives/TicTacToe.pdf" text="📄 Report" block=true %}


## 5. 💡 Learnings & Next Steps
- Unlike single-agent RL, dual-agent systems must reason about an opponent. Tracing how zero-sum game theory evolved and how it translates into modern RL architectures was eye-opening.
- With no prior robotics experience, even diagnosing simple mechanical issues took significant time. Recognizing and articulating the problem turned out to be the critical first step toward a fix.
{% endcapture %}

<div class="lang-content" data-lang="ko" data-lang-group="project-body">
  {{ ko_content | markdownify }}
</div>

<div class="lang-content" data-lang="en" data-lang-group="project-body">
  {{ en_content | markdownify }}
</div>
