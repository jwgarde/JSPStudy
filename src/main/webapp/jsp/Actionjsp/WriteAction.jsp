<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>JSP 게시판 웹 사이트</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");

    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인 하쇼');");
        script.println("location.href = '../LOGIN.jsp'");
        script.println("</script>");
    } else {
        if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 상황이 있습니다.');");
            script.println("history.back();");
            script.println("</script>");
        } else {
            BbsDAO bbsDAO = new BbsDAO();
            int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());

            if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('글쓰기에 실패 했습니다.');");
                script.println("history.back();");
                script.println("</script>");
            }
            else{
                 PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href = '../bbs.jsp'");
                script.println("</script>");
            }
        }

    }


%>
</body>
</html>
