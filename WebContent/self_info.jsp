<%@page import="java.sql.ResultSet"%>
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

<style type="text/css">
	.content{
		width: 360px;
		margin: 0px  5px;
		float: left;
		border: 1px solid;
		font-family: Arial;
		border-radius: 15px 15px ;
	}
	.content div{
		background-color: #AFEEEE;
		font-size: 30px;
		height:50px;
		line-height: 50px;
		border-radius: 15px 15px 0px 0px ;
	}
	.content  img{ 
		width: 360px;
		height: 400px;
		padding: 0px;
	}
	.content  p{
		width: 360px;
	}
</style>
</head>
<body>
	<%
	if(session.getAttribute("user")==null)
	{
		response.sendRedirect("login.jsp");
	}
	
		String id=(String)session.getAttribute("user_id");
		String name=null;
		String gender=null;
		int age=0;
		String rights=null;
		String img_address=null;
		Connection con=null;
		Statement stat=null;
		ResultSet rs=null;
		try{
			con=DBTools.getConnection();
			stat=con.createStatement();
			rs=stat.executeQuery("select id,name,gender,age,rights,img_address from user where id='"+id+"'");
			while(rs.next())
			{
				name=rs.getString("name");
				gender=rs.getString("gender");
				age=rs.getInt("age");
				rights=rs.getString("rights");
				img_address=rs.getString("img_address");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}finally{
			DBTools.close(rs);
			DBTools.close(stat);
			DBTools.close(con);
		}
	%>
		<div class="content" align="center">
				<div>当前账户信息</div>
				<img  src="<%=img_address%>">
				<p> 编号:  <%=id %></p>
				<p> 姓名:  <%=name %></p>
				<p> 性别: <%=gender %></p>
				<p> 年龄:  <%=age %></p>
				<p> 权限:  <%=rights %></p>
		</div>
		
		
</body>
</html>