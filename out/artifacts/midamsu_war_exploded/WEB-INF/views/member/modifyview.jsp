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
            <h1 class="title">회원정보수정</h1>
        </div>
        <!-- end work_nav -->
    </section>

    <!-- modify -->
    <div id="joinWindow" class="container-fluid text-center" style="margin: 50px 30px 0 30px;">
        <div class="row text-center">

            <form action="/member/modify.do" method="post" onsubmit="return validate()">
                <div class="form-group row">
                    <label class="col-sm-2 col-md-2 col-form-label">Email</label>
                    <div class="col-sm-10 col-md-10">
                        <input type="email" id="join_email" name="memId" class="form-control" value="${memberVO.memId}"
                               placeholder="${memberVO.memId}" readonly/>
                    </div>

                </div>


                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">Name</label>
                    <div class="col-sm-10">
                        <input type="text" id="join_name" name="memName" class="form-control" placeholder="Name"
                               value="${memberVO.memName}"
                               check_result="fail"/>
                    </div>
                </div>

                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">Address</label>
                    <div class="col-sm-10">
                        <input type="text" id="join_address" name="memAddress" class="form-control"
                               value="${memberVO.memAddress}"
                               placeholder="Address" check_result="fail"/>
                    </div>
                </div>

                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">Phone</label>
                    <div class="col-sm-10">
                        <input type="text" id="join_phone" name="memPhone" class="form-control" placeholder="Phone"
                               value="${memberVO.memPhone}"
                               check_result="fail"/>

                    </div>
                </div>

                <div class="form-group row">
                    <div>
                        <button type="submit" class="btn btn-primary">수정</button>
                    </div>

                </div>




            </form>

            <div>
                <a onclick="deleteAction()">
                    <button class="btn btn-danger">탈퇴하기</button>
                </a>
            </div>



            <!-- 수정 form 유효성 검사 -->
            <script>

                // 패스워드 유효성 검사 ( 영문, 숫자, 특수문자 포함 8자리 이상 )
                $("#join_pw").blur(function () {
                    var memPw = $('#join_pw').val();

                    // 조건1. 6~20 영문 대소문자 조건2. 최소 1개의 숫자 혹은 특수 문자를 포함
                    var pattern = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,20}$/;

                    if (!(pattern.test(memPw))) {
                        $("#join_pw").attr("check_result", "fail");
                        $("#join_pw_check").text("영문, 숫자, 특수문자 포함해서 6 ~ 20 자리로 입력해주세요.");
                        $("#join_pw_check").css("color", "red");
                    } else {
                        $("#join_pw").attr("check_result", "success");
                        $("#join_pw_check").empty();
                    }
                });

                // re-패스워드 검사
                $("#join_re_pw").blur(function () {
                    var pw = $('#join_pw').val();
                    var re_pw = $('#join_re_pw').val();

                    if (!(pw == re_pw) || (re_pw == "")) {
                        $("#join_re_pw").attr("check_result", "fail");
                        $("#join_re_pw_check").text("비밀번호가 다릅니다.");
                        $("#join_re_pw_check").css("color", "red");
                    } else { // 맞을 경우
                        $("#join_re_pw").attr("check_result", "success");
                        $("#join_re_pw_check").empty();
                    }

                });

                function deleteAction(){
                    if(confirm("계정에 귀속된 모든 데이터가 사라집니다. 계속하시겠습니까?")){
                        location.href = '/members/delete.do?memId=${memberVO.memId}';
                    }
                    else{
                        return;
                    }

                }

                // form 검증
                function validate() {

                    var pwcheck = $("#join_pw").attr("check_result");
                    var re_pwcheck = $("#join_re_pw").attr("check_result");
                    var name = $("#join_name").val();
                    var address = $("#join_address").val();
                    var phone = $("#join_phone").val();

                    // id,pw,repw 유효성검사 중 하나라도 통과못하고,name address 값 중 빈값이 없을때
                    if ((pwcheck == "fail") || (re_pwcheck == "fail") || (name == "") || (address == "") || (phone == "")) {
                        alert("누락된 항목이 있습니다.")
                        return false;
                    } else {
                        alert("정상적으로 수정되었습니다.")
                        return true;
                    }

                }
            </script>

        </div>
    </div>


</section>


<!-- script for login -->
<script>

    // pw  체크
    $("#pw").blur(function () {

        var userID = $('#id').val();
        var userPW = $('#pw').val();
        var idcheck = $("#id").attr("check_result");
        var pwcheck = $("#pw").attr("check_result");

        $.ajax({
            type: 'POST',
            url: 'logincheck.do',
            data: {
                userPW: userPW,
                userID: userID
            },

            success: function (result) {
                if (result == 0) {

                    $("#pw_check").text("비밀번호가 다릅니다.");
                    $("#pw_check").css("color", "red");
                    $("#id").attr("check_result", "success");
                    $("#pw").attr("check_result", "fail");

                } else if (result == -1) {

                    $("#pw_check").text("가입된 회원이 아닙니다.");
                    $("#pw_check").css("color", "red");
                    $("#id").attr("check_result", "fail");
                    $("#pw").attr("check_result", "fail");
                } else {

                    $("#pw_check").text("로그인 해주세요!");
                    $("#pw_check").css("color", "blue");
                    $("#id").attr("check_result", "success");
                    $("#pw").attr("check_result", "success");

                }
            }
        });

    });

    // 로그인 정보 validate
    function loginvalidate() {

        var idcheck = $("#id").attr("check_result");
        var pwcheck = $("#pw").attr("check_result");

        if (idcheck == "success" && pwcheck == "success") {
            return true;
        }
        return false;

    }
</script>


</body>
</html>
