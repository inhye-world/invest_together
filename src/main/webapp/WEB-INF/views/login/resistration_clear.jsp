<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>

	
	<link href="resources/temporary.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
  	<script src="resources/sb_admin/js/ast-notif.js"></script>
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	

</head>
	<body>
	<script>
		
		function alerting(content){
    		AstNotif.dialog('알림', content, {
        	  theme: 'default',
        	});
    	}
	</script>
		
		<script type="text/javascript">
			alerting("이메일이 전송되었습니다. 메일 인증 후 정상적으로 로그인이 가능합니다.")
		</script>
		
		<div class="wrapper">
			<jsp:include page="../main/header.jsp"/>
			<div class="loginSucceed">
				<br><br><br><br><br>
				
				<h3 style="text-align:center">회원가입이 완료 되었습니다 </h3>
				<h3 style="text-align:center">이메일 인증 후 정상적으로 로그인이 가능합니다.</h3>
				<br><br><br><br><br><br>

			</div>
			<jsp:include page="../main/footer.jsp"/>
		</div>
	</body>
</html>