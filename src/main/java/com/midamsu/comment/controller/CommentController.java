package com.midamsu.comment.controller;

import com.midamsu.board.vo.BoardVO;
import com.midamsu.comment.vo.CommentVO;
import com.midamsu.comment.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class CommentController {
    @Autowired
    CommentService commentService;

    // 소속된 글의 댓글 읽기
    @GetMapping("/comment/list")
    @ResponseBody
    public List<CommentVO> readComment(BoardVO boardVO) throws Exception{
        return commentService.read(boardVO);
    }

    // 댓글 등록
    @PostMapping("/comment/insert")
    @ResponseBody
    public int insertComment(@RequestParam Map map, HttpSession session) throws Exception{

        // 현재 로그인 된 사용자 정보 등록 (  아이디(email), 이름 , 소셜로그인 여부 )
        map.put("cName",session.getAttribute("name"));
        map.put("cEmail", session.getAttribute("email"));
        map.put("social", session.getAttribute("social"));

        // 등록
        commentService.insert(map);
        return 1;
    }

    // 댓글의 댓글 등록
    @PostMapping("/comment/reinsert")
    @ResponseBody
    public int reinsertComment(@RequestParam Map map, HttpSession session) throws Exception{

        // 현재 로그인 된 사용자 정보 등록
        map.put("cName",session.getAttribute("name"));
        map.put("cEmail", session.getAttribute("email"));
        map.put("social", session.getAttribute("social"));

        // 등록
        commentService.insertRe(map);
        return 1;
    }

    // 댓글 삭제
    @GetMapping("/comment/delete")
    @ResponseBody
    public boolean deleteComment(@RequestParam Map map) throws Exception{

        CommentVO commentVO = new CommentVO();
        commentVO.setCId(Integer.parseInt((String) map.get("cId")));
        commentVO.setBId(Integer.parseInt((String) map.get("bId")));

        int childNumber = commentService.getChildNum(map);

        // 자식 노드가 있으면 삭제 불가 (비공개 설정)
        if(childNumber > 0){
            commentService.deleteFlag(map);
            return false;
        }
        else {
            commentService.delete(commentVO);
            return true;
        }
    }

    // 댓글 수정
    @PostMapping("/comment/update")
    @ResponseBody
    public int updateComment(CommentVO commentVO) throws Exception{
        commentService.update(commentVO);
        return 1;
    }


}
