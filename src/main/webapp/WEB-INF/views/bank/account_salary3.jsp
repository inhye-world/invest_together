<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
					
</head>
	<body>
		
		<div class="wrapper">
		<jsp:include page="../include/header.jsp"/>
			
			<div class="container container2">
				<a class="mainA" href="/into"> 같이투자 API TEST</a>
				<br><br><br>
				
				<div class="account-list">
					<h2>-월급관리-</h2>
					
					<div class="btn-list">
						<button class="button4">전체선택</button>
						<button class="button4" type="submit" onclick="javascript: form.action='/deleteSalary';">삭제</button>
					</div>
					
					<form:form id="salary-modify-form" name="salary-modify-form" method = "post">
						<table id="account-table" class="table">
							<thead>
								<tr>
									<th></th>	
									<th>카테고리</th>
									<th>통장이름</th>
									<th>은행/증권사</th>
									<th>연이자(%)</th>
									<th>예상입금액</th>
									<th>누적액</th>
									<th>만기</th>
									<th></th>
								</tr>
							</thead>
							
							<tbody>
							
								<c:forEach var="salary" items="${accountSalaryList}" varStatus="status">
								<tr id="salary-${status.index}">
									
									<td><input type="checkbox" /></td>
									<td><input type="text" name="category" id="category" value="${salary.category}" disabled=""/></td>
									<td>${salary.account_alias}</td>
									<td>${salary.bank_name}</td>
									<td><input type="text" name="interest" id="interest" value="${salary.interest}" disabled/></td>
									<td><input type="text" name="expected_amt" id="expected_amt" value="${salary.expected_amt}" disabled/></td>
									<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${salary.balance_amt}" />원</td>
									<td>${salary.strMaturity}</td>
									<!-- 초기화면은 dto값 불러오기만 하고, 수정을 클릭하면 input 박스가 생기도록 할것 -->
									<!-- <td><input style="border:none" type="date" name="strMaturity" id="strMaturity" value="${salary.maturity}"/></td> -->
									<td><input style="border:none" type="hidden" name="fintech_use_num" value="${salary.fintech_use_num}" /><button type="button" id="modifyBtn-${status.index}">수정</button></td>
									
								</tr>
								
								<script>
									var count = ${status.count}
								</script>
							</c:forEach>
							 
							</tbody>
					</table>
					</form:form>
					
				</div>
				
		
			</div>
		
		</div>
		
		<script>
		//한줄씩 만들기
			for(var i=0; i<count; ++i) {
				(function(j) {
					$("#modifyBtn-"+j).click(function() {
						//$(this).text("저장"); //일시적으로만 바뀜 버튼을 덮어써야하나...
						//$("#salary-"+j).find('input').attr("disabled", "true");
						
						$("#modifyBtn-"+j).text("저장");
						$("#salary-"+j+" input[type='text']").attr("disabled", false);
					});
				})(i);
			}
		</script>
		
	</body>
	
</html>