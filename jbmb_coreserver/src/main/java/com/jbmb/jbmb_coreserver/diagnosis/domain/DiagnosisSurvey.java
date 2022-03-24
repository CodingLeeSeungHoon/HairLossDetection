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
@Entity
@Table(name = "diagnosis_survey")
public class DiagnosisSurvey {
    @Id
    @Column(name = "diagnosis_id")
    private Integer id;

    @Column(name = "survey_1", columnDefinition = "TINYINT", nullable = true)
    private Integer survey1;

    @Column(name = "survey_2", columnDefinition = "TINYINT", nullable = true)
    private Integer survey2;

    @Column(name = "survey_3", columnDefinition = "TINYINT", nullable = true)
    private Integer survey3;

    @Column(name = "survey_4", columnDefinition = "TINYINT", nullable = true)
    private Integer survey4;

    @Column(name = "survey_5", columnDefinition = "TINYINT", nullable = true)
    private Integer survey5;

    @Column(name = "survey_6", columnDefinition = "TINYINT", nullable = true)
    private Integer survey6;

    @Column(name = "survey_7", columnDefinition = "TINYINT", nullable = true)
    private Integer survey7;

    @Column(name = "survey_8", columnDefinition = "TINYINT", nullable = true)
    private Integer survey8;

    @Column(name = "survey_9", columnDefinition = "TINYINT", nullable = true)
    private Integer survey9;

    @Column(name = "survey_10", columnDefinition = "TINYINT", nullable = true)
    private Integer survey10;

}
