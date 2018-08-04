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
  <li><a class="active" href=index.jsp>主页</a></li>
  <li><a href="cashierSystem.jsp"  target="iframe_content">收银系统</a></li>
  <div class="dropdown">
    <a href="#" class="dropbtn">商品管理</a>
    <div class="dropdown-content">
      <a href="/yk.supermarket.manager.system/goods/goodsStore.jsp"  target="iframe">商品入库</a>
      <a href="/yk.supermarket.manager.system/goods/goods.jsp" target="iframe_content">商品信息管理</a>
    </div>
  </div>
	<li>    <a href="finance/index.html" class="dropbtn"  target="iframe_content">财务统计</a></li>
  <li ><a href="vipManager/vipManager.jsp" target="iframe_content">会员管理</a></li>
  <li style="float: right"><a href="#"  style="color: red;" >退出</a></li>
  <li  style=" float: right; line-height:52.4px; margin-right: 30px;"><span><%=info %></span><span id="time"></span></li>
</ul>
<iframe  style="margin: 0px;" width="100%"  name="iframe"  height="720px"  src="user.jsp"  scrolling="auto"/>
</body>
</html>