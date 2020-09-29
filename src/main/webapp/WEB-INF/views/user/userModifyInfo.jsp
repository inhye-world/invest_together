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
	
		tbody {
		    display: table-row-group;
		    vertical-align: middle;
		    border-color: inherit;
		}
		
		body, input, textarea, select, button, table {
		    font-family: 돋움, Dotum, sans-serif;
		    font-size: 100%;
		}
		
		div.member-container {
		    min-height: 900px;
		    padding: 50px;
		    background-color: #fff;
		    border: 1px solid #ccc;
		}
		
		.usermodify-title {
		    margin: 0 0 10px;
		    font-size: 30px;
		    font-family: "맑은 고딕", "malgun gothic", sans-serif;
		    font-weight: bold;
		    color: #333;
		    letter-spacing: -1px;
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
		}
		
		.usermodify-table .usermodify-pw th{
			border-collapse: collapse;
			font-weight: normal;
		    padding: 5px 6px 11px 0;
		    background-color: #fff;
		    white-space: nowrap;
		    width: 1%;
		    border-bottom: 0;
		}
		
		.usermodify-id-change-btn, .usermodify-nickname-change-btn, .usermodify-phone-change-btn, .usermodify-email-change-btn, .usermodify-password-submit, .usermodify-cancel, .usermodify-id-change-cancel, .usermodify-id-change-auth-send, .usermodify-nickname-change-cancel, .usermodify-nickname-change-auth-send, .usermodify-phone-change-cancel, .usermodify-phone-change-auth-send, .usermodify-email-change-cancel, .usermodify-email-change-auth-send {
		    border-color: #bcbfc6;
		    color: #777;
		    background-color: #fafbf6;
		    background-image: linear-gradient(#fff,#f1f1f1);
		    
		}
		
		.usermodify-id-change-btn, .usermodify-nickname-change-btn, .usermodify-phone-change-btn, .usermodify-email-change-btn, .usermodify-password-submit, .usermodify-cancel, .usermodify-id-change-cancel, .usermodify-id-change-auth-send, .usermodify-nickname-change-cancel, .usermodify-nickname-change-auth-send, .usermodify-phone-change-cancel, .usermodify-phone-change-auth-send, .usermodify-email-change-cancel, .usermodify-email-change-auth-send {
		    display: inline-block;
		    box-sizing: border-box;
		    border: 1px solid #898989;
		    text-decoration: none;
		    vertical-align: middle;
		    text-align: center;
		}
		
		.usermodify-table{
			border-collapse: collapse;
			border-left: 0;
			width: 100%;
		    border-top: 2px solid #969696;
		    border-collapse: collapse;
		}
		
		.usermodify-table td {
		    padding: 14px 30px;
		    border-bottom: 1px solid #ddd;
		}
		
		.usermodify-pw td{
			border-bottom: 0;
			border-left: 0;
		}
		
		.usermodify-input-table th{
			vertical-align: top;
		}
		
		.usermodify-pw-submit {
		    margin-top: 10px;
		}
		
		.usermodify-foot {
		    text-align: center;
		    margin-top: 30px;
		}	
		
		.usermodify-input-table th, .usermodify-input-table td {
		    vertical-align: top;
		    padding: 0 0 11px 0;
		}
		
		.usermodify-secession {
		    margin-top: 10px;
		    text-align: right;
		    color: #97979f;
		}
		
		.usermodify-secession-btn {
		    border-color: #898989;
		    color: #fff;
		    background-color: #a8a8a8;
		}
		
		.usermodify-secession-btn {
		    display: inline-block;
		    padding: 3px 6px;
		    border-radius: 2px;
		    font-size: 11px;
		    line-height: 13px;
		    letter-spacing: -1px;
		}
		
		.usermodify-secession-btn{
			box-sizing: border-box;
		    border: 1px solid #898989;
		    text-decoration: none;
		    vertical-align: middle;
		    text-align: center;
		}
		
		tr {
		    display: table-row;
		    vertical-align: inherit;
		    border-color: inherit;
		}
		
		td {
		    display: table-cell;
		    vertical-align: inherit;
		    margin: 0;
		}
		
		th {
		    display: table-cell;
		    vertical-align: inherit;
		    font-weight: bold;
		    margin: 0;
		}
		
		body {
		    -webkit-text-size-adjust: none;
		    font-family: dotum,sans-serif;
		    font-size: 12px;
		    line-height: 1.6;
		    color: #666;
		    margin: 0;
		}
		
		tbody {
		    display: table-row-group;
		    vertical-align: middle;
		    border-color: inherit;
		}
		
		table {
		    border-collapse: collapse;
		    border-spacing: 0;
		    border-color: grey;
		    box-sizing: border-box;
		    display: table;
		}
		
		div {
		    display: block;
		}

	</style>

</head>
	<body>
		<jsp:include page="../include/header.jsp"/>
		<div class="member-container  page-modify page-modify-decoupled-index is-email-change env-production">			
			<h1 class="usermodify-title">회원정보 수정</h1>
			<table class="usermodify-table">
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
							<input data-errmsg="이미 가입된 아이디입니다." data-target="usermodify-id-change-errmsg" name="id" class="usermodify-id-if" type="text">
							<button type="submit" class="usermodify-id-change-auth-send">변경</button>
							<div class="form-err usermodify-id-change-errmsg" style="display: none;"></div>
						</form:form>
						</div>	
					</td>
				</tr>
				<br>
				<tr>
					<th scope="row">닉네임</th>
					<td>
						<div class="usermodify-nickname">
							<strong class="usermodify-nickname-current-mail">${principal.dto.nickname}</strong>
							<button type="button" class="usermodify-nickname-change-btn" style="display: inline-block;">닉네임 변경</button>
							<button type="button" class="usermodify-nickname-change-cancel" style="display: none;">닉네임 변경취소</button>
						<form:form class="usermodify-nickname-change-auth" action="alterNickname" method="post" style="display: none;">
							<input data-errmsg="이미 가입된 닉네임입니다." data-target="usermodify-nickname-change-errmsg" class="usermodify-nickname-if" type="text" name="nickname">
							<button type="submit" class="usermodify-nickname-change-auth-send">변경</button>
							<div class="form-err usermodify-nickname-change-errmsg" style="display: none;"></div>
						</form:form>
						</div>	
					</td>
				</tr>
				<br>
				<tr>
					<th scope="row">휴대폰 번호</th>
					<td>
						<div class="usermodify-phone">
							<strong class="usermodify-phone-current-mail">${principal.dto.phone}</strong>
							<button type="button" class="usermodify-phone-change-btn" style="display: inline-block;">휴대폰 번호 변경</button>
							<button type="button" class="usermodify-phone-change-cancel" style="display: none;">휴대폰 번호 변경취소</button>
						<form:form class="usermodify-phone-change-auth" action="alterPhone" method="post" style="display: none;">
							<input data-errmsg="이미 가입된 휴대폰번호입니다." data-target="usermodify-phone-change-errmsg" class="usermodify-phone-if" type="text" name="phone">
							<button type="submit" class="usermodify-phone-change-auth-send">변경</button>
							<div class="form-err usermodify-phone-change-errmsg" style="display: none;"></div>
						</form:form>
						</div>	
					</td>
				</tr>
				<br>
				<tr>
					<th scope="row">이메일</th>
					<td>
						<div class="usermodify-email">
							<strong class="usermodify-email-current-mail">${principal.dto.email}</strong>
							<button type="button" class="usermodify-email-change-btn" style="display: inline-block;">이메일 변경</button>
							<button type="button" class="usermodify-email-change-cancel" style="display: none;">이메일 변경취소</button>
						<form:form class="usermodify-email-change-auth" action="#" method="post" style="display: none;">
							<input data-errmsg="이미 가입된 이메일입니다." data-target="usermodify-email-change-errmsg" class="usermodify-email-if" type="text" name="email">
							<button type="submit" class="usermodify-email-change-auth-send">인증메일 전송</button>
							<div class="form-err usermodify-email-change-errmsg" style="display: none;"></div>
						</form:form>
						</div>	
					</td>
				</tr>
				<br>
				<tr>
					<th scope="row">비밀번호변경</th>
					<td>
						<div class="usermodify-pw">
							<table class="usermodify-input-table">
								<tbody>
								<tr>
									<th>현재 비밀번호</th>
									<td>
										<input type="password" class="usermodify-pw-currentpassword">
										<div class="member__input-guide-area"></div>
									</td>
								</tr>
								<tr>
									<th>새 비밀번호</th>
									<td>
										<input type="password" data-stronger-password-target="true" class="usermodify-pw-newpassword" name="pw">
										<div class="member__input-guide-area"></div>
									</td>
								</tr>
								<tr>
									<th>비밀번호 다시 입력</th>
									<td>
										<input type="password" data-stronger-password-target="true" class="usermodify-pw-newpassword-confirm">
										<div class="member__input-guide-area"></div>
									</td>
								</tr>
								<tr>
									<td></td>
									<td>
										<button type="button" class="usermodify-password-submit">비밀번호 변경</button>
									</td>
								</tr>
								</tbody>
							</table>
						</div>	
					</td>
				</tr>	
			</sec:authorize>
			</table>
			<div class="usermodify-secession">
				 탈퇴를 원하시면 우측의 회원탈퇴 버튼을 눌러주세요.
				<a class="usermodify-secession-btn" href="#">회원탈퇴</a>
			</div>
			<div class="usermodify-foot">
				<button href="${pageContext.request.contextPath}" type="button" class="usermodify-cancel">나가기</button>
			</div>
		</div>
		<script type="text/javascript">
			
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
			});
		
		</script>
		<jsp:include page="../include/footer.jsp"/>
	</body>
</html>