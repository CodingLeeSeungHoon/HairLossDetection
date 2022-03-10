package com.jbmb.jbmb_coreserver;

import com.jbmb.jbmb_coreserver.account.domain.Member;
import com.jbmb.jbmb_coreserver.account.repository.MemberRepository;
import lombok.extern.slf4j.Slf4j;
import lombok.RequiredArgsConstructor;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;

import java.time.LocalDateTime;
import java.util.stream.IntStream;

@Slf4j
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

}
