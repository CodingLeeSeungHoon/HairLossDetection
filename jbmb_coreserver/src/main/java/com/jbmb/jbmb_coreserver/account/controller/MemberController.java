package com.jbmb.jbmb_coreserver.account.controller;

import com.jbmb.jbmb_coreserver.account.dto.InformationResponse;
import com.jbmb.jbmb_coreserver.account.dto.LoginResponse;
import com.jbmb.jbmb_coreserver.account.dto.LogoutResponse;
import com.jbmb.jbmb_coreserver.account.domain.Member;
import com.jbmb.jbmb_coreserver.account.dto.SignupResponse;
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
    public SignupResponse joinInJBMB(@RequestBody Member user) {
        return memberService.joinService(user);
    }

    // 로그인
    @PostMapping("/login")
    public LoginResponse loginInJBMB(@RequestBody Member user) {
        return memberService.loginService(user);
    }

    // 로그아웃
    @PostMapping("/logout")
    public LogoutResponse logoutFromJBMB(HttpServletRequest req) {
        return memberService.logoutService(req);
    }

    // 회원정보 수정 때 쓰일 것 (Deprecated 어노테이션 지우고)
    @GetMapping("/info")
    @Deprecated
    public InformationResponse getInfo(ServletRequest req) {
        return memberService.getInfoService(req);
    }

    
}
