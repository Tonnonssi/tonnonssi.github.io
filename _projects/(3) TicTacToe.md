---
name: Tic-Tac-Toe
tools: [python, RL, Robotics, Arduino, C++, web]
image:
description: "From classical learning strategies to AlphaZero to study tic-tac-toe. Implemented a CNC robot to interact with humans in the real world.<br>-<br>고전적인 학습 전략부터 알파제로까지를 전부 사용해 틱택토를 학습했다. CNC 로봇을 구현해 현실에서 인간과 상호작용할 수 있게 만들었다."
---

<!-- 한국어 콘텐츠 -->
{% capture ko_content %}
  

# TicTacToe

{% capture list_items %}
How to use
Result 
역할
작성한 글
{% endcapture %}
{% include elements/list.html title="Table of Contents" type="toc" %}

## How to use 
{% include url.html num="01" title="GitHub" description="" url="https://github.com/Tonnonssi/TicTacToeArtist.git" %}  
학습에 사용된 모든 코드를 확인할 수 있다.  

## Result 
![결과](../assets/images/TicTacToe/Robot/realWorld.gif)

## 역할  
24-2 강화시스터즈 동아리 활동으로 진행한 프로젝트로, 로보틱스 파트와 전반적인 듀얼 에이전트 게임 학습 방법론을 가르치는 역할을 담당했다.  

## 작성한 글 
{% include url.html num="01" title="[TicTacToe/01] CNC Plotter 제작" description="To help AI and humans interact in the real world, I built CNC Plotter, a robot that draws pictures.<br> AI와 인간이 현실 세계에서 상호작용하게 만들고자 했다. 이를 위해 그림을 그리는 로봇인 CNC Plotter을 제작했다." url="https://tonnonssi.github.io/blog/TicTacToeRobot" %}  
{% include url.html num="02" title="[TicTacToe/02] CNC Plotter 제어" description="Implemented the library to control CNC plotter by using C++. <br> C++을 이용해 CNC Plotter을 제어하는 라이브러리를 구현했다." url="https://tonnonssi.github.io/blog/TicTacToeRobotControl" %}  

{% endcapture %}

<!-- 영어 콘텐츠 -->
{% capture en_content %}

To be continue...

{% endcapture %}

<div id="content-ko" class="lang-content" data-lang="ko">
  {{ ko_content | markdownify }}
</div>

<div id="content-en" class="lang-content" data-lang="en" style="display: none;">
  {{ en_content | markdownify }}
</div>

