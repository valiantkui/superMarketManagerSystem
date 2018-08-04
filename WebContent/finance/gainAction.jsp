<%@page import="yk.supermarket.manager.system.DBTools"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
		response.sendRedirect("/yk.supermarket.manager.system/login.jsp");
	}
		String input_month=request.getParameter("month");
		String input_day=request.getParameter("day");
		
		int year=0;
		int month=0;
		int day=0;
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		if( input_month!=null)
		{
		String[] arr_month=input_month.split("-");//获取年份和月份
		year=Integer.parseInt(arr_month[0]);
		month=Integer.parseInt(arr_month[1]);
		//根据获取的年份和月份对数据库transaction进行查询
		con=DBTools.getConnection();
		ps=con.prepareStatement("select * from transaction where extract(year from date)=?  and  extract(month from date)");
		
			
		}
		if(input_day!=null)
		{
		String [] arr_day=input_day.split("-");
		
		year=Integer.parseInt(arr_day[0]);
		month=Integer.parseInt(arr_day[1]);
		day=Integer.parseInt(arr_day[2]);
		}
		
				
		%>
</body>
</html>