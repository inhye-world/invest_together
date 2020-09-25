<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<link href="../resources/temporary.css" rel="stylesheet" type="text/css">
</head>
	<body>
		<div class="wrapper">
			<jsp:include page="../include/header.jsp"/>
			
			<div class="container">
				<a class="mainA" href="/into"> 같이투자 API TEST</a>
				<br><br>
				
				<h2>-회원정보수정-</h2>
				<br><br><br><br>
				
				<sec:authorize access="isAuthenticated()">
				<sec:authentication var="principal" property="principal"/>
				<div>
					<p>${principal.dto.nickname} 님 &nbsp;</p>
				</div>
				
				<form:form class="form" action="userModify" method="POST">
					<input type="password" name ="pw" placeholder="비밀번호 (8~32자리)">
					<input id="regi-submit" class="button5" type="submit" value="확인">
				</form:form>		
						
			</sec:authorize>
			</div>
		</div>
	</body>
</html>