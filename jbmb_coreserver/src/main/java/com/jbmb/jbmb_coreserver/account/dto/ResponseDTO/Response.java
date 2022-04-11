package com.jbmb.jbmb_coreserver.account.dto.ResponseDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

public class Response {

    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class SignupResponse {
        private Integer resultCode;
    }


    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class LoginResponse {
        private Integer resultCode;
        private String jwt;
        private String id;
    }

    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class LogoutResponse {
        private Integer resultCode;
    }


    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class InformationResponse {
        private Integer resultCode;
        private String id;
        private String name;
        private String phoneNumber;
        private Integer sex;
        private Integer age;
        private Integer hairType;
    }

}
