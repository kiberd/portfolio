package com.midamsu.member.service;

import com.midamsu.board.paging.Criteria;
import com.midamsu.board.vo.BoardVO;
import com.midamsu.comment.vo.CommentVO;
import com.midamsu.member.vo.MemberVO;

import java.util.List;

public interface MemberService {

    void memberRegister(MemberVO memberVO) throws Exception;
    void socialRegister(MemberVO memberVO) throws Exception;
    int memberLogin(MemberVO memberVO) throws Exception;
    MemberVO getMemberVO(MemberVO memberVO) throws Exception;
    int userIdCheck(String memId, MemberVO memberVO) throws Exception;
    void setAuthkey(MemberVO memberVO) throws Exception;
    void setAuthStatus(MemberVO memberVO) throws Exception;
    void memberModify(MemberVO memberVO) throws Exception;
    void memberDelete(MemberVO memberVO) throws Exception;
    List<BoardVO> getMyContents(MemberVO memberVO, Criteria criteria) throws Exception;
    List<CommentVO> getMyComments(MemberVO memberVO, Criteria criteria) throws Exception;

}
