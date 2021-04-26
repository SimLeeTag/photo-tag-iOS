# Photo Tag - iOS Repository
<img src = "https://user-images.githubusercontent.com/58318786/96359589-80726000-114f-11eb-9e7a-c17f51b32cb1.png" width = "60%">


## Photo Tag

- 활동 기간: 2020.10 ~ 2021.02 + 리팩토링 2021.04
- 키워드  
GCD, DispatchQueue, OperationQueue, HTTP, Image Cache, MVVM-C, Combine, Test Case, Code Review, Swift, UIKit, Codebase UI
- 주요 내용  
디바이스 사진앱에 저장되어있는 사진(최대 5장)에 해시태그와 함께 노트를 작성하여 관리할 수 있도록 만든 포토 노트 앱입니다. MVVM-C 패턴의 프로젝트로 동시성 프로그래밍을 활용한 네트워크 처리 및 이미지 처리, 메모리 관리(리테인 사이클 해결)의 초점을 맞췄고, 반응형 UI와 Combine 프레임워크를 시도했습니다.

<br/>

## Description

![](https://i.imgur.com/fSofvJD.jpg)
![](https://i.imgur.com/RT1h6N9.jpg)
![](https://i.imgur.com/LX6x5IJ.png)
<br/>

## 고민한 점과 문제 해결 과정  
👉🏻 [리팩토링 PR #58](https://github.com/SimLeeTag/photo-tag-iOS/pull/58)

### 1. 거대한 ViewController를 벗어나고 각 객체의 정상 동작을 효율적으로 확인하기 위한 노력: MVVM-C

**[  각 객체의 역할과 책임을 소분하고 더 유연하게 만들기 위한 노력 ]**

#MVVM-C   #클린*아키텍쳐(Network 관련 구조) #반응형*프로그래밍  #Unit_Test

크게 3가지 이유로 MVC가 아닌 MVVM-C를 선택하여 구현하였습니다.  
첫 번째는 MVC에서는 ViewController에 코드가 방대해지고 그만큼 책임이 집중되어 하나의 객체가 거대해지고 책임이 막중해지는 문제가 있었습니다.  
두 번째는 입력/터치 이벤트가 발생했을 때 Model의 상태가 변경되고 View가 이 변화를 감지하다가 그 상태에 맞게 업데이트되도록 구현하는 것이 목적이었습니다. 그래서 View와 View를 채울 데이터를 제공하는 객체를 binding하고 listener를 설정할 수 있는 Observable 객체를 고안하였고 이에 맞는 구성이 필요했습니다.  
세 번째는 모델 관련 중요 객체와 함수가 제대로 동작하는지 확인하고 코드의 신뢰도를 높이기 위해서 단위 테스트 케이스를 만들었습니다. 그런데 이 과정에서 View와 Model, ViewController의 의존성이 강하여 제약과 불편한 점이 많았습니다.  
  
**이런 문제점들을 개선하기 위해서 View와 비즈니스 로직 등 각 객체를 작게 만들고 최대한 분리하는 작업이 필요하고 느꼈습니다. 그래서 View Controller의 역할을 더 가볍게 하기 위해 기존 MVVM에 화면 전환을 담당하는 Coordinator 를 추가하는 MVVM-C 패턴을 선택했습니다.**

그뿐만 아니라 네트워킹 관련하여 구조를 설계할 때 API 명세서에 맞게 구현하면서 형태가 비슷한 요청을 재사용하기 위해 또한 stub 객체를 사용하여 단위 테스트를 만들기 위해서 프로토콜을 통해 **유연성을 높일 필요**를 느꼈습니다. 그래서 방법을 찾던 중 **iOS 클린 아키텍처 중 네트워크 관련 부분을 참고**하였습니다.

- **작성한 블로그 글**

1. [MVVM](https://lena-chamna.netlify.app/post/ios_design_pattern_mvvm/) 
2. [Coordinator 1](https://lena-chamna.netlify.app/post/ios_design_pattern_coordinator_basic/) 
3. [Coordinator 2](https://lena-chamna.netlify.app/post/ios_design_pattern_coordinator_advanced/) 

### 2. HTTP, 응용을 위한 기본 이해

백엔드 개발자와 상의하여서 정한 API 형식에 맞게 클라이언트에서 서버로 이미지 파일과 텍스트를 업로드를 해야했습니다. 형식에 맞게 HTTP 요청을 구현했어야 하는데, HTTP 에 대한 기본적인 이해가 필요했습니다. 그래서 **HTTP 규약과 구성 등 HTTP**에 대한 기본을 먼저 학습한 다음에 응용하였고 결국에는 서버에 파일 보내는 것을 성공했었습니다. 

* 관련 블로그 글: 
1. [HTTP 이해하기](https://lena-chamna.netlify.app/post/http_multipart_form-data/) 
2. [클라이언트에서 서버로 파일 보내기](https://lena-chamna.netlify.app/post/uploading_array_of_images_using_multipart_form-data_in_swift/))

### 3. 피드백 받기

이전 프로젝트를 진행하면서 아쉬웠던 부분을 보완하면서 백엔드 개발자 1명과 함께 사이드 프로젝트를 진행했었습니다. 혼자 개발을 하면서 더 고려해야하는 점은 없는지, 더 나은 방법은 없는지 등 다른 의견과 시야의 필요성을 느끼고 **직접 다른 iOS 개발자 분들에게 코드 리뷰를 부탁**하였고, **피드백과 코멘트를 주고받으면서 더 다양한 부분을 깊이 고민을 하면서 개발**할 수 있었습니다. 
* [관련된 대표 PR](https://github.com/SimLeeTag/photo-tag-iOS/pull/21)

### 4. Test Case

각 객체의 역할과 책임에 대해서 고민하면서 각자가 본인의 역할을 의도한 대로 동작하는 것이 중요함을 깨닫고 view model의 **테스트 케이스**를 작성하였습니다. 
* [Github](https://github.com/SimLeeTag/photo-tag-iOS/blob/dev/PhotoTag/PhotoTagTests/PhotoTagTests.swift)

### 5. 앱의 반응성 높이기 위한 노력
👉🏻 [리팩토링 PR #58](https://github.com/SimLeeTag/photo-tag-iOS/pull/58)

- **Metrickit**을 이용하여 앱 반응성 체크 Metrickit을 이용하여 런타임에서 앱이 멈춘 시간을 체크하였고, 이미지를 서버에 요청하여 받아온 데이터를 표시할 때 걸리는 시간이 문제임을 확인하고 이 시간을 줄이기 위해 아래와 같은 노력을 했습니다.
- **네트워크 관련 동시성 프로그래밍** 
#Dispatch_Queues #Operation #이미지_압축 #URLSession #HTTP #multi-part / form data #Combine  
    > **[ 포토 노트 상세 화면 - 이미지 처리 ]**
    상세화면에서 노트의 데이터를 서버에 요청하여 가져오는 경우, 비동기적으로 도착하는 이미지가 산발적으로 표시되지 않고 노트에 포함된 모든 이미지들을다 가져와 표시하도록 **Dispatch Queue**를 이용하여 처리하였습니다.<br>
    **[ 포토 노트 리스트 화면 - 스크롤링에 따른 데이터 요청]** 
    태그별 포토 노트 리스트(메인) 화면에서 **Operation Queue**를 이용하여 Table View에서 스크롤이 지나간 Cell은 데이터(이미지 포함)를 표시를 하지 않고(요청을 취소하고), 보여지는 부분의 Cell 만 표시하도록 구현했습니다.
    
  1. **Dispatch Queue와 Dispatch Group**을 사용하여 서버와 통신하여 비동기적으로 도착하는 데이터, 특히 이미지 데이터가 UI에 표시될 때 산발적이지 않고 모두 도착한 다음 표시되도록 구현했습니다.
  2. 해시태그가 포함되어있는 이미지 노트 목록을 구현할 때 스크롤링하여 지나가는 부분에 대해 불필요한 서버 요청을 줄이고 반응 속도를 높이고자 요청 취소와 일시중지 기능이 있는 **OperationQueue**을 이용하여 구현하였습니다.
  3. Operation Queue를 이용하여 작업끼리의 순서와 타이밍을 맞춰야 할 필요가 있을 때 프로토콜을 활용하여 operation의 dependency 설정했습니다. ([Operations](https://github.com/SimLeeTag/photo-tag-iOS/tree/dev/PhotoTag/PhotoTag/Utility/Operation))
  4. 이미지를 서버에 보낼 때 iOS 디바이스로 촬영한 HEIC의 용량이 서버에서 허용하는 값보다 높아 요청이 거절되는 문제가 있어 이미지 확장자를 변경하고 **다운사이징(리사이징)** 처리하였습니다.
  5. 서버에서 데이터를 가지고 오는 completion handler에서 발생하는 순환 참조 문제를 'weak' 를 사용하여 클로저 순환 참조(retain cycle) 해결했습니다.

- **좀 더 효율적인 UI Rendering을 만들기**  
#이미지*캐싱 #메모리*캐싱 #디스크_캐싱   
서버 통신 비용 절감 및 랜더링 속도를 높이기 위해서 서버에 요청하여 데이터를 받아온 후 한 번 다운로드 한 이미지를 **캐싱**하여 재사용하도록 구현했습니다.

* 관련 블로그 글: 
1. [동시성 프로그래밍(Concurrency programming): 스레드와 큐(Thread and Queue)](https://lena-chamna.netlify.app/post/concurrency_programming_thread_and_queue/) 
2. [동시성 프로그래밍(Concurrency programming): dispatchQueue 사용시 주의할 점들](https://lena-chamna.netlify.app/post/concurrency_programming_caution_when_using_dispatchqueue/))
3. [Swift의 Automatic Reference Counting(ARC) vs Java의 Garbage Collection(GC)](https://lena-chamna.netlify.app/post/automatic_reference_counting_vs_garbage_collection/)
4. [Improving App Responsiveness - 앱 반응성 높이기](https://lena-chamna.netlify.app/post/improving_app_responsiveness/)


### 5. UI - 코드 베이스 UI + Xib 
- Storyboard 없이 코드로 UI를 만들어 AutoLayout을 지정하거나 Xib로 뷰를 모듈화하여 구현하였습니다.
- **작업 효율성을 높이기 위한 작업 - AutoLayout 코드 구현**
LayoutGuideCompatible 프로토콜을 만들어 UILayoutGuide와 UIView를 상속하여 자주 쓰이는 Autolayout 관련 기능을 맵핑해서 메서드로 구현했습니다. - [LayoutGuideCompatible](https://github.com/SimLeeTag/photo-tag-iOS/blob/dev/PhotoTag/PhotoTag/Utility/LayoutGuideCompatible.swift)
- view controller에 들어가는 view를 클래스로 분리하였는데, 이 때 delegate를 만들어 뷰나 그 안의 차일드 뷰(child view)들이 터치 이벤트를 받는 경우 delegate를 통해 메서드가 실행되도록 구현했습니다.
- 서버(API)와의 네트워크 통신에서 2019년 WWDC에서 처음 소개된 **Combine**을 사용하고 있습니다.

<br/>

## Member
* BE: [Poogle(심수현)](https://github.com/suhyunsim)
* iOS: [Lena(이근나)](https://github.com/dev-Lena)

## Team Ground Rules  
[Team Ground Rules](https://github.com/SimLeeTag/Team/wiki/Ground-Rule)

## 📌 Convention
### Commit
>  [Reference](http://karma-runner.github.io/1.0/dev/git-commit-msg.html)

| Type | Contents |
|--|--|
|feat| new feature for the user, not a new feature for build script
|fix| bug fix for the user, not a fix to a build script
|docs| changes to the documentation
|refactor| refactoring production code, eg. renaming a variable
|style| formatting, missing semi colons, etc; no production code change
|test| adding missing tests, refactoring tests; no production code change)
|chore| updating grunt tasks etc; no production code change

- Example

    ```
    refactor: Refactor subsystem X for readability 

    {body...}

    #1 or resolves #1 // reference issues
    ```

### Branch - Git Flow
- default branch : `dev`
- `main`: production-ready state
- `dev`: latest delivered development changes for the next release
- `feat`: develop new features for the upcoming or a distant future release
- `deploy`: support preparation of a new production release
- `hotfix`: act immediately upon an undesired state of a live production version
- `{feat}/{feature}`
- Example

    ```
    feat/create-note
    ```
