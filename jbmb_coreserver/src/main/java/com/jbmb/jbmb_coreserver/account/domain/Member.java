package com.jbmb.jbmb_coreserver.account.domain;

import lombok.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@ToString
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "member") // 테이블 이름이 같다면 굳이 써줄 필요는 없음
@Entity
public class Member implements UserDetails {

    @Id
    @Column(name = "user_num")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer userNum;

    @Column(name = "user_id", length = 20, nullable = false, unique = true, updatable = false)
    private String id;

    @Column(name = "user_pw", nullable = false, columnDefinition = "TEXT")
    private String password;

    @Column(name = "user_name", length = 10, nullable = false)
    private String name;

    @Column(name = "user_email", nullable = false, columnDefinition = "TEXT", unique = true)
    private String email;

    @Column(name = "user_phone", length = 16, nullable = false)
    private String phone;

    @Column(name = "user_sex", nullable = false, columnDefinition = "TINYINT")
    private Integer sex;

    @Column(name = "user_age", nullable = false)
    private Integer age;

    @Column(name = "user_hairtype")
    private Integer hairType;

    @ElementCollection(fetch = FetchType.EAGER)
    @Builder.Default
    private List<String> roles = new ArrayList<>();

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return this.roles.stream()
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList());
    }

    @Override
    public String getUsername() {
        return id;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

}
