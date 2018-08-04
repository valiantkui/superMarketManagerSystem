<%@page import="yk.supermarket.manager.system.DBTools"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.content{
		width: 25%;
		margin: 10px  5px;
		float: left;
		border: 1px solid;
		font-family: Arial
	}
	.content div{
		background-color: #AFEEEE;
		font-size: 30px;
		height:50px;
		line-height: 50px;
		overflow: hidden;
	}
	.content  img{ 
		width: 370px;
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
		String id=(String)session.getAttribute("id");
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
			rs=stat.executeQuery("select id,name,gender,age,rights from user where id='"+id+"'");
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
	<div style="height: 710px; overflow: auto;">
		<div class="content" align="center">
			
				<div>当前账户信息</div>
				<img  src="/yk.supermarket.manager.system/img/yuankui.jpg">
				<p> 编号:  201709001</p>
				<p> 姓名:  袁奎</p>
				<p> 性别:  男</p>
				<p> 年龄:  20</p>
				<p> 权限:  管理员</p>
			
		</div>
		<iframe  style="float: right; margin: 0px" width="73%"  height="700px" name="iframe_content"  scrolling="auto"></iframe>
	</div>
</body>
</html>