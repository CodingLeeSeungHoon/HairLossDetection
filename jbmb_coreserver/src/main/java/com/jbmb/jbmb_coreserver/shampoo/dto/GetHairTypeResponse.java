package com.jbmb.jbmb_coreserver.shampoo.dto;

import lombok.*;

@ToString
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GetHairTypeResponse {
    private Integer resultCode;
    private Integer hairType;
}
