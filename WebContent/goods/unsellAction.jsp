<%@page import="java.io.IOException"%>
<%@page import="java.sql.SQLException"%>
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
	
<script>
		function pop() {
			var h=document.getElementById("hidden");
			
					if(h.value >0)
					alert("操作成功！！");
			
		}
</script>
		
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
		try{
			con=DBTools.getConnection();
			stat=con.createStatement();
			String sql="update goods set is_sell='否' where code=" +code;
			int rows=0;
			if(  (	rows=stat.executeUpdate(sql)) >0){

				
				response.sendRedirect("goods.jsp");
			}else{
				%>
	
				<input type="hidden"  value="<%=rows%> id="hidden">
		<script>
			alert("操作失败！！");
		</script>
	<%
			
		
			}
			
			
		}catch(SQLException e)
		{
			e.printStackTrace();
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally{
			DBTools.close(stat);
			DBTools.close(con);
		}
		
		
	%>
</body>
</html>