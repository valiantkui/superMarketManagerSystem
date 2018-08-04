<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
		function  check_cardNo()
		{
			var input_cardNo=document.getElementById("cardNo");
			var span_cardNo=document.getElementById("cardNo_msg");
			var reg=/^[0-9]+$/;
			if(reg.test(input_cardNo.value)  && input_cardNo.value.length>=9  && input_cardNo.value.length<=15)
			{
				span_cardNo.innerHTML="格式正确";
				span_cardNo.style.color="gray";
				return true;
			}
			else
			{
				span_cardNo.innerHTML="格式错误";
				span_cardNo.style.color="red";
				return false;
			}
		}
		function  check_name()
		{
			var input_name=document.getElementById("name");
			var span_name=document.getElementById("name_msg");
			if( input_name.value.length<15 &&  input_name.value.length>0)
				{
				span_name.innerHTML="格式正确";
				span_name.style.color="gray";
				return true;
				}
			else{
				span_name.innerHTML="格式错误";
				span_name.style.color="red";
				return false;
			}
		}
		function  check_tel()
		{
			var input_tel=document.getElementById("tel");
			var span_tel=document.getElementById("tel_msg");
			if( input_tel.value.length==11)
				{
				span_tel.innerHTML="格式正确";
				span_tel.style.color="gray";
				return true;
				}
			else{
				span_tel.innerHTML="格式错误";
				span_tel.style.color="red";
				return false;
			}
		}
		function  check_amount()
		{
			var input_amount=document.getElementById("amount");
			var span_amount=document.getElementById("amount_msg");
			var input_rank=document.getElementById("rank");
			var input_hidden=document.getElementById("rank_hidden");
			var reg=/^[0-9]+.?[0-9]*$/;
			if( reg.test(input_amount.value))
				{
				span_amount.innerHTML="格式正确";
				span_amount.style.color="gray";
				
				var amount=parseFloat(input_amount.value);
					if( amount>10000)
						{
						input_rank.value=9.0;
						input_hidden.value=9.0;
						return true;
						}
					else{
						var rank=(amount-(amount%1000))/1000;
						input_rank.value=10-rank/10;
						input_hidden.value=10-rank/10;
						return true;
					}
				}
			else{
				span_amount.innerHTML="格式错误";
				span_amount.style.color="red";
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
		<center>欢迎注册会员</center>
		<form  action="vipRegisterAction.jsp"   method="post"  onsubmit=" return (check_cardNo()+check_name()+check_tel()+check_amount())==4">
		<table  cellpadding="10px"   cellspacing="20px" align="center">
			<tr>
					<td>卡号:</td><td><input  type="text"  name="cardNo"  id="cardNo"  onblur="check_cardNo()"></td><td  width="100px"><span  id="cardNo_msg">  </span></td>
			</tr>
				<tr>
					<td>姓名:</td><td><input  type="text"  name="name"  id="name"  onblur="check_name()"></td><td><span id="name_msg"></span></td>
			</tr>
			<tr>
					<td>电话:</td><td><input  type="text"  name="tel"  id="tel"  onblur="check_tel()"></td><td><span id="tel_msg"></span></td>
			</tr>
			<tr>
					<td>消费金额:</td><td><input  type="text"  name="amount"  id="amount"  onblur="check_amount()"></td><td><span  id="amount_msg"></span></td>
			</tr>
			<tr>
					<input  type="hidden"  name="rank"  id="rank_hidden">
					<td>级别:</td><td><input  type="text"   id="rank" disabled></td><td><span id="rank_msg"></span></td>
			</tr>
			<tr align="center">
					<td colspan="3"><input  type="submit"   value="提交"><input type="reset"   value="重置"></td>
			</tr>
		</form>
		</table>
</body>
</html>