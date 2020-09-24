<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script>  
	<link href="resources/temporary.css" rel="stylesheet" type="text/css">
	
	<style type="text/css">
		.form div.error {color:red;}
		.form div{color:red;}
	</style>
</head>
	<body>
		<div class="wrapper">
			<div class="container nicknameForm">
				<a class="mainA" href="/into"> 같이투자 API TEST</a>
				<br><br><br><br>
				
				<form:form class="form" action="addNaverUser" method="POST">
					<input type="hidden" name="id" value="${dto.id}" />
					<input type="hidden" name="email" value="${dto.email}" />
					<input type="hidden" name="name" value="${dto.name}" />
					<input type="hidden" name="sns_type" value="${dto.sns_type}" />
					<input type="hidden" name="sns_token" value="${dto.sns_token}" />
					<h2>닉네임을 입력해주세요</h2>
					<br><br><br><br>
					<input type="text" name="nickname" />
					<div>${valid_nickname} </div>
					<input type="submit" value="확인" />
				</form:form>
			</div>
		</div>
		<script type="text/javascript">	
		
			$(document).ready(function (){
				$(".form").validate({
					//규칙
					rules:{
						nickname:{
							required : true, //필수입력여부
							minlength : 2,	//최소 입력 글자수
							maxlength : 8
						},
					},

					//메시지
					messages:{
						nickname:{
							required : "닉네임은 필수 입력입니다.",
							minlength : "최소 2글자 이상 입력해주세요.",
							maxlength : "최대 8글자까지 입력가능합니다."
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