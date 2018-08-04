<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<style type="text/css">
		.navi_bar{
			height: 50px;
			background-color: #333;
			border-radius: 15px 15px;
		color: white;
		
		
		}
		.cashier{
			height: 640px;
			padding: 0px;
			border: 1px solid;
			border-radius: 15px 15px;
			float: right;
		}
		.navi_bar  .title{
			text-align: center;
			margin-left:50px;
			font-size:30px;
			line-height: 50px;
			text-shadow: 5px 5px 5px #FF0000;
		
		}
		
	
	.navi_bar div{
			float: right;
			line-height: 50px;
			margin-right: 20px;
	}
	.navi_bar  a{
		color: red;
		
	}
	</style>
<script type="text/javascript">
		window.onload=function(){
			var b_time=document.getElementById("time");
			var id=setInterval(function() {
				var t=new Date();
				var now_date=t.toLocaleDateString();
				var now_time=t.toLocaleTimeString();
				b_time.innerHTML=now_date+"  "+now_time;
			},1000);
		};
</script>
</head>
<body>
<%
if(session.getAttribute("user")==null)
{
	response.sendRedirect("login.jsp");
}

	String name=(String)session.getAttribute("user");
String info="";
		if(name!=null && !name.equals(""))
		{
			info+=name+"已登陆";
		}
		else{
			info="未登录";
		}
%>
	<div class="navi_bar" >
		<span class="title" >收银系统</span>
		<div>
			<span><%=info %></span><span id="time"></span><span><a href="quitAction.jsp">[退出]</a></span>
		</div>
	</div>
	<iframe src="self_info.jsp"  width="25%"  style="float: left; padding: 0px;margin: 0px;" height="800px;"></iframe><iframe  src="cashierSystem.jsp"   height="620px"  width="73%"  class="cashier"></iframe>

</body>
</html>