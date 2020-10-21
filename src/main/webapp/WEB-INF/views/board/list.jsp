<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="utf-8">
	    <meta http-equiv="x-ua-compatible" content="ie=edge">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	    
	    <title> 같이투자 | 게시판</title>
	    
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <link rel="manifest" href="site.webmanifest">
	    <link rel="shortcut icon" type="image/x-icon" href="resources/main/assets/img/favicon.ico">
	
	</head>

	<style>
	
		.table .title{
			font-weight: bold;
		    background-color: whitesmoke;
		}
	
		.container{
			padding-top: 100px;
			font-family: 'Noto Sans KR', sans-serif;
    		font-weight: 500;
		}
	
		.pagination {
	    	justify-content: center;
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
		
		.notice-btn{
		  display: inline-block;
		  outline: none;
		  line-height: 25px;
		  padding: 0 15px;
		  font-size: .9em;
		  text-align: center;
		  text-decoration: none;
		  font-weight: 500;
		  cursor: pointer;
		  -webkit-transition: all 0.3s ease 0s;
		  -moz-transition: all 0.3s ease 0s;
		  -o-transition: all 0.3s ease 0s;
		  transition: all 0.3s ease 0s;
		  color: #fff;
 		  background: #f44a40;
 		  border: 1px solid transparent;
		}
			
	</style>
	
	<body>
		<jsp:include page="../main/header.jsp"/>
		
		  <div class="container">
		     <div class="hero-cap">
                 <h2>자유게시판</h2>
             </div>     
				<table class="table">
					<tr class="title">
						<td>글번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>작성일</td>
						<td>조회수</td>
					</tr>
					<c:forEach items="${nlist}" var="ndto">
					<tr id="content" onmouseover="this.style.backgroundColor='rgba(9, 204, 127, 0.4)'" onmouseout="this.style.backgroundColor='white'" onclick="location.href='notice_view?notice_num=${ndto.notice_num}'">
						<td><button class="notice-btn">공지</button></td>
						<td class="point">${ndto.notice_title}</td>
						<td>관리자</td>
						<td><fmt:formatDate value="${ndto.notice_date}" dateStyle="full" /></td>
						<td>${ndto.notice_hit}</td>
					</tr>
					</c:forEach>
					<c:forEach items="${list}" var="dto">
					<tr id="content" onmouseover="this.style.backgroundColor='rgba(9, 204, 127, 0.4)'" onmouseout="this.style.backgroundColor='white'" onclick="location.href='content_view?board_num=${dto.board_num}'">
						<td>${dto.board_num}</td>
						<td class="point">${dto.board_title}</td>
						<td>${dto.board_name}</td>
						<td><fmt:formatDate value="${dto.board_date}" dateStyle="full" /></td>
						<td>${dto.board_hit}</td>
					</tr>
					</c:forEach>
				</table>
				<tr>
					<td colspan="5"> <input class="button button-contactForm btn_1 boxed-btn" onclick="location.href='write_view'" type="button" value="글작성"/> </td>
				</tr>
			</div>			
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li class="page-item">
				      	<a class="page-link" href="boardList${pageMaker.makeQuery(pageMaker.startPage - 1) }" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					        <span class="sr-only">Previous</span>
				    	</a>
				    </li>
				</c:if>
				
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					<li class="page-item ${pageMaker.cri.page_num == idx?'active':''}"><a class="page-link" href="boardList${pageMaker.makeQuery(idx)}">${idx}</a></li>
				</c:forEach>
				
				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li class="page-item">
					    <a class="page-link" href="boardList${pageMaker.makeQuery(pageMaker.endPage +1) }" aria-label="Next">
						    <span aria-hidden="true">&raquo;</span>
						    <span class="sr-only">Next</span>
					    </a>
					</li>
				</c:if>
			</ul>
			
	<!-- footer -->
	<jsp:include page="../main/footer.jsp"/>	
		
	</body>
</html>