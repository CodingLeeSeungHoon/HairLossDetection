package com.jbmb.jbmb_coreserver.account.service;

import com.jbmb.jbmb_coreserver.account.domain.Member;
import com.jbmb.jbmb_coreserver.account.dto.ResponseDTO.Response;
import com.jbmb.jbmb_coreserver.account.jwt.JwtTokenProvider;
import com.jbmb.jbmb_coreserver.account.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import java.util.*;
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
     * 회원가입 버튼 클릭 시
     * resultCode 0:성공 , 1:ID 중복, 2:실패
     * @param Member
     * @return SignupResponse
     */
    public Response.SignupResponse joinService(Member user){
        if(memberRepository.findById(user.getId()).isPresent()){
            log.info("ID 중복");
            return Response.SignupResponse
                    .builder()
                    .resultCode(1)
                    .build(); // 중복 체크
        }
        try {
            memberRepository.save(Member.builder()
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
                    .build());
            log.info("회원가입 성공");
            return Response.SignupResponse
                    .builder()
                    .resultCode(0)
                    .build();
        } catch (Exception e){
            log.info("회원가입 오류");
            return Response.SignupResponse
                    .builder()
                    .resultCode(2)
                    .build();
        }
    }

    /**
     * 로그인 버튼 클릭 시
     * { resultCode 0:성공 , 1:존재하지 않는 ID, 2:비밀번호 오류
     *   jwt : jwt }
     * @param Member
     * @return LoginResponse
     */
    public Response.LoginResponse loginService(Member user){
        Optional<Member> member=memberRepository.findById(user.getId());
        if (!member.isPresent()) {
            log.info("가입되지 않은 ID");
            return Response.LoginResponse
                    .builder()
                    .resultCode(1)
                    .build(); // 가입되지 않은 ID
        }
        if (!passwordEncoder.matches(user.getPassword(), member.get().getPassword())) {
            log.info("비밀번호 오류");
            return Response.LoginResponse
                    .builder()
                    .resultCode(2)
                    .build(); // 잘못된 비밀번호
        }
        log.info("로그인 성공");
        return Response.LoginResponse.builder()
                .resultCode(0)
                .jwt(jwtTokenProvider.createToken(member.get().getId(), member.get().getRoles()))
                .id(user.getId())
                .build();
    }

    /**
     * 로그아웃 버튼 클릭 시
     * resultCode 0:성공 , 1:ID 이미 로그아웃, 2:Invalid token
     * @param HttpServletRequest
     * @return LogoutResponse
     */
    public Response.LogoutResponse logoutService(HttpServletRequest req){
        String token = jwtTokenProvider.resolveToken(req);
        Integer re=jwtTokenProvider.checkAlreadyLogout(token);
        if (re==0) {
            Date expirationDate = jwtTokenProvider.getExpirationDate(token);
            redisTemplate.opsForValue().set(
                    token, "l",
                    expirationDate.getTime() - System.currentTimeMillis(),
                    TimeUnit.MILLISECONDS );
            log.info("redis value : "+redisTemplate.opsForValue().get(token));
            log.info("로그아웃 성공");
        }
        return Response.LogoutResponse
                .builder()
                .resultCode(re)
                .build();
    }

    /**
     * resultCode 0:성공 , 1:실패
     * 성공 시 id, name, phoneNumber, sex, age, hairType 리턴
     * @param ServeletRequest
     * @return InformationResponse
     */
    public Response.InformationResponse getInfoService(ServletRequest req){
        Optional<Member> member;
        try {
            String id = jwtTokenProvider.getUserPk(jwtTokenProvider.resolveToken((HttpServletRequest) req));
            member=memberRepository.findById(id);
        }catch (Exception e){
            log.info("오류");
            return Response.InformationResponse.builder().resultCode(1).build();
        }
        log.info("회원 정보 조회 성공");
        return Response.InformationResponse.builder()
                .resultCode(0)
                .id(member.get().getId())
                .name(member.get().getName())
                .phoneNumber(member.get().getPhone())
                .sex(member.get().getSex())
                .age(member.get().getAge())
                .hairType(member.get().getHairType())
                .build();
    }
}