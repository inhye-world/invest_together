<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>유저 정보 수정</title>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script> 
	<link href="resources/user_modify.css" rel="stylesheet" type="text/css">
	
	
</head>
	<body>
	<jsp:include page="../include/header.jsp"/>
		<div class="member-web-adapter member-web-adapter--desktop">
			<div class="member-container">
				<section class="usermodify-auth">
				<sec:authorize access="isAuthenticated()">
				<sec:authentication var="principal" property="principal"/>
				<form:form class="passwordConfirmForm" action="userModify" method="post">
				<h1 class="usermodify-auth-title">회원정보확인</h1>			

				<p class="usermodify-auth-msg">
				<strong class="usermodify-auth-nickname">${principal.dto.nickname}</strong>
				님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인 합니다.
				</p>
				<table class="usermodify-table">
					<tbody>
						<tr>
							<th scope="row">닉네임<th>
							<td>${principal.dto.nickname}</td>
						</tr>
						<tr>
						 	<th scope="row">비밀번호<th>
							<td>
							<input type="password" name="pw" placeholder="비밀번호 (8~32자리)">
							<span class="form-err">${pw_error}</span>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="usermodify-auth-foot">
					<button type="submit" class="usermodify-auth-submit">확인</button>
					<button type="submit" class="usermodify-auth-cancel">취소</button>
				</div>	
				</form:form>				
			</sec:authorize>
			</section>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"/>
		
		<script type="text/javascript">
		
		$(document).ready(function (){
			$(".usermodify-auth-cancel").on("click",function() {
				$(".passwordConfirmForm").attr("action", "${pageContext.request.contextPath}").submit();
			});			
		});
		
		</script>
		
	</body>
</html>