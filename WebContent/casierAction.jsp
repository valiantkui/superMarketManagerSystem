<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.xt.kui.exception.NotEnoughNumberException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="yk.supermarket.manager.system.DBTools"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.xt.kui.cashier.Goods"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.xt.kui.cashier.GoodsTools"%>
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
	response.sendRedirect("login.jsp");
}
	//获取cashierSystem界面提交的信息
	//接下来将对数据库进行操作
	request.setCharacterEncoding("utf-8");
	double actual_money= Double.parseDouble(request.getParameter("actual_money"));
	//vip_no有可能为空，等会做进一步判断处理
	String vip_no=request.getParameter("vip_no");
	double recoved_money=Double.parseDouble(request.getParameter("recoved_money"));
	String type=request.getParameter("type");
	GoodsTools gt=GoodsTools.getGoodsTools();
	List<Goods> goodsList=gt.getGoodsList();
	Iterator iter=goodsList.iterator();
	String goods="";
	Connection con=null;
	PreparedStatement ps=null;
	PreparedStatement ps1=null;
	ResultSet rs=null;
	ResultSet rs1=null;
	try{
		con=DBTools.getConnection();
		while(iter.hasNext())
		{
			Goods good=(Goods)iter.next();
			goods+=good.getCode()+"*"+good.getNumber()+"|";
			ps=con.prepareStatement("select number from goods where code=?");
			ps.setString(1, good.getCode());
			rs=ps.executeQuery();
			int num=0;//库存的量
			while(rs.next())
			{
				num=rs.getInt(1);
			}
			if(good.getNumber()>num)	throw new NotEnoughNumberException("没有足够的库存");
			else if(num==good.getNumber()){//如果库存减为零则将该商品下架
				ps=con.prepareStatement("update goods set isSell='否' where code=?");
				ps.setString(1, good.getCode());
				ps.executeUpdate();
				System.out.println("库存为0的记录已下架");
			}
			else{
				ps=con.prepareStatement("update goods set number=? where code=?");
				ps.setInt(1, num-good.getNumber());
				ps.setString(2,good.getCode());
				ps.executeUpdate();
				System.out.println("库存已经更新");
			}
		}//while  end 
		//向交易记录里添加记录
		if(type.equals("会员卡"))
		{
			float discount=10.0f;
			//先检查会员卡的有效性并获取会员卡的折扣信息
			ps1=con.prepareStatement("select amount from vip_consumer where cardNo=?");
			ps1.setString(1, vip_no);
			rs1=ps1.executeQuery();
			if(rs1.next())
			{
				//代表有会员信息
				discount=rs1.getFloat("amount");
				System.out.println("当前用户的折扣为："+discount);
			}
			
		ps=con.prepareStatement("insert into transaction(goods,source,discout,actualBalance,date,type,totalBalance)  values(?,?,?,?,?,?,?)");
		ps.setString(1, goods);
		ps.setString(2, vip_no);
		ps.setFloat(3,discount);
		ps.setDouble(4, (actual_money-recoved_money)*discount/10);
		java.util.Date date1=new java.util.Date();
		java.sql.Date date2=new java.sql.Date(date1.getTime());
		ps.setDate(5,date2);
		ps.setString(6, type);
		ps.setDouble(7, actual_money-recoved_money);
		ps.executeUpdate();
		gt.clearGoods();//清空当前已购买商品信息；
		session.setAttribute("pay_ok", "ok");
		response.sendRedirect("cashierSystem.jsp");
			
		}
		if(type.equals("现金"))
		{
			float discount=10.0f;
			ps=con.prepareStatement("insert into transaction(goods,actualBalance,date,type,totalBalance)  values(?,?,now(),?,?)");
			ps.setString(1, goods);
			ps.setDouble(2,(actual_money-recoved_money)*discount/10);
		//	SimpleDateFormat formatt = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date date1=new java.util.Date();
			java.sql.Date date2=new java.sql.Date(date1.getTime());
			ps.setString(3, type);
			ps.setDouble(4, actual_money-recoved_money);
			ps.executeUpdate();
			System.out.println("采用现金方式付款的记录已经保存到交易记录数据库");
			gt.clearGoods();
			session.setAttribute("pay_ok", "ok");
			response.sendRedirect("cashierSystem.jsp");
		}
		
	}catch(SQLException e)
	{
		e.printStackTrace();
	}
	catch(Exception e )
	{
		e.printStackTrace();
	}finally{
		DBTools.close(rs);	
		DBTools.close(ps);	
		DBTools.close(con);	
	}
%>

</body>
</html>