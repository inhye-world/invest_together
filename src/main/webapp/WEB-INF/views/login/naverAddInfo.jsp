<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>같이투자 | 네이버 회원가입</title>
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script>  
	<link href="resources/temporary.css" rel="stylesheet" type="text/css">
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
	
	<!-- ajax사용 위해 csrf설정 -->
  	<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
  	<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
	
	<style type="text/css">
		.form div.error {color:red;}
		.form div{color:red;}
		
		.contain{
    		margin: auto;
		 	margin-top: 75px;
			margin-bottom: 65px; 
    	}
	</style>
</head>
	<body>
		<jsp:include page="../main/header.jsp"/>
		<br><br><br>
		<div class="wrapper">
			<div class="contain nicknameForm col-xl-4 col-lg-4">
				<h1 style="text-align:center;font-size:2em;">네이버 회원가입</h1> 
				<br>
				<h2 style="text-align:center;font-size:1em;">닉네임과 핸드폰 번호를 입력해주세요.</h2> 
			
				<form:form class="form" action="addNaverUser" method="POST">
					<input type="hidden" name="id" value="${dto.id}" />
					<input type="hidden" name="email" value="${dto.email}" />
					<input type="hidden" name="name" value="${dto.name}" />
					<input type="hidden" name="sns_type" value="${dto.sns_type}" />
					<input type="hidden" name="sns_token" value="${dto.sns_token}" />
					<br><br>
					<h1 style="margin-left:-53%; color:#282724; font-size:1em;">닉네임</h1>
					<input type="text" name="nickname" />
					<br><br>
					<h1 style="margin-left:-50%; color:#282724; font-size:1em;">핸드폰 번호</h1>
					<input type="text" name="phone" maxlength="11">
					<input type="submit" value="확인" />
				</form:form>
			</div>
			<br><br><br><br>
			<jsp:include page="../main/footer.jsp"/>
		</div>
		<script type="text/javascript">	
		
		$.validator.addMethod("nicknameRegex", function(value, element) {
			return this.optional(element) || value.match(/^[가-힣a-zA-Z0-9]+$/);   
		});
		
		$.validator.addMethod("phoneRegex", function(value, element) {
			return this.optional(element) || value.match(/^01(?:0|1|[6-9])(?:\d{4})\d{4}$/);   
		});
		
			$(document).ready(function (){
				$(".form").validate({
					//규칙
					rules:{
						nickname:{
							required : true, //필수입력여부
							minlength : 2,	//최소 입력 글자수
							maxlength : 8,	//최대 입력 글자수
							nicknameRegex : true,
							remote:{
								type:"post",
								url:"checkNickname"
							},
						},
						
						phone:{
							required : true, //필수입력여부
							phoneRegex : true,
							remote:{
								type:"post",
								url:"checkPhone"
							},
						},	
					},

					//메시지
					messages:{
						nickname:{
							required : "닉네임을 입력해주세요.",
							minlength : "최소 2글자 이상 입력해주세요.",	
							maxlength : "최대 8글자까지 입력가능합니다.",
							nicknameRegex : "한글,영문,숫자만 입력가능합니다.",
							remote :  "중복된 닉네임 입니다."
						},
						
						phone:{
							required : "핸드폰번호를 입력해주세요.",
							phoneRegex : "형식에 맞지 않습니다.",
							remote :  "중복된 핸드폰 번호입니다."
						},
					},

					//메시지 태그
					errorElement : 'div', 	//태그
					errorClass: 'error',	//클래스 이름
					validClass:'vaild' 
				});
			});

		    //ajax csrf
		    $(document).ready(function(){
			    var token = $("meta[name='_csrf']").attr("content");
			    var header = $("meta[name='_csrf_header']").attr("content");
			    $(document).ajaxSend(function(e, xhr, options) {
			        xhr.setRequestHeader(header, token);
			    });
			});
			
		</script> 
	</body>
</html>