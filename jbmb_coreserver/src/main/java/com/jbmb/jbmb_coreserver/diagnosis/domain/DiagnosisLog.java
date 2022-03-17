package com.jbmb.jbmb_coreserver.diagnosis.domain;

import lombok.*;

import javax.persistence.*;

@ToString
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "diagnosis_log")
public class DiagnosisLog {
    @Id
    @Column(name = "diagnosis_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "user_num", nullable = false)
    private Integer userNum;

    @Column(name = "active", columnDefinition = "TINYINT", nullable = false)
    private Integer active;
}
