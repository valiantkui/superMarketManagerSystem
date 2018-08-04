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
	
	request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String name=request.getParameter("name");
		String type=request.getParameter("type");
		int number=Integer.parseInt(request.getParameter("number"));
		double outprice=Double.parseDouble(request.getParameter("out_price"));
		double inprice=Double.parseDouble(request.getParameter("in_price"));
		
		String isSell=request.getParameter("isSell");
		double spend=Double.parseDouble(request.getParameter("spend"));
		System.out.println(id+"   "+name+"  "+type+"   "+number+"   "+outprice+"   "+isSell+"  "+inprice+"  "+spend);
		Connection con=null;
		PreparedStatement ps=null;
		try{
			con=DBTools.getConnection();
			con.setAutoCommit(false);
			ps=con.prepareStatement("insert into goods values(?,?,?,?,?,?,?)");
			ps.setString(1, id);
			ps.setString(2, name);
			ps.setString(3,type);
			ps.setInt(4, number);
			ps.setDouble(5,inprice);
			ps.setString(6, isSell);
			ps.setDouble(7,outprice);
			if(ps.executeUpdate()>0)
			{
				//添加成功后，则需要向进货记录里添加一条进货记录
				System.out.println("添加商品成功!!!");
				ps=con.prepareStatement("insert into pur_record(name,type,number,spend,handler,handDate,single_price)  values(?,?,?,?,?,now(),?)");
				ps.setString(1, name);
				ps.setString(2,type);
				ps.setInt(3, number);
				ps.setDouble(4, spend);
				System.out.println("current id is:"+(String)session.getAttribute("user"));
				ps.setString(5, (String)session.getAttribute("user"));
				ps.setDouble(6, inprice);
				//未完成，待续。。。。。
				if(ps.executeUpdate()>0)
				{
					System.out.println("添加进货记录成功");
				}
				response.sendRedirect("addGoodsSuccess.jsp");
			}
			else{
				response.sendRedirect("addGoodsFail.jsp");
			}
			con.commit();
		}catch(Exception e)
		{	
			con.rollback();
			e.printStackTrace();
			response.sendRedirect("addGoodsFail.jsp");
		}
		finally{
			DBTools.close(ps);
			DBTools.close(con);
		}
	%>

</body>
</html>