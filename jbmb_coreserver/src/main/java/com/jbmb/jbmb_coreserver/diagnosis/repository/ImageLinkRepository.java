package com.jbmb.jbmb_coreserver.diagnosis.repository;

import com.jbmb.jbmb_coreserver.diagnosis.domain.DiagnosisImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ImageLinkRepository extends JpaRepository<DiagnosisImage, String> {
}
