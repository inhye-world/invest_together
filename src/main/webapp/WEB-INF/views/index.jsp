<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
</head>
	<body>
		<div class="wrapper">
			<jsp:include page="include/header.jsp"/>
			
			<div class="container">
				<a class="mainA" href="/into"> 같이투자 API TEST</a>
				<br><br>

				<h2>-Main-${test}</h2>
				<br><br><br><br>
	
				<button class="button5" onclick="location.href='#'">자산</button><br>
				<button class="button5" onclick="location.href='#'">가계부</button><br>
				<button class="button5" onclick="location.href='#'">주식/채권</button><br>
			</div>
		</div>
	</body>
</html>
