<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>비밀번호 찾기</title>
      <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
      <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
      <link href="resources/find.css" rel="stylesheet" type="text/css">
		
		<style type="text/css">
			
			.user-info {
				color: black;
				font-weight: 800;
				font-size: 20px;
			}
			
			.button__text {
				color: black;
			}
			
		</style>
      
      
   </head>
   <body>
   	 <jsp:include page="../main/header.jsp"/>
      <div class="container">
         <header class="header-pw">
         </header>         
         <!-- body -->
         <section class="content content--login">
            <div class="content__body">
               <div class="content__body__page">
                  <h2>아이디 찾기</h2>
                  <section class="login">
                     <article class="notification">
                        <div class="notification_pic">
                           <img src=" //d2h5doj4xlbun0.cloudfront.net/member-0.0.1367/
							images/member/member_status_img3.jpg">   
                        </div>                        
                        <dl class="notification__txt">
                           <dt></dt>
                           <dt>
                              	회원님의 본인인증 정보로 검색된 아이디는
                              <br>
                              <span class="color-blue">      
                             	 총${fn:length(id)}개
                              </span>
                              	입니다.
                           </dt>
                        </dl>   
                     </article>
                     <article class="user-area">
                     <div class="user-info">
                     <c:forEach items="${id}" var="dto">
                        <c:if test="${dto.sns_type eq 'normal'}">▷${dto.id}</c:if>
                     
                     <br><c:if test="${dto.sns_type eq 'kakao'}">▷카카오 계정</c:if>         
                     
                     <c:if test="${dto.sns_type eq 'naver'}">▷네이버 계정</c:if>    
                     </c:forEach>
                     </div>
                     </article>
                     <br>
                     <button class="button button--base-m button--shape-a" onclick="location.href='pwFind'">
                        <span class="button__text">비밀번호 찾기</span>
                     </button>
                     
                     <button class="button button--base-m button--shape-a" onclick="location.href='loginForm'">
                        <span class="button__text">로그인 페이지로 이동</span>
                     </button>
                     
                  </section>
               </div>   
            </div>      
         </section>
      </div>
      
     <!-- footer -->
	<jsp:include page="../main/footer.jsp"/>
      
   </body>
</html>