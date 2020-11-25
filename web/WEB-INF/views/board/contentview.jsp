<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <title>MIDAMSU</title>
    <meta charset="utf-8">
    <meta name="author" content="pixelhint.com">
    <meta name="description"
          content="Magnetic is a stunning responsive HTML5/CSS3 photography/portfolio website template"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0"/>

    <link href="/resources/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/resources/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css">


    <script src="/resources/js/jquery.js"></script>
    <script src="/resources/js/bootstrap.js"></script>

    <style>
        body {
            position: relative;
        }

        .affix {
            top: 0;
            width: 100%;
            z-index: 9999 !important;
        }
    </style>
</head>

<body data-spy="scroll" data-target="#nav-mob" data-offset="50">
<header>

    <!-- start logo -->
    <div class="logo">
        <a href="/"><img src="/resources/img/logo.png" title="Magnetic" alt="Magnetic"/></a>
    </div>
    <!-- end logo -->

    <!-- navigation menu -->
    <nav id="nav">
        <ul>
            <li><a href="/">Home</a></li>
            <li><a href="/board/list">Board</a></li>
            <%--            <li id="login"><a href="#myLoginModal" data-toggle="modal"> Login</a></li>--%>
            <li id="login"><a href="/member/loginform">Login</a></li>
            <li id="logout"><a href="/member/logout.do">Logout</a></li>
            <li>
                <hr style="margin-right: 30%">
                <div id="userInfo" style="margin-right: 25%">
                    <a><h5><%=session.getAttribute("name")%> 님</h5></a>
                    <a href="/member/modifyView"><h5>회원정보 수정하기</h5></a>
                    <h5>내가 쓴 게시글 : <a href="/member/myContents?memId=${sessionScope.email}&count=${boardCount}"><c:out
                            value="${boardCount}"/></a></h5>
                    <h5>내가 쓴 댓글 : <a href="/member/myComments?memId=${sessionScope.email}&count=${commentCount}"><c:out
                            value="${commentCount}"/></a></h5>
                </div>
            </li>
        </ul>

    </nav>


    <div class="footer clearfix">
        <!-- start rights -->
        <div class="rights">

            <p>Copyright © 2020 Youngmin Park</p>
            <p>
                Template by <a href="">Pixelhint.com</a>
            </p>
        </div>
        <!-- end rights -->
    </div>

</header>


<!-- Menubar for mobile-->
<div id="nav-mob">
    <div class="container-fluid text-center">


        <div id="userInfoMobile">

            <%--            <a><h4><%=session.getAttribute("name")%> 님</h4></a>--%>
            <div class="row">
                <div class="col-xs-4">
                    <a href="/member/modifyView"><h5>회원정보 수정하기</h5></a>
                </div>
                <div class="col-xs-4">
                    <h5>내가 쓴 게시글 : <a href="/member/myContents?memId=${sessionScope.email}&count=${boardCount}"><c:out
                            value="${boardCount}"/></a></h5>
                </div>
                <div class="col-xs-4">
                    <h5>내가 쓴 댓글 : <a href="/member/myComments?memId=${sessionScope.email}&count=${commentCount}"><c:out
                            value="${commentCount}"/></a></h5>
                </div>
            </div>


            <hr>
        </div>


        <div class="row">
            <a href="/">
                <div class="col-xs-4 col-md-4" style="color: black; padding: 0 5px 0 5px;"><h5>Home</h5></div>
            </a>
            <a href="/board/list">
                <div class="col-xs-4 col-md-4" style="color: black; padding: 0 5px 0 5px;"><h5>Board</h5></div>
            </a>
            <a href="/member/loginform">
                <div id="loginMobile" class="col-xs-4 col-md-4" style="color: black; padding: 0 5px 0 5px;"><h5>
                    Login</h5>
                </div>
            </a>
            <a href="/member/logout.do">
                <div id="logoutMobile" class="col-xs-4 col-md-4" style="color: black; padding: 0 5px 0 5px;"><h5>
                    Logout</h5>
                </div>
            </a>
        </div>


    </div>
</div>

<!-- 회원가입, 로그인 결과에 따른 스크립트 -->
<script type="text/javascript">

    // 로그인 상태에 따라 로그인, 로그아웃 메뉴 변경
    var sessionUId = "<%=session.getAttribute("ValidMem")%>";

    if (sessionUId != "null") {
        document.getElementById("login").style.display = "none";
        document.getElementById("logout").style.display = "block";
        document.getElementById("loginMobile").style.display = "none";
        document.getElementById("logoutMobile").style.display = "block";
        document.getElementById("userInfo").style.display = "block";
        document.getElementById("userInfoMobile").style.display = "block";

    } else {
        document.getElementById("login").style.display = "block";
        document.getElementById("logout").style.display = "none";
        document.getElementById("loginMobile").style.display = "block";
        document.getElementById("logoutMobile").style.display = "none";
        document.getElementById("userInfo").style.display = "none";
        document.getElementById("userInfoMobile").style.display = "none";

    }

