<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<html>
	<head>
		<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
		<link rel="shortcut icon" type="image/x-icon" href="resources/main/assets/img/favicon.ico">
	    
	    <!-- alert -->
	    <link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
  		<script src="resources/sb_admin/js/ast-notif.js"></script>
		
	    <title>같이투자</title>

	</head>
	
	<body>

		<script>
			  var msg = ${msg};
			  
			  function alerting(content){
				  AstNotif.snackbar(content, {
					  theme: 'default',
					});
            	}
			
			  if(msg == 1) {
					alerting('입력에 성공했습니다.');
					setTimeout(() => {  window.location.href = "target"; }, 1000);
					
				}
			  
			  if(msg == 2) {
					alerting('입력에 실패했습니다.');
					setTimeout(() => {  window.location.href = "target"; }, 1000);
				}

		</script>
		
	</body>
</html>