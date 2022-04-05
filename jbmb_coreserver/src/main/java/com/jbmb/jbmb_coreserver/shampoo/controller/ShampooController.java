package com.jbmb.jbmb_coreserver.shampoo.controller;

import com.jbmb.jbmb_coreserver.shampoo.dto.GetHairTypeResponse;
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
    public GetHairTypeResponse getHairTypeByUserID(@RequestParam(value="userId") String id){
        return shampooService.getHairTypeService(id);
    }
}