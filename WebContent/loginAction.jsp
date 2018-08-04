<%@page import="java.sql.ResultSet"%>
<%@page import="yk.supermarket.manager.system.DBTools"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
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
			String id=request.getParameter("id");
			String password=request.getParameter("password");
			System.out.println( id+"   "+password+"   ");
			Connection con=null;
			PreparedStatement  ps=null;
			ResultSet rs=null;
			try{
				con=DBTools.getConnection();
				ps=con.prepareStatement("select * from user where id=? and password=?");
				ps.setString(1, id);
				ps.setString(2,password);
				rs=ps.executeQuery();
				if(rs.next())//说明查到该账号 且密码正确
				{
					//接下来则判断他的身份
					session.setAttribute("user",rs.getString("name"));
					session.setAttribute("id", id);
					if(rs.getString("rights").equals("管理员"))
					{
						response.sendRedirect("index.jsp");
					}
					else if(rs.getString("rights").equals("收银员"))
					{
						response.sendRedirect("CashierPage.jsp");
					}
				}
				else{
					out.println("密码或账户错误");
				}
				
				
			}catch(Exception e)
			{
				e.printStackTrace();
			}
			finally{
					DBTools.close(rs);
					DBTools.close(ps);
					DBTools.close(con);
			}
	
	%>

</body>
</html>