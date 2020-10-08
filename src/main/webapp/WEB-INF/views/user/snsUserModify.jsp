<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
	<title>유저 정보 수정</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script> 
	<link href="resources/user_modify.css" rel="stylesheet" type="text/css">
	
	<!-- ajax사용 위해 csrf설정 -->
  	<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
  	<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
	
</head>
	<body>
	<jsp:include page="../include/header.jsp"/>
		<div class="member-container page-modify">			
			<h1 class="usermodify-title">회원정보 수정</h1>
			<table class="usermodify-table">
				<sec:authorize access="isAuthenticated()">
				<sec:authentication var="principal" property="principal"/>
				<tr>
					<th scope="row">아이디</th>
					<td>
						<div class="usermodify-id">
							<strong> 
							<c:if test="${principal.dto.sns_type eq 'kakao'}">카카오 계정</c:if>
							<c:if test="${principal.dto.sns_type eq 'naver'}">네이버 계정</c:if>
							</strong>
						</div>	
					</td>
				</tr>
				<br>
				<tr>
					<th scope="row">닉네임</th>
					<td>
						<div class="usermodify-nickname">
							<strong class="usermodify-nickname-current-mail">${principal.dto.nickname}</strong>
							<button type="button" class="usermodify-nickname-change-btn" style="display: inline-block;">닉네임 변경</button>
							<button type="button" class="usermodify-nickname-change-cancel" style="display: none;">닉네임 변경취소</button>
						<form:form  class="usermodify-nickname-change-auth" action="alterNickname" method="post" style="display: none;">
							<input class="usermodify-nickname-if" type="text" name="nickname" placeholder="닉네임 입력">
							<button type="submit" class="usermodify-nickname-change-auth-send">변경</button>
						</form:form>
						</div>	
					</td>
				</tr>
				<br>
				<tr>
					<th scope="row">휴대폰 번호</th>
					<td>
						<div class="usermodify-phone">
							<strong class="usermodify-phone-current-mail">${principal.dto.phone}</strong>
							<button type="button" class="usermodify-phone-change-btn" style="display: inline-block;">휴대폰 번호 변경</button>
							<button type="button" class="usermodify-phone-change-cancel" style="display: none;">휴대폰 번호 변경취소</button>
						<form:form class="usermodify-phone-change-auth" action="alterPhone" method="post" style="display: none;">
							<input class="usermodify-phone-if" type="text" name="phone" maxlength="11" placeholder="휴대폰 번호 입력">
							<button type="submit" class="usermodify-phone-change-auth-send">변경</button>		
						</form:form>
						</div>	
					</td>
				</tr>
				<br>
				<tr>
					<th scope="row">이름</th>
					<td>
						<div class="usermodify-name">
							<strong>${principal.dto.name}</strong>	
						</div>	
					</td>
				</tr>
				<br>
				<tr>
					<th scope="row">이메일</th>
					<td>
						<div class="usermodify-email">
							<strong>${principal.dto.email}</strong>
						</div>	
					</td>
				</tr>
				<br>	
			</sec:authorize>
			</table>
			<div class="usermodify-secession">
				 탈퇴를 원하시면 우측의 회원탈퇴 버튼을 눌러주세요.
				<a class="usermodify-secession-btn">회원탈퇴</a>
			</div>
			<div class="usermodify-foot">
				<button onclick = "location.href = ${pageContext.request.contextPath}/"  type="button" class="usermodify-cancel">나가기</button>
			</div>
		</div>
		<script>
			
			$(document).ready(function (){
								
				$.validator.addMethod("nicknameRegex", function(value, element) {
					return this.optional(element) || value.match(/^[가-힣a-zA-Z0-9]+$/);   
				});
				
				$(".usermodify-nickname-change-auth").validate({
					//규칙
					rules:{
						nickname:{
							required : true, //필수입력여부
							minlength : 2,	//최소 입력 글자수
							maxlength : 8,	//최대 입력 글자수
							nicknameRegex : true,
							remote:{
								type:"post",
								url:"checkNickname"
							},
						},
					},

					//메시지
					messages:{
						nickname:{
							required : "닉네임을 입력해주세요.",
							minlength : "최소 2글자 이상 입력해주세요.",	
							maxlength : "최대 8글자까지 입력가능합니다.",
							nicknameRegex : "한글,영문,숫자만 입력가능합니다.",
							remote :  "중복된 닉네임 입니다."
						},
					},

					//메시지 태그
					errorElement : 'span', 	//태그
					errorClass: 'error',	//클래스 이름
					validClass:'vaild' 
				});
				
				$.validator.addMethod("phoneRegex", function(value, element) {
					return this.optional(element) || value.match(/^01(?:0|1|[6-9])(?:\d{4})\d{4}$/);   
				});
				
				$(".usermodify-phone-change-auth").validate({
					//규칙
					rules:{
						phone:{
							required : true, //필수입력여부
							phoneRegex : true,
							remote:{
								type:"post",
								url:"checkPhone"
							},
						},
					},

					//메시지
					messages:{
						phone:{
							required : "핸드폰번호를 입력해주세요.",
							phoneRegex : "형식에 맞지 않습니다.",
							remote :  "중복된 핸드폰 번호입니다."
						},
					},

					//메시지 태그
					errorElement : 'span', 	//태그
					errorClass: 'error',	//클래스 이름
					validClass:'vaild' 
				});
				
			});	
		
		    //ajax csrf
		    $(document).ready(function(){
			    var token = $("meta[name='_csrf']").attr("content");
			    var header = $("meta[name='_csrf_header']").attr("content");
			    $(document).ajaxSend(function(e, xhr, options) {
			        xhr.setRequestHeader(header, token);
			    });
			});
			
			
			$(document).ready(function (){
				
				//nickname버튼
				$(".usermodify-nickname-change-btn").on("click", function() {
					$(".usermodify-nickname-change-btn").attr({"style":"display:none"});
					$(".usermodify-nickname-change-cancel").attr({"style":"display:inline-block"});
					$(".usermodify-nickname-change-auth").attr({"style":"display:block"});
				});
				
				$(".usermodify-nickname-change-cancel").on("click", function() {
					$(".usermodify-nickname-change-btn").attr({"style":"display:inline-block"});
					$(".usermodify-nickname-change-cancel").attr({"style":"display:none"});
					$(".usermodify-nickname-change-auth").attr({"style":"display:none"});
				});
				
				//phone버튼
				$(".usermodify-phone-change-btn").on("click", function() {
					$(".usermodify-phone-change-btn").attr({"style":"display:none"});
					$(".usermodify-phone-change-cancel").attr({"style":"display:inline-block"});
					$(".usermodify-phone-change-auth").attr({"style":"display:block"});
				});
				
				$(".usermodify-phone-change-cancel").on("click", function() {
					$(".usermodify-phone-change-btn").attr({"style":"display:inline-block"});
					$(".usermodify-phone-change-cancel").attr({"style":"display:none"});
					$(".usermodify-phone-change-auth").attr({"style":"display:none"});
				});
				
				$(".usermodify-secession-btn").on("click", function() {
					var result = confirm("회원정보를 탈퇴 하시겠습니까?")
					if(result){
						$(".usermodify-secession-btn").attr({"href":"secession"});
					} else 
						$(".usermodify-secession-btn").attr({"href":"modify"});
				});
								
			});

		</script>
		<jsp:include page="../include/footer.jsp"/>
	</body>
</html>