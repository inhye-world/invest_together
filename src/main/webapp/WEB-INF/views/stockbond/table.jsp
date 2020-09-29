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
	
	<link href="resources/sb_admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	
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
		//var addBondisRun = false;
		var checking = -1;
		var stockSum = 0;
		var bondSum = 0;
	</script>
</head>
	<body>
		
		<div class="wrapper">
		<jsp:include page="../include/header_temp.jsp"/>
			
			<div class="container container2">
				<a class="mainA" href="/into"> 같이투자 API TEST</a>
				<br><br><br>
				
				<div class="stock-list">
					<c:if test="${!(empty stockList and empty bondList and accountSum==0)}">
						<div class="portfolio">
							<canvas id="myPieChart"></canvas>
							<div>
			                    <span>
			                    	<i class="fas fa-circle text-primary"></i> 현금 &nbsp;
			                    </span>
			                    <span>
			                    	<i class="fas fa-circle text-success"></i> 주식 &nbsp;
			                    </span>
			                    <span>
			                    	<i class="fas fa-circle text-info"></i> 채권 &nbsp;
			                    </span>
		                  	</div>
						</div>
					</c:if>
					<h2>-주식-</h2>
					
					<div class="btn-list">
						<button id="stockAllSelect" class="button4">전체선택</button>
						<button id="buyStock" class="button4">매수</button>
						<button id="sellStock" class="button4">매도</button>
						<button id="deleteStock" class="button4">삭제</button>
						<span class="stock-right-btn">
							<button id="stock2excel" class="button4">엑셀파일로 다운</button>
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
								
								stockSum += (price*quantity);
							</script>
						</c:forEach>
						</tbody>
					</table>
					<div id="stock-hidden">
					</div>
					</form:form>
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
				
				
				$("#stockAllSelect").click(function() {
					$("#stock-table input[type=checkbox]").prop("checked", true);
				});
				
				$("#buyStock").click(function() {
					if(buyStockisRun==false) {
						var str = '<tr>';
						str += '<td><input type="submit" id="buy_stock_submit" value="" onclick="javascript: form.action=`buyStock`;" /></td>';
						str += '<td><input type="text" id="buy_stockinfo_symbols" name="buy_stockinfo_symbols" placeholder="종목명" size="6" /></td>';
						str += '<td><input type="text" id="buy_company" name="buy_company" placeholder="증권사" size="5" /></td>';
						str += '<td><input type="text" id="buy_purchase_price" name="buy_purchase_price" placeholder="매수가" size="5" /></td>';
						str += '<td>-</td><td>-</td><td>-</td>';
						str += '<td><input type="text" id="buy_quantity" name="buy_quantity" placeholder="매수수량" size="4" /></td>';
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
						
						$("#buy_stock_submit").click(function() {
							
							var buy_stockinfo_symbols = $("#buy_stockinfo_symbols").val();
							var buy_company = $("#buy_company").val();
							var buy_purchase_price = $("#buy_purchase_price").val();
							var buy_quantity = $("#buy_quantity").val();
							
							var RegexCompany =  /^[a-zA-Z가-힣]{1,}$/;
							var RegexNumber = /^[0-9]{1,}$/;
							var RegexHasStock = false;
							
							(function() {
								$.ajax({
									type: "GET",
									url: "rest/stockSymbolValid",
									dataType: "json",
									async: false,
									data: {"symbol": buy_stockinfo_symbols},
									
									success: function(result) {
										RegexHasStock = result.hasStock;
									}
								});
							})();
							
							if(!RegexHasStock) {
								alert("종목명을 다시 입력해주세요");
								return false;
							}
						
							if(!RegexCompany.test(buy_company)) {
								alert("증권사를 다시 입력해주세요");
								return false;
							}
							
							if(!RegexNumber.test(buy_purchase_price)) {
								alert("매수금액을 다시 입력해주세요");
								return false;
							}
							
							if((!RegexNumber.test(buy_quantity)) || (buy_quantity<1)) {
								alert("매수수량을 다시 입력해주세요");
								return false;
							}
							
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
						
						var str = '<input type="submit" id="sell_stock_submit" value="" onclick="javascript: form.action=`sellStock`;" />';
						$("#stock-"+check+" td:nth-child(1)").html(str);
						
						str = '<input type="text" id="sell_quantity" name="sell_quantity" placeholder="매도수량" size="4" />';
						$("#stock-"+check+" td:nth-child(8)").html(str);
						
						str = '<input type="hidden" name="sell_stockinfo_symbols" value="'+symbolArr[check]+'" />';
						$("#stock-hidden").html(str);
						
						$("#sell_stock_submit").click(function() {
							var sell_quantity = $("#sell_quantity").val();
							
							var RegexNumber = /^[0-9]{1,}$/;
							
							if((!RegexNumber.test(sell_quantity)) || (sell_quantity<1) || (sell_quantity>quantityArr[checking])) {
								alert("매도수량을 다시 입력해주세요");
								return false;
							}
							
							if(sell_quantity == quantityArr[checking]) {
								$("#stock-table").remove();
								var str = '<input type="hidden" name="deleteStockSymbol" value="'+symbolArr[checking]+'" />';
								$("#stock-form").append(str);
								$("#stock-form").attr("action", "deleteStock").submit();
							}
						});
						
						checking = check;
						sellStockisRun = true;
					}
				});
				
				$("#deleteStock").click(function() {
					var confirmflag = confirm("삭제하시겠습니까?");
					
					if(confirmflag) {
						$("#stock-form").attr("action", "deleteStock").submit();
					}else {
						return false;
					}
				});
				
				
				$("#bondAllSelect").click(function() {
					$("#bond-table input[type=checkbox]").prop("checked", true);
				});
				
<!--
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
-->				
				
				
				var accountSum = ${accountSum}
				
				// Set new default font family and font color to mimic Bootstrap's default styling
				Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
				Chart.defaults.global.defaultFontColor = '#858796';

				// Pie Chart Example
				var ctx = document.getElementById("myPieChart");
				var myPieChart = new Chart(ctx, {
				  type: 'doughnut',
				  data: {
				    labels: ["현금", "주식", "채권"],
				    datasets: [{
				      data: [accountSum, stockSum, bondSum],
				      backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc'],
				      hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
				      hoverBorderColor: "rgba(234, 236, 244, 1)",
				    }],
				  },
				  options: {
				    maintainAspectRatio: true,
				    tooltips: {
				      backgroundColor: "rgb(255,255,255)",
				      bodyFontColor: "#858796",
				      borderColor: '#dddfeb',
				      borderWidth: 1,
				      xPadding: 15,
				      yPadding: 15,
				      displayColors: false,
				      caretPadding: 10,
				    },
				    legend: {
				      display: false
				    },
				    cutoutPercentage: 80,
				  },
				});
				
				$("#stock2excel").click(function() {
					if(buyStockisRun || sellStockisRun) {
						alert("수정중에는 다운로드 하실 수 없습니다");
						return false;
					}
					
					$('#stock-table').tableExport({
						fileName:"가치투자_주식내역_" + new Date().toISOString().replace(/[\-\:\.]/g, ""),
						type:'excel',
					    excelstyles:['background-color', 'font-weight', 'text-align', 'width', 'font-size'],
					    mso: {  styles:['background-color', 'font-weight', 'text-align', 'width', 'font-size']
					            ,worksheetName: "주식내역"
					            ,fileFormat: "xlsx"},
						ignoreColumn: [0]
					});

				});
			});
		</script>
		<script src="resources/sb_admin/vendor/chart.js/Chart.min.js"></script>
		<script src="resources/tableExport/tableExport.min.js" type="text/javascript"></script>
		<script src="resources/tableExport/xlsx.core.min.js" type="text/javascript"></script>
		<script src="resources/tableExport/FileSaver.min.js" type="text/javascript"></script>
	</body>
</html>