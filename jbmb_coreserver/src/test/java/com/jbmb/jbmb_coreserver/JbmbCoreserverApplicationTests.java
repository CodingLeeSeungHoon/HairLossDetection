package com.jbmb.jbmb_coreserver;

import com.jbmb.jbmb_coreserver.account.domain.Member;
import com.jbmb.jbmb_coreserver.account.repository.MemberRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDateTime;
import java.util.stream.IntStream;

@SpringBootTest
class JbmbCoreserverApplicationTests {
    /*
        @Autowired
        private MemberRepository memberRepository;

        @Test
        public void InsertDummies() {
            IntStream.rangeClosed(1, 10).forEach(i -> {
                Member member = Member.builder()
                        .account("Sample..." + i)
                        .email("testuser"+i+"@google.com")
                        .phoneNumber("010-12"+i+"-5678")
                        .createdAt(LocalDateTime.now())
                        .createdBy("admin")
                        .build();
                //Create!
                memberRepository.save(member);
            });
        }
    */
    @Test
    void contextLoads() {
    }

}
