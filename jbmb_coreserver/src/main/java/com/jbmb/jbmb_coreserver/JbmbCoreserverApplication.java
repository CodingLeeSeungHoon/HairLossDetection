package com.jbmb.jbmb_coreserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration; // 구축 후 실행을 위해 잠깐 import
import org.springframework.web.bind.annotation.GetMapping; // 예제 실행을 위해 추가한
import org.springframework.web.bind.annotation.RestController; // 예제 실행을 위해 추가한

@RestController // 예제 실행을 위해 추가한
@SpringBootApplication(exclude={DataSourceAutoConfiguration.class}) // 한 번 실행해 보려고 한 것. 나중에 exclude부터 지워야
public class JbmbCoreserverApplication {

    @GetMapping("/") // 예제 실행을 위해 추가한
    public String home(){ // 예제 실행을 위해 추가한
        return "Hello World";
    }
    public static void main(String[] args) {
        SpringApplication.run(JbmbCoreserverApplication.class, args);
    }

}
