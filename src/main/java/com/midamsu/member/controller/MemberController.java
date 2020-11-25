package com.midamsu.member.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.midamsu.board.paging.Criteria;
import com.midamsu.board.paging.PageMaker;
import com.midamsu.board.vo.BoardVO;
import com.midamsu.comment.vo.CommentVO;
import com.midamsu.common.service.CommonService;
import com.midamsu.member.service.MailSendService;
import com.midamsu.member.vo.MemberVO;
import com.midamsu.member.social.GoogleController;
import com.midamsu.member.social.KakaoController;
import com.midamsu.member.social.NaverController;
import com.midamsu.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.MessagingException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

@Controller
public class MemberController {

    public static final int MEMBER_NOT_EXIST = -1;
    public static final int MEMBER_LOGIN_SUCCESS = 0;
    public static final int MEMBER_LOGIN_PW_NO_GOOD = 1;
    public static final int MEMBER_SOCIAL = 2;
    public static final int MEMBER_NOT_AUTHSTATUS = 3;

    @Autowired
    MemberService memberService;
    @Autowired
    CommonService commonService;
    @Autowired
    private MailSendService mss;
    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    // 회원가입 페이지로 이동
    @GetMapping("/member/joinform")
    public String joinForm() {
        return "/member/joinform";
    }

    // 회원가입 (join)
    @PostMapping("member/join")
    public String join(Model model, @Valid MemberVO memberVO, BindingResult result, HttpServletResponse response) throws Exception {

        // @Valid 어노테이션으로 스프링 자체에서 유효성검사 통과 x
        if (result.hasErrors()) {
            System.out.println(result.getAllErrors());
            model.addAttribute("joinmsg", "fail");
            return "member/rejoin";
        }

        //임의의 authKey 생성 & 이메일 발송
        String authKey = mss.sendAuthMail((memberVO.getMemId()));
        memberVO.setAuthkey(authKey);

        // 비밀번호 암호화
        String encPassword = bCryptPasswordEncoder.encode(memberVO.getMemPw());
        memberVO.setMemPw(encPassword);
        // DB에 기본정보 insert
        memberService.memberRegister(memberVO);

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter responseWriter = response.getWriter();
        responseWriter.println("<script>alert('가입하신 e-mail로 인증메일을 보냈습니다. 인증해주세요.');location.href = \"/\";</script> ");
        responseWriter.flush();

        return "/index";
    }

    // 소셜 id 통합 ( 패스워드 null값, social -> 0 , name -> 소셜에서 쓰는 네임, authkeystatus = 0)
    @PostMapping("member/socialjoin")
    public String socialjoin(MemberVO memberVO) throws Exception {
        memberService.socialRegister(memberVO);
        return "redirect:/";
    }

    // 중복 ID Check
    @GetMapping("/member/idCheck")
    @ResponseBody
    public int idCheck(@RequestParam("memId") String memId, @ModelAttribute MemberVO memberVO) throws Exception {
        // 0 : 중복 id 없음, 1 : 중복 id 있음
        return memberService.userIdCheck(memId, memberVO);
    }

    // 로그인 페이지 이동
    @GetMapping("/member/loginform")
    public ModelAndView loginForm(HttpSession session, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        // 로그인 전 사용하던 페이지가 로그인폼 화면이 아니라면 url 정보를 세션에 등록
        String conPath = request.getRequestURL().toString();
        String calledUrl = request.getHeader("REFERER");

        if (!conPath.equals(calledUrl)) {
            session.setAttribute("calledUrl", "redirect:" + calledUrl);
        }

        // 구글 API uri
        String googleUrl = GoogleController.getAuthorizationUrl(session);

        // 카카오 API uri
        String kakaoUrl = KakaoController.getAuthorizationUrl(session);

        // 네이버 API uri
        String naverUrl = NaverController.getAuthorizationUrl(session);

        mav.setViewName("member/loginform");
        mav.addObject("google_url", googleUrl);
        mav.addObject("kakao_url", kakaoUrl);
        mav.addObject("naver_url", naverUrl);

        return mav;
    }

