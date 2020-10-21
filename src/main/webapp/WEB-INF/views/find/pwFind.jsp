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
		<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
		<link href="resources/find.css" rel="stylesheet" type="text/css">
	
		<!-- alert -->
	    <link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
	    <script src="resources/sb_admin/js/ast-notif.js"></script>
	
		<style type="text/css">
				
			.button__text {
				color:black;
			}
		</style>
	</head>
	<body>
	   <jsp:include page="../main/header.jsp"/>
		<div class="container">
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
											<input type="text" class="form-control--base-c" id="id" name="id" placeholder="아이디 (대소문자 구분)" maxlength="12">
										
										<div class="auth-submit"><input class="genric-btn primary" id="pwFind-submit" type="submit" value="인증번호전송"></div>
										</form:form>
										<br>
									</span>
										<form:form class="auth_form" action="verifyPwd">
											<input type="hidden" name="id" id="authId">
											<input type="hidden" id="authKey" />
											<input type="password" id="verifyNumber" name="verifyNumber" placeholder="이메일 인증 번호" maxlength="50" style="display: none;" maxlength="6" >
											<input class="genric-btn primary" id="verifyNumber-submit" type="submit" value="확인" style="display: none;">
										</form:form>
										<br>		
								</div>
								<div class="user-area__help">
									<span class="list-bul">
										아이디를 찾으시나요?			
									</span>
									<button class="genric-btn primary" onclick="location.href='idFind'">
										<span>아이디 찾기</span>
									</button>			
								</div>
							</article>
						</section>
					</div>	
				</div>		
			</section>
		</div>
		
	 <script type="text/javascript">	
		 
			function alerting(content){
	       		AstNotif.dialog('알림', content, {
	           		theme: 'default',
	           	});
	       	}
	         
	        function confirming(content){
	      		AstNotif.snackbar(content, {
	          		theme: 'default',
	          	});
	     	}
	 
	 
			$(document).ready(function (){
				
				var validError = false;
				
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
					errorElement : 'div', 	//태그
					errorClass: 'error',	//클래스 이름
					validClass:'vaild',
					invalidHandler: function (form, validator) {
						var errors = validator.numberOfInvalids();
						if(errors) {
							validError = true;
						}
					}
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
					errorElement : 'div', 	//태그
					errorClass: 'error',	//클래스 이름
					validClass:'vaild' 
				});
				
				$(".id_form").on("submit", function() {
					
					if(validError) {
						alerting("아이디를 잘못 입력하셨습니다.")
						return false;
					}
					
					event.preventDefault();
					/* 이메일 중복 체크 후 메일 발송 비동기 처리 */
					$.ajax({
						type:"get",
						url : "rest/pwdEmailSend",
						dataType: 'json',
						data : "id=" + $("#id").val(),
						
					success : function(data){
						
						console.log(data);
						
						if(data.hasEmail) {
							
							$("#verifyNumber").attr({"style":"display:inline-block"});
							$("#verifyNumber-submit").attr({"style":"display:inline-block"});
							
							alerting("이메일이 발송되었습니다.");
							
							$("#authKey").val(data.authKey);
							var authId = $("#id").val();
							$("#authId").val(authId);
							
						}else {
							alerting("다시 입력해 주세요.")	
						}
					},
					
					beforeSend: function () {
						 $('#preloader-active').show(); 
					},
					
					error: function(data){
						alerting("다시 입력해 주세요.");
						return false;
					},
					
					complete: function () {
						$('#preloader-active').hide();
					}
				});	
			}); 	
		});
	
	</script>
	
	<!-- footer -->
	<jsp:include page="../main/footer.jsp"/>
	
	</body>
</html>