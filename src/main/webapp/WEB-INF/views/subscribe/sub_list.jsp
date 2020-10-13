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
	<title>같이투자 구독목록</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<link href="resources/ranking.css" rel="stylesheet" type="text/css">
	<link href="resources/sub.css" rel="stylesheet" type="text/css">
	
	<script src="resources/sb_admin/vendor/chart.js/Chart.min.js"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
	
	<script>
		$(function() {
			$(".header-nav ul li").removeClass("header-li-active");
			$(".header-nav ul li:nth-child(5)").addClass("header-li-active");
		});
	</script>
</head>
	<body>
	<jsp:include page="../include/header.jsp"/>
	
		<div class="container mt-4 mb-4 px-0">
			<div class="sub-list">
				<div>
					<span class="sub-list-mylist">
						내 구독 목록
					</span>
				</div>
				<table class="table leaderboards">
					<thead>
						<tr>
							<th>닉네임</th>
							<th>수익률</th>
							<th>수익금액</th>
							<th>투자금액</th>
							<th>구독시작</th>
							<th>구독만료</th>
							<th>상세정보</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list}">
							<tr>
								<td colspan="7">
								</td>
							</tr>
						</c:if>
						
						<c:forEach var="dto" items="${list}">
							<tr>
								<td>${dto.sub_maturity_date}</td>
								<td>${dto.seller_nickname}</td>
								<td>${dto.seller_num}</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	
	<jsp:include page="../include/footer.jsp"/>
	</body>
</html>