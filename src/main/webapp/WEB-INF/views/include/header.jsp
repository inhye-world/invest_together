<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<link href="resources/header_footer.css" rel="stylesheet" type="text/css">
	
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
	
	<script>
		$(function() {
			$(".logout-btn").click(function(){
				$("#logout-form").submit();
			});
		});
	</script>
</head>
	<body>
		<form:form id="logout-form" action="${pageContext.request.contextPath}/logout" method="POST"></form:form>
		
		<header>
			<div class="header-ribbon">
				<sec:authorize access="isAnonymous()">
					<c:url value="/loginForm" var="loginForm" />
					<div class="log-box-1">
						<a class="login-a" href="${loginForm}">로그인</a>
					</div>
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
					<sec:authentication var="principal" property="principal"/>
					<div class="log-box-2"> 
				    		<a class="mypage-a">${principal.dto.name}님</a>
				    		<button class="logout-btn">로그아웃 </button>
				    </div>
				</sec:authorize>
			</div>
			<nav class="header-nav">
				<div class="header-nav-hamburger">
					<nav role="navigation">
						<div id="menuToggle">
					    	<input type="checkbox" />
						    <span></span>
						    <span></span>
						    <span></span>
					    	<ul id="menu">
					    		<sec:authorize access="isAnonymous()">
									<c:url value="/loginForm" var="loginForm" />
									<div class="log-box-1">
										<a class="login-a" href="${loginForm}">로그인</a>
									</div>
								</sec:authorize>
								
								<sec:authorize access="isAuthenticated()">
									<sec:authentication var="principal" property="principal"/>
									<div class="log-box-2"> 
								    		<a class="mypage-a">${principal.dto.name}님</a>
								    		<button class="logout-btn">로그아웃 </button>
								    </div>
								</sec:authorize>
					    		<br>
					    		<hr>
					    		<a href="#"><li>가계부</li></a>
						      	<a href="#"><li>월급관리</li></a>
						      	<a href="#"><li>주식·채권</li></a>
						      	<a href="#"><li>계산기</li></a>
						      	<a href="#"><li>구독목록</li></a>
						      	<a href="/into/ranking"><li>투자랭킹</li></a>
						      	<a href="boardList"><li>게시판</li></a>

						    </ul>
					  	</div>
					</nav>
				</div>
				<div class="header-nav-wrap">
					<div class="header-nav-logo">
						<b onclick="location.href='/into/testmain'">같이투자</b>
					</div>
					<div class="header-nav-ul">
						<ul>
							<li>
								<div>
									<p>가계부</p>
								</div>
							</li>
							<li>
								<div>
									<p>월급관리</p>
								</div>
							</li>
							<li>
								<div>
									<p>주식·채권</p>
								</div>
							</li>
							<li>
								<div>
									<p>계산기</p>
								</div>
							</li>
							<li>
								<div>
									<p>구독목록</p>
								</div>
							</li>
							<li>
								<div onclick="location.href='/into/leaderboards'">
									<p>투자랭킹</p>
								</div>
							</li>
							<li>
								<div>
									<p>게시판</p>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</nav>
		</header>
		
	</body>
</html>