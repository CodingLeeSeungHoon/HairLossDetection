package com.jbmb.jbmb_coreserver.board.repository;

import com.jbmb.jbmb_coreserver.board.domain.CommunityPost;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CommunityPostRepository extends JpaRepository<CommunityPost, Integer> {

    Optional<CommunityPost> findById(Integer postId);

    @Override
    List<CommunityPost> findAll(Sort sort);
}
