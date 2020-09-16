<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
	<body>
		<div class="wrapper">
		<jsp:include page="../include/header.jsp"/>
		
			<div class="container">
				<a class="mainA" href="/into"> 같이투자 API TEST</a>
				<br><br>
				
				<h2>-가계부-</h2>
				<br>
				
				<div class="section">
					<div id="sec1">
					</div>
					<div id="sec2">
						>
					</div>
					<div id="sec3">
						<div id="sec4">
						</div>
					</div>	
				</div>
				<br><br><br><br><br><br>
				
				<h2>이번달 내역이 없습니다</h2>
				<br><br><br><br><br><br>
				
				
			</div>	
		</div>
		
		<script>
			$(function() {
				var month = ${month}
				$("#sec1").html("<b>"+month+"</b>월")
				
				var incomeSum = ${incomeSum}
				var expenseSum = ${expenseSum}
				$("#sec4").html("수입 <b>"+incomeSum.toLocaleString()+"</b>원<br>"
								+"지출 <b>"+expenseSum.toLocaleString()+"</b>원");
			});
		</script>
	</body>
</html>