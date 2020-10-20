<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>같이투자 | 가계부</title>
   <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
 <body>
      <div class="wrapper">
         <jsp:include page="../main/header.jsp"/>
            <div id="empty">
	               <br><br><br><br><br>
	               <h2 style="text-align:center">이번달 내역이 없습니다</h2>
	               <br><br><br><br><br><br><br>   
            </div>
         <jsp:include page="../main/footer.jsp"/>   
      </div>
      
   </body>

</html>