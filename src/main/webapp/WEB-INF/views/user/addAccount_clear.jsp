<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<link href="../resources/header_footer.css" rel="stylesheet" type="text/css">
	
	<style>
		footer:{ 
		     position:fixed; 
		     left:0px; 
		     bottom:0px; 
		     width:100%; 
		     
}
		}
		h3{
			text-align:center;
		}
	
	</style>
</head>
	<body>
		<jsp:include page="../main/header.jsp"/>
		<div class="wrapper">
			<div class="container">
				
				<br><br><br><br>
				
				<h3>계좌 등록이 완료 되었습니다 </h3>
				
				<br><br><br>
				<a href="/into">홈으로</a>
			</div>
		</div>

		<footer>
		<jsp:include page="../main/footer.jsp"/>
		</footer>

	</body>
</html>