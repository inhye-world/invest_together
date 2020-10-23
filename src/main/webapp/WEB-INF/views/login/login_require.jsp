<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">

	<title>같이투자 | 로그인 후 이용 가능합니다</title>
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
	<style>
	   	.wrapper{
	   		margin: 10% 0;
	   	}
    </style>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
		<div class="wrapper">
			<div class="loginContainer">
				<h2 style="text-align:center;">로그인 후 이용 가능합니다 </h2>
			</div>
		</div>
		<jsp:include page="../main/footer.jsp"/>
</body>
</html>