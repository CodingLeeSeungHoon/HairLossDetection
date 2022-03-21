package com.jbmb.jbmb_coreserver.diagnosis.controller;

import com.jbmb.jbmb_coreserver.diagnosis.dto.DisabledRequest;
import com.jbmb.jbmb_coreserver.diagnosis.dto.UpdateSurveyResponse;
import com.jbmb.jbmb_coreserver.diagnosis.dto.UpdateSurveyRequest;
import com.jbmb.jbmb_coreserver.diagnosis.service.DiagnosisService;
import groovy.util.logging.Slf4j;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletRequest;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/user/diagnosis")
public class DiagnosisController {

    @Autowired
    private DiagnosisService diagnosisService;

    // 기록 삭제
    @PostMapping("/disabled")
    public UpdateSurveyResponse deleteDisabledSurveyByUserId(@RequestBody DisabledRequest disabled) {
        return diagnosisService.disabledService(disabled);
    }

    // 설문조사 업데이트
    @PostMapping("/update_survey")
    public UpdateSurveyResponse updateSurvey(ServletRequest request, @RequestBody UpdateSurveyRequest survey) {
        return diagnosisService.updateService(request, survey);
    }

}