    // 로그인
    @PostMapping("/member/login.do")
    public String login(MemberVO memberVO, HttpSession session, HttpServletResponse response) throws Exception {

        // 로그인 전에 사용하던 url
        String calledUrl = (String) session.getAttribute("calledUrl");

        // 로그인 체크 결과
        int result = memberService.memberLogin(memberVO);

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter responseWriter = response.getWriter();

        // 성공
        if (result == MEMBER_LOGIN_SUCCESS) {

            // db에 저장되있는 user 정보 가져와서 session에 등록
            MemberVO memberVODB = memberService.getMemberVO(memberVO);
            setLoginSession(memberVODB.getMemId(), memberVODB.getMemName(), "yes", "midamsu", session);

            return calledUrl;
        }
        // 이메일 인증을 받지 않았을때 이메일 인증페이지로 이동
        if (result == MEMBER_NOT_AUTHSTATUS) {
            responseWriter.println("<script>alert('이메일 인증을 받지 않았습니다. 인증해주세요.'); location.href = \"/member/authEmail?id=" +memberVO.getMemId()+ "\";</script>");
        }
        // 패스워드 틀림
        if (result == MEMBER_LOGIN_PW_NO_GOOD) {
            responseWriter.println("<script>alert('비밀번호를 확인해주세요'); history.go(-1);</script>");
        }
        // 회원 아님
        if (result == MEMBER_NOT_EXIST) {
            responseWriter.println("<script>alert('가입된 회원이 아닙니다. 회원가입해주세요');location.href = \"/member/joinform\";</script>");
        }
        // 소셜 회원일때
        if (result == MEMBER_SOCIAL) {
            responseWriter.println("<script>alert('해당 e-mail로 가입된 소셜 계정이 존재합니다.'); history.go(-1);</script>");
        }
        responseWriter.flush();

        return "/index";
    }

    // 이메일 인증링크를 누르면 맵핑되는 메소드
    @GetMapping("/member/joinConfirm")
    public String joinConfirm(@RequestParam String email, @RequestParam String authKey,
                              HttpServletResponse response) throws Exception {

        // 받아온 정보를 db에 저장된 authkey와 비교
        MemberVO memberVO = new MemberVO();
        memberVO.setMemId(email);
        memberVO.setAuthkey(authKey);

        MemberVO memberVODB = memberService.getMemberVO(memberVO);

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter responseWriter = response.getWriter();

        if (memberVODB.getAuthkey().equals(authKey)) {
            memberService.setAuthStatus(memberVO);
            responseWriter.println("<script>alert('email 인증이 완료되었습니다. 로그인 해주세요');location.href = \"/\";</script>");
        } else {
            responseWriter.println("<script>alert('email 인증이 실패했습니다. 다시 시도해 주세요.');location.href = \"/member/authEmail?id=" +email+ "\";</script>");
        }
        responseWriter.flush();
        return "/index";
    }

    // 이메일 인증 화면으로 이동
    @GetMapping("/member/authEmail")
    public String authEmail(@RequestParam String id, Model model) {
        model.addAttribute("id", id);
        return "member/authEmail";
    }


    // 인증 이메일 보내기
    @PostMapping("/member/authEmail.do")
    public String doAuthEmail(MemberVO memberVO, HttpServletResponse response) throws Exception {

        // 로그인 체크 결과
        int result = memberService.memberLogin(memberVO);
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter responseWriter = response.getWriter();

        // 성공
        if (result == MEMBER_NOT_AUTHSTATUS) {
            //임의의 authKey 생성 & 이메일 발송
            String authKey = mss.sendAuthMail(memberVO.getMemId());
            memberVO.setAuthkey(authKey);
            memberService.setAuthkey(memberVO);
            responseWriter.println("<script>alert('인증메일이 발송되었습니다.');location.href = \"/\";</script>");
        }
        // 패스워드 다름
        if (result == MEMBER_LOGIN_PW_NO_GOOD) {
            responseWriter.println("<script>alert('비밀번호를 확인해주세요'); history.go(-1);</script>");
        }
        responseWriter.flush();
        return "/index";
    }


