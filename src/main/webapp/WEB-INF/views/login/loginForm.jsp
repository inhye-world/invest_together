<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>로그인 페이지</title>

    <link href="resources/temporary.css" rel="stylesheet" type="text/css">
    
    <style>
    	.contain{
    		margin: auto;
			margin-top: 100px;
			margin-bottom: 100px;
    	}
    	
    	.loginForm a{
    		color: #072366;
    		font-weight: 700;
    	}
    	
    </style>
       
</head>

	<body>
	<jsp:include page="../main/header.jsp"/>
	
		<div class="wrapper">
				<div class="contain loginForm col-xl-4 col-lg-4">
				
				
				<h2>아이디와 비밀번호를 입력해주세요</h2> 
				<br><br>
				
				<c:url value="/login" var="loginUrl" />
				
				<form:form class="login-form" name="f" action="${loginUrl}" method="POST">
				    			    
				    <input type="text" name="id" placeholder="아이디"/><br>
				    <input type="password" name="password" placeholder="비밀번호"/><br>
				    
				    <div>${requestScope.loginFailMsg}</div>
				    
				    <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
				    
				    <button type="submit" class="button5">로그인</button><br>
				    
				</form:form>
					
					<br>
					<fieldset>
						<legend>&nbsp;또는&nbsp;</legend>
					</fieldset>
					<br>
					
					<div class="kakao-btn" onclick="location.href='${kakao_url}'">
						<span class="btn-span1">
							<img src="resources/sns_login_img/kakao.png" width="50px" height="50px"/>	
						</span>
						<span class="btn-span2">
							카카오 로그인
						</span>
					</div>
					<div class="naver-btn" onclick="location.href='${naver_url}'" >
						<span class="btn-span1">
							<img src="resources/sns_login_img/naver.png" width="50px" height="50px"/>	
						</span>
						<span class="btn-span2">
							네이버 로그인
						</span>
					</div>
					
					<div class="loginForm-footer">
						<span>
							<a onmouseover="this.style.color='#09cc7f'" onmouseout="this.style.color='#072366'" href="idFind">아이디 찾기</a>
							<a> |</a>
						</span>
						<span>
							<a onmouseover="this.style.color='#09cc7f'" onmouseout="this.style.color='#072366'" href="pwFind">비밀번호 찾기</a>
						</span>
						<span>
							<a onmouseover="this.style.color='#09cc7f'" onmouseout="this.style.color='#072366'" href="registrationForm">회원가입</a>
						</span>
					</div>
	
			</div>
		</div>
		
	<!-- footer -->
	<jsp:include page="../main/footer.jsp"/>
	</body>
</html>
