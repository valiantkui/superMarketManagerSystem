<%@page import="java.sql.Connection"%>
<%@page import="yk.supermarket.manager.system.DBTools"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
		center{
			font-size: 60px;
			margin-bottom: 40px;
		}
		
	table {
		}
}
</style>
<script type="text/javascript">
		function check_id(){
			var reg=/^[0-9]+$/;
			var input_id=document.getElementById("id");
			console.log( input_id.value.length);
			if(reg.test(input_id.value) && input_id.value.length>5  && input_id.value.length<10)
				{
					var span_id= document.getElementById("id_msg");
					span_id.innerHTML="格式正确";
					span_id.style.color="gray";
					return true;
				}
			else{
					var span_id= document.getElementById("id_msg");
					span_id.innerHTML="格式错误";
					span_id.style.color="red";
					return false;
			}
		}
		function check_name()
		{
			var input_name=document.getElementById("name");
			if(input_name.value.length<10 && input_name.value.length>0)
				{
					var span_name=document.getElementById("name_msg");
					span_name.innerHTML="格式正确";
					span_name.style.color="gray";
					return true;
				}
			else{
				var span_name=document.getElementById("name_msg");
				span_name.innerHTML="长度错误";
				span_name.style.color="red";
				return false;
			}
		}
		function check_number(){
			var reg=/^[0-9]+$/;
			var input_number=document.getElementById("number");
			var input_spend=document.getElementById("spend");
			var input_inprice=document.getElementById("in_price");
			input_spend.value=input_number.value*input_inprice.value;
			if(reg.test(input_number.value) )
				{
				var span_number=document.getElementById("number_msg");
				span_number.innerHTML="格式正确";
				span_number.style.color="gray";
				return true;
				}
			else{
				var span_number=document.getElementById("number_msg");
				span_number.innerHTML="格式错误";
				span_number.style.color="red";
				return false;
			}
		}
		function check_outprice()
		{
			var reg=/^[0-9]+.?[0-9]*$/;
			var input_price=document.getElementById("out_price");
			if(reg.test(input_price.value))
				{
					var span_price=document.getElementById("outprice_msg");
					span_price.innerHTML="格式正确";
					span_price.style.color="gray";
					return true;
				}
			else{
				var span_price=document.getElementById("outprice_msg");
				span_price.innerHTML="格式错误";
				span_price.style.color="red";
				return false;
			}
		}
		function check_inprice()
		{
			var reg=/^[0-9]+.?[0-9]*$/;
			var input_price=document.getElementById("in_price");
			var input_spend=document.getElementById("spend");
			var input_number=document.getElementById("number");
			input_spend.value=input_number.value*input_price.value;
			if(reg.test(input_price.value))
				{
					var span_price=document.getElementById("inprice_msg");
					span_price.innerHTML="格式正确";
					span_price.style.color="gray";
					return true;
				}
			else{
				var span_price=document.getElementById("inprice_msg");
				span_price.innerHTML="格式错误";
				span_price.style.color="red";
				return false;
			}
		}
		function  check_isSell()
		{
			var input_isSell=document.getElementById("isSell");
			var span_isSell=document.getElementById("isSell_msg");
			if(input_isSell.value==="是"  ||  input_isSell.value==="否" )
				{
				span_isSell.innerHTML="格式正确";
				span_isSell.style.color="gray";
				return true;
				}
			else{
				span_isSell.innerHTML="格式错误";
				span_isSell.style.color="red";
				return false;
			}
		}
		function check_spend()
		{
			var reg=/^[0-9]+.?[0-9]*$/;
			var input_spend=document.getElementById("spend");
			var span_spend=document.getElementById("spend_msg");
			if(reg.test(input_spend.value) )
				{
				span_spend.innerHTML="格式正确";
				span_spend.style.color="gray";
				return true;
				}
			else{
				span_spend.innerHTML="格式错误";
				span_spend.style.color="red";
				return false;
			}
		}
</script>
</head>
<body>
<%
if(session.getAttribute("user")==null)
{
	response.sendRedirect("/yk.supermarket.manager.system/login.jsp");
}

%>
	<!-- 商品入库页面 -->
	<center>请输入要入库的商品信息</center>
	<form action="addGoodsAction.jsp"  method="post"  onsubmit=" return (check_id()+check_name()+check_number()+check_inprice()+check_isSell()+check_spend()+check_outprice())===7">
		<table align="center"  cellpadding="10px"   cellspacing="10px"  border="0px">
					<tr>
						<td>编号:</td><td><input  type="text"  name="id"  id="id"  onblur="check_id()"><span id="id_msg"></span> </td>
					</tr>
					<tr>
						<td>名称:</td><td><input  type="text"  name="name"  id="name" onblur="check_name()"><span id="name_msg"></span> </td>
					</tr>
					<tr>
						<td>类型:</td> 
						<td>
							<select  name="type">
								<option  selected  disabled>---请选择----</option>
								<option  value="服装箱包">服装箱包</option>
								<option value="食品">食品</option>
								<option value="生活用品">生活用品</option>
								<option value="手机数码">手机数码</option>
								<option value="图书乐器">图书乐器</option>
								<option value="家具家纺">家具家纺</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>数量:</td><td><input  type="text"  name="number" id="number"  onblur="check_number()"> <span id="number_msg"></span></td>
					</tr>
					<tr>
						<td>进入单价:</td><td><input  type="text"  name="in_price" id="in_price"  onblur="check_inprice()"><span id="inprice_msg"></span></td>					
					</tr>
					<tr>
						<td>出售单价:</td><td><input  type="text"  name="out_price" id="out_price"  onblur="check_outprice()"><span id="outprice_msg"></span></td>
					</tr>
					<tr>
						<td>是否上架:</td><td><input  type="text"  name="isSell" value="否"  id="isSell"  onblur="check_isSell()"><span id="isSell_msg">请输入是/否</span> </td>
					</tr>
					<tr>
						<td>花费金额</td><td><input type="text"  id="spend" name="spend"  onblur="check_spend()"> <span id="spend_msg"></span></td>
					</tr>
					<tr align="center">
						<td colspan="2"> <input  type="submit"    value="提交"  >   <input  type="reset"   value="重置"></td>
					</tr>
		</table>
	</form>
</body>
</html>