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
<script type="text/javascript"  src="/yk.supermarket.manager.system/js/bootstrap.js"></script>
		<script type="text/javascript"  src="/yk.supermarket.manager.system/js/jquery.js"></script>
		<link rel="stylesheet" href="/yk.supermarket.manager.system/css/bootstrap.css" />
<style type="text/css">
	#container{
		border:1px  solid  black;
		margin: 10px  auto;
		border-radius: 15px 15px;
	}
	#button{
		background-color: yellow;
	}
	#search{
		margin:0px 10px;
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
	.catalog  th{
		background-color: gray;
	}
	.left{
	border:1px solid;
	border-radius:15px 15px;
		height:340px;
		margin:0px 10px;
		overflow: auto;
	clear: both;
	}
	.right{
		border:1px solid;
	border-radius:15px 15px;
		height:340px;
		margin: 0px 10px;
		overflow: auto;
	}
	#search{
		background-color: #333;
		color: white;
		height: 30px;
		margin-bottom: 0px;
		margin:0px;
		border-radius: 15px 15px 10px  10px;;
	}
	#search_input{
	
	border-width: 1px;
	padding: 0px;
	}
	#search_input:hover{
	}
	#search_input:focus {
	border-radius: 5px 5px;
	border-color: #00BFFF;
}
	</style>
</head>
<body>
<%
if(session.getAttribute("user")==null)
{
	response.sendRedirect("/yk.supermarket.manager.system/login.jsp");
}
		String text=request.getParameter("goodsName");
		String search_type=request.getParameter("search_type");
	 	Connection con=null;
	 	Statement stat=null;
	 	ResultSet rs=null;
	 	String sql="";
%>
<div id="container">
	<div id="search" >
	<form action="goods.jsp">
		<div style="float: left;  margin-left: 20px;">
				<label style="line-height: 30px ; margin-right: 20px;" ><a   href="goodsStore.jsp"  target="right"  style="line-height: 30px; color: white;">商品入库</a></label>
				<label style="line-height: 30px; margin-left: 20px;"><a  href="goods.jsp"  target="right"  style="line-height: 30px;  color: white;">商品信息管理</a></label>
				
		</div>
		<div style="float: right; margin-right: 15px;">
			<select name="search_type"  style="border-radius: 5px 5px ; border-width: 0px;">
				<option  selected value="name">按商品名称查找</option>
				<option value="code">按编号查找</option>
				<option value="type">按类型查找</option>
			</select>
			<input  type="text"    name="goodsName"  id="search_input"  style="border-radius: 5px 5px;"  value="<%=text==null? "": text%>"><input style="border-radius: 5px 5px;  border-width: 0px;" type="submit"   value="查询">
		</div>
		</form>
	</div>
	<%
		if(text!=null && !text.equals(""))
		{
	%>
 				<table cellpadding="10px"   cellspacing="0" align="center"  class="table">
 				<thead>
		 			<tr>
		 				<th>商品编号</th><th>名称</th><th>类型</th><th>数量</th><th>进价</th><th>售价</th><th>是否上架</th><th>操作</th>
		 			</tr>
		 			</thead>
		 			<tbody>
		 			<%
			if(search_type.equals("code"))
			{
				sql="select * from goods where code='"+text+"'";
			}
			if(search_type.equals("name"))
			{
				sql="select * from goods where name like'%"+text+"%'";
			}
			if(search_type.equals("type"))
			{
				sql="select * from goods where type='"+text+"'";
			}
			try{
				con=DBTools.getConnection();
				stat=con.createStatement();
				rs=stat.executeQuery(sql);
%>
		<%
			while(rs.next())
			{
				
		 %>
		 <tr>
		 	<td><%=rs.getString(1) %></td><td><%=rs.getString(2) %></td><td><%=rs.getString(3) %></td>
		 				<td><%=rs.getInt(4) %></td><td><%=rs.getDouble("price") %></td><td><%=rs.getDouble("bid") %></td><td><%=rs.getString(6) %></td>
		 				<td> <a  href="SellAction.jsp?code=<%=rs.getString(1) %>"    style="margin-right: 20px" >上架</a><a  href="unsellAction.jsp?code=<%=rs.getString(1)%> "  >下架</a>
		 				<a href="updateGoods.jsp?code=<%=rs.getString(1)%>">修改</a>  </td>
		 </tr>
		 			
			
	<%
			}
			}catch(Exception e )
			{
				e.printStackTrace();
			}
			finally{
				DBTools.close(rs);
				DBTools.close(stat);
				DBTools.close(con);
			}
		}
		 %>
		 </tbody>
		 </table>
		<!-- 
				展示所有商品的信息----有待完成
		 -->
		 <%
		 if(text==null || text.equals("")) {
			 
		 	try{
		 			con=DBTools.getConnection();
		 			stat=con.createStatement();
		 			%>
 			<div  class="left">
 				<!-- 未上架的商品 -->
 				<table cellpadding="10px"   cellspacing="0" align="center"  class="table">
		 			<tr>
		 				<th>商品编号</th><th>名称</th><th>类型</th><th>数量</th><th>进价</th><th>售价</th><th>是否上架</th><th>操作</th>
		 			</tr>
		 			<%
		 			rs=stat.executeQuery("select * from goods where is_sell='是' ");
		 				while(rs.next())  
		 				{
		 			%>
		 			<tr>
		 				<td><%=rs.getString(1) %></td><td><%=rs.getString(2) %></td><td><%=rs.getString(3) %></td>
		 				<td><%=rs.getInt(4) %></td><td><%=rs.getDouble("price") %></td><td><%=rs.getDouble("bid") %></td><td><%=rs.getString(6) %></td>
		 				<td> <a  href="SellAction.jsp?code=<%=rs.getString(1) %>"    style="margin-right: 20px" >上架</a><a  href="unsellAction.jsp?code=<%=rs.getString(1)%> "  >下架</a>
		 				<a href="updateGoods.jsp?code=<%=rs.getString(1)%>">修改</a>  </td>
		 			</tr>
		 		<%
		 				}
		 		%>
		 	</table>	
 			</div>
 			<div  class="right">
 			<!-- 已经上架的商品 -->
 			<table  cellpadding="10px"   cellspacing="0" align="center"  class="table">
		 			<tr>
		 				<th>商品编号</th><th>名称</th><th>类型</th><th>数量</th><th>进价</th><th>售价</th><th>是否上架</th><th>操作</th>
		 			</tr>
		 			<%
		 			rs=stat.executeQuery("select * from goods where is_sell='否' ");
		 				while(rs.next())  
		 				{
		 			%>
		 			<tr>
		 				<td><%=rs.getString(1) %></td><td><%=rs.getString(2) %></td><td><%=rs.getString(3) %></td>
		 				<td><%=rs.getInt(4) %></td><td><%=rs.getDouble("price") %></td><td><%=rs.getDouble("bid") %></td><td><%=rs.getString(6) %></td>
		 				<td> <a  href="SellAction.jsp?code=<%=rs.getString(1) %>"    style="margin-right: 20px" >上架</a><a  href="unsellAction.jsp?code=<%=rs.getString(1)%> "  >下架</a>
		 				<a href="updateGoods.jsp?code=<%=rs.getString(1)%>">修改</a>    </td>
		 				
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
		 	finally{
		 		DBTools.close(rs);
		 		DBTools.close(stat);
		 		DBTools.close(con);
		 	}
	
		 }
		 %>
		 </div>
</div>

</body>
</html>