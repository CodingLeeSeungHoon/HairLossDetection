package com.jbmb.jbmb_coreserver.diagnosis.dto.ResponseDTO;

import lombok.*;

import java.util.List;

public class Response {

    @Getter
    public static class AIAnalysisResponse {
        private Integer statusCode;
        private List<Float> body;
    }

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class DisabledResponse {
        private Integer resultCode;
        private Integer diagnosisID;
    }

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class GetDataForDiagnosisResponse {
        private Integer resultCode;
        private String imageLink;
        private Integer surveyResult;
        private List<Float> percent;
        private SurveyClass surveyClass;
        private Integer aiResult;
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

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class GetDataFromDiagnosisResponse {
        private Integer resultCode;
        private List<Log> diagnosisList;

        @Getter
        @Builder
        public static class Log {
            private Integer diagnosisID;
            private String date;
        }
    }

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class HairLossBySurveyResponse {
        private Integer resultCode;
        private Integer state;
    }

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class HairLossDetectionResponse {
        private Integer resultCode;
        private Integer diagnosisID;
    }

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class HairLossResultResponse {
        private Integer resultCode;
        private Integer surveyResult;
        private List<Float> percent;
        private Integer aiResult;
        private String date;
    }

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class UpdateImageLinkResponse {
        private Integer resultCode;
        private Integer diagnosisID;
    }

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class UpdateSurveyResponse {
        private Integer resultCode;
        private Integer diagnosisID;
    }
}
