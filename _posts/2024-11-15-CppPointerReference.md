---
title: "[C++] Pointer & Reference"
tags: [Cpp]
pages: papers
style: fill  # fill / border 
color:  danger # secondary / success / danger / warning / info / light / dark
description: "Introductory of Pointer and Reference <br>-<br> 기초적인 포인터와 참조"
---

<!-- 한국어 콘텐츠 -->
{% capture ko_content %}

포인터와 참조는 메모리와 관련된 개념으로, C 프로그래밍에서 빠질 수 없는 개념이다. 이 글은 포인터와 참조의 특성, 차이점, 사용법에 대해 다룬다.  

### 포인터(Pointer)
포인터는 변수의 메모리 주소를 담는 변수다. 코드에 작성되는 모든 변수는 메모리 공간에 저장되고, 주소가 할당된다. 이 주소가 바로 포인터가 담는 내용이다. 
포인터는 포인터를 중심으로 원본 객체를 불러올 수 있고, 원본 객체의 멤버 변수들을 꺼내올 수 있다. 

#### 포인터 정의  
```cpp
int* pointer;
```
타입 옆에 `*`를 붙이면 포인터 인스턴스를 생성할 수 있다.  

### 포인터에서 사용되는 연산자
1. `& 연산자` (주소 연산자) : 변수의 주소를 추출하는 연산자로, 포인터에 변수의 주소값을 할당할 때 사용된다. 
2. `* 연산자` (간접참조 연산자; 역참조 연산자) : 포인터가 가리키는 장소에 값을 저장하는 연산자로, 이미 정의된 포인터에 어떤 값을 할당하기 위해 사용된다. 
3. `->` (멤버 접근 연산자) : 포인터의 멤버 변수에 접근하는 연산자다.  

#### 예시를 통해 이해하기 

01. 포인터 인스턴스 생성  
```cpp
int* pt;
```
위 코드는 포인터 pt를 생성한다. 이때 포인터는 초기화없이 선언만 되었기 때문에 랜덤한 값이 pt안에 할당된다. 따라서 값을 *pt로 pt에 있는 주소값에 있는 인스턴스를 가져오는 건 아무런 의미가 없다. 


02. 다른 인스턴스를 포인터에 할당 (포인터 초기화)  
```cpp
int* pt;
int var_1 = 40; // 주소를 0x01라 가정한다. 
pt = &var_1; // &는 var_1의 주소를 끄집어내는 연산자다.
```

위 코드는 주소가 0X01, 객체의 값이 40인 var_1의 주소를 pt에 할당한다.  

- 포인터 해석   


```cpp
#include <iostream>

int* pt;
int var_1 = 40; 
pt = &var_1; 

cout << "value of p : " << p << endl; // value of p : 0X01
cout << "value of *p : " << *p << endl; // value of *p : 40
```

03. 멤버 변수 접근  

```cpp
#include <iostream>
using namespace std;

class MyClass {
public:
    int data; // 멤버 변수
};

int main() {
    MyClass obj;       // 객체 생성
    obj.data = 10;     // 멤버 변수 직접 접근

    MyClass* ptr = &obj; // 객체의 주소를 포인터에 저장
    ptr->data = 20;      // 포인터를 통해 멤버 변수 접근

    cout << "obj.data: " << obj.data << endl; // 출력: obj.data: 20

    return 0;
}

```
직접 접근과 포인터를 통한 접근을 다룬 예제다. 


### 참조(Reference)
참조는 포인터와 마찬가지로 메모리 주소를 받는다. 하지만 사용 방법과 기능면에서 차이가 있다. 포인터는 변수의 주소를 저장해 직접적으로 변수에 접근하지만, 참조는 같은 주소를 공유하는 인스턴스를 만든다. 이 인스턴스는 원본 객체에서 얕은 복사가 된 객체로, 참조 인스턴스의 값이 수정되면 원본 객체 또한 변화한다. 

#### 참조 정의  
```cpp
int ref = 10;
int& a = ref; // 참조 선언 
```
참조는 `&`를 타입 뒤에 붙여 정의한다.  
참조는 포인터와 달리, 선언된 참조 변수(a)를 일반 변수처럼 사용할 수 있기에 별도의 연산자(*,&)가 필요하지 않아 간편하다. 다만 참조는 정의할 때 초기화가 필수적이며, 포인터처럼 독립적으로 정의될 수 없다.  

```cpp
int* p; // 초기화가 안 되어도 정의될 수 있음 
int& a; // 초기화가 안 되어서 오류 발생 
```

## 포인터 vs 참조 
<table>
  <thead>
    <tr>
      <th>특성</th>
      <th>참조 (Reference)</th>
      <th>포인터 (Pointer)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>선언 및 초기화</strong></td>
      <td>선언과 동시에 초기화가 반드시 필요</td>
      <td>초기화 없이 선언만 할 수 있음</td>
    </tr>
    <tr>
      <td><strong>주소 변경</strong></td>
      <td>초기화된 이후 다른 주소를 참조할 수 없음</td>
      <td>포인터는 다른 주소를 가리키도록 변경할 수 있음</td>
    </tr>
    <tr>
      <td><strong>Null 값</strong></td>
      <td>Null 값을 가질 수 없음</td>
      <td>Null 포인터를 가질 수 있음 (<code>nullptr</code>/NULL 사용 가능)</td>
    </tr>
    <tr>
      <td><strong>문법의 간결함</strong></td>
      <td>참조를 사용하면 원래 변수처럼 사용하므로 문법이 단순함</td>
      <td>포인터는 연산자(<code>*</code>, <code>&</code>, <code>-></code>)를 명시적으로 사용해야 함</td>
    </tr>
    <tr>
      <td><strong>사용 목적</strong></td>
      <td>주로 함수 인자 전달이나 반환값을 사용할 때 사용됨</td>
      <td>동적 메모리 할당, 배열 처리 등 다양한 상황에서 사용됨</td>
    </tr>
  </tbody>
</table>

### 클래스와 포인터, 참조  

클래스에서 또 다른 클래스를 파라미터로 받아 사용하거나, 멤버 변수로 받아 사용할 때는 일반적으로 참조(혹은 포인터)가 사용된다. C 프로그래밍에서 가장 핵심적인 것은 효율적인 메모리 관리다. 참조와 포인터는 동일한 주소를 공유 혹은 사용하기 때문에 중복 데이터에 대한 메모리 할당을 하지 않아도 된다. 만약 클래스의 파라미터로 복잡한 구조의 클래스를 받는데 참조나 포인터를 사용하지 않는다면, 메모리 오남용을 유발한다. 

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