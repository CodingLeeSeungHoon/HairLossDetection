package com.jbmb.jbmb_coreserver.board.domain;

import lombok.*;

import javax.persistence.*;
import java.util.Date;

@ToString
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "community_post")
public class CommunityPost {

    @Id
    @Column(name = "post_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer postId;

    @Column(name = "user_num", nullable = false)
    private Integer userNum;

    @Column(name = "post_title", columnDefinition = "TEXT", nullable = false)
    private String title;

    @Column(name = "post_text", columnDefinition = "TEXT", nullable = false)
    private String text;

    @Column(name = "post_created_at", columnDefinition = "DATETIME", nullable = false)
    private Date createdAt;

    public void changeTitle(String title){
        this.title=title;
    }

    public void changeText(String text){
        this.text=text;
    }
}
