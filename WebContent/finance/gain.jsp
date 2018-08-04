<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Calendar"%>
<%@page import="yk.supermarket.manager.system.DBTools"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/yk.supermarket.manager.system/css/bootstrap.css" />
<link rel="stylesheet"  href="/yk.supermarket.manager.system/css/tookits.css"/>
		<script type="text/javascript"  src="/yk.supermarket.manager.system/js/bootstrap.js"></script>
		<script type="text/javascript"  src="/yk.supermarket.manager.system/js/jquery.js"></script>
<title>Insert title here</title>
<style type="text/css">
	.but {
		height: 30px;
		border: 1px solid;
		border-radius: 15px 15px;
		overflow: hidden;
		background-color: #333;
	}
	form{
		float: right;
		
	}
			.div_table{
				
				height: 400px;
				margin: 10px 10px;
				border:1px solid;
				border-radius: 15px 15px;
				overflow: auto;
				}
				.gain_info{
				height: 40px;
				font-size:30px;
				font-weight;
				line-height: 40px;
				border:1px solid;
				border-radius: 15px 15px;
				margin: 10px 10px;
			}
			.goods_info{
				visibility: hidden;
				position: fixed;
				top:20%;
				left:0px;
				background-color: #00FF7F;
				margin:10px 10px;
				max-height: 400px;
				overflow: auto;
				border-radius: 15px 15px;
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
		<form action="gain.jsp"  >
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
					<td>交易号</td><td>购买商品</td><td>购买者</td><td>折扣</td><td>原始金额</td><td>折扣金额</td><td>付款方式</td><td>交易日期</td>
				</tr>
			</thead>
			<tbody>
		<!-- 显示本月的入账情况 -->
		<%
				String input_month=request.getParameter("month");
				String input_day=request.getParameter("day");
				if(input_month==null && input_day==null)
				{
					Connection con=null;
					PreparedStatement ps=null;
					PreparedStatement ps1=null;
					ResultSet rs=null;
					ResultSet rs1=null;
					Calendar calendar=Calendar.getInstance();
					int year=calendar.get(Calendar.YEAR);//或取当前年份
					int month=calendar.get(Calendar.MONTH)+1;
					double total=0;
			try{
				con=DBTools.getConnection();
				ps=con.prepareStatement("select * from transaction where extract(year from date)=? and extract(month from date)=?");
				ps.setInt(1,year);				
				ps.setInt(2,month);		
				
				rs=ps.executeQuery();
				int gain_number=0;
				while(rs.next())
				{
					gain_number++;
					String good_info=rs.getString("goods");
					String[] g=good_info.split("\\|");
					total+=rs.getDouble("actualBalance");
					%>
					
				<tr>
					<td><%=rs.getInt("tranNo") %></td>
					<td>
								<span  onmouseenter="appear(this);"   onmouseout="disappear(this);" >查看<input type="hidden"  value="<%=gain_number%>"></span>
								<div class="goods_info"   id="<%=gain_number%>">
								<table class="table"  style="background-color: #00FF7F;'">
									<thead>
										<tr>
											<th>商品编号</th><th>商品名称</th><th>商品类型</th><th>购买数量</th>
										</tr>
									</thead>
									<tbody>
								<%
								for(int i=0;i<g.length && !g[i].equals("");i++)
								{
									String[] str=g[i].split("\\*");//str[0]是商品编号，str[1]是商品数量
									ps1=con.prepareStatement("select code,name,type from goods where code=?");
									ps1.setString(1, str[0]);
									rs1=ps1.executeQuery();
									if(rs1.next())
									{
										
								 %>
								 <tr>
								 	<td><%=rs1.getString(1) %></td><td><%=rs1.getString(2) %></td><td><%=rs1.getString(3) %></td><td><%=str[1] %></td>
								 </tr>
								 <%
									}
								}
								 %>
									</tbody>						
								</table>
								</div>
								<script type="text/javascript">
									function appear(obj) {
						//				alert(obj.innerText);
									var	child_input=obj.childNodes;
							//			alert(child_input[1].value);
									
									var table_hidden=document.getElementById(""+child_input[1].value);
									table_hidden.style.visibility="visible";
									}
									function disappear(obj) {
									var	child_input=obj.childNodes;
									
									var table_hidden=document.getElementById(""+child_input[1].value);
									table_hidden.style.visibility="hidden";
									}
								
								</script>
								
					
					</td><td><%=rs.getString("source") %></td><td><%=rs.getFloat("discout") %></td>
					<td><%=rs.getDouble("totalBalance") %></td><td><%=rs.getDouble("actualBalance") %></td><td><%=rs.getString("type") %></td>
					<td><%=rs.getString("date") %>
				</tr>
					<%
				}
				
			}catch(Exception e)
			{
				e.printStackTrace();
			}finally{
				DBTools.close(rs);
				DBTools.close(rs1);
				DBTools.close(rs1);
				DBTools.close(ps);
				DBTools.close(con);
			}
				%>
			</tbody>
			</table>
			</div>
			<div class="gain_info">
					<span id="msg"><%=year %>年<%=month %>本月收入总额为：</span>
					<span id="money"><%=total %>元</span>
			</div>	
				<%
			
		}else{
			int year=0;
			int month=0;
			int day=0;
			Connection con=null;
			PreparedStatement ps=null;
			ResultSet rs=null;
			double total=0;
			if(input_month!=null && input_day==null)
			{
				//说明是按照年月来查询的
				String[] arr_month=input_month.split("-");//获取年份和月份
				year=Integer.parseInt(arr_month[0]);
				month=Integer.parseInt(arr_month[1]);
				//根据获取的年份和月份对数据库transaction进行查询
				try{
					con=DBTools.getConnection();
					ps=con.prepareStatement("select * from transaction where extract(year from date)=?  and  extract(month from date)=?");
					ps.setInt(1,year);
					ps.setInt(2,month);
					rs=ps.executeQuery();
					while(rs.next())
					{
						total+=rs.getDouble("actualBalance");
						%>
					<tr>
						<td><%=rs.getInt("tranNo") %></td><td><a>查看</a></td><td><%=rs.getString("source") %></td><td><%=rs.getFloat("discout") %></td>
						<td><%=rs.getDouble("totalBalance") %></td><td><%=rs.getDouble("actualBalance") %></td><td><%=rs.getString("type") %></td>
						<td><%=rs.getString("date") %>
					</tr>
						<%
					}
				}catch(Exception e)
				{
					e.printStackTrace();
				}finally{
					DBTools.close(rs);
					DBTools.close(ps);
					DBTools.close(con);
				}
				%>
			</tbody>
		</table>
		</div>
		<div class="gain_info">
				<span id="msg"><%=year %>年<%=month %>月收入总额为：</span>
				<span id="money"><%=total %>元</span>
		</div>
				<%
			}//if  end
			else{//按年月日来查询；
				String [] arr_day=input_day.split("-");
				
				year=Integer.parseInt(arr_day[0]);
				month=Integer.parseInt(arr_day[1]);
				day=Integer.parseInt(arr_day[2]);
				try{
					con=DBTools.getConnection();
					ps=con.prepareStatement("select * from transaction where extract(year from date)=?  and  extract(month from date)=? and extract(day from date)=?");
					ps.setInt(1,year);
					ps.setInt(2,month);
					ps.setInt(3, day);
					rs=ps.executeQuery();
					while(rs.next())
					{
						total+=rs.getDouble("actualBalance");
						%>
					<tr>
						<td><%=rs.getInt("tranNo") %></td><td><a>查看</a></td><td><%=rs.getString("source") %></td><td><%=rs.getFloat("discout") %></td>
						<td><%=rs.getDouble("totalBalance") %></td><td><%=rs.getDouble("actualBalance") %></td><td><%=rs.getString("type") %></td>
						<td><%=rs.getString("date") %>
					</tr>
						<%
					}
				}catch(Exception e)
				{
					e.printStackTrace();
				}finally{
					DBTools.close(rs);
					DBTools.close(ps);
					DBTools.close(con);
				}
				%>
						</tbody>
		</table>
		</div>
		<div class="gain_info">
				<span><%=year %>年<%=month %>月<%=day %>日收入总额为：</span>
				<span><%=total %>元</span>
		</div>
				
				<%
			}//else end
		}
		%>
	</div>
</body>
</html>