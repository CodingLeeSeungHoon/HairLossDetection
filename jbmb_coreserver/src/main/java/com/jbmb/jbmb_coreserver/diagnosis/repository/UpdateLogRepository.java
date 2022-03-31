package com.jbmb.jbmb_coreserver.diagnosis.repository;

import com.jbmb.jbmb_coreserver.account.domain.Member;
import com.jbmb.jbmb_coreserver.diagnosis.domain.DiagnosisLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UpdateLogRepository extends JpaRepository<DiagnosisLog, Integer> {

    Optional<DiagnosisLog> findById(Integer id);

    @Query("select l.id from DiagnosisLog l where l.userNum=?1 and l.active=0")
    Integer findLogByUserNum(Integer userNum);
    // active
    // 0:진단 시작 전
    // 1:진단 시작 후
}
