package com.jbmb.jbmb_coreserver.diagnosis.dto.Response;

import lombok.Getter;
import java.util.List;

@Getter
public class AIAnalysisResponse {
    private Integer statusCode;
    private List<Float> body;
}
