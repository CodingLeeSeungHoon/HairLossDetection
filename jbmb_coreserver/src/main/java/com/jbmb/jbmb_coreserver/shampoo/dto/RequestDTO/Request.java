package com.jbmb.jbmb_coreserver.shampoo.dto.RequestDTO;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

public class Request {

    // 샴푸 검색 Request
    @Getter
    @ToString
    @NoArgsConstructor
    public static class SearchShampooRequest{
        private Integer callCnt;
        private Integer hairType;
    }
}
