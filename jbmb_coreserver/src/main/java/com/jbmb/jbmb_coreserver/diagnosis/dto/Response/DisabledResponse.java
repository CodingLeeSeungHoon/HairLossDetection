package com.jbmb.jbmb_coreserver.diagnosis.dto.Response;

import lombok.*;

@ToString
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class DisabledResponse {
    private Integer resultCode;
    private Integer diagnosisID;
}
