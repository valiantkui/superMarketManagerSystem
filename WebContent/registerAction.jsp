<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="yk.supermarket.manager.system.DBTools"%>
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
	
	  request.setCharacterEncoding("utf-8");
	  String id=request.getParameter("id");
		String password=request.getParameter("password");
		String name=request.getParameter("name");
		String gender=request.getParameter("gender");
		int age=Integer.parseInt(request.getParameter("age"));
		String right=request.getParameter("right");
		System.out.println(id+"  "+password+"  "+name+"  "+gender+"   "+age+"  "+right  );
		Connection con=null;
		PreparedStatement ps=null;
		try{
			con=DBTools.getConnection();
			ps=con.prepareStatement("insert into user values(?,?,?,?,?,?)");
			ps.setString(1, id);
			ps.setString(2,password);
			ps.setString(3,name);
			ps.setString(4,gender);
			ps.setInt(5,age);
			ps.setString(6,right);
					
			if(ps.executeUpdate()>0)
			{
				//添加成功
				out.print(" <center>成功</center> ");
			}
			//好像没什么用处！！
			else{
				out.print(" <center>失败</center> ");
			}
		}catch(Exception e )
		{
			e.printStackTrace();
		}
		finally{
			DBTools.close(ps);
			DBTools.close(con);
		}
	%>
</body>
</html>