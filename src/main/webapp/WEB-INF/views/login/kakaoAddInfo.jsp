<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<link href="resources/temporary.css" rel="stylesheet" type="text/css">
</head>
	<body>
		<div class="wrapper">
			<div class="container nicknameForm">
				<a class="mainA" href="/into"> 같이투자 API TEST</a>
				<br><br><br><br>
				
				<form:form action="addKakaoUser" method="POST">
					<input type="hidden" name="id" value="${dto.id}" />
					<input type="hidden" name="email" value="${dto.email}" />
					<input type="hidden" name="name" value="${dto.name}" />
					<input type="hidden" name="sns_type" value="${dto.sns_type}" />
					<input type="hidden" name="sns_token" value="${dto.sns_token}" />
					<h2>닉네임을 입력해주세요</h2>
					<br><br><br><br>
					<input type="text" name="nickname" />
					<input type="submit" value="확인" />
				</form:form>
			</div>
		</div>
		
	</body>
</html>