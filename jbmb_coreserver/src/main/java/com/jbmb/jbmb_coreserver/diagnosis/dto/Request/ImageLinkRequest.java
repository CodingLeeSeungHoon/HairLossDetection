package com.jbmb.jbmb_coreserver.diagnosis.dto.Request;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
public class ImageLinkRequest {
    private Integer diagnosisID;
    private String imageLink;
}
