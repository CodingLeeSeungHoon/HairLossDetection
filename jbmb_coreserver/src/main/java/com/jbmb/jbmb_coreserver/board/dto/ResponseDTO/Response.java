package com.jbmb.jbmb_coreserver.board.dto.ResponseDTO;

import lombok.*;

import java.util.List;

public class Response {

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class BoardListResponse {
        private Integer resultCode;
        private List<post> postList;

        @Getter
        @Builder
        public static class post {
            private String title;
            private String userId;
            private Integer postId;
            private String createdAt;
        }
    }

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class GetPostResponse {
        private Integer resultCode;
        private String title;
        private String content;
        private String userId;
        private String createdAt;
        private List<comment> commentList;

        @Getter
        @Builder
        public static class comment {
            private Integer commentId;
            private String userId;
            private String comment;
            private String createdAt;
        }
    }

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class CommentInResponse {
        private Integer resultCode;
    }

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class DeleteCommentResponse {
        private Integer resultCode;
    }

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class PostingResponse {
        private Integer resultCode;
    }

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class UpdatePostResponse {
        private Integer resultCode;
    }

    @ToString
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class DeletePostResponse {
        private Integer resultCode;
    }
}
