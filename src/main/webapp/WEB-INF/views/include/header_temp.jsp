<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>

	<link href="resources/temporary.css" rel="stylesheet" type="text/css">
	
</head>
	<body>
		<div id="header">
			<sec:authorize access="isAnonymous()">
				<c:url value="/loginForm" var="loginForm" />
				<button class="button4" onclick="location.href='${loginForm}'">로그인</button>
			</sec:authorize>
			
			<sec:authorize access="isAuthenticated()">
				<sec:authentication var="principal" property="principal"/>
				<div>
					<p>${principal.dto.name} 님 &nbsp;</p>
				</div>
				
				<div> 
					<button class="button4" onclick="location.href='/into/user/myPage'">마이페이지</button>
				</div>
				
				<form:form action="${pageContext.request.contextPath}/logout" method="POST">
				<div> 
				    <input class="button4" type="submit" value="로그아웃" />
				</div>      
				</form:form>
				
			</sec:authorize>
		</div>
	</body>
</html>