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
	<title>같이투자 | 자산</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
 	<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
	
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
	
	<link href="resources/sb_admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<!-- alert -->
  	<link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
  	<script src="resources/sb_admin/js/ast-notif.js"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
	
	<link href="resources/sb_admin/css/bttn.css" rel="stylesheet" type="text/css">
	<link href="resources/ranking.css" rel="stylesheet" type="text/css">
	<link href="resources/assets.css" rel="stylesheet" type="text/css">
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
	<script>
		var codeArr = [];
		var symbolArr = [];
		var priceArr = [];
		var quantityArr = [];
		var buyStockisRun = false;
		var sellStockisRun = false;
		var checking = -1;
		var stockSum = 0;
		var bondSum = 0;
		var accountSum = ${accountSum}
		
		var addBondisRun = false;
		var modifyBondisRun = false;
		
		function alerting(content){
    		AstNotif.dialog('알림', content, {
        		theme: 'default',
        	});
    	}
      
      	function confirming(content){
      		AstNotif.snackbar(content, {
          		theme: 'default',
          	});
  		}
		
		$(function() {
			
			<c:if test="${!(empty stockList and empty bondList and accountSum==0)}">
			
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
				      backgroundColor: ['#4e73df', '#09CC7F', '#36b9cc'],
				      hoverBackgroundColor: ['#2e59d9', '#06995E', '#2c9faf'],
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
				      callbacks: {
				    	  beforeLabel: function(tooltipItem, data) {
				    	  	  return data.labels[tooltipItem.index]+" "+(data.datasets[0].data[tooltipItem.index]/(accountSum+stockSum+bondSum)*100).toFixed(2)+"%";		
				    	  },
				    	  label:function(tooltipItem, data) {
				    		  return data.datasets[0].data[tooltipItem.index].toLocaleString()+"원";
				    	  }
				      }
				    },
				    legend: {
				      display: false
				    },
				    cutoutPercentage: 80,
				  },
				});
			</c:if>
			
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
					if(stockisEmpty) {
						$("#stock-table tr:last").css("display", "none");
					}
					
					var str = '<tr>';
					str += '<td><input type="submit" id="buy_stock_submit" class="bttn-material-flat assets-submit-bttn" value="" onclick="javascript: form.action=`buyStock`;" /></td>';
					str += '<td><input type="text" id="buy_stockinfo_symbols" name="buy_stockinfo_symbols" placeholder="종목명" size="13" /></td>';
					str += '<td><input type="text" id="buy_company" name="buy_company" placeholder="증권사" size="6" /></td>';
					str += '<td><input type="text" id="buy_purchase_price" name="buy_purchase_price" placeholder="매수가" size="6" /></td>';
					str += '<td>-</td><td>-</td><td>-</td>';
					str += '<td><input type="text" id="buy_quantity" name="buy_quantity" placeholder="매수수량" size="5" /></td>';
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
							alerting("종목명을 다시 입력해주세요");
							return false;
						}
					
						if(!RegexCompany.test(buy_company)) {
							alerting("증권사를 다시 입력해주세요");
							return false;
						}
						
						if(!RegexNumber.test(buy_purchase_price)) {
							alerting("매수금액을 다시 입력해주세요");
							return false;
						}
						
						if((!RegexNumber.test(buy_quantity)) || (buy_quantity<1)) {
							alerting("매수수량을 다시 입력해주세요");
							return false;
						}
						
					});
					
					buyStockisRun=true;
				}else {
					$("#stock-table tr:last").remove();
					$("#stock-table tr:last").css("display", "table-row");
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
					alerting("한개만 체크해주세요");
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
					alerting("매도할 주식을 체크해주세요");
					return false;
				}
				
				if(checkCount==1) {
					
					if(checking != -1) {
						var str = '<input type="checkbox" id="stock-check-'+checking+'" name="deleteStockSymbol" value="'+symbolArr[checking]+'" />';
						$("#stock-"+checking+" td:nth-child(1)").html(str);
						
						str = quantityArr[checking].toLocaleString();
						$("#stock-"+checking+" td:nth-child(8)").html(str);
					}
					
					var str = '<input type="submit" id="sell_stock_submit" class="bttn-material-flat assets-submit-bttn" value="" onclick="javascript: form.action=`sellStock`;" />';
					$("#stock-"+check+" td:nth-child(1)").html(str);
					
					str = '<input type="text" id="sell_quantity" name="sell_quantity" placeholder="매도수량" size="5" />';
					$("#stock-"+check+" td:nth-child(8)").html(str);
					
					str = '<input type="hidden" name="sell_stockinfo_symbols" value="'+symbolArr[check]+'" />';
					$("#stock-hidden").html(str);
					
					$("#sell_stock_submit").click(function() {
						var sell_quantity = $("#sell_quantity").val();
						
						var RegexNumber = /^[0-9]{1,}$/;
						
						if((!RegexNumber.test(sell_quantity)) || (sell_quantity<1) || (sell_quantity>quantityArr[checking])) {
							alerting("매도수량을 다시 입력해주세요");
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
				var checkCount = 0;
				
				for(var i=0; i<symbolArr.length; ++i) {
					if($("#stock-check-"+i).is(":checked")==true) {
						++checkCount;
					}
				}
				
				if(checkCount==0) {
					alerting("삭제할 주식을 선택해주세요");
					return false;
				}
				
				confirming("삭제했습니다.");
				setTimeout(function() {
					$("#stock-form").attr("action", "deleteStock").submit();
				}, 1000);
				
			});
			
			
			$("#stock2excel").click(function() {
				if(buyStockisRun || sellStockisRun) {
					alerting("수정중에는 다운로드 하실 수 없습니다");
					return false;
				}
				
				if(stockisEmpty) {
					alerting("다운로드 하실 수 없습니다");
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
			
			$('#downloadExel').on('click', function (e) {
				if(addBondisRun || modifyBondisRun) {
					alerting("수정중에는 다운로드 하실 수 없습니다");
					return false;
				}
				
				if(bondisEmpty) {
					alerting("다운로드 하실 수 없습니다");
					return false;
				}
				e.preventDefault();
	
	            $('#bond-table').tableExport({type:'excel'});
            });
		});
	</script>
</head>
	<body>
	<jsp:include page="../main/header.jsp"/>
	
		<div class="container mt-4 mb-4 px-0">
			<div class="assets-1">
				<c:if test="${!(empty stockList and empty bondList and accountSum==0)}">
					<div class="assets-chart">
						<canvas id="myPieChart"></canvas>
						<div>
		                    <span>
		                    	<i class="fas fa-circle text-primar"></i> 현금 &nbsp;
		                    </span>
		                    <span>
		                    	<i class="fas fa-circle text-succes"></i> 주식 &nbsp;
		                    </span>
		                    <span>
		                    	<i class="fas fa-circle text-inf"></i> 채권
		                    </span>
	                  	</div>
					</div>
				</c:if>
				<div class="assets-account">
					<c:if test="${empty accountBalanceList}">
							<div class="mb-2">
								<div class="assets-account-1 assets-account-title">
									계좌
								</div>
							</div>
							<div>
								<div class="assets-account-1 assets-account-empty">
									마이페이지에서 <br>계좌를 등록해 주세요
								</div>
							</div>
					</c:if>
					<c:if test="${!empty accountBalanceList}">
							<div class="mb-4">
								<div class="assets-account-1 assets-account-title">
									계좌
								</div>
								<div class="assets-account-2">
									<b><fmt:formatNumber type="number" maxFractionDigits="3" value="${accountSum}" /></b> 원
								</div>
							</div>
						<c:forEach var="account" items="${accountBalanceList}">
							<div>
								<div class="assets-account-1">
									<div class="assets-account-1-1">${account.accountDTO.bank_name}</div>
									<div class="assets-account-1-2">ㅣ ${account.product_name}</div>
								</div>
								<div class="assets-account-2">
									<b><fmt:formatNumber type="number" maxFractionDigits="3" value="${account.balance_amt}" /></b> 원
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="assets-2">
				<div class="assets-title">
					<span>주식</span>
				</div>
				<div class="assets-bttn-container">
					<button id="stockAllSelect" class="bttn-simple bttn-xs bttn-ggreen">전체선택</button>
					<button id="buyStock" class="bttn-simple bttn-xs bttn-ggreen">매수</button>
					<button id="sellStock" class="bttn-simple bttn-xs bttn-ggreen">매도</button>
					<button id="deleteStock" class="bttn-simple bttn-xs bttn-ggreen">삭제</button>
					<button id="stock2excel" class="bttn-simple bttn-xs bttn-ggreen right-bttn">엑셀파일로 다운</button>
				</div>
				
				<div class="stock-table-container">
				<form:form id="stock-form" method="POST">
				<table id="stock-table" class="table leaderboards">
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
								<td class="assets-table-empty" colspan="9">
									주식을 추가해주세요
								</td>
							</tr>
						<script>
							var stockisEmpty = true;
						</script>	
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
								
								var stockisEmpty = false;
							</script>
						</c:forEach>
					</tbody>
				</table>
					<div id="stock-hidden"></div>
				</form:form>
				</div>
			</div>
			<div class="assets-2">
				<div class="assets-title">
					<span>채권</span>
				</div>
				
				<div class="assets-bttn-container">
					<button class="bttn-simple bttn-xs bttn-ggreen" name="addRow">추가</button>
					<button class="bttn-simple bttn-xs bttn-ggreen" name="modify">수정</button>
					<button class="bttn-simple bttn-xs bttn-ggreen" name="delRow">삭제</button>
					<button class="bttn-simple bttn-xs bttn-ggreen right-bttn" id="downloadExel">엑셀파일로 다운</button>
				</div>
				<div class="bond-table-container">
				<form:form id="frm">
				<table id="bond-table" class="table leaderboards">
					<thead>
						 <tr>
						 	<th><input type="checkbox" id="checkAll" /></th>
						 	<th>종목명</th>
						 	<th>세후보유기간이자</th>
						 	<th>증권사</th>
						 	<th>매수금액</th>
						 	<th>매수일자</th>
						 	<th>발행이자율</th>
						 	<th>할인발행율</th>
						 	<th>총상환금액</th>
						 	<th>만기일</th>
						 	<th>신용등급</th>
						 </tr>
					</thead>
					<tbody id="bond_tbody">
						<c:if test="${empty bondList}">
							<tr>
								<td class="assets-table-empty" colspan="11">
									채권을 추가해주세요
								</td>
							</tr>
						<script>
							var bondisEmpty = true;
						</script>	
						</c:if>
						<c:forEach var="bond" items="${bondList}">
							<tr id="bondList_${bond.bond_num}">
			                    <td><input type="checkbox" class="checkRow" name="checkRow" data-symbols="${bond.bond_num}" /></td>
			                    <td style="display:none;">${bond.bond_num}</td> <!-- jQuery.Deferred exception의 원인 th, td 컬럼 수가 불일치 -->
			                    <td>${bond.bond_symbols}</td>
			                    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${bond.total_interest}" />원</td>
			                    <td>${bond.bond_company}</td>
			                    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${bond.bond_price}" />원</td>
			                    <td><fmt:parseDate var="dateString" value="${bond.bond_date}" pattern="yyyy-MM-dd HH:mm:ss" /><fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" /></td>
			                    <td>${bond.coupon_interest_rate}%</td>
			                    <td>${bond.discount_rate}%</td>
			                    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${bond.gross_price}" />원</td>
			                    <td><fmt:parseDate var="dateString" value="${bond.maturity_date}" pattern="yyyy-MM-dd HH:mm:ss" /><fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" /></td>
			                    <td>${bond.grade}</td>
		                    </tr>
		                    
		                <script>
		                	var bondprice = ${bond.bond_price}
		                	bondSum += bondprice;
		                	
		                	var bondisEmpty = false;
		                </script>    
						</c:forEach>
					</tbody>
				</table>
				</form:form>
				</div>
			</div>	
		</div>
	<jsp:include page="../main/footer.jsp"/>
	
	<script type="text/javascript">
          
          function alerting(content){
        		AstNotif.dialog('알림', content, {
            	  theme: 'default',
            	});
        	}
          
          function confirming(content){
	      		AstNotif.snackbar(content, {
	          	  theme: 'default',
	          	});
      		}
          
          //날짜 validating
          $(document).on("input","input[name=maturity_date]",function(){
				    var startDate = document.getElementById("bond_date").value;
				    var endDate = document.getElementById("maturity_date").value;
				    
				    if ((Date.parse(startDate) >= Date.parse(endDate))) {
				        alerting("만기일이 매수일자보다 빠른 날짜를 선택하셨습니다.");
				        document.getElementById("maturity_date").value = "";
				    }
			}); 
          
          //특수문자, 공백 validating
           $(document).on("input","input[name=bond_symbols]",function(){
	        	  var bond_symbols = document.getElementById("bond_symbols").value;

 	        	  var pattern1 = /\s/;
	        	  var pattern2 = /[._+=-`~!@#$%^&*|\\\'\";:\/?]/gi;
	        	  
	         	  if(bond_symbols.search(pattern1) != -1 || bond_symbols.search(pattern2) != -1) {
	                  alerting("종목명을 다시 입력해주세요. 공백 및 특수문자는 사용할 수 없습니다.");
	                  document.getElementById("bond_symbols").value = "";
	                  return false;
	               }

          	}); 
          
          //숫자 validating 부동소수점 포함
          $(document).on("input","input[name=total_interest]",function(){
				var total_interest = document.getElementById("total_interest").value;

	        	var num = /^[+]?\d+\.?\d*$/;
	          
		        if(!num.test(total_interest)) {
		        	alerting("세후보유기간이자를 다시 입력해주세요");
		        	document.getElementById("total_interest").value = "";
	                return false;
		        } 
          });
          
          $(document).on("input","input[name=coupon_interest_rate]",function(){
				var coupon_interest_rate = document.getElementById("coupon_interest_rate").value;

	        	var num = /^[+]?\d+\.?\d*$/;     
		        
		        if(!num.test(coupon_interest_rate)) {
	                alerting("발행이자율을 다시 입력해주세요");
	                document.getElementById("coupon_interest_rate").value = "";
	                return false;
	             }
       	 });
          
          $(document).on("input","input[id=discount_rate]",function(){
				var discount_rate = document.getElementById("discount_rate").value;

	        	var num = /^[+]?\d+\.?\d*$/;     

		        if(!num.test(discount_rate)) {
	                alerting("할인이자율을 다시 입력해주세요");
	                document.getElementById("discount_rate").value = "";
	                return false;
	             }
 	     });
          
          
          
        //숫자 validating 정수
          $(document).on("input","input[name=bond_price]",function(){
				var bond_price = document.getElementById("bond_price").value;

	        	var num = /^\d+\.?\d*$/;
	          
		        if(!num.test(bond_price)) {
	                alerting("매수금액을 다시 입력해주세요");
	                document.getElementById("bond_price").value = "";
	                return false;
	             }
          });
        
          $(document).on("input","input[name=gross_price]",function(){
				var gross_price = document.getElementById("gross_price").value;

	        	var num = /^\d+\.?\d*$/;

		        if(!num.test(gross_price)) {
	                alerting("총상환금액을 다시 입력해주세요");
	                document.getElementById("gross_price").value = "";
	                return false;
	             }
        });
          
          

          	//전체선택 
          	$(document).ready(function(){
          	    //최상단 체크박스 클릭
          	    $("#checkAll").click(function(){
          	        //클릭되었으면
          	        if($("#checkAll").prop("checked")){
          	            //input태그의 class가  checkRow인 태그들을 찾아서 checked옵션을 true로 정의
          	            $(".checkRow").prop("checked",true);
          	            //클릭이 안되있으면
          	        }else{
          	            //input태그의 class가  checkRow인 태그들을 찾아서 checked옵션을 false로 정의
          	            $(".checkRow").prop("checked",false);
          	        }
          	    })
          	});
          	
          	//개별 체크박스가 선택되거나 선택해제되면 모두 선택 체크박스가 해체   
          	$(document).ready(function(){
          		$(".checkRow").click(function(){
      			  $("#checkAll").prop("checked", false);
      			 })
          	});
			 
          	
		    //추가 버튼
		    $(document).on("click","button[name=addRow]",function(){
		        
		    	if(addBondisRun) {
		    		return false;
		    	}
		    	
		    	if(bondisEmpty) {
		    		$("#bond-table tr:last").css("display", "none");
		    	}
		    	
		        var addTableRow =     
		        	'	 <tr id="bondList_${dto.bond_num}">'+
		            '    <td></td>'+
		            '    <td style="display:none;"><input type="hidden" name="bond_num" value="${dto.bond_num}" /></td>'+
		            '    <td><input type="text" id="bond_symbols" name="bond_symbols" placeholder="종목명" size="5"/></td>'+
		            '    <td><input type="text" id="total_interest" name="total_interest" placeholder="세후이자" size="7"/></td>'+
		            '    <td><select id="bond_company" name="bond_company" placeholder="증권사">'+
		            '	 <option value="" disabled selected>증권사</option>'+
		            '	 <option value="한국투자증권">한국투자증권</option>'+
		            '	 <option value="미래에셋대우">미래에셋대우</option>'+
		            '	 <option value="메리츠종금증권">메리츠종금증권</option>'+
		            '	 <option value="NH투자증권">NH투자증권</option>'+
		            '	 <option value="삼성증권">삼성증권</option>'+
		            '	 <option value="신한금융투자">신한금융투자</option>'+
		            '	 <option value="키움증권">키움증권</option>'+
		            '	 <option value="KB증권">KB증권</option>'+
		            '	 <option value="하나금융투자">하나금융투자</option>'+
		            '	 <option value="대신증권">대신증권</option>'+
		            '	 <option value="유안타증권">유안타증권</option>'+
		            '	 </select></td>'+
		            '    <td><input type="text" id="bond_price" name="bond_price" placeholder="매수금액" size="6"/></td>'+
		            '    <td><input type="date" id="bond_date" name="bond_date" placeholder="매수일자" /></td>'+
		            '    <td><input type="text" id="coupon_interest_rate" name="coupon_interest_rate" placeholder="발행이자율" size="6"/></td>'+
		            '    <td><input type="text" id="discount_rate" name="discount_rate" placeholder="할인발행율" size="6"/></td>'+
		            '    <td><input type="text" id="gross_price" name="gross_price" placeholder="총상환금액" size="6"/></td>'+
		            '    <td><input type="date" id="maturity_date" name="maturity_date" placeholder="만기일" /></td>'+
		            '    <td><select id="grade" name="grade" placeholder="등급">'+
		            '	 <option value="" disabled selected>등급</option>'+
		            '	 <option value="AAA">AAA</option>'+
		            '	 <option value="AA">AA</option>'+
		            '	 <option value="A">A</option>'+
		            '	 <option value="BBB">BBB</option>'+
		            '	 <option value="BB">BB</option>'+
		            '	 <option value="B">B</option>'+
		            '	 <option value="CCC">CCC</option>'+
		            '	 <option value="CC">CC</option>'+
		            '	 <option value="C">C</option>'+
		            '	 <option value="D">D</option>'+
		            '	 </select>'+
		            '  	 <button type="button" class="bttn-material-flat assets-submit-bttn" onclick="insertCheck();"></button></td>'+
		            '</tr>';
		            
		            $("#bond_tbody").append(addTableRow);
		        	addBondisRun = true;
		    });

		    //null check B4 submit
		    function insertCheck(){
		    	
		    	// form안의 모든 text type 조회
		    	var txtEle = $("#frm input[type=text]");
		    	
		    	for(var i = 0; i < txtEle.length; i ++){
		    		if("" == $(txtEle[i]).val() || null == $(txtEle[i]).val()){
			    		var ele_id = $(txtEle[i]).attr("id");
			    		//console.log("id : " + ele_id);
			    		showAlert(ele_id);
			    		return true;
		    		}
		    	}
		    	
		    	//select값 조회
		    	if("" == $("#bond_company option:selected").val() || null == $("#bond_company option:selected").val()){
		    		var ele_id = "bond_company";
		    		showAlert(ele_id);
		    		return true;
	    		}
		    			    	
		    	if("" == $("#grade option:selected").val() || null == $("#grade option:selected").val()){
		    		var ele_id = "grade";
		    		//console.log("id : " + ele_id);
		    		showAlert(ele_id);
		    		return true;
	    		}
		    	
		    		theForm = document.form;
		    		document.getElementById("frm").action = "writeBond";
		    		document.getElementById("frm").submit();
    	
		    }
		    
		    //null check B4 modify
		    function modifyCheck(){
		    	
		    	// form안의 모든 text type 조회
		    	var txtEle = $("#frm input[type=text]");
		    	
		    	for(var i = 0; i < txtEle.length; i ++){
		    		if("" == $(txtEle[i]).val() || null == $(txtEle[i]).val()){
			    		var ele_id = $(txtEle[i]).attr("id");
			    		console.log("id : " + ele_id);
			    		showAlert(ele_id);
			    		return true;
		    		}
		    	}
		    	
		    	//select값 조회
		    	if("" == $("#bond_company option:selected").val() || null == $("#bond_company option:selected").val()){
		    		var ele_id = "bond_company";
		    		showAlert(ele_id);
		    		return true;
	    		}
		    			    	
		    	if("" == $("#grade option:selected").val() || null == $("#grade option:selected").val()){
		    		var ele_id = "grade";
		    		//console.log("id : " + ele_id);
		    		showAlert(ele_id);
		    		return true;
	    		}
		    	
		    		theForm = document.form;
		    		document.getElementById("frm").action = "modifyBond";
		    		document.getElementById("frm").submit();
    	
		    }
		    
		    
		    
		    //null값일 때 focus주기 
		    function showAlert(ele_id){

		    	var ele_name = $("#" + ele_id).attr('placeholder');
		    	alerting(ele_name + "을 입력해주세요.");

		    	// 해당 id에 focus.
		    	$("#" + ele_id).focus();
		    }

		    
		    //삭제 버튼
		    $(document).on("click","button[name=delRow]",function(){
		    	//var confirm_val = confirming("정말 삭제하시겠습니까?");
		    	  
		    	  //if(confirm_val) {
		    	   var checkArr = [];
		    	   
		    	   $("input[class='checkRow']:checked").each(function(){
		    	    checkArr.push($(this).attr("data-symbols"));
		    	   });
		    	    
		    	   $.ajax({
		    	    url : "deleteBond",
		    	    type : "post",
		    	    data : {"checkRow" : checkArr},
		    	    dataType : "json",
		    	    success : function(result){
		    	    		if(result == 1){
		    	    			confirming("삭제했습니다.");
			    	    		setTimeout(function() {
			    	    			window.location.href = "/into/assets";
			    	    			}, 1000);
		    	    		}
		    	    			
		    	    	}
		    	    });
		    	   //}

 	        });
		    
		    //ajax csrf
		    $(document).ready(function(){
			    var token = $("meta[name='_csrf']").attr("content");
			    var header = $("meta[name='_csrf_header']").attr("content");
			    $(document).ajaxSend(function(e, xhr, options) {
			        xhr.setRequestHeader(header, token);
			    });
			});
		    
		    
		  //수정 input박스 띄우기 
			$(document).on("click","button[name=modify]",function(){
				$("input[class='checkRow']:checked").each(function(){
					
					var str = "";
					var tdArr = new Array();
					var checkBtn = $(this);
					var num = $(this).attr("data-symbols");
					console.log(num);
					
					// checkBtn.parent() : checkBtn의 부모는 <td>이다.
		            // checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
		            var tr = checkBtn.parent().parent();
		            var td = tr.children();
		            var id = tr.attr('id');
		            console.log("id: "+id);
					
					// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
					console.log("클릭한 row의 모든 데이터: "+tr.text());
					
					
					// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
		            td.each(function(i){
		                tdArr.push(td.eq(i).text());
		            });

					console.log("배열에 담긴 값: "+tdArr);

					str +=     
			            '    <td></td>'+
			            '    <td style="display:none;"><input type="hidden" name="bond_num" value='+tdArr[1]+' /></td>'+
			            '    <td><input type="text" id="bond_symbols" name="bond_symbols" value='+tdArr[2]+' placeholder='+tdArr[2]+' size="5"/></td>'+
			            '    <td><input type="text" id="total_interest" name="total_interest" value='+tdArr[3]+' placeholder='+tdArr[3]+' size="7"/></td>'+
			            '    <td><select id="bond_company" name="bond_company" placeholder="bond_company">'+
			            '	 <option value='+tdArr[4]+' selected>'+tdArr[4]+'</option>'+
			            '	 <option value="한국투자증권">한국투자증권</option>'+
			            '	 <option value="미래에셋대우">미래에셋대우</option>'+
			            '	 <option value="메리츠종금증권">메리츠종금증권</option>'+
			            '	 <option value="NH투자증권">NH투자증권</option>'+
			            '	 <option value="삼성증권">삼성증권</option>'+
			            '	 <option value="신한금융투자">신한금융투자</option>'+
			            '	 <option value="키움증권">키움증권</option>'+
			            '	 <option value="KB증권">KB증권</option>'+
			            '	 <option value="하나금융투자">하나금융투자</option>'+
			            '	 <option value="대신증권">대신증권</option>'+
			            '	 <option value="유안타증권">유안타증권</option>'+
			            '	 </select></td>'+
			            '    <td><input type="text" id="bond_price" name="bond_price" value='+tdArr[5]+' placeholder='+tdArr[5]+' size="6"/></td>'+
			            '    <td><input type="date" id="bond_date" name="bond_date" value='+tdArr[6]+' placeholder='+tdArr[6]+' /></td>'+
			            '    <td><input type="text" id="coupon_interest_rate" name="coupon_interest_rate" value='+tdArr[7]+' placeholder='+tdArr[7]+' size="6"/></td>'+
			            '    <td><input type="text" id="discount_rate" name="discount_rate" value='+tdArr[8]+' placeholder='+tdArr[8]+' size="6"/></td>'+
			            '    <td><input type="text" id="gross_price" name="gross_price" value='+tdArr[9]+' placeholder='+tdArr[9]+' size="6"/></td>'+
			            '    <td><input type="date" id="maturity_date" name="maturity_date" value='+tdArr[10]+' placeholder='+tdArr[10]+' /></td>'+
			            '    <td><select id="grade" name="grade" placeholder="grade">'+
			            '	 <option value='+tdArr[11]+' selected>'+tdArr[11]+'</option>'+
			            '	 <option value="AAA">AAA</option>'+
			            '	 <option value="AA">AA</option>'+
			            '	 <option value="A">A</option>'+
			            '	 <option value="BBB">BBB</option>'+
			            '	 <option value="BB">BB</option>'+
			            '	 <option value="B">B</option>'+
			            '	 <option value="CCC">CCC</option>'+
			            '	 <option value="CC">CC</option>'+
			            '	 <option value="C">C</option>'+
			            '	 <option value="D">D</option>'+
			            '	 </select>'+
			            '  	 <button type="button" class="bttn-material-flat assets-submit-bttn" onclick="modifyCheck();"></button></td>';
					
					$("#"+id).html(str);
					
					modifyBondisRun = true;
		    	   });
				
		        
		    }); 

		</script>
		
		<script src="resources/sb_admin/vendor/chart.js/Chart.min.js"></script>
	
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
		<script src="resources/tableExport/tableExport.min.js" type="text/javascript"></script>
		<script src="resources/tableExport/xlsx.core.min.js" type="text/javascript"></script>
		<script src="resources/tableExport/FileSaver.min.js" type="text/javascript"></script>
	</body>
</html>