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
										<form:form action="${pageContext.request.contextPath}/pwdEmailSend" method="POST">
											<input type="text" class="form-control--base-c" name="id" placeholder="아이디 (대소문자 구분)" maxlength="50">
											<input id="pwFind-submit" type="submit" value="인증번호전송">
										</form:form>
									</span>
										<form:form action="${pageContext.request.contextPath}/verifyPwd" method="POST">
											<input type="hidden" name="id" value="${memberDTO.id}">
											<input type="password" id="verifyNumber" name="verifyNumber" placeholder="이메일 인증 번호" maxlength="50">
											<input id="verifyNumber-submit" type="submit" value="확인">
										</form:form>		
								</div>
								<div class="user-area__help">
									<span class="list-bul">
										아이디를 찾으시나요?			
									</span>
									<button class="button button--base-m button--shape-a" style="top: 70px;" onclick="location.href='${pageContext.request.contextPath}/idFind'">
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
/* 		$(document).ready(function(){
			
		$('#pwFind-submit').click(function(event){
			event.preventDefault();
			console.log("ajax 호출전");
			
			  var formData = $("form[name=id]").serialize();
			  console.log(formData);
			$.ajax({
			    url: '${pageContext.request.contextPath}/restful/pwFind.json',
			    type: 'post',
			    dataType:"json",
			    data: formData,
			    success: function (data) {	    	
			    		console.log(data);
			            alert("데이터 전송이 성공적으로 끝났을 때 실행");
			            $('body').attr("");
			            document.write(data);
			        }
				});
			})
		}) */
		
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