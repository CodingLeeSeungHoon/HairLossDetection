package com.jbmb.jbmb_coreserver.diagnosis.dto.Response;

import lombok.*;
import java.util.List;

@ToString
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GetDataForDiagnosisResponse {
    private Integer resultCode;
    private String imageLink;
    private Integer surveyResult;
    private List<Float> percent;
    private SurveyClass surveyClass;
    private String date;

    @Getter
    @Builder
    public static class SurveyClass {
        private Integer survey1;
        private Integer survey2;
        private Integer survey3;
        private Integer survey4;
        private Integer survey5;
        private Integer survey6;
        private Integer survey7;
        private Integer survey8;
        private Integer survey9;
        private Integer survey10;
    }
}
