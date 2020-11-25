package com.midamsu.comment.dao;

import com.midamsu.board.vo.BoardVO;
import com.midamsu.comment.vo.CommentVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class CommentDaoImpl implements CommentDao {

    // SqlSessionTemplate DI
    @Autowired
    protected SqlSessionTemplate sqlSession;

    @Override
    public void insert(Map map) {
        sqlSession.insert("comment.insert", map);
    }

    @Override
    public void insertRe(Map map) {
        sqlSession.insert("comment.reinsert", map);
    }

    @Override
    public int getChildNum(Map map) {
        return sqlSession.selectOne("comment.getChildNum", map);
    }

    @Override
    public void shape(Map map, int childCount) {
        sqlSession.update("comment.shape", map);
    }

    @Override
    public List<CommentVO> read(BoardVO boardVO) {
        return sqlSession.selectList("comment.read", boardVO);
    }

    @Override
    public void update(CommentVO commentVO) {
        sqlSession.update("comment.update", commentVO);
    }

    @Override
    public void delete(CommentVO commentVO) {
        sqlSession.delete("comment.delete", commentVO);
    }

    @Override
    public void deleteFlag(int cId) {
        sqlSession.update("comment.deleteflag", cId);
    }
}
