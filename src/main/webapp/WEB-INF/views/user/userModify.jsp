<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>유저 정보 수정</title>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script> 
	
	<style type="text/css">
		body {
		    font-family: dotum,sans-serif;
		    font-size: 12px;
		    line-height: 1.6;
		    color: #666; 
		}
		
		div {
		    display: block;
		}
		
		section {
			display: block;
		}
		
		p {
		    display: block;
		    margin-block-start: 1em;
		    margin-block-end: 1em;
		    margin-inline-start: 0px;
		    margin-inline-end: 0px;
		}
		
		form {
			display: block;
			margin: 0;
			padding: 0;
		}
	
		input {
		    vertical-align: middle;
		    line-height: normal;
		    color: inherit;
    		font: inherit;
    		margin: 0;
		}
		
		table {
		    display: table;
		    box-sizing: border-box;   
		    border-color: grey;
		}
		
		tbody {
		    display: table-row-group;
		    vertical-align: middle;
		    border-color: inherit;
		}
		
		tr {
		    display: table-row;
		    vertical-align: inherit;
		    border-color: inherit;
		}
		
		span {
			display: table-row;
		    vertical-align: inherit;
		    border-color: inherit;
		}
		
		.usermodify-auth-mail {
		    color: #0185da;
		}
		
		b, strong {
		    font-weight: bold;
		}
		
		div.member-container {
		    min-height: 900px;
		    padding: 50px;
		    background-color: #fff;
		    border: 1px solid #ccc;
		}
	
		.usermodify-auth-title {
		    margin: 0 0 10px;
		    font-size: 30px;
		    font-family: "맑은 고딕", "malgun gothic", sans-serif;
		    font-weight: bold;
		    color: rgb(51, 51, 51);
		    letter-spacing: -1px;
		}
		
		.usermodify-auth-msg {
		    margin-bottom: 6px;
		    font-weight: bold;
		}
		
		.usermodify-table {
			width: 100%;
		    border-top: 2px solid #969696;
		    border-collapse: collapse;
		}
		
		.usermodify-table th {
		    width: 100px;
		    background-color: #eef1f8;
		    text-align: left;
		    white-space: nowrap;
		    padding: 14px 30px;
   			border-bottom: 1px solid #ddd;
		}
		
		.usermodify-table td {
			border-left: 1px solid #ddd;
			padding: 14px 30px;
    		border-bottom: 1px solid #ddd;
		}
		
		.usermodify-auth-foot {
		    margin-top: 30px;
		    text-align: center;
		}
		
		.usermodify-auth-submit {
			border-color: #0185da;
		    color: #fff;
		    background-color: #0e9ae9;
		    background-image: linear-gradient(#20b3f8,#0185d8);
		    display: inline-block;
			box-sizing: border-box;
			border: 1px solid #0185da;
			text-decoration: none;
			vertical-align: middle;
			text-align: center;
		}
		
		.usermodify-auth-cancel {
			border-color: #828282;
		    color: #fff;
		    background-color: #999ca5;
		    background-image: linear-gradient(#a8abba,#8c8f98);
			display: inline-block;
		    box-sizing: border-box;
		    border: 1px solid #828282;
		    text-decoration: none;
		    vertical-align: middle;
		    text-align: center;
		}
	
		.form-err {
		    padding-left: 1.6em;
		    font-style: normal;
		    font-size: 12px;
		    color: #fb0005;
		    display: inline;
		}
		
	</style>
	
</head>
	<body>
	<jsp:include page="../include/header.jsp"/>
		<div class="member-web-adapter member-web-adapter--desktop">
			<div class="member-container">
				<section class="usermodify-auth">
				<sec:authorize access="isAuthenticated()">
				<sec:authentication var="principal" property="principal"/>
				<form:form class="passwordConfirmForm" action="userModify" method="post">
				<h1 class="usermodify-auth-title">회원정보확인</h1>			

				<p class="usermodify-auth-msg">
				<strong class="usermodify-auth-mail">${principal.dto.nickname}</strong>
				님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인 합니다.
				</p>
				<table class="usermodify-table">
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
					<button type="submit" class="usermodify-auth-submit">확인</button>
					<button type="submit" class="usermodify-auth-cancel">취소</button>
				</div>	
				</form:form>				
			</sec:authorize>
			</section>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"/>
		
		<script type="text/javascript">
		
		$(document).ready(function (){
			$(".usermodify-auth-cancel").on("click",function() {
				$(".passwordConfirmForm").attr("action", "${pageContext.request.contextPath}").submit();
			});			
		});
		
		</script>
		
	</body>
</html>