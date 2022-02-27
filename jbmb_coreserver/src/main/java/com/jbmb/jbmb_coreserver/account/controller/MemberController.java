package com.jbmb.jbmb_coreserver.account.controller;

import com.jbmb.jbmb_coreserver.account.dto.JoinForm;
import com.jbmb.jbmb_coreserver.account.jwt.JwtTokenProvider;
import com.jbmb.jbmb_coreserver.account.repository.MemberRepository;
import com.jbmb.jbmb_coreserver.account.domain.Member;
import com.jbmb.jbmb_coreserver.account.service.MemberService;
import groovy.util.logging.Slf4j;
import jdk.internal.dynalink.MonomorphicCallSite;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/user/account")
public class MemberController {

    private final PasswordEncoder passwordEncoder;
    private final JwtTokenProvider jwtTokenProvider;
    private final MemberRepository memberRepository;

    @Autowired
    private MemberService memberService;

    @GetMapping("/check-duplicate/id/{id}/")
    public Boolean isAlreadyID(@RequestParam String id){
        return memberService.checkIdAlready(id);
    }

    // 회원가입
    @PostMapping("/signup")
    public String joinInJBMB(@RequestBody Member user) {
        return memberRepository.save(Member.builder()
                .id(user.getId())
                .email(user.getEmail())
                .password(passwordEncoder.encode(user.getPassword()))
                .phoneNumber(user.getPhoneNumber())
                .sex(user.getSex())
                .age(user.getAge())
                .roles(Collections.singletonList("ROLE_USER")) // 최초 가입시 USER 로 설정
                .build()).getId();
    }

    // 로그인
    @PostMapping("/auth")
    public String login(@RequestBody Member user) {
        Member member = memberRepository.findById(user.getId())
                .orElseThrow(() -> new IllegalArgumentException("가입되지 않은 ID 입니다."));
        if (!passwordEncoder.matches(user.getPassword(), member.getPassword())) {
            throw new IllegalArgumentException("잘못된 비밀번호입니다.");
        }
        return jwtTokenProvider.createToken(member.getUsername(), member.getRoles());
    }

}
