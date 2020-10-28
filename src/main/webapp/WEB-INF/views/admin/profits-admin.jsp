<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>같이투자 | 매출관리</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
 	<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
	
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
	
	<link href="resources/sb_admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<!-- alert -->
  	<link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
  	<script src="resources/sb_admin/js/ast-notif.js"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
	
	<link href="resources/sb_admin/css/bttn.css" rel="stylesheet" type="text/css">
	<link href="resources/ranking.css" rel="stylesheet" type="text/css">
	<link href="resources/assets.css" rel="stylesheet" type="text/css">
</head>
	<body>
	<jsp:include page="../main/header.jsp"/>
	
		<div class="container mt-4 mb-4 px-0">
			울 회사 매출 몇?	
		</div>
	
	<jsp:include page="../main/footer.jsp"/>
	
		
		<script src="resources/sb_admin/vendor/chart.js/Chart.min.js"></script>
	
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		
		<script src="resources/tableExport/tableExport.min.js" type="text/javascript"></script>
		<script src="resources/tableExport/xlsx.core.min.js" type="text/javascript"></script>
		<script src="resources/tableExport/FileSaver.min.js" type="text/javascript"></script>
	</body>
</html>