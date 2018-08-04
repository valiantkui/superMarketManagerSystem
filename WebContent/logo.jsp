<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
			ul {
			    list-style-type: none;
			    margin: 0;
			    padding: 0;
			    overflow: hidden;
			    background-color: #333;
			    margin-top: 2px;
			    border-radius: 10px 10px;
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
			body{
				margin-bottom: 0px;
				margin-top: 0px;
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
} %>

<%

	String name=(String)session.getAttribute("user");
String info="";
		if(name!=null)
		{
			info+=name+"已登陆";
		}
		else{
			info="未登录";
		}
%>
<ul>
  <li><a class="active" href="index.jsp"  target="main_index">主页</a></li>
  <li><a href="cashierSystem.jsp"  target="right">收银系统</a></li>
 <li><a href="goods/goods.jsp" target="right">商品管理</a></li>
  <li ><a href="vipManager/vipManager.jsp" target="right">会员管理</a></li>
	<li>    <a href="finance/index.html"  target="right">财务统计</a></li>
  <li style="float: right"><a href="quitAction.jsp"  style="color: red;" target="index">[退出]</a></li>
  <li  style=" float: right; line-height:52.4px; margin-right: 30px; color: white;"><span><%=info %></span><span id="time"></span></li>
</ul>
</body>
</html>
 <!--  <div class="dropdown">
    <a href="#" class="dropbtn">会员管理</a>
    <div class="dropdown-content">
      <a href="#">链接 1</a>
      <a href="#">链接 2</a>
      <a href="#">链接 3</a>
    </div>
  </div> -->