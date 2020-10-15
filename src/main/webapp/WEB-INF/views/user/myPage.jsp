<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>같이투자 | 마이페이지</title>
	<link href="../resources/temporary.css" rel="stylesheet" type="text/css">
	
	<style>
    	.contain{
    		margin: auto;
			margin-top: 100px;
			margin-bottom: 100px;
    	}
    </style>
	
</head>
	<body>
	<jsp:include page="../main/header.jsp"/>
		<c:url value="/modify" var="modify_url" />
		<c:url value="/purchaseDetails" var="purchase_details_url" />
		<div class="wrapper">
			
			<div class="contain">
				
				<h2>-마이페이지-</h2>
				<br><br><br><br>
				
				<button class="button5" onclick="location.href='${open_url}'">계좌 추가하기</button><br>
				<button class="button5" onclick="location.href='${modify_url}'">회원 정보 수정</button><br>
				<button class="button5" onclick="location.href='${purchase_details_url}'">거래 내역</button><br>
			</div>
		</div>
		
		<jsp:include page="../main/footer.jsp"/>
	</body>
</html>