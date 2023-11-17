# 한밭대학교 컴퓨터공학과 Accuracy100팀
<img src="https://capsule-render.vercel.app/api?type=waving&color=auto&height=250&section=header&&text=돈사%20현황판%20수기%20숫자%20OCR%20앱%20&animation=twinkling&fontSize=35" />

**팀 구성**
- 20171580 김응준 
- 20201778 이다혜
- 20201944 안희진

## <u>Teamate</u> Project Background
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
    <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/6f8e52fd-4f83-4464-8d94-8b91c9a45130" width="550" height="200">

  - ### OCR 과정
    <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/66fc4f12-a3a8-4d5c-8ce4-f2ae154be155" width="550" height="200">

  - ### APP UI
    - 로그인/회원가입 및 메인화면
      - 메인화면은 임신사/분만사 두개의 페이지로 구성.
        
      <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/933359f7-140d-4167-a56a-821d51af7ac0" width="600" height="400">
    - OCR 카메라
       - 카메라로 현황판의 윤곽선 검출 후 OCR.
       - OCR 결과가 표 안에 입력되고, 오인식된 문자 수정 후 DB에 저장. 

      <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/5105cdf3-751e-47b9-a5d1-590667bbfad2" width="400" height="400">
    - 리스트
      - 업로드된 모든 현황판 기록들을 리스트로 볼 수 있는 페이지.
      - 모돈번호를 검색하여 해당하는 모돈의 현황판을 검색하는 기능을 가짐.
      - 항목을 누르면 해당 항목의 수정페이지로 전환.
      - 삭제버튼을 누르면 해당 항목이 데이터베이스에서 삭제됨.
        
      <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/c80e8aa4-5ba6-41fb-b1c0-692faaac37bb" width="400" height="400">
    - 그래프 & 목표수
      - 총산자수, 교배복수, 이유두수의 주차별 누적값을 보여주는 막대 그래프.
      - 월을 변경하는 버튼으로 지난기록들 또한 볼 수 있음. 
      - 월별 목표치를 빨간선으로 보여주고, 목표달성률을 시각화.
      - 목표수정 버튼을 누르면 목표수정페이지로 전환. 네 항목에 대해 월별 목표값을 설정 및 수정.
        
      <img src="https://github.com/HBNU-SWUNIV/come-capstone23-accuracy100/assets/120447438/652729e5-5a04-4566-93b9-9e9184a18b54" width="300" height="400">

  - ### System Requirements
    - Front-End : Flutter
    - Back-End : Flask
    - OpenCV와 CNN 기반의 모델로 OCR.
  
## Conclusion
  - ### 기대 효과
    1. 7-Segment 숫자 표기방식을 사용함으로써 다양한 국적의 노동자들의 필체 통일 및 문자인식 정확도 향상. 
    2. 무거운 딥러닝 모델 대신 가벼운 CNN 모델을 설계함으로써 추론시간을 줄여 업무 효율 증진.
    3. 사용하기 편리한 스마트폰 앱으로 전산작업에 익숙하지 않은 외국인 노동자들도 원활한 업무 가능.
    4. 돈사 데이터들을 통계그래프로 보여줌으로써 돈사를 관리감독하고 향후계획 수립에 도움을 줌.
## Project Outcome
- ### 20XX 년 OO학술대회 
