package com.jbmb.jbmb_coreserver.shampoo.controller;

import com.jbmb.jbmb_coreserver.shampoo.dto.RequestDTO.Request;
import com.jbmb.jbmb_coreserver.shampoo.dto.ResponseDTO.Response;
import com.jbmb.jbmb_coreserver.shampoo.service.ShampooService;
import groovy.util.logging.Slf4j;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/user/shampoo")
public class ShampooController {
    @Autowired
    private ShampooService shampooService;

    // 진단 로그 리스트 받아오기 (진단 아이디와 생성 날짜로 이루어진 목록)
    @GetMapping("/hair_type")
    public Response.GetHairTypeResponse getHairTypeByUserID(@RequestParam(value="userId") String id){
        return shampooService.getHairTypeService(id);
    }

    // 두피 유형과 호출 번호 기반의 샴푸 검색 (네이버 쇼핑 API 활용)
    @PostMapping("shampoo")
    public Response.SearchShampooResponse searchShampoo(@RequestBody Request.SearchShampooRequest searchShampooRequest){
        return shampooService.searchShampooService(searchShampooRequest);
    }
}