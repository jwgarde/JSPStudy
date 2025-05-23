<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>JSP 게시판 웹 사이트</title>
    <STYLE TYPE="text/css">
        a, a:hover {
            color: #000000;
            text-decoration: none;

        }
    </STYLE>
    <!-- Bootstrap 전체 스타일 불러오기 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/custom.css">
</head>
<body>
<!--parameter는 정수형으로 바꿔주는 parseInt 함수 이용해서 바꿔줘여한다. -->
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }

    int pageNumber = 1;
    if (request.getParameter("pageNumber") != null) {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    }
%>

<nav class="navbar navbar-default">

    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li><a href="main.jsp">메인</a></li>
            <li class="active"><a href="bbs.jsp">게시판</a></li>
        </ul>
        <%
            if (userID == null) {
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">접속하기<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li class="active"><a href="LOGIN.jsp">로그인</a></li>
                    <li><a href="join.jsp">회원가입</a></li>
                </ul>
            </li>
        </ul>
        <%
        } else {
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">회원관리<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="Actionjsp/LogoutAction.jsp">로그아웃</a></li>
                </ul>
            </li>
        </ul>
        <%
            }
        %>


    </div>
</nav>
<div class="container">
    <div class="row">
        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
            <!-- 게시판의 글 목록들이 홀수와 짝수가 서로 번갈아 가면서  색상이 변경 되도록 디자인 해주는 요소중 하나-->
            <thead>
            <!-- thead는 테이블에 제목이라고 보면 됌. tr은 테이블의 하나의 행을 말함-->
            <tr>
                <th style="background-color: #eeeeee; text-align: center;">번호</th>
                <th style="background-color: #eeeeee; text-align: center;">제목</th>
                <th style="background-color: #eeeeee; text-align: center;">작성자</th>
                <th style="background-color: #eeeeee; text-align: center;">작성일</th>


            </tr>

            </thead>
            <tbody>
            <%
                BbsDAO bbsDAO = new BbsDAO();
                ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
                for (int i = 0; i < list.size(); i++) {
            %>
            <tr>
                <td><%=list.get(i).getBbsID() %></td>
               <td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></a></td>

                <td><%=list.get(i).getUserID() %></td>
                <td><%=list.get(i).getBbsDate().substring(0,11)+list.get(i).getBbsDate().substring(11,13) + "시" + list.get(i).getBbsDate().substring(14,16) + "분"%></td>
            </tr>
            <%
                }
            %>

            </tbody>
        </table>
        <%
            if(pageNumber != 1){
        %>
            <a href="bbs.jsp?pageNumber=<%=pageNumber -1%>" class="btn btn-success btn-arraw-left">이전</a>
        <%
            }
            if(bbsDAO.nextPage(pageNumber + 1)){
        %>
            <a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arraw-left">다음</a>
        <%
             }
        %>
        <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
    </div>

</div>


<!-- jQuery & Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</body>
</html>
