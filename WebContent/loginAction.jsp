<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>JSP게시판 웹사이트</title>
</head>
<body>
<%--로그인 시도 처리 페이지--%>
<%
	String userID = null;
	if (session.getAttribute("userID")!=null){
	userID = (String) session.getAttribute("userID");
	}
	if (userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>"); 
		script.println("alter('이미 로그인 되어있습니다.')");
		script.println("location.herf = 'main.jsp'"); 
		script.println("</script>");	
	}


	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(), user.getUserPassword());
	
	if (result == 1){
		session.setAttribute("userID",user.getUserID());
		PrintWriter script = response.getWriter();
		/*로그인성공시 main으로 넘어감*/
		script.println("<script>"); 
		script.println("location.href = 'main.jsp'"); 
		script.println("</script>");	
	}
	else if (result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디가 존재하지 않습니다')");
		script.println("history.back()");
		script.println("</script>");	
	}
	else if (result == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가틀립니다')");
		/*이전페이지로 돌아감*/
		script.println("history.back()");
		script.println("</script>");	
	}
	else if (result == -2){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.')");
		script.println("history.back()");
		script.println("</script>");	
	}
	


%>

</body>
</html>