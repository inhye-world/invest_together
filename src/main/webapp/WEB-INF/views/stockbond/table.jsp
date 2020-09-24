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
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script>
		var codeArr = [];
		var symbolArr = [];
		var priceArr = [];
		var quantityArr = [];
		var buyStockisRun = false;
		var sellStockisRun = false;
		var addBondisRun = false;
		var checking = -1;
		var yi;
		var pl;
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
						<button id="stockAllSelect" class="button4">전체선택</button>
						<button id="buyStock" class="button4">매수</button>
						<button id="sellStock" class="button4">매도</button>
						<button id="deleteStock" class="button4">삭제</button>
						<span class="stock-right-btn">
							<button class="button4">엑셀파일로 다운</button>
						</span>
					</div>
					
					<form:form id="stock-form" method="POST">
					<table id="stock-table" class="table">
						<thead>
							<tr>
								<th></th>	
								<th>종목명</th>
								<th>증권사</th>
								<th>평균매수가</th>
								<th>현재가</th>
								<th>수익률</th>
								<th>평가손익</th>
								<th>보유수량</th>
								<th>평가금액</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${empty stockList}">
							<tr>
								<td class="empty_stock_bond" colspan="9">
									<h2></h2>
									주식을 추가해 주세요
									<h2></h2>
								</td>
							</tr>
						</c:if>
						<c:forEach var="stock" items="${stockList}" varStatus="status">
							<tr id="stock-${status.index}">
								<td><input type="checkbox" id="stock-check-${status.index}" name="deleteStockSymbol" value="${stock.stockinfo_symbols}"/></td>
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
								var code = ${stock.stockInfoDTO.code}
								codeArr.push(code);
								var symbol = "${stock.stockinfo_symbols}"
								symbolArr.push(symbol);
								var price = ${stock.purchase_price}
								priceArr.push(price);
								var quantity = ${stock.quantity}
								quantityArr.push(quantity);
							</script>
						</c:forEach>
						</tbody>
					</table>
					<div id="stock-hidden">
					</div>
					</form:form>
				</div>
				
				<div class="bond-list">
					<h2>-채권-</h2>
					<div class="btn-list">
						<button id="bondAllSelect" class="button4">전체선택</button>
						<button id="addBond" class="button4">추가</button>
						<button id="modifyBond" class="button4">수정</button>
						<button id="deleteBond" class="button4">삭제</button>
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
						<c:if test="${empty bondList}">
							<tr>
								<td class="empty_stock_bond" colspan="11">
									<h2></h2>
									채권을 추가해 주세요
									<h2></h2>
								</td>
							</tr>
						</c:if>
						<c:forEach var="bond" items="${bondList}" varStatus="status">
							<tr>
								<td><input type="checkbox" id="bond-check-${status.index}" name="deleteBondSymbol" value="${bond.bond_symbols}"/> </td>
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
						<tr>
							<td></td>
							<td><input type="text" name="add_bond_symbols" placeholder="종목명" size="10" /></td>
							<td><input type="text" name="add_bond_company" placeholder="증권사" size="5" /></td>
							<td><input type="text" name="add_bond_price" placeholder="매수금액" size="7" /></td>
							<td><input type="date" name="add_bond_date" /></td>
							<td><input type="text" name="add_coupon_interest_rate" placeholder="발행이자율" size="5" /></td>
							<td><input type="text" name="add_discount_rate" placeholder="할인발행율" size="5" /></td>
							<td><input type="text" name="add_total_interest" placeholder="세후보유기간이자" size="11" /></td>
							<td><input type="text" name="add_gross_price" placeholder="총 상환금액" size="7" /></td>
							<td><input type="date" name="add_maturity_date" /></td>
							<td><input type="text" name="add_maturity_date" placeholder="신용등급" size="4" /></td>
						</tr>
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
									yi = (curJuka-priceArr[i])/priceArr[i]*100;
									pl = (curJuka-priceArr[i])*quantityArr[i];
									
									$("#stock-"+i+" td:nth-child(6)").text(yi.toFixed(2)+"%").css("color", "red");
									$("#stock-"+i+" td:nth-child(7)").text(pl.toLocaleString()+"원").css("color", "red");
								}else if(curJuka < priceArr[i]) {
									yi = (priceArr[i]-curJuka)/priceArr[i]*100;
									pl = (priceArr[i]-curJuka)*quantityArr[i];
									
									$("#stock-"+i+" td:nth-child(6)").text("-"+yi.toFixed(2)+"%").css("color", "blue");
									$("#stock-"+i+" td:nth-child(7)").text("-"+pl.toLocaleString()+"원").css("color", "blue");
								}
								
								var eva = curJuka * quantityArr[i];
								$("#stock-"+i+" td:nth-child(9)").text(eva.toLocaleString()+"원");
							}
						});
					})(i);
				
				}
				
				
				$("#stockAllSelect").click(function() {
					$("#stock-table input[type=checkbox]").prop("checked", true);
				});
				
				$("#buyStock").click(function() {
					if(buyStockisRun==false) {
						var str = '<tr>';
						str += '<td><input type="submit" value="" onclick="javascript: form.action=`buyStock`;" /></td>';
						str += '<td><input type="text" id="buy_stockinfo_symbols" name="buy_stockinfo_symbols" placeholder="종목명" size="6" /></td>';
						str += '<td><input type="text" name="buy_company" placeholder="증권사" size="5" /></td>';
						str += '<td><input type="text" name="buy_purchase_price" placeholder="매수가" size="5" /></td>';
						str += '<td>-</td><td>-</td><td>-</td>';
						str += '<td><input type="text" name="buy_quantity" placeholder="매수수량" size="4" /></td>';
						str += '<td>-</td>';
						str += '</tr>';
						
						var tr = $(str);
						
						$("#stock-table tbody").append(tr);
						
						$("#buy_stockinfo_symbols").autocomplete({
							source: function(request, response) {
								$.ajax({
									type: "GET",
									url: "rest/stockAutocomplete",
									dataType: "json",
									data: {"value": request.term},
									
									success: function(data) {
										response(data);
									}
								});
							},
							minLength: 1
						});	
						
						buyStockisRun=true;
					}else {
						$("#stock-table tr:last").remove();
						
						buyStockisRun=false;
					}
				});
				
				$("#sellStock").click(function() {
					var check;
					var checkCount = 0;
					for(var i=0; i<symbolArr.length; ++i) {
						if($("#stock-check-"+i).is(":checked")==true) {
							check = i;
							++checkCount;
						}
					}
					
					if(checkCount>1) {
						alert("한개만 체크해주세요");
						return false;
					}
					
					if(checkCount==0 && sellStockisRun) {
						var str = '<input type="checkbox" id="stock-check-'+checking+'" name="deleteStockSymbol" value="'+symbolArr[checking]+'" />';
						$("#stock-"+checking+" td:nth-child(1)").html(str);
						
						str = quantityArr[checking].toLocaleString();
						$("#stock-"+checking+" td:nth-child(8)").html(str);
						
						sellStockisRun = false;
						return false;
					}
					
					if(checkCount==0) {
						alert("매도할 주식을 체크해주세요");
						return false;
					}
					
					if(checkCount==1) {
						
						if(checking != -1) {
							var str = '<input type="checkbox" id="stock-check-'+checking+'" name="deleteStockSymbol" value="'+symbolArr[checking]+'" />';
							$("#stock-"+checking+" td:nth-child(1)").html(str);
							
							str = quantityArr[checking].toLocaleString();
							$("#stock-"+checking+" td:nth-child(8)").html(str);
						}
						
						var str = '<input type="submit" value="" onclick="javascript: form.action=`sellStock`;" />';
						$("#stock-"+check+" td:nth-child(1)").html(str);
						
						str = '<input type="text" name="sell_quantity" placeholder="매도수량" size="4" />';
						$("#stock-"+check+" td:nth-child(8)").html(str);
						
						str = '<input type="hidden" name="sell_stockinfo_symbols" value="'+symbolArr[check]+'" />';
						$("#stock-hidden").html(str);
						
						checking = check;
						sellStockisRun = true;
					}
				});
				
				$("#deleteStock").click(function() {
					$("#stock-form").attr("action", "deleteStock").submit();
				});
				
				
				$("#bondAllSelect").click(function() {
					$("#bond-table input[type=checkbox]").prop("checked", true);
				});
				
				$("#addBond").click(function() {
					if(addBondisRun==false) {
						var str = '<tr>';
						str += '<td><input type="submit" value="" onclick="javascript: form.action=`addBond`;" /></td>';
						//
						str += '</tr>';
						
						var tr = $(str);
						
						$("#bond-table tbody").append(tr);
						
						addBondisRun=true;
					}else {
						$("#bond-table tr:last").remove();
						
						addBondisRun=false;
					}
				});
				
				
				
			});
		</script>
	</body>
</html>