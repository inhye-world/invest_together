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
	<title>같이투자 | 구독</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
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
	<link href="resources/assets.css" rel="stylesheet" type="text/css">
	<link href="resources/ranking.css" rel="stylesheet" type="text/css">
	<link href="resources/sub.css" rel="stylesheet" type="text/css">
	
	<script>
		var codeArr = [];
		var symbolArr = [];
		var priceArr = [];
		var quantityArr = [];
		
		var stockSum = 0;
		var bondSum = 0;
		var accountSum = ${accountSum}
		
		var calisEmpty = true;
		
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
      	
      	function selectSymbols() {
      		var sellernum = ${seller_num}
      		
  			var optVal = $("#symbols option:selected").val();
  			
  			if(optVal == null || optVal == ""){
  				document.getElementById("cal-table-tbody").innerHTML = '<tr><td class="sub-info-table-empty" colspan="8">종목명을 선택해주세요.</td></tr>';
  				
  				calisEmpty = true;
  			} else {
  				$.ajax({
		    	    url : "rest/getCalculatorInfo",
		    	    type : 'GET',
		    	    data : {
		    	    	"stockinfo_symbols" : optVal,
		    	    	"member_num" : sellernum
		    	    },
		    	    dataType : "json",
		    	    success: function(data){
			    	   	var material0 = parseInt(data.ev);	//지배주주지분(기업가치)
			        	var material1 = parseFloat(data.roe);	//ROE
			        	var material2 = parseFloat(data.ke);	//주주요구수익률
		        	    var material3 = parseInt(data.share_issued);	//발행주식수
		        	    //초과이익 = 기업가치 * (주주요구수익률 - 8%)
		        	    //기업가치 = 자기자본 + 초과이익 x w / (1+할인율-w)
		        	    //8%: 임의의 무위험수익률
			        	 
		        	    //초과이익
		        	    var material4 = material0*(material1 - material2)*1000000;					
		        	  
		        	    //적정 주주가치
		        	    var material5 = material0*100000000 + material4/(material2*0.01);						
		        	    var material6 = material0*100000000 + material4*0.9/(1+(material2*0.01)-0.9);
		        	    var material7 = material0*100000000 + material4*0.8/(1+(material2*0.01)-0.8);
		        	  
		                //적정주가
		        	    var material8 = parseInt(material5/material3);								
		        	    var material9 = parseInt(material6/material3);
		        	    var material10 = parseInt(material7/material3);
		    	    	
		    	  		document.getElementById("cal-table-tbody").innerHTML = '<tr><td>영원히 지속</td>'+
														                       '<td>'+material0.toLocaleString()+'억 원</td>'+
														                       '<td>'+material1+'%</td>'+
														                       '<td>'+material2+'%</td>'+
														                       '<td>'+(material5/100000000).toLocaleString()+'억 원</td>'+
														                       '<td>'+material3.toLocaleString()+'주</td>'+
														                       '<td>'+material8.toLocaleString()+'원</td>'+
														                       '<td>매도</td></tr>'+
														                       '<tr><td>10%씩 감소</td>'+
														                       '<td>'+material0.toLocaleString()+'억 원</td>'+
														                       '<td>'+material1+'%</td>'+
														                       '<td>'+material2+'%</td>'+
														                       '<td>'+(material6/100000000).toLocaleString()+'억 원</td>'+
														                       '<td>'+material3.toLocaleString()+'주</td>'+
														                       '<td>'+material9.toLocaleString()+'원</td>'+
														                       '<td>적정</td></tr>'+
														                       '<tr><td>20%씩 감소</td>'+
															                   '<td>'+material0.toLocaleString()+'억 원</td>'+
															                   '<td>'+material1+'%</td>'+
															                   '<td>'+material2+'%</td>'+
															                   '<td>'+(material7/100000000).toLocaleString()+'억 원</td>'+
															                   '<td>'+material3.toLocaleString()+'주</td>'+
														                       '<td>'+material10.toLocaleString()+'원</td>'+
														                       '<td>매수</td></tr>'
														                      
						calisEmpty = false; 
					
					},
		    	    error: function(request, status, error){
		    	    	alert("error");
		    	    }
		    	 });
  			}
  			
  			
  		}
      	
      	$(function() {
      		
      		selectSymbols();
			
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
				    cutoutPercentage: 0,
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
							$("#stock-"+i+" td:nth-child(4)").text(curJuka+"원");
							
							curJuka = parseInt(curJuka.replace(/,/g, ''));
							if(curJuka == priceArr[i]) {
								$("#stock-"+i+" td:nth-child(5)").text("-");
								$("#stock-"+i+" td:nth-child(6)").text("-");
							}else if(curJuka > priceArr[i]) {
								var yi = (curJuka-priceArr[i])/priceArr[i]*100;
								var pl = (curJuka-priceArr[i])*quantityArr[i];
								
								$("#stock-"+i+" td:nth-child(5)").text(yi.toFixed(2)+"%").css("color", "red");
								$("#stock-"+i+" td:nth-child(6)").text(pl.toLocaleString()+"원").css("color", "red");
							}else if(curJuka < priceArr[i]) {
								var yi = (priceArr[i]-curJuka)/priceArr[i]*100;
								var pl = (priceArr[i]-curJuka)*quantityArr[i];
								
								$("#stock-"+i+" td:nth-child(5)").text("-"+yi.toFixed(2)+"%").css("color", "blue");
								$("#stock-"+i+" td:nth-child(6)").text("-"+pl.toLocaleString()+"원").css("color", "blue");
							}
							
							var eva = curJuka * quantityArr[i];
							$("#stock-"+i+" td:nth-child(8)").text(eva.toLocaleString()+"원");
						}
					});
				})(i);
			
			}
			
			$("#sub-stock2excel").click(function() {
				if(stockisEmpty) {
					alerting("다운로드 하실수 없습니다");
					return false;
				}
				
				var nick = "${nickname}";
				
				$('#sub-stock-table').tableExport({
					fileName:"가치투자_주식_"+ nick + "_" + new Date().toISOString().replace(/[\-\:\.]/g, ""),
					type:'excel',
				    excelstyles:['background-color', 'font-weight', 'text-align', 'width', 'font-size'],
				    mso: {  styles:['background-color', 'font-weight', 'text-align', 'width', 'font-size']
				            ,worksheetName: "보유주식"
				            ,fileFormat: "xlsx"},
				});

			});
			
			$("#sub-bond2excel").click(function() {
				if(bondisEmpty) {
					alerting("다운로드 하실수 없습니다");
					return false;
				}
				
				var nick = "${nickname}";
				
				$('#sub-bond-table').tableExport({
					fileName:"가치투자_채권_"+ nick + "_" + new Date().toISOString().replace(/[\-\:\.]/g, ""),
					type:'excel',
				    excelstyles:['background-color', 'font-weight', 'text-align', 'width', 'font-size'],
				    mso: {  styles:['background-color', 'font-weight', 'text-align', 'width', 'font-size']
				            ,worksheetName: "보유채권"
				            ,fileFormat: "xlsx"},
				});

			});
			
			$("#sub-cal2excel").click(function() {
				if(calisEmpty) {
					alerting("다운로드 하실수 없습니다");
					return false;
				}
				
				var nick = "${nickname}";
				var symbol = $("#symbols option:selected").val();
				
				$('#sub-cal-table').tableExport({
					fileName:"가치투자_적정주가_"+ symbol + "_" + nick + "_" + new Date().toISOString().replace(/[\-\:\.]/g, ""),
					type:'excel',
				    excelstyles:['background-color', 'font-weight', 'text-align', 'width', 'font-size'],
				    mso: {  styles:['background-color', 'font-weight', 'text-align', 'width', 'font-size']
				            ,worksheetName: "적정주가"
				            ,fileFormat: "xlsx"},
				});

			});
			
			
      	});
	</script>
