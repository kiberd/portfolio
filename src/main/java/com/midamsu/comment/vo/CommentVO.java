package com.midamsu.comment.vo;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class CommentVO {


    private int cId;
    private int bId; // 외래키 from boardVO (bId)
    private int cParent;
    private int cGroup;
    private int cStep;
    private int cIntent;
    private String cContent;
    private String cName;
    private String cEmail; // 외래키 from memberVO (memId)
    private Timestamp cDate;
    private String deleteFlag;
    private String social;
}
