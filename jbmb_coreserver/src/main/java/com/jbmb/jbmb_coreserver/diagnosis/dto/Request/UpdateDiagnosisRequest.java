package com.jbmb.jbmb_coreserver.diagnosis.dto.Request;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

@Getter
@ToString
@NoArgsConstructor
public class UpdateDiagnosisRequest {
    private Integer diagnosisID;
    private Integer resultCode;
    private List<Float> percent;
}
