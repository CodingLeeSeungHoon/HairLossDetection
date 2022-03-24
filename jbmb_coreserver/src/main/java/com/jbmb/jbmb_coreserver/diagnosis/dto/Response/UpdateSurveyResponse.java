package com.jbmb.jbmb_coreserver.diagnosis.dto.Response;

import lombok.*;

@ToString
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UpdateSurveyResponse {
    private Integer resultCode;
    private Integer diagnosisID;
}