<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>같이투자 | 유저 정보 수정</title>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script> 
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
	<style>
		.member-container{
			width:80%;
			height: 600px;
		}
	
		.usermodify-auth-title{
			padding-top: 40px;
			margin-left: 20%;
		}
    	
		.userPreCheck{
			width:60%;
			margin-left: auto;
			margin-right: auto;
			border: 1px solid #000;
			margin-top: 10px;
		}

		.userPreCheck th, td{
			border-bottom : 1px solid #000;
			padding: 10px;
		}


    	.passwordConfirmForm{
    		position:absolute;
    		border-collapse: collapse;
  			border-spacing: 0;
  			top:35%;
  			left:40%;
  			
    	}

	</style>
	
</head>
	<body>
	<jsp:include page="../main/header.jsp"/>
	
		<div class="member-web-adapter member-web-adapter--desktop">
			<div class="member-container">
				<section class="usermodify-auth">
				<sec:authorize access="isAuthenticated()">
				<sec:authentication var="principal" property="principal"/>
				
				<form:form class="passwordConfirmForm" action="userModify" method="post">
					<h1 class="usermodify-auth-title">회원정보확인</h1>	
							
          			<div>
            	  		<ul class="ranking-notice">
            	  		<li><strong class="usermodify-auth-nickname">${principal.dto.nickname}</strong>
							님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인 합니다.</li>
							
						</ul>
   					</div>
   					
					<table class="userPreCheck">
						<tbody>
							<tr>
								<th scope="row">닉네임<th>
								<td>${principal.dto.nickname}</td>
							</tr>
							<tr>
							 	<th scope="row">비밀번호<th>
								<td>
								<input type="password" name="pw" placeholder="비밀번호 (8~32자리)">
								<span class="form-err">${pw_error}</span>
								</td>
							</tr>
						</tbody>
					</table>
					
					<div class="usermodify-auth-foot">
						<button type="submit" id="usermodify-auth-submit" class="button5">확인</button>
					
						<button type="submit" class="usermodify-auth-cancel">취소</button>
					</div>	
				</form:form>
								
				</sec:authorize>
				</section>
			</div>
			<br><br><br>
		</div>
		
		<jsp:include page="../main/footer.jsp"/>
		
		<script type="text/javascript">
		
		$(document).ready(function (){
			$(".usermodify-auth-cancel").on("click",function() {
				$(".passwordConfirmForm").attr("action", "${pageContext.request.contextPath}").submit();
			});			
		});
		
		</script>
		
	</body>
</html>