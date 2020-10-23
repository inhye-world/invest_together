<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="utf-8">
	    <meta http-equiv="x-ua-compatible" content="ie=edge">
	    
	    <title> 같이투자 | 게시판</title>
	    
	    <meta name="description" content="">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <link rel="manifest" href="site.webmanifest">
	    <link rel="shortcut icon" type="image/x-icon" href="resources/main/assets/img/favicon.ico">
		
		<link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
  		<script src="resources/sb_admin/js/ast-notif.js"></script>
		
	</head>
	
	<style>
		
		.table .write-submit{
			padding-bottom: 100px;
		}
		
		.container{
			padding-top: 100px;
		}
		
		.hero-cap h2 {
		    color: #072366;
		    font-size: 35px;
		    font-weight: 600;
		    text-transform: capitalize;
		    line-height: 1;
		    padding-bottom: 30px;
		}
		
	</style>
	
	
	<body>
	<jsp:include page="../main/header.jsp"/>
	
      <div class="container">
       <div class="hero-cap">
          <h2>글쓰기</h2>
       </div>
      <div class="col-lg-12 posts-list">
		<table class="table">
		
		<sec:authorize access="isAuthenticated()">
		<sec:authentication var="principal" property="principal"/>
		
		<form:form class="boardWrite-form" action="boardWrite" method="post">
			<tr>
				<td> 작성자 </td>
				<td> ${principal.dto.nickname} </td>
			</tr>
			<tr>
				<td> 제목 </td>
				<td> <input id="board_title" type="text" name="board_title" size = "50" maxlength="40"> </td>
			</tr>
			<tr>
				<td> 내용 </td>
				<td><textarea id="board_content" name="board_content" rows="10" cols="50" maxlength="500"></textarea></td>
			</tr>
			<tr>
				<td class="write-submit" colspan="2">
					<input type="hidden" name="board_name" value="${principal.dto.nickname}"> 
					<input class="button button-contactForm btn_1 boxed-btn" id="board_submit" type="submit" value="입력"> &nbsp;&nbsp; 
					<a class="button button-contactForm btn_1 boxed-btn" href="boardList">목록보기</a>
				</td>
			</tr>
		</form:form>
		</sec:authorize>	
	    </table>
	  </div>
	</div>
	
	<!-- footer -->
   <jsp:include page="../main/footer.jsp"/>
	
	<script type="text/javascript">
	
		function alerting(content){
			AstNotif.dialog('알림', content, {
	    	  theme: 'default',
	    	});
		}
		
		$(document).ready(function (){
			
			$(".boardWrite-form").on("submit", function() {
			
			if($('#board_title').val()==''){
				event.preventDefault();
				alerting("제목을 입력해주세요.");
				
			} else if ($('#board_content').val()==''){
				event.preventDefault();
				alerting("내용을 입력해주세요.");
			}
			
			});
		});
		
	</script>
	
	</body>
</html>