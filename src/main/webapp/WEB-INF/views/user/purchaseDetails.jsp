<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 

<!DOCTYPE html>
<html>

<head>
	
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  
  <!-- alert -->
  <link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
  <script src="resources/sb_admin/js/ast-notif.js"></script>

  <title>같이투자 | 거래내역</title>
  
</head>

	<style>
		.container{
			padding-top: 150px;
			padding-bottom: 300px;
		}
		
		.setPrice{
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
	
			<div class="container">
				<div class="setPrice">
					<div class="hero-cap">
		                 <h2>보유자산 판매금액 설정</h2>
		            </div>  
					
				    <form:form class="setPrice-form" action="setPrice" method="post">
	            		<input type="text" name="set_price" placeholder="판매금액" maxlength="8">
	            		<input type="submit" value="입력"> 
	            	</form:form>
	            	
	            	<sec:authorize access="isAuthenticated()">
				  	<sec:authentication var="principal" property="principal"/>
	            	
	            	<div>
	            		<p>현재 판매금액 :${principal.dto.set_price} </p>
	            	</div>
	            	
	            	</sec:authorize>
				</div>
					
			    <div class="hero-cap">
	                 <h2>거래내역</h2>
	            </div>     
	            
					<table class="table leaderboards">
						<thead>
							<tr>
								<th>구매일</th>
								<th>판매자 아이디</th>
								<th>거래대금</th>
								<th>만료일</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty list}">
								<tr>
									<td class="sub-list-empty" colspan="7">아직 구독한 회원이 없습니다</td>
								</tr>
							</c:if>
							
							<c:forEach var="dto" items="${list}" varStatus="status">
								<tr>
									<td><fmt:formatDate value="${dto.sub_date}" pattern="yyyy-MM-dd" /></td>
									<td>${dto.seller_nickname}</td>
									<td>${dto.sub_price}</td>
									<td><fmt:formatDate value="${dto.sub_maturity_date}" pattern="yyyy-MM-dd" /></td>
								</tr>
								
							</c:forEach>
						</tbody>
					</table>
				</div>
	   <!-- footer -->
	   <jsp:include page="../main/footer.jsp"/>
	</body>
</html>
    