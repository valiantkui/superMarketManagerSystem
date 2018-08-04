<%@page import="yk.supermarket.manager.system.DBTools"%>
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
		
	request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String name=request.getParameter("name");
		String type=request.getParameter("type");
		int number=Integer.parseInt(request.getParameter("number"));
		double price=Double.parseDouble(request.getParameter("price"));
		String isSell=request.getParameter("isSell");
		System.out.println(id+"   "+name+"  "+type+"   "+number+"   "+price+"   "+isSell+"  ");
		Connection con=null;
		PreparedStatement ps=null;
		try{
			con=DBTools.getConnection();
			ps=con.prepareStatement("update goods set code=?, name=? , type=?, number=?, bid=?, is_sell=?  where code=?");
			ps.setString(1, id);
			ps.setString(2, name);
			ps.setString(3,type);
			ps.setInt(4, number);
			ps.setDouble(5,price);
			ps.setString(6, isSell);
			ps.setString(7, id);
			if(ps.executeUpdate()>0)
			{
				response.sendRedirect("goods.jsp");
				System.out.println("添加商品成功!!!");
			}
			else{
				response.sendRedirect("updateGoodsFail.jsp");
			}
		}catch(Exception e)
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