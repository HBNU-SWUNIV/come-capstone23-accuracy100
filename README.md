# 한밭대학교 컴퓨터공학과 Accuracy100팀
<img src="https://capsule-render.vercel.app/api?type=waving&color=auto&height=250&section=header&&text=돈사%20현황판%20수기%20숫자%20OCR%20앱%20&animation=twinkling&fontSize=35" />

**팀 구성**
- 20171580 김응준 
- 20201778 이다혜
- 20201944 안희진

## 목차
1. [Project Background](#Project-Background)
    - [필요성](#필요성)
    - [기존 해결책의 문제점](#기존-해결책의-문제점)
3. [System Design](#System-Design)
    - [Skills](#Skills)
    - [프로젝트 개요](#프로젝트-개요)
    - [시스템 아키텍쳐](#시스템-아키텍쳐)
    - [전체 시스템 구성도](#전체-시스템-구성도)
5. [OCR](#OCR)
    - [OCR이란?](#OCR이란?)
    - [OCR과정](#OCR과정)
        - [7-Segment 형식의 현황판과 데이터셋 구축](#7-Segment-형식의-현황판과-데이터셋-구축)
        - [Edge Detection 기능을 이용한 현황판 검출](#Edge-Detection-기능을-이용한-현황판-검출)
        - [OpenCV라이브러리를 이용한 이미지 전처리 및 문자 검출](#OpenCV라이브러리를-이용한-이미지-전처리-및-문자-검출)
        - [CNN 기반의 모델을 이용한 문자 인식](#CNN-기반의-모델을-이용한-문자-인식)
7. [App UI](#APP-UI)
    - [로그인/회원가입 및 메인화면](#로그인/회원가입-및-메인화면)
    - [OCR 카메라](#OCR-카메라)
    - [리스트](#리스트)
    - [그래프 & 목표수정](#그래프-&-목표수정)
9. [Database](#Database)
10. [Conclusion](#Conclusion)
-----------
## Project Background
- ### 필요성
  - 현재 돈사에서는 현황판에 돼지 정보를 적은 뒤 컴퓨터 문서에 옮겨적는 작업에 인력이 많이 소모된다.
  - 다양한 국적의 노동자가 많아 숫자 표기 방식이 다양하다.
  - 외국인 근로자의 전산 능력 부족과 한국어 소통의 어려움으로 인해 전산 입력에 실수가 발생한다.
  - 돈사의 열악한 업무환경으로인해 인력 수급이 원활하지 않고, 인건비 또한 상승하고 있다.
- ### 기존 해결책의 문제점
  - 최근 스마트 ICT 양돈 시스템을 도입하여 전산 시스템과 연동해 실시간으로 사육돈 정보를 관리할 수 있지만, 외국인 노동자들은 전산작업에 익숙하지 않고 한국어 소통에 불편함이 있어 새롭게 바뀐 시스템을 교육하기 쉽지않다.

## System Design
  - ### Skills
    - ![js](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white) ![js](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
    - ![js](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white) ![js](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white) ![js](https://img.shields.io/badge/MySQL-00000F?style=for-the-badge&logo=mysql&logoColor=white)
    
  - ### 프로젝트 개요
    - 7-Segment 형식의 돈사 현황판을 사용하며, edge detection으로 현황판을 검출하고 CNN 기반의 모델을 학습시켜 OCR 기능을 수행한다.
    - OCR 카메라, 리스트, 그래프 기능으로 모돈을 관리하는 모바일 어플리케이션이다.
    - 프론트엔드는 Flutter, 백엔드는 Flask, 데이터베이스는 MySQL을 사용한다.

  - ### 시스템 아키텍쳐
      - front-end : ios와 android 모두에서 실행 가능하도록 크로스플랫폼인 Flutter를 이용해 개발한다.
      - back-end : 모델 실행에 적합한 파이썬 환경의 Flask로 api서버를 구축하고,
                  여러 클라이언트 요청을 비동기적으로 처리가능한 MySQL을 데이터베이스로 사용한다. 
      <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/6f8e52fd-4f83-4464-8d94-8b91c9a45130" width="550" height="200">


  - ### 전체 시스템 구성도
     <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/06774773-7859-4fc5-87b6-f02f2ebea700" width="550" height="350">


## OCR
  - #### OCR이란?
  >    광학 문자 인식 (OCR, Optical Character Recognition)은 이미지 속 문자를 컴퓨터가 읽을 수 있는 포맷의 텍스트로 변환하는 기능.
  >   
  >    OCR = Text detection + Text recognition
 
  - #### OCR 과정
  <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/66fc4f12-a3a8-4d5c-8ce4-f2ae154be155" width="550" height="200">   

  
  1. 7-Segment 형식의 현황판과 데이터셋 구축
     - 수기방식
       
        > 7-Segment는 7개의 획으로 숫자를 표현하는 방식으로, 다양한 국적의 외국인 노동자들의 필체를 통일함으로써 인식률을 높이기 위해 현황판을 7-Segment 형식으로 구성하였다.
        > 
        >   <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/ef5e6c56-8e73-4c16-a48f-eac8b9af4682" width="300" height="50">   
     
     - 현황판 종류
       
       > 1. 임신사 : 임신한 모돈을 분만 전까지 관리. 초발정일·교배일·웅돈번호·재발확인일·분만예정일등 13항목.
       > 2. 분만사 : 분만후의 모돈과 자돈을 관리. 분만일·총산자수·포유개시두수·생시체중·이유일·이유두수·이유체중 등 15항목.
       >   <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/8b5f7663-3730-4a7a-bc13-95be537b077d" width="450" height="300">   
    
      - 데이터셋 구축
        > - 0~9까지의 숫자로 구성.
        > - 현업에서 실제로 작성한 현황판에서 수기 문자를 라벨링하여 수집,
        > - 1의 검출인식도를 개선하기 위해 OpenCV로 검출한 1의 데이터도 수집.
        > - CutOut, ColorJitter, GaussianBlur, HorizontalFilp, VerticalFlip 과 같은 데이터 증강 기법 활용.
        >   <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/3c92fa50-81a4-4b43-9fa3-a1f960e51fa1" width="550" height="100">   



  2. Edge Detection 기능을 이용한 현황판 검출
     
     앱 카메라에서 실시간으로 현황판의 윤곽선을 검출해 이미지의 왜곡을 보정하고, 불필요한 배경을 제거한다.
      
     <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/2cd55ea1-9d66-43c6-b05b-2ca38c4002e2" width="200" height="400">




  3. OpenCV라이브러리를 이용한 이미지 전처리 및 문자 검출
     
       <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/be863bc2-45a0-4f85-b7b5-fb052c8b1cb1" width="200" height="300">  <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/4b886cde-e296-4b4f-a982-820ccf94a8a7" width="200" height="300">  <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/a2071ff9-4570-4847-8941-66d3571de640" width="200" height="300">



  4. CNN 기반의 모델을 이용한 문자 인식

     무거운 딥러닝 모델 대신 가벼운 CNN 구조의 모델을 인식모델로 사용함 -> 추론시간 감소
     
         model = models.Sequential([
           layers.Conv2D(32, kernel_size=(5, 5), strides=(1, 1),
           padding='same', activation='relu', input_shape=(32, 32, 3)),
           layers.MaxPooling2D(pool_size=(2, 2), strides=(2, 2)),
           layers.Conv2D(64, kernel_size=(2, 2), activation='relu', padding='same'),
           layers.MaxPooling2D(pool_size=(2, 2)),
           layers.Dropout(0.25),
           layers.Flatten(),
           layers.Dense(1000, activation='relu'),
           layers.Dense(10, activation='softmax')
          ])

## APP UI
  1. 로그인/회원가입 및 메인화면
     
      > - 로그인/회원가입 후 메인페이지로 전환.
      > - 두개의 탭(임신사, 분만사)으로 구성.
      > - OCR, 리스트, 그래프 기능을 제공. 
      >
      > <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/933359f7-140d-4167-a56a-821d51af7ac0" width="600" height="400">
      
  3. OCR 카메라
     
      > - 카메라로 현황판의 윤곽선 검출 후 OCR.
      > - OCR 결과가 표 안에 입력되고, 오인식된 문자 수정 후 DB에 저장. 
      >
      > <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/5105cdf3-751e-47b9-a5d1-590667bbfad2" width="400" height="400">
      
  5. 리스트
     
      > - 업로드된 현황판 내역을 리스트로 확인하는 페이지.
      > - 모돈번호 검색기능으로 현황판 필터링.
      > - 현황판 내역 삭제 / 업데이트 기능 제공.
      >  
      > <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/c80e8aa4-5ba6-41fb-b1c0-692faaac37bb" width="400" height="400">
      
  4. 그래프 & 목표수정
     
      > - 데이터 항목별 월별/주별 통계를 시각화하는 페이지.
      > - ‘목표 설정 버튼’을 통해 월 별 돈사의 목표값을 설정 기능.
      >
      > <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/652729e5-5a04-4566-93b9-9e9184a18b54" width="300" height="400">
        


## Database
  ![Untitled](https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/cbf0343e-a4c5-4c79-b7c8-51e8f9782063)



## Conclusion
  - ### 기대 효과
    1. 7-Segment 숫자 표기방식을 사용함으로써 다양한 국적의 노동자들의 필체 통일 및 문자인식 정확도 향상. 
    2. 무거운 딥러닝 모델 대신 가벼운 CNN 모델을 설계함으로써 추론시간을 줄여 업무 효율 증진.
    3. 사용하기 편리한 스마트폰 앱으로 전산작업에 익숙하지 않은 외국인 노동자들도 원활한 업무 가능.
    4. 돈사 데이터들을 통계그래프로 보여줌으로써 돈사를 관리감독하고 향후계획 수립에 도움을 줌.
## Project Outcome
- ### 2024년 동계 학술대회 제출 계획
