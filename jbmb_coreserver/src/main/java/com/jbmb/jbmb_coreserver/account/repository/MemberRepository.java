package com.jbmb.jbmb_coreserver.account.repository;

import com.jbmb.jbmb_coreserver.account.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {
    Optional<Member> findById(String id);
}
