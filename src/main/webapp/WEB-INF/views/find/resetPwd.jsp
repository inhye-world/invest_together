<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 찾기</title>
		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
		<link href="resources/find.css" rel="stylesheet" type="text/css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	</head>
	<body>
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
										<br>
										<span class="color-blue">${memberDTO.id}님</span>
										이제 새로운 비밀번호로 설정해 주세요.
									</dt>
								</dl>
							</article>
							<article class="user-area">
								<form:form action="resetPwd" method="POST">
									<input type="hidden" name="id" value="${memberDTO.id}">	
									<input type="password" id="pw1" name="pw" placeholder="비밀번호 (8~32자리)" /><br>
									<div>${valid_pw} </div>
									<input type="password" id="pw2" placeholder="비밀번호 재입력" /><br>
									<div id="pw-correct"></div>						
									<input id="pwd-submit" class="button5" type="submit" value="완료">
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
			
		</script>
			
	</body>
</html>