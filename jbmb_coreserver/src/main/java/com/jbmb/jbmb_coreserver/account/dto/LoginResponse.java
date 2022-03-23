package com.jbmb.jbmb_coreserver.account.dto;

import lombok.*;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class LoginResponse {
    private Integer resultCode;
    private String jwt;
    private String id;
}
