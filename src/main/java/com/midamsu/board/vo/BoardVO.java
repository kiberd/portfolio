package com.midamsu.board.vo;

import lombok.Data;

import java.sql.Timestamp;
import java.util.List;

@Data
public class BoardVO {

    private int bId;
    private String bName;
    private String email; // 외래 키 from members (mId)
    private String bTitle;
    private String bContent;
    private Timestamp bDate;
    private int bHit;
    private int bGroup;
    private int bStep;
    private int bIndent;
    private int ccount;

}
