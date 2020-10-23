<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="bit.it.into.dto.AccountTransactionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>같이투자 | 가계부 분석</title>
	
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <link href="resources/sb_admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
   <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
   <script src="resources/sb_admin/vendor/jquery/jquery.min.js"></script>
   <script src="resources/sb_admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
   <script src="resources/sb_admin/vendor/jquery-easing/jquery.easing.min.js"></script>
   <script src="resources/sb_admin/js/sb-admin-2.min.js"></script>
   <script src="resources/sb_admin/vendor/chart.js/Chart.min.js"></script>
   <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
   
	<script>
		var shoppingSum = ${shoppingSum};
		var livingExpense = ${livingExpense};
		var transportSum = ${transportSum};
		var coffeeSum = ${coffeeSum};
		var mealSum = ${mealSum};
		var hobbySum = ${hobbySum};
		var etcSum = ${etcSum};
	</script>
	<script>
		var data=${data};
		var xDomain = [];
		for(var i=0; i<data.length; i++){
			xDomain.push(data[i].date);
		}
		
		var yDomain = [];
		for(var i=0; i<data.length; i++){
			yDomain.push(data[i].expenseAmt);
		}
		
		console.log(xDomain);
		console.log(yDomain);
	</script>
	<style>
	
		#graphs{
			display:flex;
			left:50%
			margin-left:-150px;
		}
		
		.section{
			display:flex;
		}
		
		#expenseList{
			flex:1;
		}
		
		#dailyExpense{
			flex:1;
		}
		
		#expenseWrap{
			clear:both;
		}
		
		#expenseTable{
			width: 90%;
			margin: auto;
			text-align: center;
			margin-bottom: 50px;
			font-size: 20px;
		}
		
		@media ( max-width: 768px ) {
			#graphs{
				flex-wrap:wrap;
				width:auto;
			}
		
  			#expenseList{
  				font-size:0.5em;
				width:auto;
				text-align: center;
			}
			
			#dailyExpense{
				width:auto;
				text-align: center;
				padding-top:50px;
			}
		}
		
		.tran-dropdown {
		  position: relative;
		  display: inline-block;
		  width: 600px;
		  left: 50%;
		  margin-left:-280px;
		  font-size: 2em;
		}
		
		.tran-dropdown-content {
		  display: none;
		  position: absolute;
		  background-color: #f1f1f1;
		  max-height: 200px;
		  overflow-y: auto; /* prevent horizontal scrollbar */
		  overflow-x: hidden;
		  min-width: 100%;
		  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
		  z-index: 1;
		  font-size: 1em;
		}
		
		.tran-dropdown-content a {
		  color: black;
		  padding: 12px 16px;
		  text-decoration: none;
		  font-family: 'MapoDPPA';
		  display: block;
		}
		
		.tran-dropdown-content a:hover {
			background-color: #ddd;
			text-decoration: none;
			color: #027368;
		}
		
		.tran-dropdown:hover .tran-dropdown-content {display: block;}
		
		.tran-dropdown:hover .section {background-color: #E7E7E7;}
	</style>
	
</head>	
	<body>
		<div class="wrapper">
		<jsp:include page="../main/header.jsp"/>
		
			<div class="container">
						
				<br><br>
				
				<br>
				<div id="graphs">
				<!-- 지출 유형 그래프(도넛)  -->
					<div id="expenseList">
						<c:if test="${!(shoppingSum == 0 and livingExpense == 0 and transportSum == 0
						and coffeeSum == 0 and mealSum == 0 and hobbySum == 0 and ectSum==0)}">
                  			<canvas id="myDoughnutChart"></canvas>
							<br>
							<div>
			                    <span>
			                    	<i class="fas fa-circle" style="color:#2C4459"></i> 쇼핑 &nbsp;
			                    </span>
			                    <span>
			                    	<i class="fas fa-circle" style="color:#465E73"></i> 생활 &nbsp;
			                    </span>
			                    <span>
			                    	<i class="fas fa-circle" style="color:#C1CED9"></i> 교통 &nbsp;
			                    </span>
			                    <span>
			                    	<i class="fas fa-circle" style="color:#3D2D35"></i> 커피 &nbsp;
			                    </span>
			                    <span>
			                    	<i class="fas fa-circle" style="color:#72675D"></i> 식사 &nbsp;
			                    </span>
			                    <span>
			                    	<i class="fas fa-circle" style="color:#B7AEBF"></i> 취미 &nbsp;
			                    </span>
			                    <span>
			                    	<i class="fas fa-circle" style="color:#A6949C"></i> 미분류 &nbsp;
			                    </span>
		                  	</div>
					</c:if>
					</div>
				
				<!-- 일별 지출액 그래프 (막대) -->
				<c:if test="${!(data == null)}">
					<div id="dailyExpense">
						<canvas id="myBarChart"></canvas>
							
						
					</div>
					<div id="expenseReport">
					</div>
				</c:if>
				</div>
					<br>
					<br>
					
				<div id="expenseWrap">
					<div class="tran-dropdown">
						<div class="section">
							<div id="sec1">
							</div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<div id="sec3">
								<div id="sec4">
								</div>
							</div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<div id="sec2">
								<svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-calendar-check" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
								  <path fill-rule="evenodd" d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
								  <path fill-rule="evenodd" d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
								</svg>
							</div>	
						</div>
						<div id="tran-dropdown-content" class="tran-dropdown-content">
						</div>
					</div>
				<br>
				
				<table id="expenseTable" class="table">
					<thead>
						<tr>
							<th>유형</th>
							<th>지출액</th>
						</tr>
					</thead>
					<tbody>
							<tr>
								<td>쇼핑</td>
								<td>${shoppingSum}</td>
							</tr>
							<tr>
								<td>생활</td>
								<td>${livingExpense}</td>
							</tr>
							<tr>
								<td>교통</td>
								<td>${transportSum}</td>
							</tr>
							<tr>
								<td>커피</td>
								<td>${coffeeSum}</td>
							</tr>
							<tr>
								<td>식사</td>
								<td>${mealSum}</td>
							</tr>
							<tr>
								<td>취미</td>
								<td>${hobbySum}</td>
							</tr>
							<tr>
								<td>미분류</td>
								<td>${etcSum}</td>
							</tr>
						
					</tbody>
				</table>
				</div>
			</div>
			
			<!-- 도넛 디자인 -->
			<script>
			//Set new default font family and font color to mimic Bootstrap's default styling
			Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
			Chart.defaults.global.defaultFontColor = '#858796';
			
			// Pie Chart Example


				// Pie Chart Example
				var ctx = document.getElementById("myDoughnutChart");
				var myDoughnutChart = new Chart(ctx, {
				  type: 'doughnut',
				  data: {
				    labels: ["쇼핑", "생활", "교통", "커피", "식사", "취미", "미분류"],
				    datasets: [{
				      data: [shoppingSum, livingExpense, transportSum, coffeeSum, mealSum, hobbySum, etcSum],
				      backgroundColor: ['#2C4459', '#465E73', '#C1CED9', '#3D2D35','#72675D','#B7AEBF','#A6949C'],
				      hoverBackgroundColor: ['#C0A888', '#D6D0C9', '#A69F9B','#8C8A6C','#F3F1E9','#77868C','#B47854'],
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
			</script>
				
			<!-- 막대 디자인 -->
			<script>	
				var barChartData={
					labels:xDomain,
					
					datasets:[{
						label:'일별 지출액(원)',
						backgroundColor:'#4C5775',
						fontSize:20,
						data:yDomain
					}]
				};
				
				window.onload=function(){
					var ctx = $('#myBarChart');
					window.theChart = new Chart(ctx,{
						type:'bar',
						data:barChartData
					});
				}
				
			</script>
			
		</div>
		<jsp:include page="../main/footer.jsp"/>
		
		<script>
			$(function() {
				var year = ${year}
				var month = ${month}
				$("#sec1").html("<b>"+month+"</b>월")
				
				var expenseSum = ${expenseSum}
				$("#sec4").html("총 지출 <b>"+expenseSum.toLocaleString()+"</b>원");
				
				function numberPad(n, width) {
				    n = n + '';
				    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
				}	
				
				var date = new Date();
				var y = date.getFullYear();
				var m = date.getMonth()+1;
				
				while(y>2010) {
					while(m>0) {
						var a = $("<a></a>");
						a.attr("href", "expenseAnalyze-"+y+"-"+numberPad(m, 2));
						a.text(y+"년 "+m+"월");
						if(y==year && m==month) {
							a.css("background-color", "#808080")	
						}
						
						$("#tran-dropdown-content").append(a);
						--m;
					}
					--y;
					m=12;
				}
			});
		</script>
		
   <script src="resources/sb_admin/vendor/chart.js/Chart.min.js"></script>
   <script src="resources/tableExport/tableExport.min.js" type="text/javascript"></script>
   <script src="resources/tableExport/xlsx.core.min.js" type="text/javascript"></script>
   <script src="resources/tableExport/FileSaver.min.js" type="text/javascript"></script>
	
	</body>
</html>