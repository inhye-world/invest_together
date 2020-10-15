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
   
   <title> 같이투자 | 게시판</title>
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
		
	</style>
	
<body>
  <jsp:include page="../main/header.jsp"/>
     <main>
      <!--? Blog Area Start -->
         <div class="container">
         	<div class="hero-cap">
                 <h2>자유게시판</h2>
            </div>
               <div class="col-lg-11 posts-list">
                  <div class="single-post">       
                     <div class="blog_details">
                        <h2 style="color: #2d2d2d;">${content_view.board_title}</h2>
                        <ul class="blog-info-link mt-3 mb-4">
                           <li><i>작성자:</i>${content_view.board_name}</a></li>
                           <li><i>작성일:</i><fmt:formatDate value="${content_view.board_date}"/></a></li>
                           <li><i>조회수:</i>${content_view.board_hit}</a></li>
                        </ul>
                        <p class="excert">
                           ${content_view.board_content}
                        </p>
                     </div>
                  </div>
				  <br>
				  <sec:authorize access="isAuthenticated()">
				  <sec:authentication var="principal" property="principal"/>
				  
                  <c:if test="${content_view.board_name eq principal.dto.nickname}">
	                  <a class="button button-contactForm btn_1 boxed-btn" onclick="location.href='modify_view?board_num=${content_view.board_num}'">수정</a> &nbsp;&nbsp; 
	                  <a class="button button-contactForm btn_1 boxed-btn" onclick="location.href='boardDelete?board_num=${content_view.board_num}'">삭제</a> &nbsp;&nbsp; 
				  </c:if>
				  
				  </sec:authorize>
				  <a class="button button-contactForm btn_1 boxed-btn" onclick="location.href='${pageContext.request.contextPath}/boardList'">목록보기</a>                
                  
                  <div class="navigation-top">
                  <div class="comments-area">
                  
                     <h4>${total} comments</h4>
                     
                     <c:forEach items="${comments}" var="dto">
	                     <div class="comment-list" id="${dto.comment_num}">
	                        <div class="single-comment justify-content-between d-flex">
	                           <div class="user justify-content-between d-flex">
	                              <div class="thumb">
	                                 <img src="resources/main/assets/img/blog/profile.jpeg" alt="">
	                              </div>
	                              <div class="desc">
	                                 <p class="comment">
	                                    ${dto.comment_content}
	                                 </p>
	                                 <div class="d-flex justify-content">
	                                    <div class="d-flex align-items-center">
	                                       <h5>
	                                          <a>${dto.comment_name}</a>
	                                       </h5>
	                                       <a class="date"><fmt:formatDate value="${dto.comment_date}" dateStyle="full" /></a>
	                                    </div>
	                                    <c:if test="${dto.comment_name eq principal.dto.nickname}">
	                                    <div class="reply-btn">&nbsp;&nbsp;
	                                       <a type="button" class="btn-modity" onmouseover="this.style.color='#09CC7F'" onmouseout="this.style.color='black'">수정</a>
	                                    </div>
	                                    <div>&nbsp;&nbsp;
	                                       <a type="button" class="btn-delete" onclick="location.href='${pageContext.request.contextPath}/delete_comments?board_num=${content_view.board_num}&comment_num=${dto.comment_num}'" onmouseover="this.style.color='#09CC7F'" onmouseout="this.style.color='black'">삭제</a>
	                                    </div>
	                                    </c:if>
	                                 </div>
	                              </div>
	                           </div> 
	                        </div>
	                     </div>
	                     <div id="comments-${dto.comment_num}">
	                     	<div class="reply-comments" style="display: none;">
	                        	<form:form class="reply-comments-form" action="modify_comments" id="commentForm">
	                       	<div class="col-12">
	                          <div class="form-group">
	                             <textarea class="form-control w-100" name="comment_content" id="comment" maxlength="200"
	                                placeholder="${dto.comment_content}"></textarea>
			                  </div>
			                </div>
			                  <div class="form-group">
			                     <input type="hidden" name="comment_num" value="${dto.comment_num}"> 
			                     <input type="hidden" name="board_num" value="${content_view.board_num}">
			                     <button type="submit" class="button button-contactForm btn_1 boxed-btn">수정하기</button>
	                    	  </div>
	              				</form:form>
	                       	</div>
	                     </div>        
	                     <script>
	                     	$("#"+${dto.comment_num}+" .btn-modity").click(function() {
	                     		$("#comments-"+${dto.comment_num}+" .reply-comments").css("display", "block");
	                     	});
	                     </script>                  
                     </c:forEach>
                     <ul class="pagination">
                      <c:if test="${content_view.board_num eq pageMaker.board_num}">
						<c:if test="${pageMaker.prev}">
							<li class="page-item">
						      	<a class="page-link" href="content_view${pageMaker.makeQuery(pageMaker.startPage - 1) }&board_num=${content_view.board_num}" aria-label="Previous">
							        <span aria-hidden="true">&laquo;</span>
							        <span class="sr-only">Previous</span>
						    	</a>
						    </li>
						</c:if>
						
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
							<li class="page-item ${pageMaker.cri.page_num == idx?'active':''}"><a class="page-link" href="content_view${pageMaker.makeQuery(idx)}&board_num=${content_view.board_num}">${idx}</a></li>
						</c:forEach>
						
						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li class="page-item">
							    <a class="page-link" href="content_view${pageMaker.makeQuery(pageMaker.endPage +1) }&board_num=${content_view.board_num}" aria-label="Next">
								    <span aria-hidden="true">&raquo;</span>
								    <span class="sr-only">Next</span>
							    </a>
							</li>
						</c:if>
					  </c:if>
					</ul>
                  </div>
                  <div class="comment-form">
                     <h4>Leave a Reply</h4>
                     <form:form class="form-contact comment_form" action="writeComment" id="commentForm">
                           <div class="col-12">
                              <div class="form-group">
                                 <textarea class="form-control" name="comment_content" id="comment" cols="50" rows="15" placeholder="Write Comment"></textarea>
                              </div>
                           </div>
                        <div class="form-group">
						   <input type="hidden" name="comment_name" value="${principal.dto.nickname}">                        
                           <input type="hidden" name="board_num" value="${content_view.board_num}">
                           <button type="submit" class="button button-contactForm btn_1 boxed-btn">댓글 입력</button>
                        </div>
                     </form:form>
                  </div>
               </div>
            </div>  
      <!-- Blog Area End -->
   		</main>
   
   	<!-- footer -->
	<jsp:include page="../main/footer.jsp"/>
      
   </body>
</html>