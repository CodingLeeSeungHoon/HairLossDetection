package com.jbmb.jbmb_coreserver.account.controller;

import com.jbmb.jbmb_coreserver.account.domain.Member;
import com.jbmb.jbmb_coreserver.account.domain.Response;
import com.jbmb.jbmb_coreserver.account.service.MemberService;
import groovy.util.logging.Slf4j;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
    public Response joinInJBMB(@RequestBody Member user) {
        return memberService.joinService(user);
    }

    // 로그인
    @PostMapping("/login")
    public Response loginInJBMB(@RequestBody Member user) {
        return memberService.loginService(user);
    }

    // 로그아웃
    @PostMapping("/logout")
    public Response logoutFromJBMB(HttpServletRequest req) {
        return memberService.logoutService(req);
    }
}
