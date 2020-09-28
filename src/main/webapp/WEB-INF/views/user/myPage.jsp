<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<link href="../resources/temporary.css" rel="stylesheet" type="text/css">
</head>
	<body>
		<c:url value="/modify" var="modify_url" />
		<div class="wrapper">
			<jsp:include page="../include/header_temp.jsp"/>
			
			<div class="container">
				<a class="mainA" href="/into"> 같이투자 API TEST</a>
				<br><br>
				
				<h2>-마이페이지-</h2>
				<br><br><br><br>
				
				<button class="button5" onclick="location.href='${open_url}'">계좌 추가하기</button><br>
				<button class="button5" onclick="location.href='${modify_url}'">회원 정보 수정</button><br>
			</div>
		</div>
	</body>
</html>