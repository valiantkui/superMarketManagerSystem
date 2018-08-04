<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	body{
	
		margin: 0px;
	}
			ul {
			    list-style-type: none;
			    margin: 0;
			    padding: 0;
			    overflow: hidden;
			    background-color: #333;
			    margin-top: 2px;
			    border-radius: 15px 15px;
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
</style>
</head>
<body>	

<%
if(session.getAttribute("user")==null)
{
	response.sendRedirect("/yk.supermarket.manager.system/login.jsp");
}

%>
<ul>
				<li><a href="finance.jsp" target="finance_main">进货花费</a></li>
				<li><a href="gain.jsp" target="finance_main">入账统计</a></li>
				<li><a href="profit.jsp" target="finance_main">利润统计</a></li>
				<li style="float: right;">
					<input type="text"   id="search">
					<span><a href="search">查询</a></span>
				</li>
			</ul>
</body>
</html>