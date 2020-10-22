<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
	<title>같이투자 | 유저 정보 수정</title>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script> 
	<link href="../resources/temporary.css" rel="stylesheet" type="text/css">
	<link href="resources/user_modify.css" rel="stylesheet" type="text/css">
  	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
  	
  	<link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
  	<script src="resources/sb_admin/js/ast-notif.js"></script>
  	
	<!-- ajax사용 위해 csrf설정 -->
  	<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
  	<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
  	
	<style type="text/css">
	
		 .usermodify-title{
			margin-left: 50%;
   			margin-top: 7%;
   			color: #032380;
		} 
		
		 .table{
			 left:50%; 
			 
		}
		
		.member-container{
			left:40%;
			padding:20%;
		}
		
		 th{
			font-family: "Lucida Console", Courier, monospace;
		} 
		
	</style>

</head>
	<body>
	<jsp:include page="../main/header.jsp"/>
		<div class="member-container page-modify">			
			<h1 class="usermodify-title">회원정보 수정</h1>
			<br>
			<table class="table">

				<sec:authorize access="isAuthenticated()">
				<sec:authentication var="principal" property="principal"/>
				<tr>
					<th scope="row">아이디</th>
					<td>
						<div class="usermodify-id">
							<strong class="usermodify-id-current-mail">${principal.dto.id}</strong>
							<button type="button" class="usermodify-id-change-btn" style="display: inline-block;">아이디 변경</button>
							<button type="button" class="usermodify-id-change-cancel" style="display: none;">아이디 변경취소</button>
						<form:form class="usermodify-id-change-auth" action="alterId" method="post" style="display: none;">
							<input name="id" class="usermodify-id-if" type="text" placeholder="아이디 입력">
							<button type="submit" class="usermodify-id-change-auth-send">변경</button>
						</form:form>
						</div>	
					</td>
				</tr>
				
				<tr>
					<th scope="row">닉네임</th>
					<td>
						<div class="usermodify-nickname">
							<strong class="usermodify-nickname-current-mail">${principal.dto.nickname}</strong>
							<button type="button" class="usermodify-nickname-change-btn" style="display: inline-block;">닉네임 변경</button>
							<button type="button" class="usermodify-nickname-change-cancel" style="display: none;">닉네임 변경취소</button>
						<form:form  class="usermodify-nickname-change-auth" action="alterNickname" method="post" style="display: none;">
							<input class="usermodify-nickname-if" type="text" name="nickname" placeholder="닉네임 입력">
							<button type="submit" class="usermodify-nickname-change-auth-send">변경</button>		
						</form:form>
						</div>	
					</td>
				</tr>
				
				<tr>
					<th scope="row">휴대폰 번호</th>
					<td>
						<div class="usermodify-phone">
							<strong class="usermodify-phone-current-mail">${principal.dto.phone}</strong>
							<button type="button" class="usermodify-phone-change-btn" style="display: inline-block;">휴대폰 번호 변경</button>
							<button type="button" class="usermodify-phone-change-cancel" style="display: none;">휴대폰 번호 변경취소</button>
						<form:form class="usermodify-phone-change-auth" action="alterPhone" method="post" style="display: none;">
							<input class="usermodify-phone-if" type="text" name="phone" maxlength="11" placeholder="휴대폰 번호 입력">
							<button type="submit" class="usermodify-phone-change-auth-send">변경</button>		
						</form:form>
						</div>	
					</td>
				</tr>
				
				<tr>
					<th scope="row">이메일</th>
					<td>
						<div class="usermodify-email">
							<strong class="usermodify-email-current-mail">${principal.dto.email}</strong>
							<button type="button" class="usermodify-email-change-btn" style="display: inline-block;">이메일 변경</button>
							<button type="button" class="usermodify-email-change-cancel" style="display: none;">이메일 변경취소</button>
						<form:form class="usermodify-email-change-auth" action="emailChange" method="post" style="display: none;">
							<input class="usermodify-email-if" type="text" name="email" placeholder="이메일 입력">
							<button type="submit" class="usermodify-email-change-auth-send">인증메일 전송</button>
						</form:form>
						</div>	
					</td>
				</tr>
				
				<tr>
					<th scope="row">비밀번호변경</th>
					<td>
						<div class="usermodify-pw">
						<form:form class="usermodify-password-change" action="alterPw" method="post">
							<table class="usermodify-input-table">
								<tbody>
								<tr>
									<th>새 비밀번호</th>
									<td>
										<input type="password" id="pw1" name="pw" class="usermodify-pw-newpassword" placeholder="비밀번호 (8~32자리)">
									</td>
								</tr>
								<tr>
									<th>비밀번호 재입력</th>
									<td>
										<input type="password" id="pw2" class="usermodify-pw-newpassword-confirm" placeholder="비밀번호 (8~32자리)">
										<div id="pw-correct"></div>	
									</td>
								</tr>
								<tr>
									<td></td>
									<td>
										<button type="submit" class="usermodify-password-submit">비밀번호 변경</button>
									</td>
								</tr>
								</tbody>		
							</table>
							</form:form>
						</div>	
					</td>
				</tr>	
			</sec:authorize>
			</table>	
			
			<div class="usermodify-secession">
				 탈퇴를 원하시면 우측의 회원탈퇴 버튼을 눌러주세요.
				<a class="usermodify-secession-btn">회원탈퇴</a>
			
			<!-- <div class="usermodify-foot"> -->
				<button onclick = "location.href = ${pageContext.request.contextPath}/"  type="button" class="usermodify-cancel">나가기</button>
			</div>
		</div>
		<br><br><br>
	<script>
		
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
				
				$.validator.addMethod("idRegex", function(value, element) {
					return this.optional(element) || value.match(/^[a-z0-9]+$/);   
				});
				
				$(".usermodify-id-change-auth").validate({
					//규칙
					rules:{
						id:{
							required : true, //필수입력여부
							minlength : 4, 	//최소 입력 글자수
							maxlength : 12,  //최대 입력 글자수
							idRegex : true,
							remote:{
								type:"post",
								url:"checkId"
							},
						},
					},
					//메시지
					messages:{
						id:{
							required : "아이디를 입력해주세요.",
							minlength : "최소 4글자 이상 입력해주세요.",
							maxlength : "최대 12글자까지 입력가능합니다.",
							idRegex : "영문과 숫자만 입력가능합니다.",
							remote :  "중복된 아이디 입니다."
						},
					},
					//메시지 태그
					errorElement : 'span', 	//태그
					errorClass: 'error',	//클래스 이름
					validClass:'vaild' 
				});
				
				$.validator.addMethod("nicknameRegex", function(value, element) {
					return this.optional(element) || value.match(/^[가-힣a-zA-Z0-9]+$/);   
				});
				
				$(".usermodify-nickname-change-auth").validate({
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
					},
					//메시지 태그
					errorElement : 'span', 	//태그
					errorClass: 'error',	//클래스 이름
					validClass:'vaild' 
				});
				
				$.validator.addMethod("phoneRegex", function(value, element) {
					return this.optional(element) || value.match(/^01(?:0|1|[6-9])(?:\d{4})\d{4}$/);   
				});
				
				$(".usermodify-phone-change-auth").validate({
					//규칙
					rules:{
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
						phone:{
							required : "핸드폰번호를 입력해주세요.",
							phoneRegex : "형식에 맞지 않습니다.",
							remote :  "중복된 핸드폰 번호입니다."
						},
					},
					//메시지 태그
					errorElement : 'span', 	//태그
					errorClass: 'error',	//클래스 이름
					validClass:'vaild' 
				});
				
				$(".usermodify-email-change-auth").validate({
										
					//규칙
					rules:{
						email:{
							required : true, //필수입력여부
							email : true, 	//이메일형식
							remote:{
								type:"post",
								url:"checkEmail"
							},
						},
					},
					//메시지
					messages:{
						email:{
							required : "이메일을 입력해주세요.",
							email : "이메일 형식에 맞지 않습니다.",
							remote :  "중복된 이메일 입니다."
						},
					},
					//메시지 태그
					errorElement : 'span', 	//태그
					errorClass: 'error',	//클래스 이름
					validClass:'vaild',
					
				});	
				
		 			$(".usermodify-email-change-auth").on("submit", function() {
												
						event.preventDefault();
						/* 이메일 중복 체크 후 메일 발송 비동기 처리 */
						$.ajax({
							type:"get",
							url : "rest/emailChange",
							dataType: 'json',
							data : "email=" + $("#email").val(),
							
						success : function(data){
							
							console.log(data);
							
							if(data.hasEmail) {
								
								alerting("이메일이 발송되었습니다.");
					
							}else {
								
								alerting("이메일을 다시 입력해 주세요.")	
							}
						},
						
						beforeSend: function () {
							 $('#preloader-active').show(); 
						},
						
						error: function(data){
							alerting("이메일을 다시 입력해 주세요.");
							return false;
						},
						
						complete: function () {
							$('#preloader-active').hide();
						}
						 
					});	
				});
				
				$.validator.addMethod("pwRegex", function(value, element) {
					return this.optional(element) || value.match(/^(?=.*[a-z])(?=.*[0-9])[0-9A-Za-z$&+,:;=?@#|'<>.^*()%!-]{8,32}$/);   
				});
				
				$(".usermodify-password-change").validate({
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
					errorElement : 'span', 	//태그
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
			
			
			$(document).ready(function (){
				
				//id버튼
				$(".usermodify-id-change-btn").on("click", function() {
					$(".usermodify-id-change-btn").attr({"style":"display:none"});
					$(".usermodify-id-change-cancel").attr({"style":"display:inline-block"});
					$(".usermodify-id-change-auth").attr({"style":"display:block"});
				});
				
				$(".usermodify-id-change-cancel").on("click", function() {
					$(".usermodify-id-change-btn").attr({"style":"display:inline-block"});
					$(".usermodify-id-change-cancel").attr({"style":"display:none"});
					$(".usermodify-id-change-auth").attr({"style":"display:none"});
				});
				
				//nickname버튼
				$(".usermodify-nickname-change-btn").on("click", function() {
					$(".usermodify-nickname-change-btn").attr({"style":"display:none"});
					$(".usermodify-nickname-change-cancel").attr({"style":"display:inline-block"});
					$(".usermodify-nickname-change-auth").attr({"style":"display:block"});
				});
				
				$(".usermodify-nickname-change-cancel").on("click", function() {
					$(".usermodify-nickname-change-btn").attr({"style":"display:inline-block"});
					$(".usermodify-nickname-change-cancel").attr({"style":"display:none"});
					$(".usermodify-nickname-change-auth").attr({"style":"display:none"});
				});
				
				//phone버튼
				$(".usermodify-phone-change-btn").on("click", function() {
					$(".usermodify-phone-change-btn").attr({"style":"display:none"});
					$(".usermodify-phone-change-cancel").attr({"style":"display:inline-block"});
					$(".usermodify-phone-change-auth").attr({"style":"display:block"});
				});
				
				$(".usermodify-phone-change-cancel").on("click", function() {
					$(".usermodify-phone-change-btn").attr({"style":"display:inline-block"});
					$(".usermodify-phone-change-cancel").attr({"style":"display:none"});
					$(".usermodify-phone-change-auth").attr({"style":"display:none"});
				});
				
				//email버튼
				$(".usermodify-email-change-btn").on("click", function() {
					$(".usermodify-email-change-btn").attr({"style":"display:none"});
					$(".usermodify-email-change-cancel").attr({"style":"display:inline-block"});
					$(".usermodify-email-change-auth").attr({"style":"display:block"});
				});
				
				$(".usermodify-email-change-cancel").on("click", function() {
					$(".usermodify-email-change-btn").attr({"style":"display:inline-block"});
					$(".usermodify-email-change-cancel").attr({"style":"display:none"});
					$(".usermodify-email-change-auth").attr({"style":"display:none"});
				});
				
				$(".usermodify-secession-btn").on("click", function() {
					
					var result = confirm("회원정보를 탈퇴 하시겠습니까?");
					
					if(result){		
						$(".usermodify-secession-btn").attr({"href":"secession"});
					} else 
						$(".usermodify-secession-btn").attr({"href":"modify"});
				});
								
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
			
			$(".usermodify-password-submit").click(function(e) {
				var pw1 = $("#pw1").val();
				var pw2 = $("#pw2").val();
				if(pw1 != pw2) {
					alerting("비밀번호와 비밀번호 재확인이 일치해야 합니다");
					e.preventDefault();
				}
			});
			
		</script>
		<jsp:include page="../main/footer.jsp"/>
	</body>
</html>