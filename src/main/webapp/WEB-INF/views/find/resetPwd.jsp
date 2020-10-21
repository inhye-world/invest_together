<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>같이투자 | 비밀번호 찾기</title>
		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
		<link href="resources/find.css" rel="stylesheet" type="text/css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script>
	
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
										<br>
										<span class="color-blue">${id}님</span>
										이제 새로운 비밀번호로 설정해 주세요.
									</dt>
								</dl>
							</article>
							<article class="user-area">
								<form:form class="pw_form" action="resetPwd" method="POST">
									<input type="hidden" name="id" value="${id}">	
									<input type="password" id="pw1" name="pw" placeholder="비밀번호 (8~32자리)"/><br>
									<input type="password" id="pw2" placeholder="비밀번호 재입력" /><br>	
									<div id="pw-correct"></div>
									<br>				
									<input id="pwd-submit" class="genric-btn primary" type="submit" value="완료">
								</form:form>
							</article>
						</section>
					</div>	
				</div>		
			</section>
		</div>
		
		<script>
		
			$("input[type=password]").keyup(function() {
				var pw1 = $("#pw1").val();
				var pw2 = $("#pw2").val();
				if(pw1 != "" || pw2 != "") {
					if(pw1 == pw2) {
						$("#pw-correct").text("비밀번호가 일치합니다.");
						$("#pw-correct").css("color", "green");
					}else {
						$("#pw-correct").text("비밀번호가 일치하지 않습니다.");
						$("#pw-correct").css("color", "red");
					}
				}
			});
			
			$("#pwd-submit").click(function(e) {
				var pw1 = $("#pw1").val();
				var pw2 = $("#pw2").val();
				if(pw1 != pw2) {
					alert("비밀번호와 비밀번호 재확인이 일치해야 합니다");
					e.preventDefault();
				}
			});			
			
			$(document).ready(function (){
				
				$.validator.addMethod("pwRegex", function(value, element) {
					return this.optional(element) || value.match(/^(?=.*[a-z])(?=.*[0-9])[0-9A-Za-z$&+,:;=?@#|'<>.^*()%!-]{8,32}$/);   
				});
				
				$(".pw_form").validate({
					//규칙
					rules:{
						pw:{
							required : true, //필수입력여부
							minlength : 8,	//최소 입력 글자수
							maxlength : 32,	//최대 입력 글자수
							pwRegex : true
						},
					},

					//메시지
					messages:{
						pw:{
							required : "비밀번호를 입력해주세요.",
							minlength : "최소 8글자 이상 입력해주세요.",	
							maxlength : "최대 32글자까지 입력가능합니다.",
							pwRegex : "영문과 숫자가 포함된 비밀번호를 입력해 주세요."
						},
					},

					//메시지 태그
					errorElement : 'div', 	//태그
					errorClass: 'error',	//클래스 이름
					validClass:'vaild' 

				});
			});
			
			
		</script>
		
		<!-- footer -->
		<jsp:include page="../main/footer.jsp"/>
	</body>
</html>