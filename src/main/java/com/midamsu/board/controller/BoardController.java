package com.midamsu.board.controller;


import com.midamsu.board.vo.BoardVO;
import com.midamsu.board.paging.Criteria;
import com.midamsu.board.paging.PageMaker;
import com.midamsu.board.service.BoardService;
import com.midamsu.common.service.CommonService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.activation.CommandMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

@Controller
public class BoardController {

    @Autowired
    BoardService boardService;

    @Autowired
    CommonService commonService;

    // 현재 유저 상태 (작성글 수 , 댓글 수 출력을 위한 메소드)
    public ModelAndView getUserStatus(HttpSession session, ModelAndView mav) throws Exception {
        String userId = (String) session.getAttribute("email");
        if (userId != null) {
            HashMap<String, Integer> userInfo = new HashMap<>();
            userInfo = commonService.getAccountInfo(userId);
            mav.addObject("boardCount", userInfo.get("boardCount"));
            mav.addObject("commentCount", userInfo.get("commentCount"));
        }
        return mav;
    }

    @GetMapping("/board/list")
    public ModelAndView boardList(Criteria criteria, HttpSession session) throws Exception {

        ModelAndView mav = new ModelAndView();
        int totalNumber = boardService.getTotalNumber();
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalNumber);

        // DTO(각 게시글) 이 담겨있는 어레이리스트
        List<BoardVO> dtos = boardService.listPaging(criteria);

        // view로 던져줌
        mav.addObject("list", dtos);
        mav.addObject("pageMaker", pageMaker);
        mav.setViewName("/board/list");

        // 유저 상태정보 던짐
        return getUserStatus(session, mav);
    }


    // 글쓰기 화면으로 이동
    @GetMapping("/board/writeview")
    public ModelAndView writeView(HttpSession session) throws Exception {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("/board/writeview");

        return getUserStatus(session, mav);
    }

    // 글쓰기 액션
    @PostMapping("/board/write.do")
    public ModelAndView doWrite(BoardVO boardVO, HttpSession session, HttpServletRequest request) throws Exception {

        ModelAndView mav = new ModelAndView();

        // 현재 로그인 되어있는 회원정보를 해당글에 set
        boardVO.setEmail((String) session.getAttribute("email"));
        boardVO.setBName((String) session.getAttribute("name"));
//        for(int i=1; i<1000; i++){
//            BoardVO b = new BoardVO();
//            b.setBName(i+"번째 이름");
//            b.setEmail("kiberd22@gmail.com");
//            b.setBTitle(i+"번쨰 제목");
//            b.setBContent(i+"번째 내용");
//            boardService.write(b,request);
//        }
        boardService.write(boardVO, request);
        mav.setViewName("redirect:/board/list");

        return mav;
    }


    // 글보기
    @GetMapping("/board/viewcontent")
    public ModelAndView viewContent(@RequestParam int bId, Criteria criteria, HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView();
        Map<String, Object> resultMap = boardService.viewContent(bId);


        System.out.println(resultMap.get("fileList"));
        mav.setViewName("/board/contentview");
        mav.addObject("content_view", resultMap.get("boardVO"));
        mav.addObject("file_list", resultMap.get("fileList"));
        mav.addObject("criteria", criteria);

        // 유저 상태 정보 던짐
        return getUserStatus(session, mav);
    }


    // 글수정 화면으로 이동
    @PostMapping("/board/modifyview")
    public ModelAndView modifyView(BoardVO boardVO, HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView();

        // 수정할 글의 제목과 내용을 가져와서 뷰에 뿌려줌
        mav.addObject("bDto", boardVO);
        mav.setViewName("/board/modifyview");

        return getUserStatus(session, mav);
    }

    // 글 수정 액션
    @PostMapping("/board/modify.do")
    public ModelAndView doModify(BoardVO boardVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        // 수정된 제목과 내용을 가져와서 logic 실행
        boardService.modify(boardVO, request);
        mav.setViewName("redirect:/board/viewcontent?bId=" + boardVO.getBId());
        return mav;
    }

    // 글 삭제
    @GetMapping("board/delete.do")
    public ModelAndView doDelete(@RequestParam int bId) throws Exception {
        ModelAndView mav = new ModelAndView();
        boardService.delete(bId);
        mav.setViewName("redirect:/board/list");
        return mav;
    }

    // 답변글쓰기 화면으로 이동
    @GetMapping("/board/replyview")
    public ModelAndView replyView(@RequestParam int bId, HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView();
        mav.addObject("reply_view", boardService.getContent(bId));
        mav.setViewName("/board/replyview");
        return getUserStatus(session, mav);
    }

    @PostMapping("/board/reply.do")
    public String doReply(BoardVO boardVO, HttpSession session, HttpServletRequest request) throws Exception {
        // 현재 로그인 된 사람의 정보로 글dto 정보 갱신
        boardVO.setEmail((String) session.getAttribute("email"));
        boardVO.setBName((String) session.getAttribute("name"));
        boardService.reply(boardVO, request);
        return "redirect:/board/list";
    }

    @PostMapping(value = "/board/uploadSummernoteImageFile", produces = "application/json")
    @ResponseBody
    public Map<String, Object> uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {

        Map<String, Object> jsonObject = new HashMap<String, Object>();
        String fileRoot = "/usr/local/tomcat/webapps/upload/";    //저장될 외부 파일 경로
        String originalFileName = multipartFile.getOriginalFilename();    //오리지날 파일명
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));    //파일 확장자

        String savedFileName = UUID.randomUUID() + extension;    //저장될 파일 명

        File targetFile = new File(fileRoot + savedFileName);

        try {
            InputStream fileStream = multipartFile.getInputStream();
            FileUtils.copyInputStreamToFile(fileStream, targetFile);    //파일 저장
            jsonObject.put("url", "/summernoteImage/" + savedFileName);
            jsonObject.put("responseCode", "success");

        } catch (IOException e) {
            FileUtils.deleteQuietly(targetFile);    //저장된 파일 삭제
            jsonObject.put("responseCode", "error");
            e.printStackTrace();
        }

        return jsonObject;
    }


}
