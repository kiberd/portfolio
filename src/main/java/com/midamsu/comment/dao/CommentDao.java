package com.midamsu.comment.dao;

import com.midamsu.board.vo.BoardVO;
import com.midamsu.comment.vo.CommentVO;

import java.util.List;
import java.util.Map;

public interface CommentDao {

    void insert(Map map);

    void insertRe(Map map);

    int getChildNum(Map map);

    void shape(Map map, int childCount);

    List<CommentVO> read(BoardVO boardVO);

    void update(CommentVO commentVO);

    void delete(CommentVO commentVO);

    void deleteFlag(int cId);
}
