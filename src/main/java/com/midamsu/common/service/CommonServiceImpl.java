package com.midamsu.common.service;

import com.midamsu.common.dao.CommonDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class CommonServiceImpl implements CommonService{

    @Autowired
    CommonDao commonDao;

    @Override
    public HashMap<String,Integer> getAccountInfo(String userId) throws Exception {

        HashMap<String, Integer> userInfo = new HashMap<>();

        userInfo.put("boardCount", commonDao.getCountBoard(userId));
        userInfo.put("commentCount", commonDao.getCountComment(userId));

        return userInfo;
    }

    @Override
    public Map<String, Object> selectFileInfo(int fId) throws Exception {
        return commonDao.selectFileInfo(fId);
    }
}
