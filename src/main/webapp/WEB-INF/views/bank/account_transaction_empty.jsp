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
		<jsp:include page="../include/header_temp.jsp"/>
		
			<div class="container">
				<a class="mainA" href="/into"> 같이투자 API TEST</a>
				<br><br>
				
				<h2>-가계부-</h2>
				<br>
				
				<div class="tran-dropdown">
					<div class="section">
						<div id="sec1">
						</div>
						<div id="sec2">
							▼
						</div>
						<div id="sec3">
							<div id="sec4">
							</div>
						</div>	
					</div>
					<div id="tran-dropdown-content" class="tran-dropdown-content">
					</div>
				</div>
				<br><br><br><br><br><br>
				
				<h2>이번달 내역이 없습니다</h2>
				<br><br><br><br><br><br>
				
				
			</div>	
		</div>
		
		<script>
			$(function() {
				var year = ${year}
				var month = ${month}
				$("#sec1").html("<b>"+month+"</b>월")
				
				var incomeSum = ${incomeSum}
				var expenseSum = ${expenseSum}
				$("#sec4").html("수입 <b>"+incomeSum.toLocaleString()+"</b>원<br>"
								+"지출 <b>"+expenseSum.toLocaleString()+"</b>원");
				
				function numberPad(n, width) {
				    n = n + '';
				    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
				}	
				
				var date = new Date();
				var y = date.getFullYear();
				var m = date.getMonth()+1;
				
				while(y>2010) {
					while(m>0) {
						var a = $("<a></a>");
						a.attr("href", "accountTransaction-"+y+"-"+numberPad(m, 2));
						a.text(y+"년 "+m+"월");
						if(y==year && m==month) {
							a.css("background-color", "#808080")	
						}
						
						$("#tran-dropdown-content").append(a);
						--m;
					}
					--y;
					m=12;
				}
			});
		</script>
	</body>
</html>