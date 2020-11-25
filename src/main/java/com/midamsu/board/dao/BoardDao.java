package com.midamsu.board.dao;

import com.midamsu.board.vo.BoardVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface BoardDao {
    void write(BoardVO boardVO);

    List<BoardVO> listPaging(HashMap pageMap);

    BoardVO viewContent(int strID);

    void modify(BoardVO boardVO);

    void delete(int bId);

    BoardVO getContent(int bId);

    void reply(BoardVO boardVO);

    void replyShape(BoardVO boardVO);

    void upHit(int bId);

    int getTotalNumber();

    void insertFile(Map<String, Object> map);

    void modifyFile(Map<String, Object> map);

    List<Map<String, Object>> selectFileList(int bId);

    void updateReplyCount(int bId, int i);
}
