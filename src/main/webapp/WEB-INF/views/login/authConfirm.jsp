<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>같이투자 | 회원가입 완료</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
		
		<link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
  		<script src="resources/sb_admin/js/ast-notif-sign_up.js"></script>
	
		<script type="text/javascript">

		function alerting(content){
			AstNotif.dialog('알림', content, {
	    	  theme: 'default',
	    	});
		}
		
		$(document).ready(function (){
		
		alerting('회원가입을 축하합니다. 이제 로그인이 가능 합니다.');
		
		});
		
		</script>
	
	</head>
	
	<body>
		
	</body>
</html>