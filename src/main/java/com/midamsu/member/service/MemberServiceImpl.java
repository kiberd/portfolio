package com.midamsu.member.service;

import com.midamsu.board.paging.Criteria;
import com.midamsu.board.vo.BoardVO;
import com.midamsu.comment.vo.CommentVO;
import com.midamsu.member.vo.MemberVO;
import com.midamsu.member.dao.MemberDao;
import com.midamsu.member.vo.MyContentsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {

    public static final int MEMBER_NOT_EXIST = -1;
    public static final int MEMBER_LOGIN_SUCCESS = 0;
    public static final int MEMBER_LOGIN_PW_NO_GOOD = 1;
    public static final int MEMBER_SOCIAL = 2;
    public static final int MEMBER_NOT_AUTHSTATUS = 3;

    @Autowired
    MemberDao dao;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public void memberRegister(MemberVO memberVO) throws Exception {
        dao.memberInsert(memberVO);
    }

    @Override
    public void socialRegister(MemberVO memberVO) throws Exception {
        dao.socialRegister(memberVO);
    }

    @Override
    public int memberLogin(MemberVO memberVO) throws Exception {
        MemberVO memberVODB = dao.userCheck(memberVO);

        // 일치하는 멤버가 없을때
        if(memberVODB == null){
            return MEMBER_NOT_EXIST;
        }
        // 일치하는 멤버가 있을때
        else{
            // 소셜 멤버일떄
            if(memberVODB.getSocial() != null){
                return MEMBER_SOCIAL;
            }
            // 비밀번호 일치
            else if(bCryptPasswordEncoder.matches(memberVO.getMemPw(), memberVODB.getMemPw())){
                // 이메일인증 x
                if(memberVODB.getAuthStatus() == null){
                    return MEMBER_NOT_AUTHSTATUS;
                }
                return MEMBER_LOGIN_SUCCESS;
            }
            // 비밀번호 불일치
            else{
                return MEMBER_LOGIN_PW_NO_GOOD;
            }
        }

    }

    @Override
    public MemberVO getMemberVO(MemberVO memberVO) throws Exception {
        return dao.getMemberVO(memberVO);
    }

    @Override
    public int userIdCheck(String memId, MemberVO memberVO) throws Exception {
        return dao.userIdCheck(memId, memberVO);
    }

    @Override
    public void setAuthkey(MemberVO memberVO) throws Exception {
        dao.setAuthkey(memberVO);
    }

    @Override
    public void setAuthStatus(MemberVO memberVO) throws Exception {
        dao.setAuthStatus(memberVO);
    }

    @Override
    public void memberModify(MemberVO memberVO) throws Exception {
        dao.memberModify(memberVO);
    }

    @Override
    public void memberDelete(MemberVO memberVO) throws Exception {
        dao.memberDelete(memberVO);
    }

    @Override
    public List<BoardVO> getMyContents(MemberVO memberVO , Criteria criteria) throws Exception{

        int startIndex = ((criteria.getPageNum() - 1) * criteria.getSize()) + 1;
        int endIndex = criteria.getPageNum() * criteria.getSize();

        MyContentsVO myContentsVO = new MyContentsVO();
        myContentsVO.setStartIndex(startIndex);
        myContentsVO.setEndIndex(endIndex);
        myContentsVO.setMemId(memberVO.getMemId());

        return dao.getMyContents(myContentsVO);
    }

    @Override
    public List<CommentVO> getMyComments(MemberVO memberVO, Criteria criteria) throws Exception {

        int startIndex = ((criteria.getPageNum() - 1) * criteria.getSize()) + 1;
        int endIndex = criteria.getPageNum() * criteria.getSize();

        MyContentsVO myContentsVO = new MyContentsVO();
        myContentsVO.setStartIndex(startIndex);
        myContentsVO.setEndIndex(endIndex);
        myContentsVO.setMemId(memberVO.getMemId());

        return dao.getMyComments(myContentsVO);
    }
}
