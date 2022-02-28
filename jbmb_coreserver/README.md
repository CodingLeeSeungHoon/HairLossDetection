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
   │  │               │   ├── dao
   │  │               │   ├── domain
   │  │               │   │   └── Member.java
   │  │               │   ├── dto
   │  │               │   │   └── JoinForm.java
   │  │               │   ├── jwt
   │  │               │   │   ├── JwtAuthenticationFilter.java
   │  │               │   │   └── JwtTokenProvider.java
   │  │               │   ├── repository
   │  │               │   │   └── MemberRepository.java
   │  │               │   └── service
   │  │               │   │   ├── CustomUserDetailService.java
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
