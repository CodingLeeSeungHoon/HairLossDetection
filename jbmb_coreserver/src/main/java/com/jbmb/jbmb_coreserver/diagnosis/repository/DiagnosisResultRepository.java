package com.jbmb.jbmb_coreserver.diagnosis.repository;

import com.jbmb.jbmb_coreserver.diagnosis.domain.DiagnosisResult;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface DiagnosisResultRepository extends JpaRepository<DiagnosisResult, Integer> {
    Optional<DiagnosisResult> findById(Integer id);
}
