<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix ="javatime" uri="http://sargue.net/jsptags/time" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<!DOCTYPE html>
<html>
<style>
		.test1{
			text-align:center;
		}
		.test3{
			text-align:center;
			background-color: #212529;
			color:#ffffff;
		}
		#test2{
			text-align:center;
			background-color: #fef7f7;
			color: #ed6767;
		}

		.wrapper{
			margin:30px 30px 30px 50px;
		}
		
		 tbody {
            height: 190px; 
            overflow-y: scroll;
        }
      
       th,td {
            padding: 5px 8px; 
            border: 1px solid #ddd; 
            width: 190px;
        }
        
      #salary-table {
             border-collapse: collapse; 
        }
        
         thead,tbody {
            display: block;
        }
       
		::-webkit-scrollbar-track
		{
			-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0);
			background-color: #ffffff;
		}
		
		::-webkit-scrollbar
		{
			width: 6px;
			background-color: lightgray;
		}
		::-webkit-scrollbar-thumb
		{
			background-color: #ffffff;
			
		}
		
</style>
<head>
	<meta charset="UTF-8">
	<title>같이투자 | 통장내역</title>
	<link href="resources/ranking.css" rel="stylesheet" type="text/css">
	<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
</head>
	<body>
	<div class="wrapper">
		<div>
            	  <div class="ranking-reague">
					<ul>
						<li>
							<div>
								 <h4 style="font-weight: bold; color:#032380;">통장 내역</h4>
							</div>
						</li>
					</ul>
				</div>
				
            	  <ul class="ranking-notice">
            	  <li> 
            	  	<sec:authorize access="isAuthenticated()">
					<sec:authentication var="principal" property="principal"/>
					<P data-animation="fadeInUp" data-delay=".8s"><span style="color:#2B66A0;">${principal.dto.name}</span> 님의 해당통장에 대한 내역을 보여드립니다.</P>
					</sec:authorize>    
					</li>
				</ul>
    	</div>
		<table id="salary-table" class="table">
				<thead>
					<tr >
							<th class="test3">회차</th>
							<th class="test3">납입일</th>
							<th class="test3">납입금</th>
							<th class="test3">납입 후 잔액</th>
							<th class="test3">입금 분류</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="account" items="${accountTransactionList}" varStatus="status">
							<tr>
								<td class="test1">${status.count} 회차</td>
								<td class="test1"><javatime:format value="${account.tran_date_time}" pattern=" yyyy-MM-dd HH:mm:ss"/></td>
								<td class="test1" id="test2"><fmt:formatNumber type="number" maxFractionDigits="3" value="${account.tran_amt}" /> 원</td>
								<td class="test1" id="test2"><fmt:formatNumber type="number" maxFractionDigits="3" value="${account.after_balance_amt}"/> 원</td>
								<td class="test1">${account.branch_name}</td>	
							</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		</body>
</html>