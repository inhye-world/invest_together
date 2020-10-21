<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!doctype html>
<html class="no-js" lang="zxx">
<head>
   <meta charset="utf-8">
   <meta http-equiv="x-ua-compatible" content="ie=edge">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   
   <title> 같이투자 | 게시판</title>
   <meta name="description" content="">
   <meta name="viewport" content="width=device-width, initial-scale=1">

   <link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
   <script src="resources/sb_admin/js/ast-notif.js"></script>
  	
</head>
	
	<style>
		
		#command textarea.form-control {
		    height: 400px;
		    margin-bottom: 25px;
		    font-size:20px;
		}
		
		.container{
			padding-top: 100px;
		}
		
		.modify_button{
			padding-bottom: 100px;
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
   	 <main>
      <!--? Blog Area Start -->
         <div class="container">
            <div class="hero-cap">
               <h2>글수정</h2>
            </div>
               <div class="col-lg-11 posts-list">
                  <div class="single-post">       
                     <div class="blog_details">
                        <h2 style="color: #2d2d2d;">${modify_view.board_title}</h2>
                        <ul class="blog-info-link mt-3 mb-4">
                           <li><i>작성자:</i>${principal.dto.nickname}</a></li>
                           <li><i>작성일:</i><fmt:formatDate value="${modify_view.board_date}"/></a></li>
                           <li><i>조회수:</i>${modify_view.board_hit}</a></li>
                        </ul>
                        <form:form class="boardModify-form" action="boardModify">
                        <textarea class="form-control w-100" id="board_content" name="board_content" maxlength="2000">${modify_view.board_content}</textarea>             
                     </div>
                  </div>
				  <br>
				  <div class="modify_button">
				  <input type="hidden" name="board_num" value=${modify_view.board_num}>
                  <button type="submit" class="button button-contactForm btn_1 boxed-btn">확인</button> &nbsp;&nbsp; 
                  <a class="button button-contactForm btn_1 boxed-btn" onclick="location.href='boardDelete?board_num=${modify_view.board_num}'">삭제</a> &nbsp;&nbsp; 
				  <a class="button button-contactForm btn_1 boxed-btn" onclick="location.href='${pageContext.request.contextPath}/boardList'">목록보기</a>                
                  </div>
                  </form:form>
            </div>
        </div>
     
      <!-- Blog Area End -->
   </main>
   
   <!-- footer -->
   <jsp:include page="../main/footer.jsp"/>
      
   <script type="text/javascript">
	
		function alerting(content){
			AstNotif.dialog('알림', content, {
	    	  theme: 'default',
	    	});
		}
		
		$(document).ready(function (){
			
			$(".boardModify-form").on("submit", function() {
			
			if($('#board_content').val()==''){
				event.preventDefault();
				alerting("내용을 입력해주세요.");
			}
			
			});
		});
		
	</script> 
      
   </body>
</html>