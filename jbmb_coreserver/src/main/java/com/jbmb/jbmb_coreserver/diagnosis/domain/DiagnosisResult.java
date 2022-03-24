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
@Table(name = "diagnosis_result")
public class DiagnosisResult {
    @Id
    @Column(name = "diagnosis_id")
    private Integer id;

    @Column(name = "result_code", nullable = false)
    private Integer resultCode;

    @Column(name = "result_0", nullable = false)
    private Float result0;

    @Column(name = "result_1", nullable = false)
    private Float result1;

    @Column(name = "result_2", nullable = false)
    private Float result2;

    @Column(name = "result_3", nullable = false)
    private Float result3;
}
