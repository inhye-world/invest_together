<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>결제 완료</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<link href="resources/sub.css" rel="stylesheet" type="text/css">
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
</head>
	<body>
		<jsp:include page="../include/header.jsp"/>
		
		<div class="payment-complete container mt-4 mb-4 px-0">
			<div class="payment-complete-container">
				<h2>결제 완료</h2>
				<hr>
				<br>
				<h4>다음 구독의 구입이 완료되었습니다.</h4>
				<div class="payment-complete-wrap">
					<div>
						구독명칭:<br>
						구독번호:<br>
						구매일:<br>
						구독 기간:<br>
						가격:<br>
					</div>
					<div>
						&nbsp;같이투자 개인 멤버십<br>
						&nbsp;${dto.merchant_uid}<br>
						&nbsp;<fmt:formatDate value="${dto.sub_date}" pattern="yyyy-MM-dd"/><br>
						&nbsp;1개월<br>
						&nbsp;<fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.sub_price}"/>원
					</div>
				</div>
				<h4>결제내역 확인은 마이페이지의 "결제내역조회"에서 하실 수 있습니다.</h4>
				<div class="payment-complete-btn">
					<button onclick="location.href='/into'">확인</button>
				</div>
			</div>
		</div>
		
		<jsp:include page="../include/footer.jsp"/>
	</body>
</html>