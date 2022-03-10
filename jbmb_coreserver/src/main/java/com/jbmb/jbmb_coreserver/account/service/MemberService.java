package com.jbmb.jbmb_coreserver.account.service;

import com.jbmb.jbmb_coreserver.account.domain.Member;
import com.jbmb.jbmb_coreserver.account.jwt.JwtTokenProvider;
import com.jbmb.jbmb_coreserver.account.repository.MemberRepository;
import io.netty.util.Constant;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.openjsse.sun.security.ssl.SSLLogger;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberService {

    private final PasswordEncoder passwordEncoder;
    private final JwtTokenProvider jwtTokenProvider;
    private final MemberRepository memberRepository;
    private final RedisTemplate<String, Object> redisTemplate;
    /**
     *
     * @param id
     * @return
     */
    public Boolean checkIdAlready(String id){
        /*List<String> list = new ArrayList<>();

        list.stream()
                .filter()
                .filter()
                .filter()
                .anyMatch()
                .
         */
        return true;
    }

    /**
     * 회원가입 버튼 클릭 시
     * @param user
     * @return {결과 코드, 에러 발생 코드}
     */
    public String joinService(Member user){
        if (!checkIdAlready(user.getId())) return "{ \"resultCode\" : 0, \"errorCode\" : 0 }"; // 중복 체크
        return memberRepository.save(Member.builder()
                .userNum(user.getUserNum())
                .id(user.getId())
                .password(passwordEncoder.encode(user.getPassword()))
                .name(user.getName())
                .email(user.getEmail())
                .phone(user.getPhone())
                .sex(user.getSex())
                .age(user.getAge())
                .hairType(user.getHairType())
                .roles(Collections.singletonList("ROLE_USER")) // 최초 가입시 USER 로 설정
                .build()).getId();
    }

    /**
     * 로그인 버튼 클릭 시
     * @param user
     * @return jwt 토큰
     */
    public String loginService(Member user){
        Member member = memberRepository.findById(user.getId())
                .orElseThrow(() -> new IllegalArgumentException("가입되지 않은 ID 입니다."));
        if (!passwordEncoder.matches(user.getPassword(), member.getPassword())) {
            throw new IllegalArgumentException("잘못된 비밀번호입니다.");
        }
        return jwtTokenProvider.createToken(member.getUsername(), member.getRoles());
    }

    public String logoutService(HttpServletRequest req){
        String token = jwtTokenProvider.resolveToken(req).substring(7);
        System.out.println("토큰 내용은 : " + token); // 임시
        if (jwtTokenProvider.checkAlreadyLogout(token)) {
            Date expirationDate = jwtTokenProvider.getExpirationDate(token);
            redisTemplate.opsForValue().set(
                    token, "l",
                    expirationDate.getTime() - System.currentTimeMillis(),
                    TimeUnit.MILLISECONDS );
            log.info("redis value : "+redisTemplate.opsForValue().get(token));
            System.out.println("처음 로그아웃 시도인거지");
        }
        return "test";
    }
}
