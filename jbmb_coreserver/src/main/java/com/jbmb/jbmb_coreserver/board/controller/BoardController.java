package com.jbmb.jbmb_coreserver.board.controller;

import com.jbmb.jbmb_coreserver.board.dto.RequestDTO.Request;
import com.jbmb.jbmb_coreserver.board.dto.ResponseDTO.Response;
import com.jbmb.jbmb_coreserver.board.service.BoardService;
import groovy.util.logging.Slf4j;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/user/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    // 게시글 목록 API
    @GetMapping("/list")
    public Response.BoardListResponse getListOfPost(@RequestParam(value="callCnt") Integer callCnt){
        return boardService.boardListService(callCnt);
    }

    // 게시글 상세 내용 API
    @GetMapping("/contents")
    public Response.GetPostResponse getPostByPostID(@RequestParam(value="postId") Integer postId){
        return boardService.getPostService(postId);
    }

    // 댓글 작성 API
    @PostMapping("/contents/comment")
    public Response.CommentInResponse commentInPost(@RequestBody Request.CommentInRequest commentInRequest){
        return boardService.commentInService(commentInRequest);
    }

    // 댓글 삭제 API
    @PostMapping("/contents/comment/delete")
    public Response.DeleteCommentResponse deleteComment(@RequestBody Request.DeleteCommentRequest deleteCommentRequest){
        return boardService.deleteCommentService(deleteCommentRequest);
    }

    // 게시글 작성 API
    @PostMapping("/contents/post")
    public Response.PostingResponse posting(@RequestBody Request.PostingRequest postingRequest){
        return boardService.postingService(postingRequest);
    }

    // 게시글 수정 API
    @PostMapping("/contents/post/edit")
    public Response.UpdatePostResponse updatePost(@RequestBody Request.UpdatePostRequest updatePostRequest){
        return boardService.updatePostService(updatePostRequest);
    }

    // 게시글 삭제 API
    @PostMapping("/contents/post/delete")
    public Response.DeletePostResponse deletePost(@RequestBody Request.DeletePostRequest deletePostRequest){
        return boardService.deletePostService(deletePostRequest);
    }
}
