<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 찾기</title>
		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script>
		<link href="resources/find.css" rel="stylesheet" type="text/css">
	
		<style type="text/css">
			.id_form span.error {color:red;} 
			.auth_form span.error {color:red;} 
		</style>
	</head>
	<body>
	${authKey}
	${memberDTO.id}
		<div class="wrapper">
			<header class="header-pw">
			</header>			
			<!-- body -->
			<section class="content content--login">
				<div class="content__body">
					<div class="content__body__page">
						<h2>비밀번호 찾기</h2>
						<section class="login">
							<article class="notification">
								<div class="notification_pic">
									<img src="//d2h5doj4xlbun0.cloudfront.net/member-0.0.1367/
									images/member/member_status_img4.jpg">	
								</div>								
								<dl class="notification__txt">
									<dt></dt>
									<dt>
										비밀번호 찾기를 위한
										<br>
										<span class="color-blue">아이디</span>
										를 입력해주세요.
									</dt>
								</dl>
							</article>
							<article class="user-area">
								<div class="user-area_content">
									<span class="input-state input-state--success is-block" id="user_id_box">
										<form:form class="id_form" action="pwdEmailSend" method="POST">
											<input type="text" class="form-control--base-c" name="id" placeholder="아이디 (대소문자 구분)" maxlength="12"><br><br>
											<input id="pwFind-submit" type="submit" value="인증번호전송">
										</form:form>
										<br>
									</span>
										<form:form class="auth_form" action="verifyPwd" method="POST">
											<input type="hidden" name="id" value="${memberDTO.id}">
											<input type="hidden" id="authKey" value="${authKey}" />
											<input type="password" id="verifyNumber" name="verifyNumber" placeholder="이메일 인증 번호" maxlength="50"><br><br>
											<input id="verifyNumber-submit" type="submit" value="확인">
										</form:form>		
								</div>
								<div class="user-area__help">
									<span class="list-bul">
										아이디를 찾으시나요?			
									</span>
									<button class="button button--base-m button--shape-a" style="top: 70px;" onclick="location.href='idFind'">
										<span class="button__text">아이디 찾기</span>
									</button>			
								</div>
							</article>
						</section>
					</div>	
				</div>		
			</section>
		</div>
		
	 <script type="text/javascript">	
		 
			$(document).ready(function (){
				$(".id_form").validate({
					//규칙
					rules:{
						id:{
							required : true, //필수입력여부
							minlength : 4 	//최소 입력 글자수
						},
					},

					//메시지
					messages:{
						id:{
							required : "아이디를 입력해주세요.",
							minlength : "최소 4글자 이상 입력해주세요."
						},
					},

					//메시지 태그
					errorElement : 'span', 	//태그
					errorClass: 'error',	//클래스 이름
					validClass:'vaild' 
				});
				
				$(".auth_form").validate({
					//규칙
					rules:{	
						verifyNumber:{
							required : true, //필수입력여부
							equalTo : "#authKey"
						},
					},

					//메시지
					messages:{		
						verifyNumber: {
							required : "인증번호를 입력해주세요.",
							equalTo : "인증번호가 틀렸습니다."
						},
					},

					//메시지 태그
					errorElement : 'span', 	//태그
					errorClass: 'error',	//클래스 이름
					validClass:'vaild' 
				});
			});
	
	</script> 	
	</body>
</html>