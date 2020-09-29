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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script> 
	<style type="text/css">
		.form div.error {color:red;} 
		.form div{color:red;}
	</style>
</head>
	<body>
		<div class="wrapper">
			<div class="container registrationForm">
				<a class="mainA" href="/into"> 같이투자 API TEST</a>
				<br><br><br><br>
				
				<form:form class="form" action="registration" method="POST">
				 	<input type="text" id="id" name="id" placeholder="아이디" value="${dto.id}" />
				 	<div id="id-empty">${valid_id}</div>
					<input type="password" id="pw1" name="pw" placeholder="비밀번호 (8~32자리)" />
					<div>${valid_pw} </div>
					<input type="password" id="pw2" placeholder="비밀번호 재입력" />
					<div id="pw-correct"></div>
					<input type="text" name="name" placeholder="이름" value="${dto.name}" />
					<div>${valid_name} </div>
					<input type="text" name="nickname" placeholder="닉네임" value="${dto.nickname}" />
					<div>${valid_nickname} </div>
					<input type="text" name="email" placeholder="이메일" value="${dto.email}" />
					<div>${valid_email} </div>
					<input type="text" name="phone" placeholder="핸드폰" value="${dto.phone}" />
					<div>${valid_phone} </div>
					<input id="regi-submit" class="button5" type="submit" value="가입">
				</form:form>
			</div>
		</div>
		
		<script>
			
			$("input[type=text]").keyup(function() {
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
			
			
			$(document).ready(function (){
				$(".form").validate({
					//규칙
					rules:{
						id:{
							required : true, //필수입력여부
							minlength : 4,	//최소 입력 글자수
							maxlength : 12  //최대 입력 글자수
						},
						
						pw:{
							required : true, //필수입력여부
							minlength : 8,	//최소 입력 글자수
							maxlength : 32	//최대 입력 글자수
						},
						
						name:{
							required : true, //필수입력여부
							minlength : 2,	//최소 입력 글자수
							maxlength : 8	//최대 입력 글자수
						},
						
						nickname:{
							required : true, //필수입력여부
							minlength : 2,	//최소 입력 글자수
							maxlength : 8	//최대 입력 글자수
						},
						
						email:{
							required : true, //필수입력여부
							email : true 	//이메일형식
						},
						
						phone:{
							required : true, //필수입력여부
							maxlength : 11	//최대 입력 글자수
						},

					},

					//메시지
					messages:{
						id:{
							required : "아이디를 입력해주세요.",
							minlength : "최소 4글자 이상 입력해주세요.",	
							maxlength : "최대 12글자까지 입력가능합니다."	
						},
						
						pw:{
							required : "비밀번호를 입력해주세요.",
							minlength : "최소 8글자 이상 입력해주세요.",	
							maxlength : "최대 32글자까지 입력가능합니다."
						},	
						
						name:{
							required : "이름을 입력해주세요.",
							minlength : "최소 2글자 이상 입력해주세요.",	
							maxlength : "최대 8글자까지 입력가능합니다."
						},
						
						nickname:{
							required : "닉네임을 입력해주세요.",
							minlength : "최소 2글자 이상 입력해주세요.",	
							maxlength : "최대 8글자까지 입력가능합니다."
						},
						
						email:{
							required : "이메일을 입력해주세요.",
							email : "이메일 형식에 맞지 않습니다.",	
						},
						
						phone:{
							required : "핸드폰번호를 입력해주세요.",
							maxlength : "최대 11글자까지 입력가능합니다."
						},
					},
					
					//메시지 태그
					errorElement : 'div', 	//태그
					errorClass: 'error',	//클레스 이름
					validClass:'vaild' 
				});
			});
			
		</script>
	</body>
</html>