<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	
	if(session.getAttribute("user")==null)
	{
		response.sendRedirect("login.jsp");
	}
		//将session 里的user信息注销了即可
		session.setAttribute("user", null);
		session.setAttribute("user_id", null);
		response.sendRedirect("login.jsp");
		
	%>
</body>
</html>