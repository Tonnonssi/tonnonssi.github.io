---
name: Omok
tools: [python, RL, Robotics, IssacSim, Arduino, C++, web]
image:
description: "Trained an 'Omok' model based on AlphaZero. To interact with humans in the real world, an Arduino-controlled robotic arm was built and taught to move. <br>-<br>알파제로를 기반으로 오목을 두는 모델을 만들었다. 현실에서 인간과 상호작용하기 위해 아두이노로 제어하는 로봇팔을 제작하고 수를 두도록 학습시켰다. "
# external_url: https://github.com/yousinix
---


<!-- 한국어 콘텐츠 -->
{% capture ko_content %}
  

# Omok

{% capture list_items %}
How to use
About TicTacToe   
역할
작성한 글
{% endcapture %}
{% include elements/list.html title="Table of Contents" type="toc" %}

## How to use 
{% include url.html num="01" title="GitHub" description="" url="https://github.com/Tonnonssi/AiGO.git" %}  
학습에 사용된 모든 코드를 확인할 수 있다.  

## Result 
![결과](../assets/images/Omok/Omok.gif)  

![움짤](../assets/images/Omok/with_policy.gif)

## 역할  
24-2 강화시스터즈 동아리 활동의 일환으로 진행한 프로젝트로, 로보틱스 파트, 알파제로 구현, 웹 구현은 담당했다.  
  

## 작성한 글 
  

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

