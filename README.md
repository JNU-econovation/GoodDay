# GoodDay

<br/>

> 교내 IT 개발 동아리 ECONOVATION에서 활동하며 진행한 첫 iOS 프로젝트입니다. GoodDay는이별로 무너진 일상의 회복을 돕는 이별 극복 서포팅 서비스입니다. 사랑하는 사람과 이별을 한 분들께 극복하는 데 조금이나마 도움을 드리자는 아이디어에서 시작되었습니다.
>
> 진행 기간: 2021.10.02 ~ 2022.01.31

<br/>

## 팀 구성

|                        최명선(개발자)                        |                       김서하(디자이너)                       |                        임채승(개발자)                        |                        김시형(기획자)                        |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| <img src="https://avatars.githubusercontent.com/u/74762699?s=400&u=44a002eb9bfd2be6f192a6f994f9552d081060b8&v=4" width="250" height="250" style="border-radius: 50%;"/> | <img src="https://avatars.githubusercontent.com/u/88692742?v=4" width="250" height="250" style="border-radius: 50%;"/> | <img src="https://user-images.githubusercontent.com/74762699/235291759-473da611-567a-43ec-af51-bc8627219b63.png" width="250" height="250" style="border-radius: 50%;"/> | <img src="https://ca.slack-edge.com/TCV8K3NA2-U02G2CGTTKM-a73336e657b2-512" width="250" height="250" style="border-radius: 50%;"/> |
|      [Github Profile](https://github.com/myungsun7782)       |        [Github Profile](https://github.com/jnuseoha)         |        [Github Profile](https://github.com/loopy-lim)        |        [Github Profile](https://github.com/Si-hyeong)        |

<br/>

## 발표 자료 

[PPT 자료](https://drive.google.com/file/d/1HVAfJ9USgU0J-YSKeaFui9VHGYKqGyVU/view?usp=sharing)

<br/>

## 구현 영상

[실제 구현 영상](https://www.youtube.com/watch?v=DVJ2_99pwEE)

<br/>

## 사용 기술 및 라이브러리

- Swift, UIKit, CocoaPods
- Cloud Firestore, Lottie
- FSCalendar, MSPeekCollectionViewDelegateImplementation
- IQKeyboardManagerSwift

<br/>

## 담당한 기능(iOS)

- 사용자 초기 설정
- 마이 페이지 (수정)
- 메인 화면
- 플로팅 버튼
- 일기장 (일기 추가/수정/삭제)
- MVC 패턴 적용

<br/>

## 프로젝트를 하면서 배운 점 

- **CocoaPods**는 Objective-C 또는 Swift에서 외부 라이브러리를 사용할 수 있게 도와주는 관리 모듈이다. 이 외에도 Carthage, Swift Package Manager(SPM)가 있다.
- Autolayout은 제약 조건에 따라 뷰 계층 구조에 있는 모든 뷰의 크기와 위치를 동적으로 지정하는 것이다.
- **UIStackView**는 여러 개의 뷰를 정렬해서 나타낼 때 사용하고, View들을 일정한 간격으로 배치하기 위해 사용한다.
- **Lottie**를 사용해서 간단하게 벡터 애니메이션을 앱에 적용할 수 있다. 장점으로는 벡터 기반이라 용량이 적고 크기에 의한 해상도 저하가 없지만, 애프터 이펙트의 기본적인 기능들만 적용할 수 있다는 단점이 있다.
- 별도의 서버 구축 없이 DB를 사용하기 위해 **Firebase**를 이용해 볼 수 있다.
  - Cloud Firestore: Firestore에 세팅된 최신 데이터를 앱 DB에 저장
- **MVC 패턴**은 개발할 때 Model, View, Controller 부분의 영역을 나눠서 개발하는 디자인 패턴이다. 장점으로는 코드 관리가 쉬워져 에러와 실수를 줄여줄 수 있지만, 역할 분담이 정확히 되지 않으면 Controller의 크기가 매우 커질 수 있다는 단점이 있다.

