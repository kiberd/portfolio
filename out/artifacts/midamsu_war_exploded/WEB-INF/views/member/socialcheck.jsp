

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

        <div class="row">
            <div class="col-xs-12 col-md-12">
                <h3>
                    현재 동일한 e-mail로 등록된 미담수 계정이 존재합니다. 통합하시겠습니까?
                </h3>
            </div>
        </div>


        <div class="row text-center">
            <div class="col-xs-12 col-md-12">
                <h3>
                    소셜 로그인 연동하시면 기존의 가입하신 계정(email) 의 비밀번호는 초기화 됩니다.
                </h3>
                <form class="form-group" action="/member/socialjoin" method="post">
                    <div class="input-group" style="text-align: center">
                        <input type="hidden" name="memId" value="${memverVO.memId}"/>
                        <input type="hidden" name="memName" value="${memverVO.memName}"/>
                    </div>
                    <div  style="text-align: center">
                        <button onclick="socialOk()" type="submit" class="btn btn-primary">동의</button>

                    </div>
                </form>

                <a onclick="goToLoginform()">
                    <button class="btn btn-primary">기존 미담수 계정으로 이용하겠습니다.</button>
                </a>


            </div>
        </div>


    </div>

</section>

<script>
    function goToLoginform(){
        alert("다시 로그인해주세요");
        location.href = "/member/loginform";
    }
    function socialOk(){
        alert("정상적으로 계정통합이 완료되었습니다. 다시 로그인 해주세요.")
    }



</script>


</body>
</html>

