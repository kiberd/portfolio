package com.midamsu.member.dao;

import com.midamsu.board.vo.BoardVO;
import com.midamsu.comment.vo.CommentVO;
import com.midamsu.member.vo.MemberVO;
import com.midamsu.member.vo.MyContentsVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberDaoImpl implements MemberDao{

    // SqlSessionTemplate DI
    @Autowired
    protected SqlSessionTemplate sqlSession;

    @Override
    public void memberInsert(MemberVO memberVO){
        sqlSession.insert("member.memberInsert", memberVO);
    }

    @Override
    public void socialRegister(MemberVO memberVO)  {
        sqlSession.update("member.socialRegister" , memberVO);
    }

    @Override
    public MemberVO userCheck(MemberVO memberVO) {
        return sqlSession.selectOne("member.userCheck" , memberVO);
    }

    @Override
    public MemberVO getMemberVO(MemberVO memberVO)  {
        return sqlSession.selectOne("member.getMemberVO",memberVO);
    }

    @Override
    public int userIdCheck(String memId, MemberVO memberVO)  {
        String result = sqlSession.selectOne("member.userIdCheck", memberVO);
        // 0 : 중복 id 없음, 1 : 중복 id 있음
        return (result == null)? 0 : 1;
    }

    @Override
    public void setAuthkey(MemberVO memberVO){
        sqlSession.update("member.setAuthkey", memberVO);
    }

    @Override
    public void setAuthStatus(MemberVO memberVO)  {
        sqlSession.update("member.setAuthStatus" , memberVO);
    }

    @Override
    public void memberModify(MemberVO memberVO) {
        sqlSession.update("member.memberModify", memberVO);
    }

    @Override
    public void memberDelete(MemberVO memberVO) {
        sqlSession.delete("member.memberDelete" , memberVO);
    }

    @Override
    public List<BoardVO> getMyContents(MyContentsVO myContentsVO){
        return sqlSession.selectList("member.getMyContents", myContentsVO);
    }

    @Override
    public List<CommentVO> getMyComments(MyContentsVO myContentsVO) {
        return sqlSession.selectList("member.getMyComments", myContentsVO);
    }
}
