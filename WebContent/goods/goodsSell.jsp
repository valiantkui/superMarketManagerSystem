<%@page import="yk.supermarket.manager.system.DBTools"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#container{
		border:1px  dashed  black;
		margin: 10px  auto;
	}
	#button{
		background-color: yellow;
	}
	#search{
		background-color: gray;
	}
	#button a{
			margin: 10px  20px;
			padding :10px  20px;
			text-decoration: none;
	}
	.catalog, .catalog th, .catalog td{
		border: 1px solid black;
	}
	.catalog{
		width: 100%;
	}
	.catalog  th{
		background-color: gray;
	}
	#mainPage{
		margin: 10px  20px;
	}
	</style>
</head>
<body>
<%
if(session.getAttribute("user")==null)
{
	response.sendRedirect("/yk.supermarket.manager.system/login.jsp");
}
%>
<div class="container">
		<div id="search" align="right">
				<table >
						<tr>
								<td><input  type="text"  value="请输入商品名称查询"> </td><td><input type="submit"   value="查询">  </td>
						</tr>
				</table>
		</div>
		<div  id="mainPage">
		<!-- 
				展示所有商品的信息----有待完成
		 -->
		 <%
		 	Connection con=null;
		 	Statement stat=null;
		 	ResultSet rs=null;
		 	try{
		 			con=DBTools.getConnection();
		 			stat=con.createStatement();
		 			rs=stat.executeQuery("select * from goods");
		 			%>
		 		<table class="catalog"  cellpadding="10px"   cellspacing="0" align="center">
		 			<tr>
		 				<th>商品编号</th><th>名称</th><th>类型</th><th>数量</th><th>价格</th><th>是否上架</th><th>进价<th>操作</th>
		 			</tr>
		 			<%
		 				while(rs.next())  
		 				{
		 			%>
		 			<tr>
		 				<td><%=rs.getString(1) %></td><td><%=rs.getString(2) %></td><td><%=rs.getString(3) %></td>
		 				<td><%=rs.getInt(4) %></td><td><%=rs.getDouble(5) %></td><td><%=rs.getString(6) %></td><td><%=rs.getString(7) %></td>
		 				<td> <a  href="SellAction.jsp?code=<%=rs.getString(1) %>"    style="margin-right: 20px" >上架</a><a  href="unsellAction.jsp?code=<%=rs.getString(1)%> "  >下架</a>  </td>
		 			</tr>
		 		<%
		 				}
		 		%>
		 		</table>	
		 	<%
		 	}catch(Exception e)
		 	{
		 		e.printStackTrace();
		 	}
		 %>
	</div>
</div>
</body>
</html>