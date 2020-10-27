<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>같이투자 | 회원가입 완료</title>

	
	<link href="resources/temporary.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
  	<script src="resources/sb_admin/js/ast-notif.js"></script>
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
	<style>
	   	.wrapper{
	   		margin: 10% 0;
	   	}
    </style>
</head>
	<body>
		<jsp:include page="../main/header.jsp"/>
		<div class="wrapper">
			<div class="loginSucceed">
				<h3 style="text-align:center">회원가입이 완료 되었습니다 </h3>
				<h3 style="text-align:center">이메일 인증 후 정상적으로 로그인이 가능합니다.</h3>
			</div>
		</div>
		<jsp:include page="../main/footer.jsp"/>
		
		<script type="text/javascript">
		
			function alerting(content){
		   		AstNotif.dialog('알림', content, {
		       	  theme: 'default',
		       	});
		   	}
		
			alerting("이메일이 전송되었습니다. 메일 인증 후 정상적으로 로그인이 가능합니다.")
		</script>
	</body>
</html>