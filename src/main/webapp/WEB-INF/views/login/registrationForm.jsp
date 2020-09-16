<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<link href="resources/temporary.css" rel="stylesheet" type="text/css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
	<body>
		<div class="wrapper">
			<div class="container registrationForm">
				<a class="mainA" href="/into"> 같이투자 API TEST</a>
				<br><br><br><br>
				
				<form:form action="registration" method="POST">
				 	<input type="text" name="id" placeholder="아이디" value="${dto.id}" /><br>
				 	<div>${valid_id} </div>
					<input type="password" id="pw1" name="pw" placeholder="비밀번호 (8~32자리)" /><br>
					<div>${valid_pw} </div>
					<input type="password" id="pw2" placeholder="비밀번호 재입력" /><br>
					<div id="pw-correct"></div>
					<input type="text" name="name" placeholder="이름" value="${dto.name}" /><br>
					<div>${valid_name} </div>
					<input type="text" name="nickname" placeholder="닉네임" value="${dto.nickname}" /><br>
					<div>${valid_nickname} </div>
					<input type="text" name="email" placeholder="이메일" value="${dto.email}" /><br>
					<div>${valid_email} </div>
					<input type="text" name="phone" placeholder="핸드폰" value="${dto.phone}" /><br>
					<div>${valid_phone} </div>
					<input id="regi-submit" class="button5" type="submit" value="가입">
				</form:form>
			</div>
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
			
			$("#regi-submit").click(function(e) {
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