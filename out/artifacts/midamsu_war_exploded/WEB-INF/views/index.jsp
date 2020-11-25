<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        <div class="rights">
            <p>Copyright © 2020 Youngmin Park</p>
            <p>Template by <a href="">Pixelhint.com</a></p>
        </div>
    </div>

</header>

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

    history.replaceState({}, null, location.pathname);

</script>

<!--Main section start-->
<section class="main clearfix">

    <!-- Upper section -->
    <div class="container-fluid text-center" style="margin-top: 50px">

        <div class="row">
            <!-- Carousel start -->
            <div class="col-md-9 col-xs-12">
                <div id="myCarousel" class="carousel slide" data-ride="carousel" interval="2">
                    <ol class="carousel-indicators">
                        <li class="active" data-target="#myCarousel" data-slide-to="0"></li>
                        <li class="" data-target="#myCarousel" data-slide-to="1"></li>
                        <li class="" data-target="#myCarousel" data-slide-to="2"></li>
                        <li class="" data-target="#myCarousel" data-slide-to="3"></li>
                    </ol>
                    <div class="carousel-inner" role="listbox">
                        <div class="item active">
                            <a href="index.jsp"> <img class="first-slide" src="/resources/img/carusel1.jpg"></img>
                            </a>
                            <div class="container">
                                <div class="carousel-caption"></div>
                            </div>
                        </div>
                        <div class="item">
                            <a href="index.jsp"> <img class="second-slide" src="/resources/img/carusel2.jpg"></img>
                            </a>
                            <div class="container">
                                <div class="carousel-caption"></div>
                            </div>
                        </div>
                        <div class="item">
                            <a href="index.jsp"> <img class="third-slide" src="/resources/img/carusel3.jpg"></img>
                            </a>
                            <div class="container">
                                <div class="carousel-caption"></div>
                            </div>
                        </div>
                        <div class="item">
                            <a href="index.jsp"> <img class="fourth-slide" src="/resources/img/carusel4.jpg"></img>
                            </a>
                            <div class="container">
                                <div class="carousel-caption"></div>
                            </div>
                        </div>
                    </div>
                    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev"> <span
                            class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> <span class="sr-only">Previous</span>
                    </a> <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next"> <span
                        class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> <span
                        class="sr-only">Next</span>
                </a>
                </div>
            </div>
            <!-- Upper Right photo container -->
            <div class="col-md-3 hidden-sm hidden-xs">
                <div class="thumbnail">
                    <a><img class="img-responsive" src="/resources/img/product2_detail.jpg"
                            onclick="viewPic('/resources/img/product2_detail.jpg')"> </a>
                </div>
                <div class="thumbnail" style="margin-top: 50px;">
                    <a href="http://www.naver.com"><img class="img-responsive" src="/resources/img/naver.jpg"> </a>
                </div>
            </div>
            <div class="hidden-lg hidden-md hidden-sm col-xs-12">
                <div class="thumbnail" style="margin-top: 50px;">
                    <a href="http://naver.com"><img class="img-responsive" src="/resources/img/naver.jpg"> </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Upper section end -->

    <!-- Middle section start -->
    <div class="container-fluid text-center" style="margin-top: 50px; border-top: double 1px;">

        <%--        <!-- Video and middle photo section -->--%>
        <%--        <div class="col-md-5 col-xs-12" style="padding-top: 30px;">--%>
        <%--            <div class="thumbnail">--%>
        <%--                <a><img class="img-responsive" src="/resources/img/front.jpg"--%>
        <%--                        onclick="doImgPop('img/front_detail.jpg')"></a>--%>
        <%--            </div>--%>
        <%--        </div>--%>
            <div class="col-md-6 col-xs-12" style="padding-top: 45px;">
                <a><img class="img-responsive" src="/resources/img/mainpic.jpg"
                        onclick="viewPic('/resources/img/mainpic.jpg')"></a>
            </div>
        <div class="col-md-6 col-xs-12" style="padding-top: 45px;">
            <a><img class="img-responsive" src="/resources/img/mainpic.jpg"
                    onclick="viewPic('/resources/img/mainpic.jpg')"></a>
        </div>
    </div>


    <%--    <div class="container-fluid text-center" style="margin: 50px 0 50px 0; border-top: double 1px;">--%>
    <%--        <div class="col-md-3 col-xs-12" style="padding-top: 30px;">--%>
    <%--            <div>--%>
    <%--                <a href="" data-toggle="modal"><img src="/resources/img/mail.jpg"></a>--%>
    <%--            </div>--%>
    <%--        </div>--%>
    <%--        <div class="col-md-3 col-xs-12" style="padding-top: 30px;">--%>
    <%--            <div>--%>
    <%--                <a href=""><img src="/resources/img/phone.jpg"> </a>--%>
    <%--            </div>--%>
    <%--        </div>--%>
    <%--        <div class="col-md-3 col-xs-12" style="padding-top: 30px;">--%>
    <%--            <div>--%>
    <%--                <a href=""><img src="/resources/img/wechat.jpg"> </a>--%>
    <%--            </div>--%>
    <%--        </div>--%>
    <%--        <div class="col-md-3 col-xs-12" style="padding-top: 30px;">--%>
    <%--            <div>--%>
    <%--                <a href=""><img src="/resources/img/kakao.jpg"> </a>--%>
    <%--            </div>--%>
    <%--        </div>--%>
    <%--    </div>--%>
    <!-- Middle section End -->

