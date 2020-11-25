package com.midamsu.common.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class CommonDaoImpl implements CommonDao{

    // SqlSessionTemplate DI
    @Autowired
    protected SqlSessionTemplate sqlSession;


    @Override
    public int getCountBoard(String userId) {
        return sqlSession.selectOne("common.getCountBoard", userId);
    }

    @Override
    public int getCountComment(String userId) {
        return sqlSession.selectOne("common.getCountComment", userId);
    }

    @Override
    public Map<String, Object> selectFileInfo(int fId) throws Exception {
        return sqlSession.selectOne("common.selectFileInfo", fId);
    }
}
