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
<!-- end header -->


<!-- Menubar for mobile-->
<div id="nav-mob">
    <div class="container-fluid text-center">


        <div id="userInfoMobile" class="well-sm">

            <a><h4><%=session.getAttribute("name")%> 님</h4></a>
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
            <h1 class="title">Login</h1>
        </div>
        <!-- end work_nav -->
    </section>

    <div class="container-fluid text-center">


        <div class="row text-center">
            <div class="col-xs-12 col-md-12">
                <h3>
                    비밀번호를 입력해주세요.
                </h3>

                <form class="form-group" action="/member/authEmail.do" method="post">
                    <div class="form-group">

                        <label class="sr-only">Email address</label>
                        <input type="email" name="memId" id="id" class="form-control"
                               placeholder="Email address" value="${id}" readonly>

                        <label class="sr-only">Password</label>
                        <input type="password" name="memPw" id="pw" class="form-control"
                               placeholder="Password" required>
                    </div>

                    <button onclick="LoadingWithMask()" id="logincheck" class="btn btn-primary btn-block" type="submit">이메일 인증하기</button>
                </form>



            </div>
        </div>


    </div>

</section>

<script>
    function LoadingWithMask() {
        //화면의 높이와 너비를 구함
        var maskHeight = $(document).height();
        var maskWidth;
        var mask;
        var lodingImg = '';

        // 모바일 사이즈
        if ($(document).width() < 1100){
            maskWidth = $(".main").width();
            //화면에 출력할 마스크를 설정해줍니다.
            mask = "<div id='mask' style='position:absolute; z-index:8000; background-color:#000000; display:none; left:0; top:0;'></div>";
            loadingImg = '';
            loadingImg += '<div  id="loadingImg" style= "position:absolute; left:0; top:0;z-index:9000  ">';
            loadingImg += '<img  src="/resources/img/Spinner.gif"  style="position:absolute; left:50%; top:50%; transform:translateX(-50%);"  />';
            loadingImg += '</div>';
        }
        // 데스크탑 사이즈
        else{
            maskWidth = $(".top").width();
            //화면에 출력할 마스크를 설정해줍니다.
            mask = "<div id='mask' style='position:absolute; z-index:8000; background-color:#000000; display:none; right:0; top:0;;'></div>";
            loadingImg = '';
            loadingImg += '<div  id="loadingImg" style= "position:absolute; right:0; top:0;z-index:9000  ">';
            loadingImg += '<img  src="/resources/img/Spinner.gif"  style="position:absolute; left:50%; top:50%; transform:translateX(-50%);"  />';
            loadingImg += '</div>';
        }
        //화면에 레이어 추가
        $('body')
            .append(mask)
            .append(loadingImg)
        //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채웁니다.
        $("#mask").css({
            'width': maskWidth
            , 'height': maskHeight
            , 'opacity': '0.3'
        });

        $("#loadingImg").css({
            'width': maskWidth
            , 'height': maskHeight

        });
        //마스크 표시
        $('#mask').show();
        //로딩중 이미지 표시
        $('#loadingImg').show();
    }



</script>


</body>
</html>

