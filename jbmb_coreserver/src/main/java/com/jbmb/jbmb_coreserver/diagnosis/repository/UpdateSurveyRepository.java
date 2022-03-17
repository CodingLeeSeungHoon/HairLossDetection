package com.jbmb.jbmb_coreserver.diagnosis.repository;

import com.jbmb.jbmb_coreserver.diagnosis.domain.DiagnosisSurvey;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.Optional;

@Repository
public interface UpdateSurveyRepository extends JpaRepository<DiagnosisSurvey, Long> {

    Optional<DiagnosisSurvey> findById(Integer id);

    @Transactional
    @Modifying // select 문이 아님을 나타낸다
    @Query("UPDATE DiagnosisSurvey s set s.survey1 = ?2 where s.id = ?1")
    void updateSurvey1(Integer diagnosis_id, Integer checked);

}