    // 구글 로그인
    @GetMapping(value = "/member/googlelogin.do")
    public String googleLogin(@RequestParam("code") String code, HttpSession session, Model model) throws Exception {

        // 로그인 전에 사용하던 url
        String calledUrl = (String) session.getAttribute("calledUrl");

        // 토큰 요청
        JsonNode jsonToken = GoogleController.getAccessToken(code);
        String accessToken = jsonToken.get("access_token").toString();

        // 받아온 토큰정보로 유저정보 요청
        JsonNode userInfo = GoogleController.getUserInfo(accessToken);
        String email, name;
        email = userInfo.get("email").asText();
        name = userInfo.get("name").asText();

        // db 등록을 위해 member 객체 하나 생성 후 가져온 email 정보 등록
        MemberVO memberVO = new MemberVO();
        memberVO.setMemId(email);
        memberVO.setMemName(name);
        // db에 동일 email이 있는지 확인
        MemberVO memberVODB = memberService.getMemberVO(memberVO);

        // 해당 email로 가입된 정보가 없다면 가입진행 후 로그인 처리
        if (memberVODB == null) {
            memberVO.setSocial("0"); // 기본값은 (null) 이지만 소셜 등록이므로 0 세팅
            memberVO.setAuthStatus("0"); // 소셜계정은 이메일 인증이 필요없음
            memberService.memberRegister(memberVO);
            setLoginSession(email, name, "yes", "google", session);
        }
        // 가입된 email 정보가 있는데
        else {
            // 소셜 통합이 안된 상태 social : null
            if (memberVODB.getSocial() == null) {
                model.addAttribute("memverVO", memberVO);
                return "member/socialcheck";
            }
            // 소셜 통합이 된 상태면 로그인 진행
            else {
                setLoginSession(email, name, "yes", "google", session);
            }
        }
        return calledUrl;
    }

    // 카카오 로그인
    @GetMapping(value = "/member/kakaologin.do", produces = "application/json")
    public String kakaoLogin(@RequestParam("code") String code, HttpSession session, Model model, HttpServletResponse response) throws Exception {

        // 로그인 전에 사용하던 url
        String calledUrl = (String) session.getAttribute("calledUrl");

        // 토큰 요청
        JsonNode jsonToken = KakaoController.getAccessToken(code);
        JsonNode accessToken = jsonToken.get("access_token");

        // 받아온 토큰정보로 유저정보 요청
        JsonNode userInfo = KakaoController.getUserInfo(accessToken);

        // 사용자 정보 가져오기
        String email, name;
        JsonNode properties = userInfo.path("kakao_account");

        email = properties.path("email").asText();
        name = properties.path("profile").path("nickname").asText();

        // db 등록을 위해 member 객체 하나 생성 후 가져온 email 정보 등록
        MemberVO memberVO = new MemberVO();
        memberVO.setMemId(email);
        memberVO.setMemName(name);

        // db에 동일 email이 있는지 확인
        MemberVO memberVODB = memberService.getMemberVO(memberVO);

        // 해당 email로 가입된 정보가 없다면 등록 후 로그인 처리
        if (memberVODB == null) {

            // 카카오에서 email 정보를 못가져올 경우 (카카오는 email이 필수가 아님)
            if(email.equals("")){
                PrintWriter responseWriter = response.getWriter();
                responseWriter.println("<script>alert('해당 카카오 계정에서 이메일 정보를 불러올 수 없습니다. 다른 소셜 계정으로 시도해 주세요!');history.go(-1);</script>");
                responseWriter.flush();
                return "index";
            }

            memberVO.setSocial("0"); // 기본값은 (null) 이지만 소셜 등록이므로 (0:true) 으로 세팅
            memberVO.setAuthStatus("0");
            memberService.memberRegister(memberVO);
            setLoginSession(email, name, "yes", "kakao", session);
        }
        // 가입된 email 정보가 있는데
        else {
            // 소셜 통합이 안된 상태 social : null
            if (memberVODB.getSocial() == null) {
                model.addAttribute("memverVO", memberVO);
                return "member/socialcheck";
            }
            // 소셜 통합이 된 상태면 로그인 진행
            else {
                setLoginSession(email, name, "yes", "kakao", session);
            }
        }
        return calledUrl;
    }

    // 네이버 로그인
    @GetMapping(value = "/member/naverlogin.do", produces = "application/json")
    public String naverLogin(@RequestParam("code") String code, HttpSession session, Model model) throws Exception {

        // 로그인 전에 사용하던 url
        String calledUrl = (String) session.getAttribute("calledUrl");

        // 토큰 요청
        JsonNode jsonToken = NaverController.getAccessToken(code);
        JsonNode accessToken = jsonToken.get("access_token");

        // 받아온 토큰정보로 유저정보 요청
        JsonNode userInfo = NaverController.getUserInfo(accessToken);

        // 사용자 정보 가져오기
        String email, name;
        JsonNode properties = userInfo.path("response");

        email = properties.path("email").asText();
        name = properties.path("name").asText();

        // db 등록을 위해 member 객체 하나 생성 후 가져온 email 정보 등록
        MemberVO memberVO = new MemberVO();
        memberVO.setMemId(email);
        memberVO.setMemName(name);

        // db에 동일 email이 있는지 확인
        MemberVO memberVODB = memberService.getMemberVO(memberVO);

        // 해당 email로 가입된 정보가 없다면 등록 후 로그인 처리
        if (memberVODB == null) {
            memberVO.setSocial("0"); // 기본값은 (null) 이지만 소셜 등록이므로 (0:true) 으로 세팅
            memberVO.setAuthStatus("0");
            memberService.memberRegister(memberVO);
            setLoginSession(email, name, "yes", "naver", session);
        }
        // 가입된 email 정보가 있는데
        else {
            // 소셜 통합이 안된 상태 social : null
            if (memberVODB.getSocial() == null) {
                model.addAttribute("memverVO", memberVO);
                return "member/socialcheck";
            }
            // 소셜 통합이 된 상태면 로그인 진행
            else {
                setLoginSession(email, name, "yes", "naver", session);
            }
        }
        return calledUrl;
    }


