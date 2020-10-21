<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>같이투자 | 아이디 찾기</title>
		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script>
		<link href="resources/find.css" rel="stylesheet" type="text/css">
		
		<!-- alert -->
	    <link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
	    <script src="resources/sb_admin/js/ast-notif.js"></script>
		
		
		
		<style type="text/css">
				
			.name-input {
				padding-bottom: 3px;
			}
		
			.verify_form-content {
				padding-top: 15px;
			}
			
			.content__body__page h2 {
				color: #072366;
			    font-size: 30px;
			    font-weight: 800;
			    text-transform: capitalize;
			    line-height: 1;
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
						<h2>아이디 찾기</h2>
						<section class="login">
							<article class="notification">
								<div class="notification_pic">
									<img src=" //d2h5doj4xlbun0.cloudfront.net/member-0.0.1367/
									images/member/member_status_img3.jpg">	
								</div>								
								<dl class="notification__txt">
									<dt></dt>
									<dt>
										아이디 찾기를 위한
										<br>
										<span class="color-blue">이름,이메일 주소를</span>
										입력해주세요.
									</dt>
								</dl>
							</article>
							<article class="user-area">
								<div class="user-area_content">
									<span class="input-state input-state--success is-block" id="user_id_box">
										<form:form class="auth_form" action="idEmailSend" method="POST">
											<div class="name-input">
												이름: <input type="text" id="name" name="name" maxlength="40">
											</div>
											<br>
												이메일 주소: <input type="text" id="email" name="email" maxlength="100">
									</span>
											<div class="auth-submit"><input class="genric-btn primary" type="submit" value="인증번호 받기"></div>
										</form:form>
										
										<div class="verify_form-content">
										<form:form class="verify_form" action="verifyId" method="POST">
											<input type="hidden" id="authEmail" name="email" />
											<input type="hidden" id="authKey" />
											<input class="verifyNumber-input" type="password" name="verifyNumber" placeholder="인증번호 6자리 숫자 입력" maxlength="6" style="display: none;">
											<input class="genric-btn primary" id="verifyNumber-submit" type="submit" value="확인" style="display: none;">
										</form:form>
										</div>
									</span>		
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

		$(document).ready(function (){
			
			var validError = false;
					
			$(".auth_form").validate({
				
				//규칙
				rules:{
					name:{
						required : true, //필수입력여부
						minlength : 2 	//최소 입력 글자수
					},
					email:{
						required : true, //필수입력여부
						email : true 	//이메일형식
					},
					
				},

				//메시지
				messages:{
					name:{
						required : "이름을 입력해주세요.",
						minlength : "최소 2글자 이상 입력해주세요."
					},
					email: {
						required : "이메일을 입력해주세요.",
						email : "이메일 형식을 지켜주세요." 
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
			
			$(".verify_form").validate({
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
			
 			$(".auth_form").on("submit", function() {
				
				if(validError) {
					alerting("이름 또는 이메일을 잘못 입력하셨습니다.")
					return false;
				}
				
				event.preventDefault();
				/* 이메일 중복 체크 후 메일 발송 비동기 처리 */
				$.ajax({
					type:"get",
					url : "rest/idEmailSend",
					dataType: 'json',
					data : "email=" + $("#email").val() + "&name=" + $("#name").val(),
					
				success : function(data){
					
					console.log(data);
					
					if(data.hasEmail) {
						$(".verifyNumber-input").attr({"style":"display:inline-block"});
						$("#verifyNumber-submit").attr({"style":"display:inline-block"});
						
						alerting("이메일이 발송되었습니다.");
						
						$("#authKey").val(data.authKey);
						var authEmail = $("#email").val();
						$("#authEmail").val(authEmail);
						
					}else {
						alerting("아이디 또는 이메일을 잘못 입력하셨습니다.")
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