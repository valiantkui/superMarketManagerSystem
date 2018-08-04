<%@page import="java.sql.ResultSet"%>
<%@page import="yk.supermarket.manager.system.DBTools"%>
<%@page import="java.sql.Statement"%>
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
		String code=request.getParameter("code");
		Connection con=null;
		Statement stat=null;
		ResultSet rs=null;
		try{
			con=DBTools.getConnection();
			stat=con.createStatement();
			rs=stat.executeQuery("select * from goods where code='"+code+"'");
			rs.next();
			%>
		<form action="updateGoodsAction.jsp"  method="post">
		<input type="hidden"   value="<%=rs.getString(1) %>"   name="id">
		<table align="center"  cellpadding="10px"   cellspacing="10px">
				
					<tr>
						<td>编号:</td><td><input  type="text"   value="<%=rs.getString(1)%>"   disabled ></td>
					</tr>
					<tr>
						<td>名称:</td><td><input  type="text"  name="name"  value="<%=rs.getString(2)%>" /> </td>
					</tr>
					<tr>
						<td>类型:</td> 
						<td>
							<select  name="type">
								<option    disabled>---请选择----</option>
								<option  value="服装箱包"  <%=rs.getString("type").equals("服装箱包")? "selected" : "" %>>服装箱包</option>
								<option value="食品"  <%=rs.getString("type").equals("食品")? "selected" : "" %>>食品</option>
								<option value="生活用品"  <%=rs.getString("type").equals("生活用品")? "selected" : "" %>>生活用品</option>
								<option value="手机数码"  <%=rs.getString("type").equals("手机数码")? "selected" : "" %>>手机数码</option>
								<option value="图书乐器" <%=rs.getString("type").equals("图书乐器")? "selected" : "" %>>图书乐器</option>
								<option value="家具家纺" <%=rs.getString("type").equals("家具家纺")? "selected" : "" %>>家具家纺</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>数量:</td><td><input  type="text"  name="number"  value="<%=rs.getInt("number")%>" > </td>
					</tr>
					<tr>
						<td>售价:</td><td><input  type="text"  name="price"  value="<%=rs.getDouble("bid")%>"   > </td>
					</tr>
					<tr>
						<td>是否上架:</td><td><input  type="text"  name="isSell" value="<%=rs.getString("is_sell")%>" > </td>
					</tr>
					<tr align="center">
						<td colspan="2"> <input  type="submit"    value="提交" >   <input  type="reset"   value="重置"></td>
					</tr>
		</table>
	</form>			
			
			
			<% 
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally{
			DBTools.close(rs);
			DBTools.close(stat);
			DBTools.close(con);
		}
		
	%>
</body>
</html>