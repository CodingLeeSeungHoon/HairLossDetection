# 백엔드

### 디렉토리 구조
```sh
└─ src
   ├─ main
   │  ├── java
   │  │   └── com
   │  │       └── jbmb
   │  │           └── jbmb_coreserver
   │  │               ├── jbmbCoreserverApplication.java
   │  │               ├── account
   │  │               │   ├── config
   │  │               │   │   ├── RedisConfig.java
   │  │               │   │   └── WebSecurityConfig.java
   │  │               │   ├── controller
   │  │               │   │   └── MemberController.java
   │  │               │   ├── domain
   │  │               │   │   └── Member.java
   │  │               │   ├── dto
   │  │               │   │   ├── Login.java
   │  │               │   │   ├── Logout.java
   │  │               │   │   ├── Signup.java
   │  │               │   │   └── InformationResponse.java
   │  │               │   ├── jwt
   │  │               │   │   ├── JwtAuthenticationFilter.java
   │  │               │   │   └── JwtTokenProvider.java
   │  │               │   ├── repository
   │  │               │   │   └── MemberRepository.java
   │  │               │   └── service
   │  │               │       ├── CustomUserDetailService.java
   │  │               │       └── MemberService.java
   │  │               ├── diagnosis
   │  │               │   ├── controller
   │  │               │   │   └── DiagnosisController.java
   │  │               │   ├── domain
   │  │               │   │   ├── DiagnosisImage.java
   │  │               │   │   ├── DiagnosisLog.java
   │  │               │   │   ├── DiagnosisResultImage.java
   │  │               │   │   └── DiagnosisSurvey.java
   │  │               │   ├── dto
   │  │               │   │   ├── Request
   │  │               │   │   │   ├── DisabledRequest.java
   │  │               │   │   │   ├── GetDataForDiagnosisRequest.java
   │  │               │   │   │   ├── HairLossBySurveyRequest.java
   │  │               │   │   │   ├── HairLossDetectionRequest.java
   │  │               │   │   │   ├── HairLossResultRequest.java
   │  │               │   │   │   ├── ImageLinkRequest.java
   │  │               │   │   │   ├── UpdateDiagnosisRequest.java
   │  │               │   │   │   └── UpdateSurveyResponse.java
   │  │               │   │   └── Response
   │  │               │   │       ├── AIAnalysisResponse.java
   │  │               │   │       ├── DisabledResponse.java
   │  │               │   │       ├── GetDataForDiagnosisResponse.java
   │  │               │   │       ├── GetDataFromDiagnosisResponse.java
   │  │               │   │       ├── HairLossBySurveyResponse.java
   │  │               │   │       ├── HairLossDetectionResponse.java
   │  │               │   │       ├── HairLossResultResponse.java
   │  │               │   │       ├── UpdateImageLinkResponse.java
   │  │               │   │       └── UpdateSurveyResponse.java
   │  │               │   ├── repository
   │  │               │   │   ├── DiagnosisResultRepository.java
   │  │               │   │   ├── ImageLinkRepository.java
   │  │               │   │   ├── UpdateLogRepository.java
   │  │               │   │   └── UpdateSurveyRepository.java
   │  │               │   └── service
   │  │               │       └── DiagnosisService.java
   │  │               ├── shampoo
   │  │               │   ├── controller
   │  │               │   │   └── ShampooController.java
   │  │               │   ├── dto
   │  │               │   │   └── GetHairTypeResponse.java
   │  │               │   └── service
   │  │               │       └── ShampooService.java
   │  │               └── board
   │  │                   ├── controller
   │  │                   │   └── BoardController.java
   │  │                   ├── domain
   │  │                   │   └── Board.java
   │  │                   ├── dto
   │  │                   │   └── BoardRequestDto.java
   │  │                   ├── repository
   │  │                   │   └── BoardRepository.java
   │  │                   └── service
   │  │                       └── BoardService.java
