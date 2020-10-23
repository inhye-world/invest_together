<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<% response.setStatus(200); %>
<!DOCTYPE html>
<html lang="ko">
	<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	    <title>같이투자 || 에러가 발생했습니다.</title>
	</head>
	
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	
	<link href="${pageContext.request.contextPath}/resources/error.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/backbutton.css">
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">

	<body>
		<div class="wrapper">
			<div class="contain col-xl-5 col-lg-5">
				<div>
				<header>
					<img src="${pageContext.request.contextPath}/resources/main/assets/img/error.png">
				</header>

				<h3>
					죄송합니다.
					<br>
					서비스 처리 과정에서 에러가 발생했습니다.
				</h3>
				<p>조속한 시일 내로 문제를 해결하겠습니다.</p>
				<p>감사합니다.</p>
				<button class="back-btn" onclick="location.href='/into'"><span>홈페이지로 돌아가기</span></button>
				</div>
			</div>
		</div>
	</body>
</html>
