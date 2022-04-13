package com.jbmb.jbmb_coreserver.account.controller;

import com.jbmb.jbmb_coreserver.account.domain.Member;
import com.jbmb.jbmb_coreserver.account.dto.ResponseDTO.Response;
import com.jbmb.jbmb_coreserver.account.service.MemberService;
import groovy.util.logging.Slf4j;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/user/account")
public class MemberController {

    @Autowired
    private MemberService memberService;

    // 회원가입
    @PostMapping("/signup")
    public Response.SignupResponse joinInJBMB(@RequestBody Member user) {
        return memberService.joinService(user);
    }

    // 로그인
    @PostMapping("/login")
    public Response.LoginResponse loginInJBMB(@RequestBody Member user) {
        return memberService.loginService(user);
    }


    // 회원 정보 가져오기
    @GetMapping("/info")
    public Response.InformationResponse getInfo(ServletRequest req) {
        return memberService.getInfoService(req);
    }

    // 로그인
    @PostMapping("/update_hair_type")
    public Response.UpdateHairTypeResponse updateHairType(@RequestBody Member user) {
        return memberService.updateHairTypeService(user);
    }

}
