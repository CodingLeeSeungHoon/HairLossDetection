package com.jbmb.jbmb_coreserver.diagnosis.service;

import com.jbmb.jbmb_coreserver.account.jwt.JwtTokenProvider;
import com.jbmb.jbmb_coreserver.account.repository.MemberRepository;
import com.jbmb.jbmb_coreserver.diagnosis.domain.DiagnosisLog;
import com.jbmb.jbmb_coreserver.diagnosis.domain.DiagnosisSurvey;
import com.jbmb.jbmb_coreserver.diagnosis.dto.DisabledRequest;
import com.jbmb.jbmb_coreserver.diagnosis.dto.UpdateSurveyRequest;
import com.jbmb.jbmb_coreserver.diagnosis.dto.UpdateSurveyResponse;
import com.jbmb.jbmb_coreserver.diagnosis.repository.UpdateLogRepository;
import com.jbmb.jbmb_coreserver.diagnosis.repository.UpdateSurveyRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
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
    private final UpdateSurveyResponse response = new UpdateSurveyResponse();

    /**
     * 설문조사 하다가 중간에 튕겼을 때 삭제를 위한
     * resultCode 0:성공 , 1:진단기록 없음 , 2:아이디 틀림
     * @param DisabledRequest
     * @return UpdateSurveyResponse
     */
    public UpdateSurveyResponse disabledService(DisabledRequest disalbed){
        try{
            Integer userNum = memberRepository.findById(disalbed.getId()).get().getUserNum();
            Integer diagnosisID = updateLogRepository.findLogByUserNum(userNum);
            updateLogRepository.deleteById(diagnosisID);
            updateSurveyRepository.deleteById(diagnosisID);
        }catch (NoSuchElementException e){
            return response.builder().resultCode(2).build();
        }
        catch (Exception e){
            return response.builder().resultCode(1).build();
        }
        return response.builder().resultCode(0).build();
    }

    /**
     * 설문조사 페이지 하나 넘길 때마다
     * resultCode 0:성공 , 1:실패
     * @param UpdateSurveyRequest
     * @return UpdateSurveyResponse
     */
    public UpdateSurveyResponse updateService(ServletRequest request, UpdateSurveyRequest survey) {
        Integer userNum;
        try {
            String id = jwtTokenProvider.getUserPk(jwtTokenProvider.resolveToken((HttpServletRequest) request));
            userNum = memberRepository.findById(id).get().getUserNum();
        }catch (Exception e){
            return response.builder().resultCode(1).build();
        }
        Integer diagnosisID = updateLogRepository.findLogByUserNum(userNum);
        if (diagnosisID == null) {  // 설문을 처음 진행할 경우
            diagnosisID = updateLogRepository.save(DiagnosisLog.builder()
                    .userNum(userNum)
                    .active(0)
                    .build()).getId();
            updateSurveyRepository.save(DiagnosisSurvey.builder()
                    .id(diagnosisID).build());
        }

        Optional<DiagnosisSurvey> result = updateSurveyRepository.findById(diagnosisID);
        int[] checkNum=new int[11];

        try{
        checkNum[1]=result.get().getSurvey1();
        checkNum[2]=result.get().getSurvey2();
        checkNum[3]=result.get().getSurvey3();
        checkNum[4]=result.get().getSurvey4();
        checkNum[5]=result.get().getSurvey5();
        checkNum[6]=result.get().getSurvey6();
        checkNum[7]=result.get().getSurvey7();
        checkNum[8]=result.get().getSurvey8();
        checkNum[9]=result.get().getSurvey9();
        checkNum[10]=result.get().getSurvey10();
        }catch (Exception e){}
        checkNum[survey.getSurveyNum()]= survey.getChecked();

        updateSurveyRepository.save(DiagnosisSurvey.builder()
                .id(diagnosisID)
                .survey1(checkNum[1])
                .survey2(checkNum[2])
                .survey3(checkNum[3])
                .survey4(checkNum[4])
                .survey5(checkNum[5])
                .survey6(checkNum[6])
                .survey7(checkNum[7])
                .survey8(checkNum[8])
                .survey9(checkNum[9])
                .survey10(checkNum[10])
                .build());

        return response.builder().resultCode(0).build();
    }

}