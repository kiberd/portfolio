package com.midamsu.common.service;

import java.util.HashMap;
import java.util.Map;

public interface CommonService {

    public HashMap<String,Integer> getAccountInfo(String userId) throws Exception;
    public Map<String, Object> selectFileInfo(int fId) throws Exception;

}
