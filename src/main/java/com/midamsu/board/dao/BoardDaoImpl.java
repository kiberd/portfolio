package com.midamsu.board.dao;

import com.midamsu.board.vo.BoardVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BoardDaoImpl implements BoardDao {

    // SqlSessionTemplate DI
    @Autowired
    protected SqlSessionTemplate sqlSession;

    @Override
    public void write(BoardVO boardVO) {
        sqlSession.insert("board.write", boardVO);
    }


    @Override
    public BoardVO viewContent(int bId) {
        upHit(bId);
        return sqlSession.selectOne("board.viewcontent", bId);
    }

    @Override
    public void modify(BoardVO boardVO) {
        sqlSession.update("board.modify", boardVO);

    }

    @Override
    public void delete(int bId) {
        sqlSession.delete("board.delete", bId);
    }

    @Override
    public BoardVO getContent(int bId) {
        return sqlSession.selectOne("board.getcontent", bId);
    }

    @Override
    public void reply(BoardVO boardVO) {
        replyShape(boardVO);
        sqlSession.insert("board.reply", boardVO);

    }

    @Override
    public void replyShape(BoardVO boardVO) {
        sqlSession.update("board.replyshape", boardVO);

    }

    @Override
    public void upHit(int bId) {
        sqlSession.update("board.uphit", bId);

    }

    @Override
    public List<BoardVO> listPaging(HashMap pageMap) {
        return sqlSession.selectList("board.listpaging", pageMap);
    }


    @Override
    public int getTotalNumber() {
        return sqlSession.selectOne("board.getTotalNumber");
    }

    @Override
    public void insertFile(Map<String, Object> map) {
        sqlSession.insert("board.insertFile", map);
    }

    @Override
    public void modifyFile(Map<String, Object> map) {
        sqlSession.update("board.modifyFile", map);
    }

    @Override
    public List<Map<String, Object>> selectFileList(int bId) {
        return sqlSession.selectList("board.selectFileList", bId);
    }

    @Override
    public void updateReplyCount(int bId, int i) {

        Map<String, Integer> map = new HashMap<>();
        map.put("bId", bId);
        map.put("i", i);
        sqlSession.update("board.updateReplyCount", map);
    }
}
