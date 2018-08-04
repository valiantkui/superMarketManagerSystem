<%@page import="java.sql.PreparedStatement"%>
<%@page import="yk.supermarket.manager.system.DBTools"%>
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
	request.setCharacterEncoding("utf-8");
			String cardNo=request.getParameter("cardNo");
		String name=request.getParameter("name");
		String tel=request.getParameter("tel");
		double amount=Double.parseDouble(request.getParameter("amount"));
		float  rank=Float.parseFloat(request.getParameter("rank"));
		String test=request.getParameter("test");	//测试使用的
		System.out.println(cardNo+"  "+name+"   "+tel+"   "+amount+"   "+ rank);
		Connection con=null;
		PreparedStatement ps=null;
		try{
				con=DBTools.getConnection();
				ps=con.prepareStatement("insert into vip_consumer values(?,?,?,?,?)");
				ps.setString(1, cardNo);
				ps.setString(2,name);
				ps.setString(3,tel);
				ps.setDouble(4, amount);
				ps.setFloat(5, rank);
				if(ps.executeUpdate()>0)
				{
					out.print("注册成功");
				}
				else{
					out.print("注册失败");
				}
		}catch(Exception e )
		{
			e.printStackTrace();
		}finally{
			DBTools.close(ps);
			DBTools.close(con);
		}
	%>
</body>
</html>