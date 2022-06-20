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
@Table(name = "community_comment")
public class CommunityComment {

    @Id
    @Column(name = "comment_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer commentId;

    @Column(name = "post_id", nullable = false)
    private Integer postId;

    @Column(name = "user_num", nullable = false)
    private Integer userNum;

    @Column(name = "comment_text", columnDefinition = "TEXT", nullable = false)
    private String comment;

    @Column(name = "comment_created_at", columnDefinition = "DATETIME", nullable = false)
    private Date createdAt;
}
