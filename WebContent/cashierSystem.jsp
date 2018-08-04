<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.xt.kui.cashier.Goods"%>
<%@page import="com.xt.kui.cashier.GoodsTools"%>
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
		<link rel="stylesheet" href="/yk.supermarket.manager.system/css/bootstrap.css" />
		<script type="text/javascript"  src="/yk.supermarket.manager.system/js/bootstrap.js"></script>
		<script type="text/javascript"  src="/yk.supermarket.manager.system/js/jquery.js"></script>
	
		<title>Insert title here</title>
		
		<style type="text/css">
				.content{
						border: 1px solid;
						border-radius:15px  15px;
						margin: 10px 20px;
						height: 620px;
						overflow: auto;
				}
				.na_search{
					border-radius:15px 15px;
					
			}
		/* 		.left{
					width: 48%;
					height: 600px;
					margin: 10px 10px;
					border: 1px solid;
					float: left;
				}
				.right{
					width: 48%;
					height: 600px;
					margin: 10px 10px;
					border: 1px solid;
					float: right;
				} */
				.goodstable{
				
					height: 400px;
				border:1px  solid;
					overflow: auto;
				}
			.total{
				height: 40px;
				line-height: 40px;
				font-size: 30px;
				padding-left: 10px;
			}
			.pay_method{
					height: 40px;
					padding-left:10px;
					padding-top:0px;
					padding-bottom:0px;
					font-size: 30px;
					line-height: 40px;
			}
			.pay_method  button{
					height: 35px;
					padding-top: 0;
					padding-bottom: 0;
					margin-top: 0px;
					margin-bottom: 0px;
				
			}
			.pay_info  table{
				width: 60%;
				height: 80px;
				font-size: 25px;
			}
		</style>
		<script type="text/javascript">
				<%
					String pay_ok=(String)session.getAttribute("pay_ok");
				if(pay_ok!=null)
				{
					
					if(pay_ok.equals("ok"))
					{
						%>
						alert("交易成功！！！");	
						<%
						session.setAttribute("pay_ok", "false");
					}
				}
				
				%>
		
		</script>
</head>
<body>
<%
		if(session.getAttribute("user")==null)
		{
			response.sendRedirect("login.jsp");
		}
	String add_code=request.getParameter("add_code");
	if(add_code!=null)
	{
		GoodsTools gtls=GoodsTools.getGoodsTools();
		Iterator it=gtls.getGoodsList().iterator();
		while(it.hasNext())
		{
			Goods goo=(Goods)it.next();
			if(goo.getCode().equals(add_code))
			{
				//加1
				goo.setNumber(goo.getNumber()+1);
				break;
			}
		}
	}
	
	String d_code=request.getParameter("d_code");
	if(d_code!=null)
	{
		GoodsTools gtls=GoodsTools.getGoodsTools();
		Iterator it=gtls.getGoodsList().iterator();
		while(it.hasNext())
		{
			Goods goo=(Goods)it.next();
			if(goo.getCode().equals(d_code))
			{
				//减1
				goo.setNumber(goo.getNumber()-1);
				break;
			}
		}
	}
	String delete_code=request.getParameter("delete_code");
	if(delete_code!=null)
	{
		GoodsTools gtls=GoodsTools.getGoodsTools();
		Iterator it=gtls.getGoodsList().iterator();
		while(it.hasNext())
		{
			Goods goo=(Goods)it.next();
			if(goo.getCode().equals(delete_code))
			{
				//删除该对象
				it.remove();
				break;
			}
		}
	}
