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
            <h1 class="title">My Comments</h1>
        </div>
        <!-- end work_nav -->
    </section>

    <div class="container">
        <form id="boardForm" name="boardForm" method="post">
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>원글번호</th>
                    <th>내용</th>
                    <th>날짜</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="dto" items="${list}" varStatus="status">
                    <tr>
                        <td>
                            <c:out value="${dto.BId}"/>
                        </td>
                        <td>
                            <a href="/board/viewcontent${pageMaker.makeQuery(pageMaker.criteria.pageNum)}&bId=${dto.BId}">
                            <c:out value="${dto.CContent}"/>
                            </a>
                        </td>
                        <td><c:out value="${dto.CDate}"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>


        </form>
    </div>

    <div class="container">
        <div class="row">

            <div class="col-md-12 col-xs-12 text-center">
                <ul class="pagination">

                    <c:if test="${pageMaker.criteria.pageNum > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${path}/member/myComments${pageMaker.makeQuery(pageMaker.startPage)}&memId=${memId}&count=${count}"
                               aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </li>
                    </c:if>

                    <c:if test="${pageMaker.criteria.pageNum > 5}">
                        <li class="paginate_button">
                            <a href="${path}/member/myComments${pageMaker.makeQuery(1)}&memId=${memId}&count=${count}">1</a>
                        </li>
                        <li class="page-item"><a id="prevcomma">...</a></li>
                    </c:if>

                    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                        <li class="paginate_button ${pageMaker.criteria.pageNum == num ? 'active' :''}">
                            <a href="${path}/member/myComments${pageMaker.makeQuery(num)}&memId=${memId}&count=${count}">${num}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${pageMaker.totalPage - pageMaker.criteria.pageNum > 5}">
                        <li class="page-item"><a id="nextcomma">...</a></li>
                        <li class="paginate_button">
                            <a href="${path}/member/myComments${pageMaker.makeQuery(pageMaker.totalPage)}&memId=${memId}&count=${count}">${pageMaker.totalPage}</a>
                        </li>
                    </c:if>


                    <c:if test="${pageMaker.criteria.pageNum < pageMaker.totalPage}">
                        <li class="page-item">
                            <a class="page-link" href="${path}/member/myComments${pageMaker.makeQuery(pageMaker.endPage)}&memId=${memId}&count=${count}"
                               aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                    </c:if>

                </ul>
            </div>

        </div>



    </div>

    <script>

        $("#prevcomma").removeAttr("href");
        $("#nextcomma").removeAttr("href");


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