    public void setLoginSession(String email, String name, String ValidMem, String social, HttpSession session) {
        session.setAttribute("email", email);
        session.setAttribute("name", name);
        session.setAttribute("ValidMem", ValidMem);
        session.setAttribute("social", social);
    }

    // 로그아웃
    @GetMapping("/member/logout.do")
    public String logout(HttpServletRequest request, HttpSession session) {
        // 모든 세션 제거
        session.invalidate();
        return "redirect:/";
    }

    // 회원정보 수정 화면으로 이동
    @GetMapping("/member/modifyView")
    public ModelAndView modifyView(Model model, HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView();

        // 현재 세션값의 로그인된 사람의 정보 가져오기 위해 memberVO 객체 만듬
        MemberVO memberVO = new MemberVO();
        memberVO.setMemId((String) session.getAttribute("email"));

        // DB에서 가져온 정보를 뷰로 뿌려줌
        MemberVO memberVODB = memberService.getMemberVO(memberVO);

        mav.addObject("memberVO", memberVODB);
        mav.setViewName("/member/modifyview");

        return getUserStatus(session, mav);

    }

    // 회원정보 수정 액션
    @PostMapping("/member/modify.do")
    public String doModify(MemberVO memberVO) throws Exception {
        memberService.memberModify(memberVO);
        return "redirect:/";
    }

    // 회원 탈퇴 액션
    @GetMapping("/members/delete.do")
    public String doDelete(@RequestParam String memId, HttpSession session) throws Exception {
        MemberVO memberVO = new MemberVO();
        memberVO.setMemId(memId);
        memberService.memberDelete(memberVO);
        session.invalidate();
        return "redirect:/";
    }

    // 내 작성글 화면 list 화면으로 이동
    @GetMapping("/member/myContents")
    public ModelAndView viewMyContents(@RequestParam String memId, @RequestParam int count, Criteria criteria, HttpSession session) throws Exception {

        ModelAndView mav = new ModelAndView();

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(count);

        MemberVO memberVO = new MemberVO();
        memberVO.setMemId(memId);

        List<BoardVO> contents = memberService.getMyContents(memberVO, criteria);

        mav.addObject("memId", memId);
        mav.addObject("count", count);
        mav.addObject("list", contents);
        mav.addObject("pageMaker", pageMaker);
        mav.setViewName("/member/mycontents");

        return getUserStatus(session, mav);
    }

    // 내 작성 댓글 list 화면으로 이동
    @GetMapping("/member/myComments")
    public ModelAndView viewMyComments(@RequestParam String memId, @RequestParam int count, Criteria criteria, HttpSession session) throws Exception {

        ModelAndView mav = new ModelAndView();

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(count);

        MemberVO memberVO = new MemberVO();
        memberVO.setMemId(memId);

        List<CommentVO> contents = memberService.getMyComments(memberVO, criteria);
        mav.addObject("memId", memId);
        mav.addObject("count", count);
        mav.addObject("list", contents);
        mav.addObject("pageMaker", pageMaker);
        mav.setViewName("/member/mycomments");

        return getUserStatus(session, mav);
    }


    // 현재 로그인된 유저의 상태 (작성한 글 숫자, 작성한 댓글 숫자) 를 가져오기 위한 메소
    public ModelAndView getUserStatus(HttpSession session, ModelAndView mav) throws Exception {
        String userId = (String) session.getAttribute("email");
        if(userId != null) {
            HashMap<String, Integer> userInfo = new HashMap<>();
            userInfo = commonService.getAccountInfo(userId);
            mav.addObject("boardCount", userInfo.get("boardCount"));
            mav.addObject("commentCount", userInfo.get("commentCount"));
        }
        return mav;
    }

}
