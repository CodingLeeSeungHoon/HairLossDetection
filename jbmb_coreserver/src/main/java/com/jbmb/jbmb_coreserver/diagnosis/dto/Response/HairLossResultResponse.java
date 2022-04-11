package com.jbmb.jbmb_coreserver.diagnosis.dto.Response;

import lombok.*;

import java.util.List;

@ToString
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class HairLossResultResponse {
    private Integer resultCode;
    private Integer surveyResult;
    private List<Float> percent;
    private Integer aiResult;
    private String date;
}
