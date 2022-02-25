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
   │  │               │   ├── controller
   │  │               │   │   └── MemberController.java
   │  │               │   ├── dao
   │  │               │   ├── domain
   │  │               │   │   └── Member.java
   │  │               │   ├── dto
   │  │               │   │   └── JoinForm.java
   │  │               │   ├── jwt
   │  │               │   │   ├── CustomUserDetailService.java
   │  │               │   │   ├── JwtAuthenticationFilter.java
   │  │               │   │   ├── JwtTokenProvider.java
   │  │               │   │   └── WebSecurityConfig.java
   │  │               │   ├── repository
   │  │               │       └── MemberRepository.java
   │  │               │   └── service
   │  │               │       └── MemberService.java
   │  │               ├── board
   │  │               │   ├── controller
   │  │               │   ├── dao
   │  │               │   ├── domain
   │  │               │   ├── dto
   │  │               │   ├── repository
   │  │               │   └── service
   │  │               ├── diagnosis
   │  │               │   ├── controller
   │  │               │   ├── dao
   │  │               │   ├── domain
   │  │               │   ├── dto
   │  │               │   ├── repository
   │  │               │   └── service
   │  │               └── feedback
   │  │                   ├── controller
   │  │                   ├── dao
   │  │                   ├── domain
   │  │                   ├── dto
   │  │                   ├── repository
   │  │                   └── service
   │  └── resources                 
   │      └── application.properties
