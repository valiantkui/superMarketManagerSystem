<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
if(session.getAttribute("user")==null)
{
	response.sendRedirect("login.jsp");
}

%>
	<frameset rows="54,*"  border="0px"  name="main_index">
    		<frame  src="logo.jsp" >
    		<frame src="second.html"  name="content">
    	</frameset>
</html>