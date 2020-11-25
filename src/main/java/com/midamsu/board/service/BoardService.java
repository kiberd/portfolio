package com.midamsu.board.service;

import com.midamsu.board.vo.BoardVO;
import com.midamsu.board.paging.Criteria;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface BoardService {

    List<BoardVO> listPaging(Criteria criteria) throws Exception;
    public int getTotalNumber() throws Exception;
    void write(BoardVO boardVO, HttpServletRequest request) throws Exception;
    Map<String,Object> viewContent(int bId) throws Exception;
    void modify(BoardVO boardVO, HttpServletRequest request) throws Exception;
    void delete(int bId) throws Exception;
    BoardVO getContent(int bId) throws Exception;
    void reply(BoardVO boardVO, HttpServletRequest request) throws Exception;


}
