package com.midamsu.board.paging;

import lombok.Data;

@Data
public class Criteria {

    private int pageNum; // 페이지 번호
    private int size; // 출력할 갯수

    public Criteria(){
        this(1,10);
    }

    public Criteria(int pageNum, int size) {
        this.pageNum = pageNum;
        this.size = size;
    }
}
