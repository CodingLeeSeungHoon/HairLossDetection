package com.jbmb.jbmb_coreserver.account.domain;

import lombok.*;

@ToString
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Response {
    private Integer resultCode;
    private String jwt;
}