</section>

<!--Modal(login)-->
<div class="modal fade" id="myLoginModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4>MIDAMSU.COM</h4>
            </div>
            <div class="modal-body">
                <div>
                    <%--          <form class="form-signin" action="/member/login.do" method="post" onsubmit="return loginvalidate()">--%>
                    <form class="form-signin" action="/member/login.do" method="post">
                        <h2 class="form-signin-heading">Please sign in</h2>
                        <label class="sr-only">Email address</label> <input type="email" name="memId" id="id"
                                                                            class="form-control"
                                                                            placeholder="Email address" required
                                                                            autofocus check_result="fail">
                        <div id="id_check"></div>
                        <label class="sr-only">Password</label> <input type="password" name="memPw" id="pw"
                                                                       class="form-control" placeholder="Password"
                                                                       required check_result="fail">
                        <div id="pw_check"></div>
                        <button id="logincheck" class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
                        <a class="btn btn-lg btn-info btn-block" href="/member/joinform">Join to us</a>
                    </form>
                </div>
                <div id="naver_id_login"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
</div>
<!-- /.modal end-->

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
<!-- script for ect action -->
<script type="text/javascript"> var imgCommonPreview = new Image();

function viewPic(filepath) {
    if (filepath == "") {
        alert('등록된 이미지가 없습니다.');
        return;
    }
    imgCommonPreview.src = filepath;
    setTimeout("createPreviewWin(imgCommonPreview)", 100);
}

function createPreviewWin(imgCommonPreview) {
    if (!imgCommonPreview.complete) {
        setTimeout("createPreviewWin(imgCommonPreview)", 100);
        return;
    }
    var scrollsize = 17;
    var swidth = screen.width - 10;
    var sheight = screen.height - 90;
    var wsize = imgCommonPreview.width
    var hsize = imgCommonPreview.height;
    if (wsize < 50) wsize = 50; // 가로 최소 크기
    if (hsize < 50) hsize = 50; // 세로 최소 크기
    if (wsize > swidth) wsize = swidth; // 가로 최대 크기
    if (hsize > sheight) hsize = sheight; // 세로 최대 크기 // 세로가 최대크기를 초과한경우 세로스크롤바 자리 확보 \
    if ((wsize < swidth - scrollsize) && hsize >= sheight) wsize += scrollsize; // 가로가 최대크기를 초과한경우 가로스크롤바 자리 확보
    if ((hsize < sheight - scrollsize) && wsize >= swidth) hsize += scrollsize; // IE 6,7 전용 : 가로세로 크기가 보통일때 세로 스크롤바 자리 확보
    if ((wsize < swidth - scrollsize) && hsize < sheight && (navigator.userAgent.indexOf("MSIE 6.0") > -1 || navigator.userAgent.indexOf("MSIE 7.0") > -1)) wsize += scrollsize; // 듀얼 모니터에서 팝업 가운데 정렬하기
    var mtWidth = document.body.clientWidth; // 현재 브라우저가 있는 모니터의 화면 폭 사이즈
    var mtHeight = document.body.clientHeight; // 현재 브라우저가 있는 모니터의 화면 높이 사이즈
    var scX = window.screenLeft; // 현재 브라우저의 x 좌표(모니터 두 대를 합한 총 위치 기준)
    var scY = window.screenTop; // 현재 브라우저의 y 좌표(모니터 두 대를 합한 총 위치 기준)
    var popX = scX + (mtWidth - wsize) / 2 - 50; // 팝업 창을 띄울 x 위치 지정(모니터 두 대를 합한 총 위치 기준)
    var popY = scY + (mtHeight - hsize) / 2 - 50; // 팝업 창을 띄울 y 위치 지정(모니터 두 대를 합한 총 위치 기준) // window.open('주소', '이름(공란가능)', '속성');
    imageWin = window.open("", "", "top=" + popY + ",left=" + popX + ",width=" + wsize + ",height=" + hsize + ",scrollbars=yes,resizable=yes,status=no");
    imageWin.document.write("<html><title>Preview</title><body style='margin:0;cursor:pointer;' title='Close' onclick='window.close()'>");
    imageWin.document.write("<img src='" + imgCommonPreview.src + "'>");
    imageWin.document.write("</body></html>");
}
</script>


</body>
</html>
