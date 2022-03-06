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
   │  │               │   │   └── WebSecurityConfig.java
   │  │               │   ├── controller
   │  │               │   │   └── MemberController.java
   │  │               │   ├── domain
   │  │               │   │   └── Member.java
   │  │               │   ├── dto
   │  │               │   │   └── UserRequestDto.java
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
   │  │               │   │   └── Diagnosis.java
   │  │               │   ├── dto
   │  │               │   │   └── DiagnosisRequestDto.java
   │  │               │   ├── repository
   │  │               │   │   └── DiagnosisRepository.java
   │  │               │   └── service
   │  │               │       └── DiagnosisService.java
   │  │               ├── feedback
   │  │               │   ├── controller
   │  │               │   │   └── FeedbackController.java
   │  │               │   └── service
   │  │               │       └── FeedbackService.java
   │  │               ├── board
   │  │               │   ├── controller
   │  │               │   │   └── BoardController.java
   │  │               │   ├── domain
   │  │               │   │   └── Board.java
   │  │               │   ├── dto
   │  │               │   │   └── BoardRequestDto.java
   │  │               │   ├── repository
   │  │               │   │   └── BoardRepository.java
   │  │               │   └── service
   │  │               │       └── BoardService.java
