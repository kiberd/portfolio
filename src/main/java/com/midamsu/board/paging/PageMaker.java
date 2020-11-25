package com.midamsu.board.paging;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

@Getter
@Setter
public class PageMaker {
    private int totalCount; // 총 게시글 숫자
    private int startPage; // 시작 페이지
    private int endPage; // 끝 페이지
    private int totalPage; // 총 페이지 숫자
    private boolean prev; // 전 페이지 유무
    private boolean next; // 뒤 페이지 유무

    private int displayPageNum = 10; // 한번에 보여질 페이지 목록 개수

    private Criteria criteria;

    public void setCriteria(Criteria criteria){
        this.criteria = criteria;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        calcData();
    }

    private void calcData(){
//        endPage = (int) (Math.ceil(criteria.getPageNum() / (double) displayPageNum) * displayPageNum);
//        startPage = (endPage - displayPageNum) + 1;
        totalPage = (int) (Math.ceil(totalCount / (double) criteria.getSize()));

        startPage = criteria.getPageNum() - 4;
        endPage = criteria.getPageNum() + 4;

        if(startPage < 1){
            startPage = 1;
        }

        if(endPage > totalPage){
            endPage = totalPage;
        }



        prev = startPage == 1? false : true;

        next = endPage * criteria.getSize() >= totalCount ? false :true;
    }

    public String makeQuery(int pageNum){
        UriComponents uriComponents = UriComponentsBuilder.newInstance()
                .queryParam("pageNum", pageNum)
                .queryParam("size", criteria.getSize())
                .build();
        return uriComponents.toUriString();

    }
}
