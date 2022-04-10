package com.jbmb.jbmb_coreserver.diagnosis.domain;

import lombok.*;

import javax.persistence.*;
import java.util.Date;

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

    @Column(name="created_at", columnDefinition = "DATETIME", nullable = false)
    private Date date;

    public void changeActive(){
        active=1;
    }
}
