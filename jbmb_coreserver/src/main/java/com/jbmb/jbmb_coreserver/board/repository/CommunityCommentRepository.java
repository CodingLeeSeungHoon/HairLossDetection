package com.jbmb.jbmb_coreserver.board.repository;

import com.jbmb.jbmb_coreserver.board.domain.CommunityComment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommunityCommentRepository extends JpaRepository<CommunityComment, Integer> {
    List<CommunityComment> findByPostId(Integer postId);

}
