<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
		
</head>
	<body>
		
		<script type="text/javascript">
			alert("이메일이 전송되었습니다. 메일 인증 후 정상적으로 로그인이 가능합니다.")
		</script>
		
		<div class="wrapper">
			<jsp:include page="../main/header.jsp"/>
			<div class="loginSucceed">
				<br><br><br><br>
				
				<h3 style="align:center">회원가입이 완료 되었습니다 </h3>
				<h3 style="align:center">이메일 인증 후 정상적으로 로그인이 가능합니다.</h3>
				<br><br><br>
			</div>
			<jsp:include page="../main/footer.jsp"/>
		</div>
	</body>
</html>