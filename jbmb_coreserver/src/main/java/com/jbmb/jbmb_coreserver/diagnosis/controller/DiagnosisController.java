package com.jbmb.jbmb_coreserver.diagnosis.controller;

import com.jbmb.jbmb_coreserver.diagnosis.dto.Request.*;
import com.jbmb.jbmb_coreserver.diagnosis.dto.Response.*;
import com.jbmb.jbmb_coreserver.diagnosis.service.DiagnosisService;
import groovy.util.logging.Slf4j;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
    public disabledResponse deleteDisabledSurveyByUserId(@RequestBody DisabledRequest disabled) {
        return diagnosisService.disabledService(disabled);
    }

    // 설문조사 업데이트
    @PostMapping("/update_survey")
    public UpdateSurveyResponse updateSurvey(ServletRequest request, @RequestBody UpdateSurveyRequest survey) {
        return diagnosisService.updateService(survey);
    }

    // 이미지 링크 DB 저장
    @PostMapping("/image_link")
    public UpdateImageLinkResponse updateUserImageLink(ServletRequest request, @RequestBody ImageLinkRequest imageLink) {
        return diagnosisService.imageLinkService(imageLink);
    }

    // 진단 시작
    @PostMapping("hair_loss_detection")
    public HairLossDetectionResponse hairLossDetection(@RequestBody HairLossDetectionRequest hairLossDetectionRequest){
        return diagnosisService.hairLossDetectionService(hairLossDetectionRequest);
    }

    // 진단 결과 리턴
    @GetMapping("hair_loss_result")
    public HairLossResultResponse hairLossResult(@RequestBody HairLossResultRequest hairLossResultRequest){
        return diagnosisService.hairLossResultService(hairLossResultRequest);
    }

    // 진단 로그 받아오기
    @GetMapping("data")
    public GetDataForDiagnosisResponse getDataForDiagnosis(@RequestBody GetDataForDiagnosisRequest getDataForDiagnosisRequest){
        return diagnosisService.getDataForDiagnosisService(getDataForDiagnosisRequest);
    }

    // 설문 분석
    // 필요시 사용
    @Deprecated
    @PostMapping("/hair_loss_survey")
    public HairLossBySurveyResponse diagnoseHairLossBySurvey(@RequestBody HairLossBySurveyRequest hairLossBySurvey) {
        return diagnosisService.hairLossBySurveyService(hairLossBySurvey);
    }

    // 진단 업데이트
    // 필요시 사용
    @Deprecated
    @PostMapping("/update_diagnosis")
    public disabledResponse updateDiagnosis(@RequestBody UpdateDiagnosisRequest updateDiagnosisRequest) {
        return diagnosisService.updateDiagnosisService(updateDiagnosisRequest);
    }

}
