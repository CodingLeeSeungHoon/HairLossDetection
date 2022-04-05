package com.jbmb.jbmb_coreserver.shampoo.service;

import com.jbmb.jbmb_coreserver.account.repository.MemberRepository;
import com.jbmb.jbmb_coreserver.shampoo.dto.GetHairTypeResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;


@Slf4j
@Service
@RequiredArgsConstructor
public class ShampooService {

    private final MemberRepository memberRepository;


    /**
     * 사용자 아이디를 기반으로 두피 유형 받아오기
     * resultCode 0:성공 , 1:두피 유형 미입력 , 2:실패
     * @param id
     * @return
     */
    public GetHairTypeResponse getHairTypeService(String id){

        Integer hairType;

        try{
            hairType=memberRepository.findById(id).get().getHairType();
        }catch (Exception e){
            log.info("잘못된 사용자 아이디가 넘어옴");
            return GetHairTypeResponse.builder()
                    .resultCode(2)
                    .build();
        }
        
        if(hairType==null){
            log.info("사용자 두피 유형 미입력");
            return GetHairTypeResponse.builder()
                    .resultCode(1)
                    .build();
        }
        
        log.info("사용자 두피 유형 보내기");
        return GetHairTypeResponse.builder()
                .resultCode(0)
                .hairType(hairType)
                .build();
    }
}
