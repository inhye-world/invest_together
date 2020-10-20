<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<% response.setStatus(200); %>
<!DOCTYPE html>
<html lang="ko">
	<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	    <title>같이투자 || 페이지를 찾을 수 없습니다.</title>
	</head>
	
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	
	<link href="${pageContext.request.contextPath}/resources/error.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/backbutton.css">

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
					요청하신 페이지를 찾을 수 없습니다.
				</h3>
				<p>
					방문하시려는 페이지의 주소가 잘못 입력되었거나,
					<br>
					페이지의 주소가 변경 혹은 삭제되어 요청하신 페이지를 찾을 수 없습니다.
				</p>
				<p>입력하신 주소가 정확한지 다시 한번 확인해 주시기 바랍니다.</p>
				<p>관련 문의사항은 같이투자 고객센터에 알려주시면 친절하게 안내해 드리겠습니다.</p>
				<p>감사합니다.</p>
				<button class="back-btn" onclick="location.href='/into'"><span>홈페이지로 돌아가기</span></button>
				</div>
			</div>
		</div>
	</body>
</html>
