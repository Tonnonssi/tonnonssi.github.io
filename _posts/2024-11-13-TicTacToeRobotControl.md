---
title: "[TicTacToe/02] CNC Plotter 제어"
tags: [TicTacToe]
pages: papers
style: fill  # fill / border 
color:  warning # secondary / success / danger / warning / info / light / dark
description: "Implemented the library to control CNC plotter by using C++. <br>-<br> C++을 이용해 CNC Plotter을 제어하는 라이브러리를 구현했다."
---

<!-- 한국어 콘텐츠 -->
{% capture ko_content %}

## 01. 스텝 모터

> Step Motor 28BYJ-48 기준  

스텝 모터는 움직이던 관성에 영향을 받지 않고, 일정한 각도만큼 회전하는 모터다. 스텝 모터는 신호를 읽고 해당하는 동작을 절차적으로 수행하며 모터를 회전시킨다. 구현에 사용한 28BYJ-48 모터는 5 wires 유니폴라 구조며, 정밀한 제어가 가능한 half-step 시퀀스를 이용한다. (더 자세한 서보 모터의 구조와 시퀀스는 아래 참고 자료를 읽는 것을 추천한다.) 

![alt text](..\assets\images\TicTacToe\Robot\image.png)  

28BYJ-48 스텝 모터의 5 wires는 각각 전원선, IN1-4와 연결된다. 5 wires 유니폴라 방식은 두 개의 코일로 구성되어 있는데, 각각의 코일은 IN1과 IN3, IN2와 IN4과 연결되어 있다. 각각의 선에 0-7 순서로 신호를 전달하면 시계 방향으로 모터가 회전한다. 시계 반대 방향으로 모터를 돌리고 싶다면, 역순으로 신호를 전달하면 된다. 

```
// Switching Seq 
// Step  | IN1 IN2 IN3 IN4
// ----- | ----------------
//   0   |  0   0   0   1
//   1   |  0   0   1   1
//   2   |  0   0   1   0
//   3   |  0   1   1   0
//   4   |  0   1   0   0
//   5   |  1   1   0   0
//   6   |  1   0   0   0
//   7   |  1   0   0   1
```

- **참고 자료** 
1. [Stepper motors and drives, what is full step, half step and microstepping?](https://www.rs-online.com/designspark/stepper-motors-and-drives-what-is-full-step-half-step-and-microstepping)  
2. [Arduino + Stepper (Theory)](https://coeleveld.com/arduino-stepper/)   
3. [아두이노 중급_29. 스텝모터, 스테핑모터](https://m.blog.naver.com/PostView.naver?blogId=darknisia&logNo=221652111026&proxyReferer=https:%2F%2Fwww.google.com%2F&trackingCode=external)  
4. [28BYJ-48 - 5V Stepper Motor](https://components101.com/motors/28byj-48-stepper-motor)


### 아두이노용 라이브러리 제작

아두이노는 `Stepper`라는 스텝 모터 제어 라이브러리를 제공한다. 원래는 `Stepper` 라이브러리를 이용해 제어 프로그램을 작성할 예정이었으나, 디지털 핀에 꼽힌 x와 y축 담당 스텝 모터가 단방향으로만 이동하는 오류가 발생했다. 이 오류는 랜덤으로 발생해 명확한 원인을 알아내기 어려웠다. 예를 들어, 처음에는 양방향으로 잘 돌아가던 모터가 같은 코드 상에서 갑자기 단방향으로만 돌아가는 모습을 보였다. 이 문제를 해결하고자 28BYJ-48 스텝 모터를 제어하는 전용 라이브러리를 다시 만들었다.  

### C++ 기초 다지기 

스텝 모터 제어 라이브러리와 로봇 제어 코드는 전부 C++으로 구현했다. C++의 클래스와 포인터, 참조, 복사를 다룬 아래 두 글은 라이브러리를 구현하며 공부한 내용이다. 

{% include url.html num="01" title="C++ Class" description=" " url="https://tonnonssi.github.io/blog/CppClass" %}   
{% include url.html num="02" title="C++ Pointer & Reference" description=" " url="https://tonnonssi.github.io/blog/CppPointerReference" %}  

<br>

### 코드 바로가기 
{% include elements/button.html link="https://github.com/Tonnonssi/StepMotor.git" text="Codes on GitHub" block=true %}

<br>

### 문제 상황 및 해결  

1. **모터의 속도 저하 문제.**   
  하나 하나 핀을 설정해주는 것과 그 내용을 함수로 묶은거랑 움직임 속도 차이가 난다. .. 왜? 


2. **병렬 연산을 지원하지 않는 아두이노.**   
  대각선을 그리기 위해서는 x,y 축이 동시에 움직여야 한다. 하지만 아두이노는 병렬 연산을 지원하지 않기 때문에 `std::thread()`를 사용할 수 없다. 처음에는 아두이노에서의 멀티 테스킹을 가능케 만드는 [`Scheduler`](https://github.com/mikaelpatel/Arduino-Scheduler)를 사용하려고 했다. 구현해야 하는 대각선 그리는 코드는 n_steps를 받아 그 크기만큼 x, y 스텝모터를 동시에 움직여야 하는데, 스케줄러는 정적 함수만을 파라미터로 받기 때문에 구현이 불가능했다. 이 문제는 `MultiStepper(&stepper_x, &stepper_y)` 클래스를 구현해 해결했다.  

3. **한 방향으로만 도는 모터.** 
  Seiral 통신을 통해 direction과 step_signal이 오류 없이 변화하는 것을 확인했음에도 회전 방향이 달라지지 않았다. 이 문제는 step 사이의 더 큰 delay() 값을 주며 해결되었다. 너무 적은 -나의 초깃값은 30이었다- 딜레이 시간은 모터에게 신호를 제대로 전달하지 못한다는 것을 알 수 있었고, 여러 시도 후 500을 딜레이 값으로 설정했다. 

## 03. 그림 그리기 제어 코드 
### TicTacToeArtist 
틱택토 아티스트 클래스는 3개의 스텝 모터를 이용해 O / X, 판을 그리는 제어용 클래스다. `StepMotor.h` 라이브러리를 이용해 3개의 스텝 모터 클래스를 선언한 후, 인자로 받아 사용한다. 
{%- gist 3c466bc3c32c4ae5c9b36d1266b913d8 %} // 수정해야 되,

```
ino code 여기로 
```

{% include elements/button.html link="https://github.com/Tonnonssi/StepMotor.git" text="Codes on GitHub" block=true %}
// 수정해야 되

### 실제 움직임 


### 문제 상황 및 해결

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