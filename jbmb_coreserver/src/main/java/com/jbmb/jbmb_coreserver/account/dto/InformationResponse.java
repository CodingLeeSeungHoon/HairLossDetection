package com.jbmb.jbmb_coreserver.account.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Deprecated //회원정보 수정 때 쓰일 것 (어노테이션 지우고)
public class InformationResponse {
    private Integer resultCode;
    private String id;
    private String name;
    private String phoneNumber;
    private Integer sex;
    private Integer age;
    private Integer hairType;
}
