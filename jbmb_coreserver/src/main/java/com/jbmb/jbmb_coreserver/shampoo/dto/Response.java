package com.jbmb.jbmb_coreserver.shampoo.dto;

import lombok.*;

import java.util.List;

public class Response {

    // 두피 유형 Reponse
    @Getter
    @Builder
    @AllArgsConstructor
    public static class GetHairTypeResponse{
        private Integer resultCode;
        private Integer hairType;
    }

    // 샴푸 리스트 Response
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class SearchShampooResponse{
        private List<item> items;

        @Setter
        @Getter
        @Builder
        @AllArgsConstructor
        @NoArgsConstructor
        public static class item {
            private String title;
            private String link;
            private String image;
            private Integer lprice;
            private String brand;
        }
    }
}
