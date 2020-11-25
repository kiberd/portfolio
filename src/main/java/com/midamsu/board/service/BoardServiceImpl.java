package com.midamsu.board.service;

import com.midamsu.board.dao.BoardDao;
import com.midamsu.board.vo.BoardVO;
import com.midamsu.board.paging.Criteria;
import com.midamsu.common.utill.FileUtils;
import com.sun.scenario.effect.impl.sw.sse.SSEBlend_SRC_OUTPeer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    BoardDao bDao;

    @Autowired
    FileUtils fileUtils;

    @Override
    @Transactional
    public void write(BoardVO boardVO, HttpServletRequest request) throws Exception {

        bDao.write(boardVO);
        // 파일 쓰기
        List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(boardVO, request);
        for (int i = 0, size = list.size(); i < size; i++) {
            bDao.insertFile(list.get(i));
        }

    }


    @Override
    public List<BoardVO> listPaging(Criteria criteria) throws Exception {

        // criteria에 담겨있는 현재 pageNo, 출력 사이즈를 맵에 담아서 dao에 넘긴다.
        HashMap<String, Integer> pageMap = new HashMap<>();
        int startIndex = ((criteria.getPageNum() - 1) * criteria.getSize()) + 1;
        int endIndex = criteria.getPageNum() * criteria.getSize();
        pageMap.put("startIndex", startIndex);
        pageMap.put("endIndex", endIndex);

        return bDao.listPaging(pageMap);
    }

    @Override
    public int getTotalNumber() throws Exception {
        return bDao.getTotalNumber();
    }

    @Override
    @Transactional
    public Map<String, Object> viewContent(int bId) throws Exception {

        // 결과(글정보, 파일정보)를 받은 map
        Map<String, Object> resultMap = new HashMap<String, Object>();

        // db에서 가져온 글 정보
        BoardVO boardVODB = bDao.viewContent(bId);
        resultMap.put("boardVO", boardVODB);

        // db에서 가져온 파일(글에 귀속된) 정보
        List<Map<String, Object>> list = bDao.selectFileList(bId);
        resultMap.put("fileList", list);

        return resultMap;

    }

    @Override
    @Transactional
    public void modify(BoardVO boardVO,HttpServletRequest request) throws Exception {
        bDao.modify(boardVO);
        // 파일 쓰기
        List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(boardVO, request);
        for (int i = 0, size = list.size(); i < size; i++) {
            list.get(i).put("BID", boardVO.getBId());
            bDao.modifyFile(list.get(i));
        }
    }

    @Override
    public void delete(int bId) throws Exception {
        bDao.delete(bId);
    }

    @Override
    public BoardVO getContent(int bId) throws Exception {
        return bDao.getContent(bId);
    }

    @Override
    @Transactional
    public void reply(BoardVO boardVO, HttpServletRequest request) throws Exception {

        bDao.reply(boardVO);

        List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(boardVO, request);
        for (int i = 0, size = list.size(); i < size; i++) {
            bDao.insertFile(list.get(i));
        }
    }


}
