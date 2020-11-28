package com.midamsu.comment.service;

import com.midamsu.board.dao.BoardDao;
import com.midamsu.comment.dao.CommentDao;
import com.midamsu.board.vo.BoardVO;
import com.midamsu.comment.vo.CommentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    CommentDao commentDao;

    @Autowired
    BoardDao boardDao;

    // 댓글 등록
    @Override
    @Transactional
    public void insert(Map map) throws Exception {
        commentDao.insert(map);

        // 원글의 댓글 수 카운트 증가
        int bId = Integer.parseInt((String) map.get("bId"));
        boardDao.updateReplyCount(bId, 1);
    }

    // 댓글의 댓글 등록
    @Override
    @Transactional
    public void insertRe(Map map) throws Exception {

        int oldStep = Integer.parseInt((String) map.get("cStep")) ;
        int oldIntent = Integer.parseInt((String) map.get("cIntent"));
        int newStep = 0;
        int newIntent = 0;

        // 해당 댓글 밑의 자식 노드개수 구함
        int childCount = getChildNum(map);

        // 댓글을 원댓글에 적절한 위치에 넣기 위하여 db모양을 보정
        shape(map,childCount);

        // 자식이 없을때
        if(childCount == 0){
            newStep += oldStep + 1;
        } else{
            newStep = oldStep + childCount + 1;
        }
        newIntent = oldIntent + 1;

        // 새로 설정된 indexing 정보 map에 삽입
        map.put("cSgit tep", newStep);
        map.put("cIntent", newIntent);

        commentDao.insertRe(map);

        // 원글의 댓글 수 카운트 증가
        int bId = Integer.parseInt((String) map.get("bId"));
        boardDao.updateReplyCount(bId, 1);
    }

    @Override
    public List<CommentVO> read(BoardVO boardVO) throws Exception{
        return commentDao.read(boardVO);
    }

    @Override
    public int getChildNum(Map map) throws Exception {
        return commentDao.getChildNum(map) - 1;
    }

    @Override
    public void update(CommentVO commentVO) throws Exception {
        commentDao.update(commentVO);
    }

    @Override
    @Transactional
    public void delete(CommentVO commentVO) throws Exception{
        commentDao.delete(commentVO);
        boardDao.updateReplyCount(commentVO.getBId(),-1);
    }

    @Override
    public void deleteFlag(Map map) throws Exception {
        int cId = Integer.parseInt((String)map.get("cId"));
        commentDao.deleteFlag(cId);
    }

    @Override
    public void shape(Map map, int childCount) throws Exception {
        int target = childCount + Integer.parseInt((String) map.get("cStep"));
        map.put("cStep", target);

        commentDao.shape(map, childCount);
    }
}
