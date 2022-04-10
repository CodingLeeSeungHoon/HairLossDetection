package com.jbmb.jbmb_coreserver.diagnosis.repository;

import com.jbmb.jbmb_coreserver.diagnosis.domain.DiagnosisSurvey;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UpdateSurveyRepository extends JpaRepository<DiagnosisSurvey, Integer> {
    Optional<DiagnosisSurvey> findById(Integer id);
}
