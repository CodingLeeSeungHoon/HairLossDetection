package com.jbmb.jbmb_coreserver.diagnosis.controller;

import com.jbmb.jbmb_coreserver.diagnosis.dto.Request.DisabledRequest;
import com.jbmb.jbmb_coreserver.diagnosis.dto.Request.HairLossBySurveyRequest;
import com.jbmb.jbmb_coreserver.diagnosis.dto.Request.ImageLinkRequest;
import com.jbmb.jbmb_coreserver.diagnosis.dto.Request.UpdateSurveyRequest;
import com.jbmb.jbmb_coreserver.diagnosis.dto.Response.HairLossBySurveyResponse;
import com.jbmb.jbmb_coreserver.diagnosis.dto.Response.Response;
import com.jbmb.jbmb_coreserver.diagnosis.dto.Response.UpdateSurveyResponse;
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
    public Response deleteDisabledSurveyByUserId(@RequestBody DisabledRequest disabled) {
        return diagnosisService.disabledService(disabled);
    }

    // 설문조사 업데이트
    @PostMapping("/update_survey")
    public UpdateSurveyResponse updateSurvey(ServletRequest request, @RequestBody UpdateSurveyRequest survey) {
        return diagnosisService.updateService(request, survey);
    }

    // 이미지 링크 DB 저장
    @PostMapping("/image_link")
    public Response updateUserImageLink(ServletRequest request, @RequestBody ImageLinkRequest imageLink) {
        return diagnosisService.imageLinkService(request, imageLink);
    }

    // 설문 분석
    @PostMapping("/hair_loss_survey")
    public HairLossBySurveyResponse diagnoseHairLossBySurvey(@RequestBody HairLossBySurveyRequest hairLossBySurvey) {
        return diagnosisService.hairLossBySurveyService(hairLossBySurvey);
    }

}
