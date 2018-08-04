<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	span{
		font-size: 10px;
		
	}
	.ok{
		font-size: 10px;
		color: green;
	}
	.error{
		font-size: 10px;
		color:yellow;
	}
</style>
<script type="text/javascript">
	function check() {
		
	//获取账号标签
		var id=document.getElementById("code");
		var span=document.getElementById("code_msg");
		if(checkString(id.value))//正确
			{
				//获取账号提示所在的标签
				span.innerHTML="正确";
				span.style.color="green";
				return true;
			}
		else{
			span.innerHTML="格式错误";
			span.style.color="red";
			return false;
		}
	}
	function checkString(a)
	{
		if(a.length<5  ||  a.length>10)
			return false;
		for(var i=0;i<a.length;i++)
			{
			if(isNaN( parseInt(a[i]))  )
				return false;
			}
		return true;
	}
	
	function checkPW(a)
	{
		var regExp = /^[a-z0-9]+$/i;
		if(a.length<5 || a.length>10)
			return false;
		if(!  regExp.test(a))
			return false;
		return true;
		
	}
	function  checkPassWord(){
			var password=document.getElementById("pw");
			var  span2=document.getElementById("password_msg");
		if(checkPW(password.value)  )//输入的密码正确
			{
				span2.className="ok";
			return true;
			}
		else{
		span2.className="error";
		return false;
		}
	}
	
//检测名称输入是否正确
//	var ref1=/^[a-zA-Z]+$/;
	function checkName() {
		var name=document.getElementById("name");
		var span=document.getElementById("name_msg");
		if(name.value.length>15){
			span.className="error";
			return false;
		}
		
		else {
			span.className="od";
			return true;
		}
		
	}
	
</script>
<%
if(session.getAttribute("user")==null)
{
	response.sendRedirect("login.jsp");
}
%>
</head>
<body>
<center>请输入用户信息</center>
		<form action="registerAction.jsp"  method="post"  onsubmit="  return check()+checkPassWord()==2;">
		<table align="center"  cellpadding="10px"   cellspacing="10px">
					<tr>
						<td>账号:</td><td><input  type="text"  name="id"  id="code"  onblur="check();"> </td><td><span  id="code_msg">请输入5-10位的数字</span></td>
					</tr>
					<tr>
						<td>密码:</td><td><input  type="password"  name="password"  id="pw"  onblur="checkPassWord();"> </td><td><span  id="password_msg">请输入5-10位的数字或字母</span>  </td>
					</tr>
					<tr>
						<td>名称:</td><td><input  type="text"  name="name"  id="name"  onblur="checkName();"> </td><td><span id="name_msg">名称</span></td>
					</tr>
					<tr>
						<td>性别:</td> 		<!-- 有待改正！！！ -->
						<td> <label> 男<input  type="radio"  value="男"  name="gender"  id="a1">  </label>  <label></label>女<input  type="radio"  value="男"  name="gender" ></label></td>
					</tr>
					<tr>
						<td>年龄:</td><td><input  type="text"  name="age"> </td>
					</tr>
					<tr>
						<td>权限:</td>
						<td>
							<select  name="right">
								<option selected  disabled>---请选择----	</option>
								<option  value="管理员">管理员	</option>
								<option  value="收银员">收银员</option>
							
							</select>
						</td>
					</tr>
			
					<tr align="center">
						<td colspan="2"> <input  type="submit"    value="提交"  onclick=" document.getElementByID ">   <input  type="reset"   value="重置"></td>
					</tr>
		</table>
	</form>
</body>
</html>