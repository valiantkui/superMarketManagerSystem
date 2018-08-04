<%@page import="yk.supermarket.manager.system.DBTools"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/yk.supermarket.manager.system/css/bootstrap.css">
<script type="text/javascript"  src="/yk.supermarket.manager.system/js/bootstrap.js" ></script> 
<script type="text/javascript" src="/yk.supermarket.manager.system/js/jquery.js"></script>
<title>Insert title here</title>
	<style type="text/css">
			.na{
				background-color: #333;
				border-radius: 15px 15px;
			}
			.right_content{
					height: 600px;
					border: 1px solid;
					border-radius: 15px 15px;
				}
			form a, form input {
						margin-right: 20px;
			}
	</style>
</head>
<body>
<%
if(session.getAttribute("user")==null)
{
	response.sendRedirect("/yk.supermarket.manager.system/login.jsp");
}
		request.setCharacterEncoding("utf-8");
			String name=request.getParameter("name");
			String cardNo=request.getParameter("cardNo");

%>
<div class="na">
<form action="vipManager.jsp"  method="post">
	<div  style="float: left; height: 43.28px; line-height: 43.28px; margin-left: 40px; font-size: 28px; text-shadow: 5px 5px 3px #333; ">
		<span >
		<a href="vipManager.jsp">会员管理页面</a>	
		</span>		
		<span  style="margin-left: 30px;">
			<a href="vipRegister.jsp">会员注册</a>
		</span>		
	</div>
	
	<div style="float: right;">
	<div class="input-group">

				<input type="text" class="form-control" name="name">
				<span class="input-group-btn">
					<input class="btn btn-default"  type="submit"  value="查询姓名"  >
				</span>
						
		
						<input type="text" class="form-control" name="cardNo">
						<span class="input-group-btn">
							<input class="btn btn-default" type="submit"  value="查询卡号">
						</span>
				
				</div><!-- /input-group -->
	</div>
	</form>
</div>
		<div  class="right_content">
			<table class="table">
					<tr>
						<th>卡号</th><th>姓名</th><th>电话</th><th>累计消费金额</th><th>享受折扣</th>
					</tr>
			<%
			Connection con=null;
			Statement stat=null;
			ResultSet rs=null;
			String sql="";
			if((name==null || name.equals("")) && (cardNo==null || cardNo.equals(""))  )
			{
				sql="select * from vip_consumer";
			}
			else if((name==null || name.equals("")) && (cardNo!=null && !cardNo.equals("")))
			{
				sql="select * from vip_consumer where cardNo='"+cardNo+"'";
			}
			else if((name!=null && !name.equals("")) && (cardNo==null || cardNo.equals("")))
			{
				//按姓名查找
				sql="select * from vip_consumer where  name='"+name+"'";
			}
			else{
				//按姓名和卡号一起查找
				sql="select * from vip_consumer where name='"+name+"'  and cardNo='"+cardNo+"'";
				
			}
			try{
				con=DBTools.getConnection();
				stat=con.createStatement();
				rs=stat.executeQuery(sql);
				while(rs.next())
				{
					%>
					<tr>
						<td><%=rs.getString(1) %></td><td><%=rs.getString(2) %></td><td><%=rs.getString(3) %></td><td><%=rs.getDouble(4) %></td><td><%=rs.getDouble(5) %></td>
					</tr>
			<%} %>
			</table>
		<%		
			}catch(Exception e)
			{
				e.printStackTrace();
			}finally{
				DBTools.close(rs);
				DBTools.close(stat);
				DBTools.close(con);
			}
			
			%>
		</div>
	
	</div>

</body>
</html>