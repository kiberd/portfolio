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
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
            <h1 class="title">Join to us</h1>
        </div>
        <!-- end work_nav -->
    </section>

    <!-- Join -->
    <div class="container text-center" style="margin-top:5%" >
        <div class="row text-center">

            <form action="/member/join" method="post" id="joinform">


                <div class="form-group row">
                    <label class="col-xs-12 col-md-2 col-form-label">Email</label>
                    <div class="col-xs-12 col-md-10">
                        <input type="email" id="join_email" name="memId" class="form-control" placeholder="Email"
                               check_result="fail"/>
                    </div>
                    <div id="join_id_check"></div>
                </div>



                <div class="form-group row">
                    <label class="col-xs-12 col-md-2 col-form-label">Password</label>
                    <div class="col-xs-12 col-md-10">
                        <input type="password" id="join_pw" name="memPw" class="form-control" placeholder="영대문자, 영소문자, 숫자, 특수문자 포함 8자리 이상"
                               check_result="fail"/>
                    </div>
                    <div  id="join_pw_check"></div>
                </div>

                <div class="form-group row">
                    <label class="col-xs-12 col-md-2 col-form-label">Re-Password</label>
                    <div class="col-xs-12 col-md-10">
                        <input type="password" id="join_re_pw" name="memRePw" class="form-control"
                               placeholder="re-type" check_result="fail"/>
                    </div>
                    <div id="join_re_pw_check"></div>
                </div>


                <div class="form-group row">
                    <label class="col-xs-12 col-md-2 col-form-label">Name</label>
                    <div class="col-xs-12 col-md-10">
                        <input type="text" id="join_name" name="memName" class="form-control" placeholder="Name"
                               check_result="fail"/>
                        <div id="join_name_check"></div>
                    </div>
                </div>

                <div class="form-group row">
                    <label class="col-xs-12 col-md-2 col-form-label">Address</label>
                    <div class="col-xs-8 col-md-6">
                        <input type="hidden" id="join_address" name="memAddress" class="form-control"
                               placeholder="Address" check_result="fail" />
                        <input id="address" class="form-control" placeholder="Address" readonly/>
                        <input id="detailAddress" class="form-control" placeholder="상세주소" check_result="fail" style="margin-top: 1%"/>
                        <div id="detailAddress_check"></div>
                        <input class="btn btn-info btn-sm" onclick ="kakaoAddress()" value="Find" style="margin-top: 1%" readonly/>
                    </div>
                    <div class="col-xs-4 col-md-4">
                        <input id="zoneCode" class="form-control" placeholder="우편번호" readonly/>

                    </div>
                </div>

                <div class="form-group row">
                    <label class="col-xs-12 col-md-2 col-form-label">Phone</label>
                    <div class="col-xs-12 col-md-10">
                        <input type="text" id="join_phone" name="memPhone" class="form-control"
                               placeholder="000-0000-0000"
                               check_result="fail"/>
                        <div id="join_phone_check"></div>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-xs-12 col-md-12">
                        <input onclick="joinSubmit()" class="btn btn-success" value="Submit" readonly>
                    </div>
                </div>
            </form>

            <script>
                // 제출시 주소값 조합해서 제출
                function joinSubmit(){
                    // 도로명(지번)주소 + 상세주소 합쳐서 서버에 넘겨줄 join_address에 값 입력
                    var address = $("#address").val();
                    var detailAdress = $("#detailAddress").val();
                    $("#join_address").val(address + detailAdress);
                    if(validate()){
                        document.getElementById("joinform").submit();
                    }
                }

                // 카카오 주소 api callback
                function kakaoAddress() {
                    new daum.Postcode({
                        oncomplete: function(data) {
                            var addr = ''; // 주소 변수
                            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                                addr = data.roadAddress;
                            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                                addr = data.jibunAddress;
                            }
                            document.getElementById('address').value = addr;
                            document.getElementById('zoneCode').value = data.zonecode;
                            document.getElementById("detailAddress").focus();
                        }
                    }).open();
                }
            </script>

            <!-- joinform 유효성 검사 -->
            <script>
                // id(email) 중복 체크
                $("#join_email").blur(function () {
                    var memId = $('#join_email').val();
                    $.ajax({
                        url: '/member/idCheck?memId=' + memId,
                        type: 'get',
                        success: function (result) {
                            if (result == 1) {  // id 사용중인 경우
                                $("#join_email").attr("check_result", "fail");
                                $("#join_id_check").text("이미 사용중인 ID가 있습니다.");
                                $("#join_id_check").css("color", "red");
                            } else if (result == 0) {
                                $("#join_email").attr("check_result", "success");
                                $("#join_id_check").empty();
                            }
                        }
                    });
                });

                // 패스워드 유효성 검사 ( 영문, 숫자, 특수문자 포함 8자리 ~ 20자리 )
                $("#join_pw").blur(function () {
                    var memPw = $('#join_pw').val();
                    var pattern = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;

                    if (!(pattern.test(memPw))) {
                        $("#join_pw").attr("check_result", "fail");
                        $("#join_pw_check").text("영대문자, 영소문자 , 숫자, 특수문자 포함해서 8자리 이상으로 입력해주세요.");
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

                // 전화번호 유효성 검사
                $("#join_phone").blur(function () {
                    var memPhone = $('#join_phone').val();
                    var pattern = new RegExp("[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}");

                    if (!(pattern.test(memPhone))) {
                        $("#join_phone").attr("check_result", "fail");
                        $("#join_phone_check").text("000-0000-0000 와 같은 형식으로 입력해주세요");
                        $("#join_phone_check").css("color", "red");
                    } else {
                        $("#join_phone").attr("check_result", "success");
                        $("#join_phone_check").empty();
                    }
                });

                // 상세주소 유효성 검사
                $("#detailAddress").blur(function () {
                    var detailAddress= $('#detailAddress').val();

                    if (detailAddress == '') {
                        $("#detailAddress").attr("check_result", "fail");
                        $("#detailAddress_check").text("상세주소를 입력해 주세요");
                        $("#detailAddress_check").css("color", "red");
                    } else {
                        $("#detailAddress").attr("check_result", "success");
                        $("#detailAddress_check").empty();
                    }
                });

                // form 검증
                function validate() {
                    var idcheck = $("#join_email").attr("check_result");
                    var pwcheck = $("#join_pw").attr("check_result");
                    var re_pwcheck = $("#join_re_pw").attr("check_result");
                    var name = $("#join_name").val();
                    var address = $("#join_address").val();
                    var phone = $("#join_phone").val();

                    // id,pw,repw 유효성검사 중 하나라도 통과못하고,name address 값 중 빈값이 없을때
                    if ((idcheck == "fail") || (pwcheck == "fail") || (re_pwcheck == "fail") || (name == "") || (address == "") || (phone == "")) {
                        alert("누락된 항목이 있습니다.")
                        return false;
                    } else {
                        LoadingWithMask();
                        return true;
                    }
                }

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
        </div>
    </div>


</section>
</body>
</html>
