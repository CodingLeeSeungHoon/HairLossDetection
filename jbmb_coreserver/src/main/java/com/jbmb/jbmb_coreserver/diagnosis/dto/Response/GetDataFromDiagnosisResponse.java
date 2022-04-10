package com.jbmb.jbmb_coreserver.diagnosis.dto.Response;

import lombok.*;

import java.util.List;

@ToString
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GetDataFromDiagnosisResponse {
    private Integer resultCode;
    private List<Log> diagnosisList;

    @Getter
    @Builder
    public static class Log {
        private Integer diagnosisID;
        private String date;
    }
}