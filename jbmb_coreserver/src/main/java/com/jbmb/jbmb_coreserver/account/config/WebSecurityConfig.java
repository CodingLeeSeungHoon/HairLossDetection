package com.jbmb.jbmb_coreserver.account.config;

import com.jbmb.jbmb_coreserver.account.jwt.JwtAuthenticationFilter;
import com.jbmb.jbmb_coreserver.account.jwt.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

/**
 * spring security를 설정하기 위한 클래스
 */
@RequiredArgsConstructor
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    private final JwtTokenProvider jwtTokenProvider;

    // 암호화에 필요한 PasswordEncoder 를 Bean 등록합니다.
    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

    // authenticationManager를 Bean 등록합니다.
    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .httpBasic().disable() // rest api 만을 고려하여 기본 설정은 해제하겠습니다.
                .csrf().disable() // csrf 보안 토큰 disable처리.
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS) // 토큰 기반 인증이므로 세션 역시 사용하지 않습니다.
                .and()
                .authorizeRequests() // 요청에 대한 사용권한 체크
                .antMatchers("/admin/**").hasRole("ADMIN")
                //.antMatchers("/user/**").hasRole("USER")
                //.antMatchers("/user/account/logout").hasRole("USER")
                .antMatchers("/user/diagnosis/**").hasRole("USER")
                .antMatchers("/user/shampoo/**").hasRole("USER")
                .antMatchers("/user/board/**").hasRole("USER") // 회원정보 수정, 진단, 피드백, 게시판 접속하려면 로그인이 되어야 하게끔
                .anyRequest().permitAll() // 그 외 나머지 요청은 누구나 접근 가능
                //.and()
                //.anonymous().disable() 만약 누구나 사용 가능하게 해주려면 주석 제거하면 됨
                //.formLogin() spring security에서 제공하는 login form을 이용한다는 뜻. 로그인 성공시 '/'로 리다이렉트
                .and()
                .addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider),
                        UsernamePasswordAuthenticationFilter.class);
        // JwtAuthenticationFilter를 UsernamePasswordAuthenticationFilter 전에 넣는다
    }
}