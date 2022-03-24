package com.jbmb.jbmb_coreserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping; // 예제 실행을 위해 추가한
import org.springframework.web.bind.annotation.RestController; // 예제 실행을 위해 추가한

@RestController // 예제 실행을 위해 추가한
@SpringBootApplication
public class JbmbCoreserverApplication {

    @GetMapping("/") // 예제 실행을 위해 추가한
    public String home(){ // 예제 실행을 위해 추가한
        return "Hello World";
    }
    public static void main(String[] args) {
        SpringApplication.run(JbmbCoreserverApplication.class, args);
    }

}
