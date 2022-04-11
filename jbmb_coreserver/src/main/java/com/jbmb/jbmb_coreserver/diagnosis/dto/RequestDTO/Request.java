package com.jbmb.jbmb_coreserver.diagnosis.dto.RequestDTO;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

public class Request {

    @Getter
    @ToString
    @NoArgsConstructor
    public static class DisabledRequest {
        private String id;
    }

    @Getter
    @ToString
    @NoArgsConstructor
    public static class GetDataForDiagnosisRequest {
        private Integer diagnosisID;
    }

    @Getter
    @ToString
    @NoArgsConstructor
    public static class HairLossBySurveyRequest {
        private Integer diagnosisID;
    }

    @Getter
    @ToString
    @NoArgsConstructor
    public static class HairLossDetectionRequest {
        private Integer diagnosisID;
    }

    @Getter
    @ToString
    @NoArgsConstructor
    public static class HairLossResultRequest {
        private Integer diagnosisID;
    }

    @Getter
    @ToString
    @NoArgsConstructor
    public static class ImageLinkRequest {
        private Integer diagnosisID;
        private String imageLink;
    }

    @Getter
    @ToString
    @NoArgsConstructor
    public static class UpdateDiagnosisRequest {
        private Integer diagnosisID;
        private Integer resultCode;
        private List<Float> percent;
    }

    @Getter
    @ToString
    @NoArgsConstructor
    public static class UpdateSurveyRequest {
        private Integer diagnosisID;
        private Integer surveyNum;
        private Integer checked;
    }

}
