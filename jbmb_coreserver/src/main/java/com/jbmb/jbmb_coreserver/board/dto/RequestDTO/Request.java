package com.jbmb.jbmb_coreserver.board.dto.RequestDTO;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

public class Request {

    @Getter
    @ToString
    @NoArgsConstructor
    public static class CommentInRequest {
        private String userId;
        private Integer postId;
        private String comment;
    }

    @Getter
    @ToString
    @NoArgsConstructor
    public static class DeleteCommentRequest {
        private Integer commentId;
    }

    @Getter
    @ToString
    @NoArgsConstructor
    public static class PostingRequest {
        private String userId;
        private String title;
        private String text;
    }

    @Getter
    @ToString
    @NoArgsConstructor
    public static class UpdatePostRequest {
        private Integer postId;
        private String title;
        private String text;
    }

    @Getter
    @ToString
    @NoArgsConstructor
    public static class DeletePostRequest {
        private Integer postId;
    }
}
