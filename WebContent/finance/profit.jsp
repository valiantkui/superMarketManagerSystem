<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="yk.supermarket.manager.system.DBTools"%>
<%@page import="java.util.Calendar"%>
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
<link rel="stylesheet" href="/yk.supermarket.manager.system/css/bootstrap.css" />
		<script type="text/javascript"  src="/yk.supermarket.manager.system/js/bootstrap.js"></script>
		<script type="text/javascript"  src="/yk.supermarket.manager.system/js/jquery.js"></script>
<style type="text/css">
	.but {
		height: 30px;
		border: 1px solid;
		background-color: #333;
		border-radius: 15px 15px;
		overflow: hidden;
	}
	form{
		float: right;
	}
	.div_table{
		height: 400px;
		border: 1px solid;
		border-radius: 15px 15px;
		overflow: auto;
	
	}
	.profit_info{
		height: 40px;
		font-size: 25px;
		line-height: 40px;
	
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

	<div class="but">
		<!-- 每月或每日的入账统计按钮 -->
		<form action="profit.jsp"  >
			<input type="month"  name="month"><input type="submit"  value="每月查询">
		</form>
		
		<form action="">
			<input type="date" name="day"><input type="submit"  value="每日查询">
		</form>
	</div>
	<div class="div_table">
		<table class="table">
		<thead>
			<tr>
				<th>交易号</th><th>商品</th><th>付款者</th><th>折扣</th><th>总金额</th><th>折后金额</th><th>交易类型</th><th>交易时间</th><th>获得利润</th>
			</tr>
		</thead>
		<tbody>
		<%
			String input_month=request.getParameter("month");
			String input_date=request.getParameter("day");
			int year=0;
			int month=0;
			int day=0;
			boolean isDay=true;
//			System.out.println("input_month:"+input_month+",   input_date:"+input_date);
			
			String sql="select * from transaction where extract(year from date)=?  and  extract(month from date)=?";
			if((input_month==null || input_month.equals("")) && (input_date==null || input_date.equals("")) )
			{
				sql+=" and extract(day from date)=?";
			//获取当前日期：年   月   日
				Calendar calendar=Calendar.getInstance();
				 year=calendar.get(Calendar.YEAR);
				month=calendar.get(Calendar.MONTH)+1;//月份从零开始，切记切记
				day=calendar.get(Calendar.DAY_OF_MONTH);
				}
			else if((input_month!=null && !input_month.equals("")) && (input_date==null || input_date.equals("")) )
				{
					System.out.println("这是month 输入框对应的");
					String[] m=input_month.split("-");
					year=Integer.parseInt(m[0]);
					month=Integer.parseInt(m[1]);
					isDay=false;
				}
				else{
					sql+=" and extract(day from date)=?";
					String []d=input_date.split("-");
					year=Integer.parseInt(d[0]);
					month=Integer.parseInt(d[1]);
					day=Integer.parseInt(d[2]);
				}
			
		//默认显示本月的利润信息
			Connection con=null;
			PreparedStatement ps=null;
			PreparedStatement ps1=null;
			ResultSet rs=null;
			ResultSet rs1=null;
			List<String []> list=new ArrayList<>();
			double total_profit=0d;
		
			try{
				con=DBTools.getConnection();
				ps=con.prepareStatement(sql);
				ps.setInt(1, year);
				ps.setInt(2,month);
				if(isDay){
					ps.setInt(3, day);
				}
				rs=ps.executeQuery();
				while(rs.next())
				{
					//将所搜索条件下的商品编号以数组的形式存进list集合中
					list.add(rs.getString("goods").split("\\|"));
					String[] str=rs.getString("goods").split("\\|");
					Float discount=rs.getFloat("discout");
					Double  current_profit=0d;
					for(int i=0;i<str.length && !str[i].equals("");i++)
					{
					//	System.out.println(str[i]);
						String[] g=str[i].split("\\*");
						int number=Integer.parseInt(g[1]);
						ps1=con.prepareStatement("select (bid*?/10-price)*? as profit from goods where code=?");
						ps1.setFloat(1, discount);
						ps1.setInt(2, number);
						ps1.setString(3, g[0]);
						rs1=ps1.executeQuery();
						while(rs1.next())
						{
							current_profit+=rs1.getDouble(1);
						}
					}
					total_profit+=current_profit;
					//将搜索到的交易记录以及计算到的利润一起打印成表格
					%>
					<tr>
						<td><%=rs.getInt("tranNo") %></td><td><a>查看</a></td><td><%=rs.getString("source") %></td><td><%=rs.getFloat("discout") %></td>
						<td><%=rs.getDouble("totalBalance") %></td>
						<td><%=rs.getDouble("actualBalance")%></td><td><%=rs.getString("type") %></td><td><%=rs.getString("date") %></td><td><%=current_profit %></td>
					</tr>
					<%
				}
			}catch(Exception e)
			{
				e.printStackTrace();
			}
			finally{
				DBTools.close(rs);
				DBTools.close(rs1);
				DBTools.close(ps);
				DBTools.close(ps1);
				DBTools.close(con);
			}
			%>
				</tbody>
				</table>
			</div>
			<div class="profit_info">
				<span>本月获得利润：</span>
				<span><%=total_profit %></span>
			</div>
			<% 
		%>
</body>
</html>