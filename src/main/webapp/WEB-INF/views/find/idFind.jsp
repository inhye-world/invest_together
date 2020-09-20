<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 찾기</title>
		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<link href="resources/find.css" rel="stylesheet" type="text/css">
	</head>
	<body>
	${authKey}
	${memberDTO.name}
	${memberDTO.email}
		<div class="wrapper">
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
										<form:form action="${pageContext.request.contextPath}/idEmailSend" method="POST">
											이름: <input type="text" name="name" maxlength="40"><br>
											이메일 주소: <input type="text" name="email" maxlength="100">
											<input id="verifyNumber-submit" type="submit" value="인증번호 받기"><br>
										</form:form>
										<form:form action="${pageContext.request.contextPath}/verifyId" method="POST">
											<input type="hidden" name="email" value="${memberDTO.email}">
											<input type="password" name="verifyNumber" placeholder="인증번호 6자리 숫자 입력" maxlength="6">
											<input id="verifyNumber-submit" type="submit" value="확인">
										</form:form>
									</span>		
								</div>
							</article>
						</section>
					</div>	
				</div>		
			</section>
		</div>
		
	 <script type="text/javascript">	
	 
			$("#pwFind-submit").click(function(e) {
				var id = $("#id").val();
				if(id == null) {
					alert("아이디를 다시 확인해주세요.");
					e.preventDefault();
				}
			});
		
					
			$("#verifyNumber-submit").click(function(e) {
				e.preventDefault();
				alert("인증번호를 입력해주세요.");
				var verifyNumber = $("#verifyNumber").val();
				var authKey = ${authKey};
				if(verifyNumber != authKey) {
					alert("인증번호를 다시 확인해주세요.");
				}
			}); 
		
	</script> 

		
		
	</body>
</html>