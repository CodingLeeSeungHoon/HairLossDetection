package com.jbmb.jbmb_coreserver.diagnosis.domain;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@ToString
@Getter
@Builder
@Setter
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

    public void changeSurvey(Integer num, Integer checked){
        if(num==1)survey1=checked;
        else if(num==2)survey2=checked;
        else if(num==3)survey3=checked;
        else if(num==4)survey4=checked;
        else if(num==5)survey5=checked;
        else if(num==6)survey6=checked;
        else if(num==7)survey7=checked;
        else if(num==8)survey8=checked;
        else if(num==9)survey9=checked;
        else if(num==10)survey10=checked;
    }

    public boolean checkNull(){
        if(survey1==null
                || survey2==null
                || survey3==null
                || survey4==null
                || survey5==null
                || survey6==null
                || survey7==null
                || survey8==null
                || survey9==null
                || survey10==null) return false;
        return true;
    }
}
