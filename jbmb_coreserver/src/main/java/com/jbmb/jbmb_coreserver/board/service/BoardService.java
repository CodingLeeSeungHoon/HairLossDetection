package com.jbmb.jbmb_coreserver.board.service;

import com.jbmb.jbmb_coreserver.account.repository.MemberRepository;
import com.jbmb.jbmb_coreserver.board.domain.CommunityComment;
import com.jbmb.jbmb_coreserver.board.domain.CommunityPost;
import com.jbmb.jbmb_coreserver.board.dto.RequestDTO.Request.*;
import com.jbmb.jbmb_coreserver.board.dto.ResponseDTO.Response.*;
import com.jbmb.jbmb_coreserver.board.repository.CommunityCommentRepository;
import com.jbmb.jbmb_coreserver.board.repository.CommunityPostRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class BoardService {

    private final MemberRepository memberRepository;
    private final CommunityPostRepository communityPostRepository;
    private final CommunityCommentRepository communityCommentRepository;

    /**
     * <게시글 목록>
     * 커뮤니티 페이지 들어가면 보이는 게시글들의 리스트
     * 최근에 작성한 게시글부터 20개씩 보내줘야 함.
     * 제일 먼저 보낸 것이 가장 최근의 글
     * resultCode 0:성공 , 1:글 없음, 2:실패
     * @param callCnt
     * @return Response.BoardListResponse
     */
    public BoardListResponse boardListService(Integer callCnt){

        List<CommunityPost> list;

        try{
            list = communityPostRepository.findAll(Sort.by(Sort.Direction.DESC, "postId"));
            if((callCnt-1)*20+1>list.size()){
                log.info("해당 호출 번호의 글 없음");
                return BoardListResponse.builder().resultCode(1).build();
            }
        }catch (Exception e){
            log.info("게시글 불러오기 오류");
            return BoardListResponse.builder().resultCode(2).build();
        }

        List<BoardListResponse.post> postList=new ArrayList<>();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd a HH:mm:ss");
        for(int i=(callCnt-1)*20, sum=0;i<list.size() && sum<20;i++,sum++){
            postList.add(BoardListResponse.post.builder()
                    .title(list.get(i).getTitle())
                    .userId(memberRepository.findByUserNum(list.get(i).getUserNum()).get().getId())
                    .postId(list.get(i).getPostId())
                    .createdAt(simpleDateFormat.format(list.get(i).getCreatedAt())).build());
        }
        
        log.info("게시글 불러오기 성공");
        return BoardListResponse.builder().resultCode(0).postList(postList).build();
    }

    /**
     * <게시글 상세>
     * 게시글 리스트에서 어떤 게시글 하나 클릭하면 보여지는 상세 내용
     * 댓글까지 보여야 함 (댓글은 호출 번호 없이 그냥 다 긁어오는 형식)
     * resultCode 0:성공(댓글도 있음) , 1:성공(댓글은 없음), 2:실패
     * @param postId
     * @return Response.GetPostResponse
     */
    public GetPostResponse getPostService(Integer postId){

        CommunityPost communityPost;
        List<CommunityComment> communityCommentList;
        String userId;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd a HH:mm:ss");

        try{
            communityPost=communityPostRepository.findById(postId).get();
            communityCommentList=communityCommentRepository.findByPostId(postId);
            userId=memberRepository.findByUserNum(communityPost.getUserNum()).get().getId();
        }catch (Exception e){
            log.info("게시글 상세 불러오기 실패");
            return GetPostResponse.builder().resultCode(2).build();
        }
        if(communityCommentList.isEmpty()){
            log.info("게시글 불러오기 성공 - 댓글 없음");
            return GetPostResponse.builder().resultCode(1)
                    .title(communityPost.getTitle())
                    .content(communityPost.getText())
                    .userId(userId)
                    .createdAt(simpleDateFormat.format(communityPost.getCreatedAt())).build();
        }

        List<GetPostResponse.comment> commentList = new ArrayList<>();
        try {
            for (CommunityComment comment : communityCommentList) {
                commentList.add(GetPostResponse.comment.builder()
                        .commentId(comment.getCommentId())
                        .userId(memberRepository.findByUserNum(comment.getUserNum()).get().getId())
                        .comment(comment.getComment())
                        .createdAt(simpleDateFormat.format(comment.getCreatedAt())).build());
            }
        }catch (Exception e){
            log.info("댓글 불러오는데 오류");
            return GetPostResponse.builder().resultCode(2).build();
        }

        log.info("게시글 불러오기 성공 - 댓글 있음");
        return GetPostResponse.builder().resultCode(0)
                .title(communityPost.getTitle())
                .content(communityPost.getText())
                .userId(userId)
                .createdAt(simpleDateFormat.format(communityPost.getCreatedAt()))
                .commentList(commentList).build();
    }

    /**
     * <댓글 작성>
     * 게시글 상세 페이지에서 댓글 작성할 수 있도록
     * resultCode 0:성공 , 1:실패
     * @param commentInRequest
     * @return Response.CommentInResponse
     */
    public CommentInResponse commentInService(CommentInRequest commentInRequest){
        try {
            communityCommentRepository.save(CommunityComment.builder()
                    .postId(commentInRequest.getPostId())
                    .userNum(memberRepository.findById(commentInRequest.getUserId()).get().getUserNum())
                    .comment(commentInRequest.getComment())
                    .createdAt(new Date())
                    .build());
        }catch (Exception e){
            log.info("댓글 작성 시 오류 발생");
            return CommentInResponse.builder().resultCode(1).build();
        }

        log.info("댓글 작성 완료");
        return CommentInResponse.builder().resultCode(0).build();
    }

    /**
     * <댓글 삭제>
     * 게시글 상세 페이지에서 댓글 삭제할 수 있도록
     * resultCode 0:성공 , 1:실패
     * @param deleteCommentRequest
     * @return Response.DeleteCommentResponse
     */
    public DeleteCommentResponse deleteCommentService(DeleteCommentRequest deleteCommentRequest){
        try{
            communityCommentRepository.deleteById(deleteCommentRequest.getCommentId());
        }catch (Exception e){
            log.info("댓글 삭제 오류");
            return DeleteCommentResponse.builder().resultCode(1).build();
        }

        log.info("댓글 삭제 완료");
        return DeleteCommentResponse.builder().resultCode(0).build();
    }

    /**
     * <게시글 작성>
     * resultCode 0:성공 , 1:실패
     * @param postingRequest
     * @return Response.PostingResponse
     */
    public PostingResponse postingService(PostingRequest postingRequest){

        try {
            communityPostRepository.save(CommunityPost.builder()
                    .userNum(memberRepository.findById(postingRequest.getUserId()).get().getUserNum())
                    .title(postingRequest.getTitle())
                    .text(postingRequest.getText())
                    .createdAt(new Date())
                    .build());
        }catch (Exception e){
            log.info("게시글 작성 시 오류 발생");
            return PostingResponse.builder().resultCode(1).build();
        }

        log.info("게시글 작성 완료");
        return PostingResponse.builder().resultCode(0).build();
    }

    /**
     * <게시글 수정>
     * resultCode 0:성공 , 1:실패
     * @param updatePostRequest
     * @return Response.UpdatePostResponse
     */
    public UpdatePostResponse updatePostService(UpdatePostRequest updatePostRequest){

        try{
            CommunityPost communityPost = communityPostRepository.findById(updatePostRequest.getPostId()).get();
            communityPost.changeTitle(updatePostRequest.getTitle());
            communityPost.changeText(updatePostRequest.getText());
            communityPostRepository.save(communityPost);
        }catch (Exception e){
            log.info("게시글 수정 오류");
            UpdatePostResponse.builder().resultCode(1).build();
        }
        
        log.info("게시글 수정 완료");
        return UpdatePostResponse.builder().resultCode(0).build();
    }

    /**
     * <게시글 삭제>
     * resultCode 0:성공 , 1:게시글 삭제 오류 -> 댓글은 삭제 , 2:댓글 삭제 오류 -> 게시글도 삭제되지 않음
     * @param deletePostRequest
     * @return Response.DeletePostResponse
     */
    public DeletePostResponse deletePostService(DeletePostRequest deletePostRequest){

        try{
            try{
                List<CommunityComment> list = communityCommentRepository.findByPostId(deletePostRequest.getPostId());
                for(CommunityComment comment : list){
                    communityCommentRepository.deleteById(comment.getCommentId());
                }
            }catch (Exception e){
                log.info("댓글 삭제 오류 -> 게시글도 삭제되지 않음");
                return DeletePostResponse.builder().resultCode(2).build();
            }
            communityPostRepository.deleteById(deletePostRequest.getPostId());
        }catch (Exception e){
            log.info("게시글 삭제 오류 -> 댓글은 삭제");
            return DeletePostResponse.builder().resultCode(1).build();
        }

        log.info("게시글 삭제 완료");
        return DeletePostResponse.builder().resultCode(0).build();
    }
}