</script>


<!--Main section start-->
<section class="main clearfix">

    <section class="top">
        <div class="wrapper content_header clearfix">
            <h1 class="title">Board</h1>
        </div>
        <!-- end work_nav -->
    </section>

    <div class="container">
        <div class="row">
        <form id="boardForm" name="boardForm" method="post" action="/board/modifyview" style="margin-top:30px;">
            <table class="table table-hover table-bordered">
                <input type="hidden" name="bId" value='${content_view.BId}'/>
                <input type="hidden" name="bTitle" value='${content_view.BTitle}'/>
                <input type="hidden" name="bContent" value='${content_view.BContent}'>
                <input type="hidden" name="pageNum" value='${criteria.pageNum}'/>
                <tr>
                    <th width="10%"><h5 style="opacity: 0.8">번호</h5></th>
                    <td width="10%"><h5>${content_view.BId}</h5></td>
                    <th width="10%"><h5 style="opacity: 0.8">작성자</h5></th>
                    <td width="30%"><h5>${content_view.BName}</h5></td>
                    <th width="10%"><h5 style="opacity: 0.8">조회수</h5></th>
                    <td width="10%"><h5>${content_view.BHit}</h5></td>
                </tr>
                <tr>
                    <th><h5 style="opacity: 0.8">제목</h5></th>
                    <td colspan="5"><h5>${content_view.BTitle}</h5></td>
                </tr>
                <tr>
                    <td colspan="6">${content_view.BContent}</td>
                </tr>



                <tr>
                    <th scope="row"><h5 style="opacity: 0.8">첨부파일</h5></th>
                    <td colspan="6">
                        <c:forEach var="row" items="${file_list}">
                            <input type="hidden" id="FID" value="${row.FID}">
                            <a href="/common/downloadFile.do?fId=${row.FID}" name="file">${row.ORIGINAL_FILE_NAME }</a> (${row.FILE_SIZE }kb)
                        </c:forEach>
                    </td>
                </tr>


                <tr>
                    <td colspan="6">

                        <input id="modifyButton" type="submit" value="수정" class="btn btn-success btn-sm">
                        <a id="deleteButton" href="/board/delete.do?bId=${content_view.BId}"
                           class="btn btn-success btn-sm" style="margin-left: 1%">삭제</a>&nbsp;&nbsp;
                        <a href="/board/list?pageNum=${criteria.pageNum}" class="btn btn-success btn-sm">목록보기</a> &nbsp;&nbsp;
                        <a id="replyButton" href="/board/replyview?bId=${content_view.BId}&pageNum=${criteria.pageNum}"
                           class="btn btn-success btn-sm">답변</a>

                    </td>
                </tr>
            </table>
        </form>
        </div>
    </div>


    <!--  댓글  -->
    <div class="container">


        <label for="content">comment</label>


        <form name="commentInsertForm">
            <div class="input-group">
                <input type="hidden" name="bId" value="${content_view.BId}"/>
                <input type="text" class="form-control" id="content" name="content" placeholder="내용을 입력하세요."/>
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" name="commentInsertBtn">등록</button>
               </span>
            </div>
        </form>
        <hr>


    </div>

    <div class="container">
        <div id="commentList">
        </div>
    </div>


    <script>

        // 로그인 상태에 따른 댓글창 ui 조정
        var sessionUId = "<%=session.getAttribute("ValidMem")%>";
        $("#content").attr("readonly", true);

        if (sessionUId == "null") {
            $("#content").attr("placeholder", "로그인 후 이용가능합니다.");
            $("#content").attr("readonly", true);
        } else {
            $("#content").attr("placeholder", "내용을 입력하세요.");
            $("#content").attr("readonly", false);
        }


        // 댓글 Control
        var bId = "${content_view.BId}" //게시글 번호

        //페이지 로딩시 댓글 목록 출력
        $(document).ready(function () {
            commentList();
        });

        //댓글 등록 버튼 클릭시
        $('[name=commentInsertBtn]').click(function () {
            var content = $("#content").val();

            // 내용이 없으면 수행하지 않음
            if (content == "") {
                alert("내용은 필수 입력사항입니다")
            } else {
                var insertData = $('[name=commentInsertForm]').serialize();
                commentInsert(insertData);
            }
        });


        //댓글 등록
        function commentInsert(insertData) {
            $.ajax({
                url: '/comment/insert',
                type: 'post',
                data: insertData,
                success: function (data) {
                    if (data == 1) {
                        commentList(); //댓글 작성 후 댓글 목록 reload
                        $('[name=content]').val('');
                    }
                }
            });
        }

        //댓글 목록
        function commentList() {

            $.ajax({
                url: '/comment/list',
                type: 'get',
                data: {'bId': bId},
                success: function (data) {
                    var sessionEmail = "<%=session.getAttribute("email")%>"
                    var sessionLogin = "<%=session.getAttribute("ValidMem")%>"
                    var a = '';

                    $.each(data, function (key, value) {

                        // 해당 게시물 들여쓰기 값
                        var marginStep = value.cintent;
                        // 자식 노드가 있는 경우 삭제표시 여부
                        var deleteFlag = value.deleteFlag;
                        // 삭제처리 되었다면
                        if (deleteFlag == 0) {
                            a += '<div class="row"><div class="col-md-12 col-xs-12"><h5 style="opacity: 0.8">사용자에 의해 비공개 처리 된 댓글입니다.</h5></div></div><hr>';
                        } else {


                            var commentDate = new Date(value.cdate);
                            var currentDate = new Date();

                            var commentTime;

                            // 현재 날짜, 댓글 등록 날짜
                            var currentHour = Math.floor(currentDate.getTime() / (1000 * 60 * 60));
                            var commentHour = Math.floor(commentDate.getTime() / (1000 * 60 * 60));

                            commentTime = leadingZeros(commentDate.getFullYear(), 4) + '-' +
                                leadingZeros(commentDate.getMonth() + 1, 2) + '-' +
                                leadingZeros(commentDate.getDate(), 2) + ' ' +
                                leadingZeros(commentDate.getHours(), 2) + ':' +
                                leadingZeros(commentDate.getMinutes(), 2) + ':' +
                                leadingZeros(commentDate.getSeconds(), 2);


                            a += '<div class = "row">';

                            if (marginStep > 0) {
                                a += '<div class="col-md-' + marginStep + ' col-xs-' + marginStep + '"   ></div>';
                            }


                            a += '<div class = "col-md-1 col-xs-1" style="margin-top: 1%; border-left: solid 0.5px   ">';


                            if (value.social == "google") {
                                a += '<img src="/resources/img/google/google.png"/>';
                            }
                            if (value.social == "kakao") {
                                a += '<img src="/resources/img/kakao/kakao.png"/>';
                            }
                            if (value.social == "naver") {
                                a += '<img src="/resources/img/naver/naver.png"/>';
                            }
                            if (value.social == "midamsu") {
                                a += '<img src="/resources/img/point.png"/>';
                            }


                            a += '</div>';

                            a += '<div class="col-md-' + (11 - marginStep) + ' col-xs-' + (11 - marginStep) + '">';
                            a += '<div class="row">';

                            a += '<div class="col-md-2 col-xs-2" >';
                            a += '<h6 style="opacity: 0.8">' + value.cname + '</h6>';
                            a += '</div>';

                            a += '<div class="col-md-4 col-xs-3" >';
                            a += '<h6 style="opacity: 0.8">' + commentTime + '</h6>';
                            a += '</div>';

                            a += '<div class="col-md-1 col-xs-1" style="margin-top: 1%; ">';
                            // 댓글 작성된지 12시간이 안됐으면 new 버튼 활성화
                            if (currentHour - commentHour < 12) {
                                a += '<img id = "newimg" src="/resources/img/new.png">';
                            }
                            a += '</div>';

                            // 현재 로그인한 유저와 글쓴이가 같을때만 수정, 삭제 버튼 활성화
                            if (sessionEmail == value.cemail) {
                                a += '<div id = "modifyButton_' + value.cid + '" class = "col-md-1 col-xs-2">';
                                a += '<a onclick=\'commentUpdate(' + value.cid + ',&#39' + value.ccontent + '&#39);\'';
                                a += '>';
                                a += '<h6>수정</h6> </a>';
                                a += '</div>';
                                a += '<div class = "col-md-1 col-xs-2">';
                                a += '<a onclick="commentDelete(' + value.cid + ',' + value.bid + ');"> <h6>삭제</h6> </a> ';
                                a += '</div>';
                            }

                            // 로그인 상태일때만 답변 버튼 활성화
                            if (sessionLogin != "null") {
                                a += '<div class = "col-md-1 col-xs-2">';
                                a += '<a onclick="commentReply(' + value.cid + ');"> <h6>답변</h6> </a> ';
                                a += '</div>';
                            }

                            a += '</div>';

                            a += '<div class="row">';
                            a += '<div id  = "commentContent' + value.cid + '"        class="col-md-12 col-xs-12">';
                            a += value.ccontent;
                            a += '</div>';
                            a += '</div>';

                            a += '</div>';
                            a += '</div>';


                            a += '<div id ="replyArea' + value.cid + '" style="display: none;" >';
                            a += '<form id = "recommentInsertForm' + value.cid + '" >';
                            a += '<div class="input-group">';


                            a += '<input type="hidden" name="bId" value="' + bId + '"/>';
                            a += '<input type="hidden" name="cId" value="' + value.cid + '"/>';
                            a += '<input type="hidden" name="cGroup" value="' + value.cgroup + '"/>';
                            a += '<input type="hidden" name="cStep" value="' + value.cstep + '"/>';
                            a += '<input type="hidden" name="cIntent" value="' + value.cintent + '"/>';


                            a += '<input id ="reContent' + value.cid + '" type="text" name="cContent" class="form-control" placeholder="내용을 입력하세요."/>';
                            a += '<span class="input-group-btn">';
                            a += '<button onclick="recommentCancle(' + value.cid + ')" class="btn btn-default" type="button" name="re_commentCancleBtn">취소</button>';
                            a += '<button onclick="recommentPreInsert(' + value.cid + ')"               class="btn btn-default" type="button" name="re_commentInsertBtn">등록</button>';
                            a += '</span>';
                            a += '</div>';
                            a += '</form>';
                            a += '</div>';


                            a += '<hr>';

                        }

                    });
                    $("#commentList").html(a);
                }
            });
        }

        //대댓글 등록 버튼 클릭시 form의 내용 을 담는 작업
        function recommentPreInsert(cid) {
            var reContent = $("#reContent" + cid).val();

            // 내용이 없으면 수행하지 않음
            if (reContent == "") {
                alert("내용은 필수 입력사항입니다")
            } else {
                var insertData = $("#recommentInsertForm" + cid).serialize();
                recommentInsert(insertData);
            }
        }

        //댓글 등록
        function recommentInsert(insertData) {
            $.ajax({
                url: '/comment/reinsert',
                type: 'post',
                data: insertData,
                success: function (data) {
                    if (data == 1) {
                        commentList(); //댓글 작성 후 댓글 목록 reload
                    }
                }
            });
        }


        function recommentCancle(cid) {
            $("#replyArea" + cid).css('display', 'none');
        }

        function commentReply(cid) {
            $("#replyArea" + cid).css('display', 'block');

        }


        //댓글 수정 - 댓글 내용 출력을 input 폼으로 변경
        function commentUpdate(cid, ccontent) {


            var a = '';

            a += '<div class="input-group" style="margin-bottom: 1%">';
            a += '<input type="text" class="form-control" name="content_' + cid + '" value=\'' + ccontent + '  \'/>';
            a += '<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="commentUpdateProc(' + cid + ');">수정</button> </span>';
            a += '</div>';

            $("#modifyButton_" + cid).css('visibility', 'hidden'); // 수정 중에는 수정 버튼이 hidden
            $("#commentContent" + cid).html(a);

        }

        //댓글 수정
        function commentUpdateProc(cid) {
            var updateContent = $('[name=content_' + cid + ']').val();

            $.ajax({
                url: '/comment/update',
                type: 'post',
                data: {'cContent': updateContent, 'cId': cid},
                success: function (data) {
                    if (data == 1) {
                        $("#modifyButton_" + cid).css('visibility', 'visible'); // 수정 후에 버튼 보이기
                        commentList(bId); //댓글 수정후 목록 출력
                    }
                }
            });
        }


        //댓글 삭제
        function commentDelete(cid, bid) {
            $.ajax({
                url: '/comment/delete',
                type: 'get',
                data: {'cId': cid, 'bId': bid},
                success: function (data) {
                    // 자식노드가 없으면 삭제
                    if (data) {
                        commentList(bId);
                    } else {
                        alert("댓글이 달린 게시물은 비공개 처리됩니다.")
                        commentList(bId);
                    }
                }
            });
        }

        function leadingZeros(n, digits) {
            var zero = '';
            n = n.toString();

            if (n.length < digits) {
                for (i = 0; i < digits - n.length; i++)
                    zero += '0';
            }
            return zero + n;
        }


    </script>


    <script>
        var sessionValid = "<%=session.getAttribute("ValidMem")%>";
        var sessionEmail = "<%=session.getAttribute("email")%>";
        var contentEmail = "${content_view.email}";

        if (sessionValid == "null") { // 로그인 안 된 상태 : 수정, 삭제, 답변 숨김
            $("#modifyButton").css("display", "none");
            $("#deleteButton").css("display", "none");
            $("#replyButton").css("display", "none");
        } else { // 로그인 된 상태
            if (sessionEmail != contentEmail) { // 글쓴이와 로그인한 사람이 다르면 : 수정, 삭제 숨김
                $("#modifyButton").css("display", "none");
                $("#deleteButton").css("display", "none");
            }

        }

        function loginCheck(url) {
            var sessionUId = "<%=session.getAttribute("ValidMem")%>";
            if (sessionUId != "null") {
                location.href = url;
            } else {
                alert("로그인 해주세요")
                location.href = "/member/loginform";
            }
        }
    </script>


</section>


</body>
</html>
