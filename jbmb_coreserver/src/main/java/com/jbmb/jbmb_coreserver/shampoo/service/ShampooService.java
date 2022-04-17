package com.jbmb.jbmb_coreserver.shampoo.service;

import com.jbmb.jbmb_coreserver.account.repository.MemberRepository;
import com.jbmb.jbmb_coreserver.shampoo.dto.RequestDTO.Request;
import com.jbmb.jbmb_coreserver.shampoo.dto.ResponseDTO.Response;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClientResponseException;

@Slf4j
@Service
@RequiredArgsConstructor
public class ShampooService {

    @Value("${Client.ID}")
    private String id;

    @Value("${Client.Secret}")
    private String secret;

    private final MemberRepository memberRepository;

    /**
     * 사용자 아이디를 기반으로 두피 유형 받아오기
     * resultCode 0:성공 , 1:두피 유형 미입력 , 2:실패
     * @param id
     * @return Response.GetHairTypeResponse
     */
    public Response.GetHairTypeResponse getHairTypeService(String id){

        Integer hairType;

        try{
            hairType=memberRepository.findById(id).get().getHairType();
        }catch (Exception e){
            log.info("잘못된 사용자 아이디가 넘어옴");
            return Response.GetHairTypeResponse.builder()
                    .resultCode(2)
                    .build();
        }
        
        if(hairType==null){
            log.info("사용자 두피 유형 미입력");
            return Response.GetHairTypeResponse.builder()
                    .resultCode(1)
                    .build();
        }
        
        log.info("사용자 두피 유형 보내기");
        return Response.GetHairTypeResponse.builder()
                .resultCode(0)
                .hairType(hairType)
                .build();
    }

    /**
     * 샴푸 검색
     * @param Request.SearchShampooRequest
     * @return Response.SearchShampooResponse
     */
    public Response.SearchShampooResponse searchShampooService(Request.SearchShampooRequest searchShampooRequest){

        Response.SearchShampooResponse searchShampooResponse;

        try{
            searchShampooResponse = WebClient.create("https://openapi.naver.com/v1/search").get().
                    uri(uriBuilder -> uriBuilder.path("/shop.json")
                            .queryParam("query", (searchShampooRequest.getHairType()==1)?"지성두피 샴푸":"건성두피 샴푸")
                            .queryParam("display", 20)
                            .queryParam("start", (searchShampooRequest.getCallCnt()-1)*20+1).build())
                    .headers(headers -> {
                        headers.add("X-Naver-Client-Id", id);
                        headers.add("X-Naver-Client-Secret", secret);
                    }).retrieve().bodyToMono(Response.SearchShampooResponse.class)
                    .block();
            for (Response.SearchShampooResponse.item item : searchShampooResponse.getItems()) {
                item.setTitle(item.getTitle().replaceAll("<[^>]*>", ""));
            }
        }catch (WebClientResponseException e){
            log.info("네이버 API 호출 오류");
            return Response.SearchShampooResponse.builder().build();
        }catch (Exception e){
            log.info("수신 데이터 오류");
            return Response.SearchShampooResponse.builder().build();
        }

        log.info("샴푸 검색");
        return searchShampooResponse;
    }
}
