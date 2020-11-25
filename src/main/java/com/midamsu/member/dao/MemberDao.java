package com.midamsu.member.dao;

import com.midamsu.board.vo.BoardVO;
import com.midamsu.comment.vo.CommentVO;
import com.midamsu.member.vo.MemberVO;
import com.midamsu.member.vo.MyContentsVO;

import java.util.List;

public interface MemberDao {

    void memberInsert(MemberVO memberVO) ;
    void socialRegister(MemberVO memberVO) ;
    public MemberVO userCheck(MemberVO memberVO) ;
    public MemberVO getMemberVO(MemberVO memberVO) ;
    int userIdCheck(String memId, MemberVO memberVO) ;
    void setAuthkey(MemberVO memberVO) ;
    void setAuthStatus(MemberVO memberVO) ;
    void memberModify(MemberVO memberVO) ;
    void memberDelete(MemberVO memberVO) ;
    List<BoardVO> getMyContents(MyContentsVO myContentsVO) ;
    List<CommentVO> getMyComments(MyContentsVO myContentsVO) ;

}
