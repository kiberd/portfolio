package com.midamsu.comment.service;

import com.midamsu.board.vo.BoardVO;
import com.midamsu.comment.vo.CommentVO;

import java.util.List;
import java.util.Map;

public interface CommentService {


    public void insert(Map map) throws Exception;
    public void insertRe(Map map) throws Exception;
    public List<CommentVO> read(BoardVO boardVO) throws Exception;
    public int getChildNum(Map map) throws Exception;
    public void update(CommentVO commentVO) throws Exception;
    public void delete(CommentVO commentVO) throws Exception;
    public void deleteFlag(Map map) throws Exception;
    public void shape(Map map, int childCount) throws Exception;
}
