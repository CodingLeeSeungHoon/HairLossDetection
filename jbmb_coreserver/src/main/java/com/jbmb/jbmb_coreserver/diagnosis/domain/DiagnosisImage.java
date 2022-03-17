package com.jbmb.jbmb_coreserver.diagnosis.domain;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@ToString
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "diagnosis_image")
@Entity
public class DiagnosisImage {
    @Id
    @Column(name = "diagnosis_id")
    private Integer id;

    @Column(name = "diagnosis_image", columnDefinition = "TEXT", nullable = true)
    private String diagnosisImage;
}
