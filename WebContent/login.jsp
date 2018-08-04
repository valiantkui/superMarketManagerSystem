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
<style type="text/css">

	.login{
		width: 450px;
		height: 300px;
		margin: 200px  auto; 
		background-color: yellow;
		box-shadow: 10px  10px  10px grey;
		border-radius: 20px 20px;
	}
	body {
		background: url("img/background.png");
		background-size: 100% 120%;
		background-repeat: no-repeat;
	}
	.login table{
		margin: 20px auto;
		margin-right: 15px;
	}
	.login  .title {
		margin-top:20px;
		font-size: 20px;
		color: red;
		text-shadow: 5px 5px 5px red;
		text-align: center;
		padding-top: 40px;
}
	.login  table  input{
			border-radius: 5px 5px;
			border-width: 1px;
		
	}
	#submit_input  input{
		width: 80px;
		height:40px;
		color: blue;
		
	
	}
</style>

<script type="text/javascript">
	function check_id() {
		var input_id=document.getElementById("id");
		var span_id=document.getElementById("id_msg");
		var reg=/^[0-9]+$/;
		if(reg.test(input_id.value) && input_id.value.length<=15 && input_id.value.length>0)
			{
				//格式正确
				span_id.innerHTML="格式正确";
				span_id.style.color="green";
				return true;
			}
		else{
			//格式错误
			span_id.innerHTML="格式错误";
			span_id.style.color="red";
			return false;
		}
		
	}
	
	function check_password() {
		var input_password=document.getElementById("password");
		var span_password=document.getElementById("password_msg");
	
		if(input_password.value.length<20)
			{
				//格式正确
				span_password.innerHTML="格式正确";
				span_password.style.color="green";
				return true;
			}
		else{
			//格式错误
			span_password.innerHTML="格式错误";
			span_password.style.color="red";
			return false;
		}
		
	}
</script>
<%
			
			String id=request.getParameter("id");
			String password=request.getParameter("password");
			Connection con=null;
			PreparedStatement  ps=null;
			ResultSet rs=null;
			String anoucement=null;
			try{
				//获取连接
				con=DBTools.getConnection();
				ps=con.prepareStatement("select * from user where id=? and password=?");
				ps.setString(1, id);
				ps.setString(2,password);
				rs=ps.executeQuery();
				if(rs.next())//说明查到该账号 且密码正确
				{
					//接下来则判断他的身份
					session.setAttribute("user",rs.getString("name"));
					session.setAttribute("user_id", rs.getString("id"));
					if(rs.getString("rights").equals("管理员"))
					{
						response.sendRedirect("index.jsp");
					}
					else if(rs.getString("rights").equals("收银员"))
					{
						response.sendRedirect("cashierPage.jsp");
					}
				}
				else{
					anoucement="用户名或密码错误";
					
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
</head>
<body>
			<div class="login">
			<div  class="title">
				欢迎访问超市管理系统
				</div>
			<form action="login.jsp"  onsubmit="return   check_id() " method="post">
				<table  cellpadding="10px"  cellspacing="10px" >
						<tr>
							<td>账号：</td><td> <input type="text"   name="id"  id="id" onblur="check_id()"></td><td  width="70px"><span id="id_msg"></span></td>
						</tr>
						<tr>
							<td>密码：</td><td> <input type="password"   name="password"  id="password"  onblur="check_password()"></td><td><span password_msg></span></td>
						</tr>
						<tr align="center"  id="submit_input">
							<td colspan="3"   align="left"  style="padding-left: 100px;"><input  type="submit"  value="登陆"><span style="margin-left: 30px;"><a href="#">忘记密码？</a></span></td>
						</tr>
				</table>
				</form>
			</div>
</body>
</html>