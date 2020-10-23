<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<!doctype html>
<html class="no-js" lang="zxx">
<head>
   <meta charset="utf-8">
   <meta http-equiv="x-ua-compatible" content="ie=edge">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   
   <title> 같이투자 | 공지사항</title>
   <meta name="description" content="">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="shortcut icon" type="image/x-icon" href="resources/main/assets/img/favicon.ico">

	<style>
		
		.form-group textarea.form-control {
		    height: 100px;
		    margin-bottom: 25px;
		    font-size:17px;
		}
	
		.container{
			padding-top: 100px;
			padding-bottom: 100px;
		}
		
		.comments-area .comment{
		    overflow-wrap: anywhere;
		}
		
		.pagination {
	    	place-content: center;
		}
		
		.hero-cap h2 {
		    color: #072366;
		    font-size: 35px;
		    font-weight: 600;
		    text-transform: capitalize;
		    line-height: 1;
		    padding-bottom: 30px;
		}
		
		.btn-delete {
			cursor: pointer;
		}
		
		.blog_details {
			height: 300px;
		}
		
		.blog-info-link li {
			font-family: 'Jeju Gothic';
		}
		
	</style>
	
<body>
  <jsp:include page="../main/header.jsp"/>
     <main>
         <div class="container">
         	<div class="hero-cap">
                 <h2>공지사항</h2>
            </div>
               <div class="col-lg-11 posts-list">
                  <div class="single-post">       
                     <div class="blog_details">
                        <h2 style="color: #2d2d2d;">${notice.notice_title}</h2>
                        <ul class="blog-info-link mt-3 mb-4">
                           <li><i>작성자: </i>관리자</li>
                           <li><i>작성일: </i><fmt:formatDate value="${notice.notice_date}"/></li>
                           <li><i>조회수: </i>${notice.notice_hit}</li>
                        </ul>
                        <p class="excert">
                           ${notice.notice_content}
                        </p>
                     </div>
                  </div>
				  <br>
				  <sec:authorize access="hasRole('ROLE_ADMIN')">
					  <sec:authentication var="principal" property="principal"/>	  
	                  <c:if test="${notice.notice_name eq principal.dto.nickname}">
		                  <a class="button button-contactForm btn_1 boxed-btn" onclick="location.href='modify_notice?notice_num=${notice.notice_num}'">수정</a> &nbsp;&nbsp; 
		                  <a class="button button-contactForm btn_1 boxed-btn" onclick="location.href='noticeDelete?notice_num=${notice.notice_num}'">삭제</a> &nbsp;&nbsp; 
					  </c:if>
				  </sec:authorize>
				  <a class="button button-contactForm btn_1 boxed-btn" onclick="location.href='${pageContext.request.contextPath}/boardList'">목록보기</a>                
                  
               </div>
           </div>  
   		</main>
   
   	<!-- footer -->
	<jsp:include page="../main/footer.jsp"/>
      
   </body>
</html>