%>
			<div class="content">
			<!-- 主要界面 -->
				<div class="na_search">
					<form action="cashierSystem.jsp" method="post" >
					<div  class="input-group"  style="background-color: #FFF8DC; ">
						<span class="navbar-brand"   style="margin: 0px  80px; ">已购物品</span>
						<input type="text"   class="form-control"  name="search_code"  style="border-radius: 15px 15px 15px 15px;">
						<span class="input-group-btu">
							<input type="submit"  value="提交"  class="btn  btn-default"  style="border-radius: 15px 15px 15px 15px;">
						</span>
					</div>
					</form>
				</div><!-- na_search   end -->
					<!-- 表格界面 -->
					<div class="goodstable">
						<table  class="table" border="0px" >
							<thead >
								<tr>
									<th>商品编号</th><th>商品名称</th><th>单价</th><th>数量</th><th>总价</th><th>操作</th>
								</tr>
							</thead>
							<tbody>
					<%		
					String code=request.getParameter("search_code");
					Connection con=null;
					Statement stat=null;
					ResultSet rs=null;
					List<Goods> goodsList=null;
					Goods good=null;
					//当每次刷新时，gt对象已经变了，所以GoodsTools类应该只能有一个对象
					//待处理
					//GoodsTools类只能有一个实例对象
					GoodsTools gt=GoodsTools.getGoodsTools();
						double totalMoney=0;//合计金额
						double recovedMoney=0;
					try{
					if(code!=null)
					{
						con=DBTools.getConnection();
						stat=con.createStatement();
						rs=stat.executeQuery("select code,name,bid  from goods where code='"+code+"' and is_sell='是'");
						//如果rs为空的话需要进行处理
							if(rs.next()){
									
							 good=new Goods(rs.getString("code"), rs.getString("name"), 1,rs.getDouble("bid"));
								}else{
									//输入的编号不存在或者未上架
									response.sendRedirect("cashierSystem.jsp");
								}
						if(good!=null)
						{
						gt.addGoods(good);
							
						}
					}
						goodsList=gt.getGoodsList();
						Iterator iter=goodsList.iterator();
						while(iter.hasNext())
						{
							Goods g=(Goods)iter.next();
							
							double pri=g.getPrice();
							totalMoney+=pri*g.getNumber();
							%>
								<tr>
									<td><%=g.getCode() %></td><td><%=g.getName() %></td><td><%=g.getPrice() %></td>
									<td>
									<span class="input-group  input-group-sm">
										<a href="cashierSystem.jsp?d_code=<%=g.getCode()%>" class="input-group-addon">-</a>
										<input  type="text"   size="2"  value="<%=g.getNumber()%> " disabled>
										<a href="cashierSystem.jsp?add_code=<%=g.getCode()%>" class="input-group-addon">+</a>
									</span>
									</td>
									<td><%=pri*g.getNumber()%></td><td><a href="cashierSystem.jsp?delete_code=<%=g.getCode()%>">删除</a></td>
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
						
					</div><!-- goodstable 结束 -->
				<div class="total">合计:  <span ><%=totalMoney %></span> <span>元</span>
				</div>
				<div class="pay_method"> 
							<span>付款方式：</span>
							<button type="button" class="btn btn-default"  onclick="cash_event()" onblur="cash_blur()">现金</button>
							<button type="button" class="btn btn-primary" onclick="alipay_event()">支付宝</button>
							<button type="button" class="btn btn-success" onclick="wechat_event()">微信</button>
							<button type="button" class="btn btn-info" onclick="bank_event()">银行卡</button>
							<button type="button" class="btn btn-info" onclick="vip_event()">会员卡</button>
				</div><!--  pay_method 结束-->
				<form action="casierAction.jsp"  method="post">
				<!-- 显示已付金额和找零信息 -->
					<div  class="pay_info"  id="pay_info">
						<!-- <table >
							<tr>
								<td>已付金额：</td><td><span>---------</span>元</td><td colspan="2"><input type="submit"  style="height: 40px;  width: 80px;"   value="找回"></td>
							</tr>
							<tr>
								<td>找回金额：</td><td><span>---------</span>元</td>
							</tr>
						</table> -->
					
					</div>
				</form>
	</div>
	
		<script type="text/javascript">
		//本次先实现现金和会员卡页面事件
				function cash_event(){
						var div_pay=document.getElementById("pay_info");
						div_pay.innerHTML="<div class='cash_html' style='height:80px; font-size:25px; line-height:40px; float:left; '><div><span>已付金额：</span><input type='text'  id='cash_pay' style='height:35px;vertical-align:bottom;' size='4' onblur='cash_blur()'  name='actual_money'><span>元</span></div>"+
															"<div><span>找回金额：</span><span id='recovedMoney'><%=recovedMoney%></span>元<input type='hidden' id='hidden_recoved' name='recoved_money'><input type='hidden' id='type' name='type'></div></div>" +
															"<div style='height:80px; float:left; margin-left: 40px;' ><input type='submit' value='找回' style='height: 70px;  width: 80px; vertical-align:bottom; margin-bottom:0px; border-radius:5px 5px; border-width:0px; font-size:25px;' ></div>";
					<%-- 	
						div_pay.innerHTML="<table id='pay_id'>"+
						"<tr><td>已付金额：</td><td><span><input type='text' id='cash_pay' size='4' onblur='cash_blur()' name='actual_money'></span>元</td><td valign='bottom' colspan='2'><input type='submit'  style='height: 40px;  width: 80px; line-height:40px;'   value='找回'></td></tr>"+
						"<tr>"+
							"<td>找回金额：</td><td><span id='recovedMoney'><%=recovedMoney%></span>元<input type='hidden' id='hidden_recoved' name='recoved_money'><input type='hidden' id='type' name='type'></td>"+
						"</tr>"+
					"</table>"; --%>
					var hidden_type=document.getElementById("type");
					hidden_type.value="现金";
				}
		function cash_blur()
		{
			var input_cash=document.getElementById("cash_pay");
			var span_recoved=document.getElementById("recovedMoney");
			var input_recoved=document.getElementById("hidden_recoved");
			span_recoved.innerHTML=input_cash.value-<%=totalMoney%>;
			input_recoved.value=input_cash.value-<%=totalMoney%>;
		}
		//会员卡按钮点击事件
		function vip_event()
		{
			var div_pay=document.getElementById("pay_info");
			div_pay.innerHTML="<table id='pay_id'>"+
			"<tr><td>已付金额：</td><td><span><input type='text' id='cash_pay' size='4' onblur='cash_blur()' name='actual_money'></span>元</td><td>会员卡号：<input type='text' name='vip_no' size='4'></td></tr>"+
			"<tr>"+
				"<td>找回金额：</td><td><span id='recovedMoney'><%=recovedMoney%></span>元<input type='hidden' id='hidden_recoved' name='recoved_money'><input type='hidden' id='type' name='type'></td><td><input type='submit'  style='height: 40px;  width: 80px; font-size:25px; border-radius:5px 5px; border-width:0px'   value='找回'></td>"+
			"</tr>"+
		"</table>";
		var hidden_type=document.getElementById("type");
		hidden_type.value="会员卡";
		}
		</script>
</body>
</html>