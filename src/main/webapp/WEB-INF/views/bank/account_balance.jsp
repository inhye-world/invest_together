<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
	<body>
		
		<div class="wrapper">
		<jsp:include page="../include/header2.jsp"/>
			
			<div class="container">
				
				
				<div class="section">
					<div id="sec5">
						<div id="sec6">
							총 자산
						</div>
						<div id="sec7">
						</div>
					</div>
				</div>
				<br><br><br>
				
				<c:forEach var="account" items="${accountBalanceList}" varStatus="status">
					<div class="balance">
						<span>${account.accountDTO.bank_name} | ${account.product_name}</span>
						<span class="bal2" id="bal-${status.index}"></span>
					</div>
					
					<script>
						var balance_amt = ${account.balance_amt}
						$("#bal-"+${status.index}).text(balance_amt.toLocaleString()+"원");
					</script>
				</c:forEach>
			</div>
			<jsp:include page="../include/footer2.jsp"/>	
		</div>
		
		<script>
			var balanceSum = ${balanceSum}
			$("#sec7").text(balanceSum.toLocaleString()+"원");
		</script>
	</body>
</html>