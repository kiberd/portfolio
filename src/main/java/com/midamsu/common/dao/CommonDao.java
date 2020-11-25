package com.midamsu.common.dao;

import java.util.Map;

public interface CommonDao {
    public int getCountBoard(String userId);
    public int getCountComment(String userId);
    public Map<String, Object> selectFileInfo(int fId) throws Exception;

}