</head>
	<body>
		<jsp:include page="../main/header.jsp"/>
	
		<div class="container mt-4 mb-4 px-0">
			<div class="sub-info-nickname">
				<b>${nickname}</b> 님
				<hr>
			</div>
			
			<div class="sub-info-portfolio">
				<div class="sub-info-title">보유비중</div>
				
				<c:if test="${empty stockList and empty bondList and accountSum==0}">
					<div class="sub-info-chart-empty">
						보유 자산이 없습니다
					</div>
				</c:if>
				
				<c:if test="${!(empty stockList and empty bondList and accountSum==0)}">
					<div class="sub-info-chart">
						<canvas id="myPieChart" width="500" height="250"></canvas>
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
			</div>
			
			<div class="sub-info-stock">
				<div class="sub-info-title">보유주식</div>
				
				<div class="sub-info-bttn-container">
					<button id="sub-stock2excel" class="bttn-simple bttn-xs bttn-ggreen right-bttn">엑셀파일로 다운</button>
				</div>
				
				<table id="sub-stock-table" class="table leaderboards">
					<thead>
						<tr>
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
								<td colspan="8" class="sub-info-table-empty">
									보유 주식이 없습니다
								</td>
							</tr>
							
							<script>
								var stockisEmpty = true;
							</script>
						</c:if>
						
						<c:forEach var="stock" items="${stockList}" varStatus="status">
							<tr id="stock-${status.index}">
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
			</div>
			
			<div class="sub-info-bond">
				<div class="sub-info-title">보유채권</div>
				
				<div class="sub-info-bttn-container">
					<button id="sub-bond2excel" class="bttn-simple bttn-xs bttn-ggreen right-bttn">엑셀파일로 다운</button>
				</div>
				
				<table id="sub-bond-table" class="table leaderboards">
					<thead>
						<tr>
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
					
					<tbody>
						<c:if test="${empty bondList}">
							<tr>
								<td colspan="10" class="sub-info-table-empty">
									보유 채권이 없습니다
								</td>
							</tr>
							
							<script>
								var bondisEmpty = true;
							</script>
						</c:if>
						
						<c:forEach var="bond" items="${bondList}">
							<tr>
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
			</div>
			
			<div class="sub-info-calculator">
				<div class="sub-info-title">적정주가</div>
				
				<div class="sub-info-bttn-container sub-info-cal-symbols">
					<span>
						<select id="symbols" onchange="selectSymbols(this.value)">
           						<option value="" disabled selected>종목명</option>
           					<c:forEach var="cal" items= "${calList}">
			           			<option value="${cal.stockinfo_symbols}" >${cal.stockinfo_symbols}</option>
			           		</c:forEach>
	           			</select>
					</span>
				
					<button id="sub-cal2excel" class="bttn-simple bttn-xs bttn-ggreen right-bttn">엑셀파일로 다운</button>
				</div>
				
				<table id="sub-cal-table" class="table leaderboards">
					<thead>
						<tr>
							<th>초과이익 가정(w)</th>
							<th>지배주주지분</th>
							<th>ROE</th>
							<th>주주요구수익률</th>
							<th>적정주주가치</th>
							<th>발행주식수</th>
							<th>적정주가</th>
							<th>매수/매도 여부</th>
						</tr>
					</thead>
					
					<tbody id="cal-table-tbody">
					</tbody>
				</table>
			</div>
		</div>
	
		<jsp:include page="../main/footer.jsp"/>
	
		<script src="resources/sb_admin/vendor/chart.js/Chart.min.js"></script>
		
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		
		<script src="resources/tableExport/tableExport.min.js" type="text/javascript"></script>
		<script src="resources/tableExport/xlsx.core.min.js" type="text/javascript"></script>
		<script src="resources/tableExport/FileSaver.min.js" type="text/javascript"></script>
	</body>
</html>