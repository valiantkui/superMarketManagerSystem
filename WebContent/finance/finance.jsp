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
		<link rel="stylesheet" href="/yk.supermarket.manager.system/css/bootstrap.css" />
		<script type="text/javascript"  src="/yk.supermarket.manager.system/js/bootstrap.js"></script>
		<script type="text/javascript"  src="/yk.supermarket.manager.system/js/jquery.js"></script>
<title>Insert title here</title>

<style type="text/css">
		.containt{
			margin: 10px  20px;
			border-radius: 15px 15px;
			
		}
		.but{
			height: 60px;
		}
		.content{
			height: 400px;
			margin: 0px 0px;
			overflow: auto;
			border:1px solid;
			border-radius: 15px 15px;
		}
</style>
<style>

			ul {
			    list-style-type: none;
			    margin: 0;
			    padding: 0;
			    overflow: hidden;
			    background-color: #333;
			    margin-top: 2px;
			}
			
			li {
			    float: left;
			}
			
			li a, .dropbtn {
			    display: inline-block;
			    color: white;
			    text-align: center;
			    padding: 14px 16px;
			    text-decoration: none;
			}
			
			li a:hover, .dropdown:hover .dropbtn {
			    background-color: #111;
			}
			
			.dropdown {
			    display: inline-block;
			}
			
			.dropdown-content {
			    display: none;
			    position: absolute;
			    background-color: #f9f9f9;
			    min-width: 160px;
			    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
			}
			
			.dropdown-content a {
			    color: black;
			    padding: 12px 16px;
			    text-decoration: none;
			    display: block;
			}
			
			.dropdown-content a:hover {background-color: #f1f1f1}
			
			.dropdown:hover .dropdown-content {
			    display: block;
			}
			.total_spend{
				height: 40px;
				font-size:30px;
				line-height: 40px;
				border:1px solid;
				border-radius: 15px  15px;
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
		<div  class="containt">
			<div	 class="content">
				<table class="table">
					<thead>
						<tr>
							<th>进货编号</th><th>进货商品</th><th>类型</th><th>数量</th><th>进价</th><th>总花费</th><th>处理者</th><th>处理日期</th>
						</tr>
					</thead>
					<tbody>
				<%
					Connection con=null;
					Statement stat=null;
					ResultSet rs=null;
					double total_spend=0;
					try{
						con=DBTools.getConnection();
						stat=con.createStatement();
						rs=stat.executeQuery("select * from pur_record");
						while(rs.next())
						{
							total_spend+=rs.getDouble("spend");
							%>
							<tr>
								<td><%=rs.getInt("code") %></td><td><%=rs.getString("name") %></td><td><%=rs.getString("type") %></td><td><%=rs.getInt("number") %>
								</td><td><%=rs.getDouble("single_price") %></td><td><%=rs.getDouble("spend") %></td><td><%=rs.getString("handler") %></td><td><%=rs.getString("handDate") %></td>
							</tr>
							<%
						}
					}catch(Exception e )
					{
						e.printStackTrace();
					}finally{
						DBTools.close(rs);
						DBTools.close(stat);
						DBTools.close(con);
					}
				%>
					</tbody>
				</table>
			</div>
			<div class="total_spend">
				<span>进货总花费：</span><span><%=total_spend %>元</span>
			</div>
		</div>
</body>
</html>