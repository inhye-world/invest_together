<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
	<body>
		<div class="wrapper">
			<jsp:include page="include/header.jsp"/>
			
			<div class="container">
				<a class="mainA" href="/into"> 같이투자 API TEST</a>
				<br><br>

				<h2>-Main-</h2>
				<br><br><br><br>
	
				<button class="button5" onclick="location.href='accountBalance'">자산</button><br>
				<button id="accountTransaction" class="button5">가계부</button><br>
				<button class="button5" onclick="location.href='stockBondTable'">주식/채권</button><br>
				<button class="button5" onclick="location.href='bond'">채권</button><br>
			</div>
		</div>
		
		<script>
			function numberPad(n, width) {
			    n = n + '';
			    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
			}	
		
			var date = new Date();
			var year = date.getFullYear();
			var month = numberPad((date.getMonth()+1), 2);
			
			$(function() {
				$("#accountTransaction").attr("onclick", "location.href='accountTransaction-"+year+"-"+month+"'");
			});
		</script>
	</body>
</html>
