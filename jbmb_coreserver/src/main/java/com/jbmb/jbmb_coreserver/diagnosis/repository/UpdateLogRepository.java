package com.jbmb.jbmb_coreserver.diagnosis.repository;

import com.jbmb.jbmb_coreserver.diagnosis.domain.DiagnosisLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UpdateLogRepository extends JpaRepository<DiagnosisLog, Integer> {

    @Query("select l.id from DiagnosisLog l where l.userNum=?1 and l.active=0")
    Integer findLogByUserNum(Integer userNum);
    // active
    // 0:설문조사 진행 중
    // 1:설문조사 완료
}
