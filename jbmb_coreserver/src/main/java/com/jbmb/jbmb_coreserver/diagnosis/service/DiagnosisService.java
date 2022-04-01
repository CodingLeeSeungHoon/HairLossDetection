package com.jbmb.jbmb_coreserver.diagnosis.service;

import com.jbmb.jbmb_coreserver.account.jwt.JwtTokenProvider;
import com.jbmb.jbmb_coreserver.account.repository.MemberRepository;
import com.jbmb.jbmb_coreserver.diagnosis.domain.DiagnosisImage;
import com.jbmb.jbmb_coreserver.diagnosis.domain.DiagnosisLog;
import com.jbmb.jbmb_coreserver.diagnosis.domain.DiagnosisResult;
import com.jbmb.jbmb_coreserver.diagnosis.domain.DiagnosisSurvey;
import com.jbmb.jbmb_coreserver.diagnosis.dto.Request.*;
import com.jbmb.jbmb_coreserver.diagnosis.dto.Response.*;
import com.jbmb.jbmb_coreserver.diagnosis.repository.DiagnosisResultRepository;
import com.jbmb.jbmb_coreserver.diagnosis.repository.ImageLinkRepository;
import com.jbmb.jbmb_coreserver.diagnosis.repository.UpdateLogRepository;
import com.jbmb.jbmb_coreserver.diagnosis.repository.UpdateSurveyRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.NoSuchElementException;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class DiagnosisService {

    private final JwtTokenProvider jwtTokenProvider;
    private final MemberRepository memberRepository;
    private final UpdateLogRepository updateLogRepository;
    private final UpdateSurveyRepository updateSurveyRepository;
    private final ImageLinkRepository imageLinkRepository;
    private final DiagnosisResultRepository diagnosisResultRepository;

    /**
     * 진단 관련 로그 4가지 생성 및 진단 아이디 반환
     * @param userNum
     * @return diagnosisID
     */
    public Integer createLog(Integer userNum){
        Integer diagnosisID = updateLogRepository.save(DiagnosisLog.builder()
                .userNum(userNum)
                .active(0)
                .date(new Date())
                .build()).getId();
        updateSurveyRepository.save(DiagnosisSurvey.builder().id(diagnosisID).build());
        imageLinkRepository.save(DiagnosisImage.builder().id(diagnosisID).build());
        return diagnosisID;
    }

    /**
     * 설문조사 하다가 중간에 튕겼을 때 삭제를 위한 API
     * 설문조사 시작할 때 프론트에서 호출
     * resultCode 0:성공 , 1:진단기록 없음 , 2:아이디 틀림
     * 1:진단기록 없음도 성공임(ative=0인게 없다는 것)
     * @param DisabledRequest
     * @return disabledResponse
     */
    public disabledResponse disabledService(DisabledRequest disalbed){
        Integer userNum = null;
        try{
            userNum = memberRepository.findById(disalbed.getId()).get().getUserNum();
            Integer diagnosisID = updateLogRepository.findLogByUserNum(userNum);    // active가 0인 것을 조회
            updateLogRepository.deleteById(diagnosisID);    // 로그 삭제
            updateSurveyRepository.deleteById(diagnosisID); // 설문 삭제
            imageLinkRepository.deleteById(diagnosisID);    // 이미지 링크 삭제
        }catch (NoSuchElementException e){
            log.info("프론트에서 잘못된 ID로 요청함");
            return disabledResponse.builder().resultCode(2).build();
        }
        catch (Exception e){
            log.info("active가 0인 진단기록 없음(=성공) 및 진단 아이디 생성");
            return disabledResponse.builder().resultCode(1).diagnosisID(createLog(userNum)).build();
        }
        log.info("active가 1인 진단기록 삭제 성공 및 진단 아이디 생성");
        return disabledResponse.builder().resultCode(0).diagnosisID(createLog(userNum)).build();
    }

    /**
     * 토큰 정보로 사용자 유저 번호를 가져옴
     * @param ServletRequest
     * @return userNum
     */
    private Integer getUserNum(ServletRequest request){
        Integer userNum;
        try {
            String id = jwtTokenProvider.getUserPk(jwtTokenProvider.resolveToken((HttpServletRequest) request));
            userNum = memberRepository.findById(id).get().getUserNum();
        }catch (Exception e){
            return 0;
        }
        return userNum;
    }

    /**
     * 설문조사 페이지 하나 넘길 때마다
     * checked 0:미체크 , 1:없다 , 2:있다
     * resultCode 0:성공 , 1:실패
     * @param UpdateSurveyRequest
     * @return UpdateSurveyResponse
     */
    public UpdateSurveyResponse updateService(UpdateSurveyRequest survey) {

        DiagnosisSurvey diagnosisSurvey;
        
        try{
            Optional<DiagnosisSurvey> optionalDiagnosisSurvey = updateSurveyRepository.findById(survey.getDiagnosisID());
            diagnosisSurvey=optionalDiagnosisSurvey.get();
        }
        catch (Exception e){
            log.info("잘못된 진단 아이디");
            return UpdateSurveyResponse.builder().resultCode(1).build();
        }

        diagnosisSurvey.changeSurvey(survey.getSurveyNum(), survey.getChecked());
        updateSurveyRepository.save(diagnosisSurvey);

        log.info("설문조사 업데이트");
        return UpdateSurveyResponse.builder().resultCode(0).diagnosisID(survey.getDiagnosisID()).build();
    }

    /**
     * 이미지 링크 DB에 저장
     * resultCode 0:성공 , 1:실패
     * @param ImageLinkRequest
     * @return UpdateImageLinkResponse
     */
    public UpdateImageLinkResponse imageLinkService(ImageLinkRequest imageLink){

        DiagnosisImage diagnosisImage;

        try{
            Optional<DiagnosisImage> optionalDiagnosisImage = imageLinkRepository.findById(imageLink.getDiagnosisID());
            diagnosisImage=optionalDiagnosisImage.get();
        }
        catch (Exception e){
            log.info("잘못된 진단 아이디");
            return UpdateImageLinkResponse.builder().resultCode(1).build();
        }

        diagnosisImage.changeDiagnosisImage(imageLink.getImageLink());
        imageLinkRepository.save(diagnosisImage);
        
        log.info("이미지 링크 DB 저장");
        return UpdateImageLinkResponse.builder().resultCode(0).diagnosisID(imageLink.getDiagnosisID()).build();
    }

    /**
     * 진단 시작
     * resultCode 0:성공 , 1:실패
     * 설문조사와 이미지 링크에 null값인 진단 아이디는 삭제
     * 설문조사와 이미지 링크가 완전히 들어있는 진단 아이디의 active를 1로 업데이트
     * 이미지 링크 보내서 AI 분석 람다 함수 호출 및 리턴 결과 저장
     * 설문조사 분석 후 진단 결과 저장.
     * @param HairLossDetectionRequest
     * @return HairLossDetectionResponse
     */
    public HairLossDetectionResponse hairLossDetectionService(HairLossDetectionRequest hairLossDetectionRequest){

        DiagnosisLog diagnosisLog=null;
        DiagnosisSurvey diagnosisSurvey=null;
        DiagnosisImage diagnosisImage=null;
        AIAnalysisResponse aiAnalysisResponse=null;

        try {
            diagnosisLog = updateLogRepository.findById(hairLossDetectionRequest.getDiagnosisID()).get();
            diagnosisSurvey = updateSurveyRepository.findById(hairLossDetectionRequest.getDiagnosisID()).get();
            diagnosisImage = imageLinkRepository.findById(hairLossDetectionRequest.getDiagnosisID()).get();
        }catch (Exception e){
            log.info("잘못된 진단 아이디");
            HairLossDetectionResponse.builder().resultCode(1).diagnosisID(hairLossDetectionRequest.getDiagnosisID()).build();
        }

        if(diagnosisSurvey.checkNull() && diagnosisImage.checkNull()) diagnosisLog.changeActive();
        else {
            log.info("null 값 존재");
            return HairLossDetectionResponse.builder().resultCode(1).diagnosisID(hairLossDetectionRequest.getDiagnosisID()).build();
        }

        try{
            aiAnalysisResponse= aiAnalysisService(diagnosisImage.getDiagnosisImage());
        }catch (Exception e){
            log.info("active는 1로 바뀌었으난 AI 이미지 진단 실패");
            return HairLossDetectionResponse.builder().resultCode(1).diagnosisID(hairLossDetectionRequest.getDiagnosisID()).build();
        }

        log.info("진단 성공");
        diagnosisResultRepository.save(DiagnosisResult.builder()
                .id(hairLossDetectionRequest.getDiagnosisID())
                .resultCode(getSurveyResult(diagnosisSurvey))
                .result0(aiAnalysisResponse.getPercent0())
                .result1(aiAnalysisResponse.getPercent1())
                .result2(aiAnalysisResponse.getPercent2())
                .build());
        return HairLossDetectionResponse.builder().resultCode(0).diagnosisID(hairLossDetectionRequest.getDiagnosisID()).build();
    }

    /**
     * 설문 분석
     * @param DiagnosisSurvey
     * @return
     */
    public Integer getSurveyResult(DiagnosisSurvey diagnosisSurvey){
        Integer sum=diagnosisSurvey.getSurvey1()
                +diagnosisSurvey.getSurvey2()
                +diagnosisSurvey.getSurvey3()
                +diagnosisSurvey.getSurvey4()
                +diagnosisSurvey.getSurvey5()
                +diagnosisSurvey.getSurvey6()
                +diagnosisSurvey.getSurvey7()
                +diagnosisSurvey.getSurvey8()
                +diagnosisSurvey.getSurvey9()
                +diagnosisSurvey.getSurvey10()-10;
        if (sum<3) return 0;
        else if(sum<4) return 1;
        else if(sum<6) return 2;
        return 3;
    }

    /**
     * 이미지 분석 http 요청 WebClient (POST 요청)
     * @param imageLink
     * @return
     */
    public AIAnalysisResponse aiAnalysisService(String imageLink){
        MultiValueMap<String, String> formData = new LinkedMultiValueMap<>();
        formData.add("imageLink", imageLink);
        WebClient webClient = WebClient.create("http://localhost:5000");    // 람다 엔드포인트 URI 채워야
        return webClient.post()
                .uri("/analysis")                                       // 람다 엔드포인트 URI 채워야
                .contentType(MediaType.APPLICATION_FORM_URLENCODED)
                .body(BodyInserters.fromFormData(formData))
                .retrieve()
                .bodyToMono(AIAnalysisResponse.class)
                .block();
    }

    /**
     * DB에 저장된 설문 내용으로 설문 분석 리턴
     * 필요시 사용
     * resultCode 0:성공 , 1:실패
     * @param hairLossBySurvey
     * @return HairLossBySurveyResponse
     */
    @Deprecated
    public HairLossBySurveyResponse hairLossBySurveyService(HairLossBySurveyRequest hairLossBySurvey){
        Optional<DiagnosisSurvey> result = updateSurveyRepository.findById(hairLossBySurvey.getDiagnosisID());
        if(!result.isPresent()) return HairLossBySurveyResponse.builder().resultCode(1).build();
        Integer sum=result.get().getSurvey1()
                +result.get().getSurvey2()
                +result.get().getSurvey3()
                +result.get().getSurvey4()
                +result.get().getSurvey5()
                +result.get().getSurvey6()
                +result.get().getSurvey7()
                +result.get().getSurvey8()
                +result.get().getSurvey9()
                +result.get().getSurvey10()-10;
        if (sum<3) return HairLossBySurveyResponse.builder().resultCode(0).state(0).build();
        else if(sum<4) return HairLossBySurveyResponse.builder().resultCode(0).state(1).build();
        else if(sum<6) return HairLossBySurveyResponse.builder().resultCode(0).state(2).build();
        return HairLossBySurveyResponse.builder().resultCode(0).state(3).build();
    }

    /**
     * 진단 결과를 DB에 저장
     * 필요시 사용
     * resultCode 0:성공 , 1:실패
     * @param UpdateDiagnosisRequest
     * @return Response
     */
    @Deprecated
    public disabledResponse updateDiagnosisService(UpdateDiagnosisRequest updateDiagnosisRequest){
        try{
            diagnosisResultRepository.save(DiagnosisResult.builder()
                    .id(updateDiagnosisRequest.getDiagnosisID())
                    .resultCode(updateDiagnosisRequest.getResultCode())
                    .result0(updateDiagnosisRequest.getPercent().get(0))
                    .result1(updateDiagnosisRequest.getPercent().get(1))
                    .result2(updateDiagnosisRequest.getPercent().get(2))
                    .build());
            return disabledResponse.builder().resultCode(0).build();
        }catch (Exception e){
            return disabledResponse.builder().resultCode(1).build();
        }

    }
}