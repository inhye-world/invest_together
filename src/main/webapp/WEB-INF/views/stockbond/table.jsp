<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script>
		var codeArr = [];
		var priceArr = [];
		var quantityArr = [];
	</script>
</head>
	<body>
		
		<div class="wrapper">
		<jsp:include page="../include/header.jsp"/>
			
			<div class="container container2">
				<a class="mainA" href="/into"> 같이투자 API TEST</a>
				<br><br><br>
				
				<div class="stock-list">
					<h2>-주식-</h2>
					<div class="btn-list">
						<button class="button4">전체선택</button>
						<button class="button4">추가</button>
						<button class="button4">수정</button>
						<button class="button4">삭제</button>
						<span class="stock-right-btn">
							<button class="button4">엑셀파일로 다운</button>
						</span>
					</div>
					
					<table id="stock-table" class="table">
						<thead>
							<tr>
								<th></th>	
								<th>종목명</th>
								<th>증권사</th>
								<th>매입가</th>
								<th>현재가</th>
								<th>수익률</th>
								<th>평가손익</th>
								<th>보유수량</th>
								<th>평가금액</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="stock" items="${stockList}" varStatus="status">
							<tr id="stock-${status.index}">
								<td><input type="checkbox" /></td>
								<td>${stock.stockinfo_symbols}</td>
								<td>${stock.company}</td>
								<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${stock.purchase_price}" />원</td>
								<td></td>
								<td></td>
								<td></td>
								<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${stock.quantity}" /></td>
								<td></td>
							</tr>
							
							<script>
								codeArr.push(${stock.stockInfoDTO.code});
								priceArr.push(${stock.purchase_price});
								quantityArr.push(${stock.quantity});
							</script>
						</c:forEach>
						</tbody>
					</table>
				</div>
				
				<div class="bond-list">
					<h2>-채권-</h2>
					<div class="btn-list">
						<button class="button4">전체선택</button>
						<button class="button4">추가</button>
						<button class="button4">수정</button>
						<button class="button4">삭제</button>
						<span class="bond-right-btn">
							<button class="button4">엑셀파일로 다운</button>
						</span>
					</div>
					<table id="bond-table" class="table">
						<thead>
							<tr>
								<th></th> 
								<th>종목명</th>
								<th>증권사</th>
								<th>매수금액</th>
								<th>매수일자</th>
								<th>발행이자율</th>
								<th>할인발행율</th>
								<th>세후보유기간이자</th>
								<th>총 상환금액</th>
								<th>만기일</th>
								<th>신용등급</th>
							</tr>
						</thead>
						
						<tbody>
						<c:forEach var="bond" items="${bondList}">
							<tr>
								<td><input type="checkbox" /> </td>
								<td>${bond.bond_symbols}</td>
								<td>${bond.bond_company}</td>
								<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${bond.bond_price}" />원</td>
								<td><fmt:formatDate value="${bond.bond_date}" type="both" pattern="yyyy-MM-dd"/></td>
								<td>${bond.coupon_interest_rate}%</td>
								<td>${bond.discount_rate}%</td>
								<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${bond.total_interest}" />원</td>
								<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${bond.gross_price}" />원</td>
								<td><fmt:formatDate value="${bond.maturity_date}" type="both" pattern="yyyy-MM-dd"/></td>
								<td>${bond.grade}</td>
							</tr>	
						</c:forEach>
						</tbody>
					</table>
				</div>
		
			</div>
		
		</div>
		
		<script>
			$(function() {
				for(var i=0; i<codeArr.length; ++i) {
					
					(function(i){
						var url = 'rest/stockInfo/'+codeArr[i]+'.json';
						
						$.ajax({
							url: url,
							type: 'GET',
							dataType: 'json',
							success: function(result) {
								var curJuka = result.stockprice.TBL_StockInfo.CurJuka;
								$("#stock-"+i+" td:nth-child(5)").text(curJuka+"원");
								
								curJuka = parseInt(curJuka.replace(/,/g, ''));
								if(curJuka == priceArr[i]) {
									$("#stock-"+i+" td:nth-child(6)").text("-");
									$("#stock-"+i+" td:nth-child(7)").text("-");
								}else if(curJuka > priceArr[i]) {
									var yield = (curJuka-priceArr[i])/priceArr[i]*100;
									var pl = (curJuka-priceArr[i])*quantityArr[i];
									
									$("#stock-"+i+" td:nth-child(6)").text(yield.toFixed(2)+"%").css("color", "red");
									$("#stock-"+i+" td:nth-child(7)").text(pl.toLocaleString()+"원").css("color", "red");
								}else if(curJuka < priceArr[i]) {
									var yield = (priceArr[i]-curJuka)/priceArr[i]*100;
									var pl = (priceArr[i]-curJuka)*quantityArr[i];
									
									$("#stock-"+i+" td:nth-child(6)").text("-"+yield.toFixed(2)+"%").css("color", "blue");
									$("#stock-"+i+" td:nth-child(7)").text("-"+pl.toLocaleString()+"원").css("color", "blue");
								}
								
								var eva = curJuka * quantityArr[i];
								$("#stock-"+i+" td:nth-child(9)").text(eva.toLocaleString()+"원");
							}
						});
					})(i);
				
				}
				
				
				
			});
		</script>
	</body>
</html>