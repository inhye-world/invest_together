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
	<title>같이투자 | 매출분석</title>
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
 	<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
	
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
	<link href='https://spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css' rel='stylesheet' type='text/css'>
	
	<script src="resources/sb_admin/vendor/chart.js/Chart.min.js"></script>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.css"/>
	
	<link href="resources/ranking.css" rel="stylesheet" type="text/css">
	<link href="resources/sales.css" rel="stylesheet" type="text/css">
	<link href="resources/sb_admin/css/bootstrap-datepicker3-custom.min.css" rel="stylesheet" type="text/css">
	
	
	<script>
		var dailyChart;
		var monthlyChart;
		
		var dailyChartRunning = false;
		
		$(function(){
			moment.locale("ko");
			
			$.fn.datepicker.dates['kr'] = {
				days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
				daysShort: ["일", "월", "화", "수", "목", "금", "토", "일"],
				daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
				months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
			};
			
			$('.input-group.date').datepicker({
				calendarWeeks: false,
				todayHighlight: true,
				autoclose: true,
				format: "yyyy-mm-dd",
				language: "kr"
			});
			
			
			
			$("#sales-info-yesterday").click(function() {
				var startDate = moment().subtract(1, 'days').format("YYYY-MM-DD"); 
				var endDate = moment().subtract(1, 'days').format("YYYY-MM-DD");
				
				loadSalesInfo(startDate, endDate);
				
				$(".btttn").removeClass("btttn-active");
				$(this).addClass("btttn-active");
				$(".my-date-input").removeClass("input-read-only-active");
				$(".my-date-input").addClass("input-read-only");
			});
			
			$("#sales-info-thisweek").click(function() {
				var startDate = moment().startOf('week').add(1, 'days').format("YYYY-MM-DD");
				var endDate = moment().subtract(1, 'days').format("YYYY-MM-DD");
				
				loadSalesInfo(startDate, endDate);
				
				$(".btttn").removeClass("btttn-active");
				$(this).addClass("btttn-active");
				$(".my-date-input").removeClass("input-read-only-active");
				$(".my-date-input").addClass("input-read-only");
			});
			
			$("#sales-info-thismonth").click(function() {
				var startDate = moment().startOf('month').format("YYYY-MM-DD");
				var endDate = moment().subtract(1, 'days').format("YYYY-MM-DD");
				
				loadSalesInfo(startDate, endDate);
				
				$(".btttn").removeClass("btttn-active");
				$(this).addClass("btttn-active");
				$(".my-date-input").removeClass("input-read-only-active");
				$(".my-date-input").addClass("input-read-only");
			});
			
			$("#sales-info-last3month").click(function() {
				var startDate = moment().subtract(2, 'month').startOf('month').format("YYYY-MM-DD");
				var endDate = moment().subtract(1, 'days').format("YYYY-MM-DD");
				
				loadSalesInfo(startDate, endDate);
				
				$(".btttn").removeClass("btttn-active");
				$(this).addClass("btttn-active");
				$(".my-date-input").removeClass("input-read-only-active");
				$(".my-date-input").addClass("input-read-only");
			});
			
			$("#sales-info-search").click(function() {
				var startDate = $("#startDate").val();
				var endDate = $("#endDate").val();
				
				if(startDate=="" || endDate=="") {
					return false;
				}
				
				loadSalesInfo(startDate, endDate);
				
				$(".btttn").removeClass("btttn-active");
				$(".my-date-input").removeClass("input-read-only");
				$(".my-date-input").addClass("input-read-only-active");
			});
			
			
			$("#sales-info-thismonth").click();
			
			
			(function() {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				
				$.ajax({
					url: "rest/monthlySalesInfo",
		    		type: 'POST',
		    		dataType: 'json',
		    		beforeSend: function(xhr){
		    			xhr.setRequestHeader(header, token);
		    		},
		    		success: function(result) {
		    			if(result.hasMonthlySales) {
		    				monthlyChart = new Chart(document.getElementById("monthly-chart").getContext('2d'), {
			    				type: 'bar',
			    			    data: {
			    			        datasets: [
			    			        	{
				    			            label: '월별 매출',
				    			            data: result.data1,
				    			            backgroundColor: '#68b6dc',
						                    borderColor: '#68b6dc',
						                    yAxisID: 'A',
						                    order: 2
			    			        	}, 
			    			        	{
				    			            label: '누적 매출',
				    			            data: result.data2,
				    						type: 'line',
				    						backgroundColor: '#fdda28',
						                    borderColor: '#fdda28',
						                    fill: false,
						                    borderWidth: 1,
						                    pointRadius: 2,
						                    yAxisID: 'B',
						                    order: 1
			    			        	}
			    			        ],
			    			        labels: result.labels
			    			   },
			    			   options: {
				           			responsive: true,
					                animation: {
					                    duration: 200
					                },
					                legend: {
					                    display: true,
					                    position: 'bottom'
					                },
					                maintainAspectRatio: false,
					                title: {
					                    display: false
					                },
					                tooltips: {
					                    mode: 'index',
					                    intersect: false,
					                    callbacks: {
					                    	title: function (tooltipItems, data) {
					                            var tooltipItem = tooltipItems[0];
					                            return data.labels[tooltipItem.index];
					                        },
					                        label: function (tooltipItem, data) {
					                            return " ₩ "+(tooltipItem.value*1).toLocaleString();
					                        }
					                    },
					                    backgroundColor: '#FFF',
					                    borderWidth: 1,
					                    borderColor: '#666',
					                    titleFontColor: '#000',
					                    bodyFontColor: '#666',
					                    bodyFontSize: 12
					                },
					                scales: {
					                    xAxes: [{
					                    	display: true,
					                    	scaleLabel: {
					                            display: false
					                        },
					                        ticks: {
					                            callback: function (value, index, values) {
					                                return value.toLocaleString();
					                            }
					                        },
					                        gridLines: {
					                            display: false,
					                        }
					                    }],
					                    yAxes: [
					                    	{	
					                    		id: 'A',
					                    		type: 'linear',
					                    		position: 'left',
					                    		display: true,
					                    		scaleLabel: {
						                            display: false
						                        },
						                        ticks: {
						                       		stepSize: 5000000,
						                       		beginAtZero: true,
						                       		callback: function (value, index, values) {
						                                return value.toLocaleString();
						                            }
						                        }
						                    },
					                    	{
					                    		id: 'B',
					                    		type: 'linear',
					                    		position: 'right',
					                    		display: true,
					                    		scaleLabel: {
						                            display: true,
						                            labelString: "누적",
						                            fontColor: "#a0a0a0",
						                         	fontFamily: "'Spoqa Han Sans', sans-serif"
						                        },
						                        ticks: {
						                       		stepSize: 10000000,
						                       		beginAtZero: true,
						                       		callback: function (value, index, values) {
						                                return value.toLocaleString();
						                            }
						                        }
						                    }
					                    ]
					                }
				            	}
			    			});
		    				
		    				$("#monthly-chart-empty").css("display", "none");
		    				$("#monthly-chart").css("display", "block");
		    				
		    			}else {
		    				$("#monthly-chart").css("display", "none");
		    				$("#monthly-chart-empty").css("display", "block");
		    			}
		    		}
				});
			})();
			
			
		});
	</script>
</head>
	<body>
		<jsp:include page="../main/header.jsp"/>
		
		<div class="container">
			<div class="sales-btn-container">
				<span class="btn-group">
					<button id="sales-info-yesterday" type="button" class="btttn">어제</button>
					<button id="sales-info-thisweek" type="button" class="btttn">이번주</button>
					<button id="sales-info-thismonth" type="button" class="btttn">이번달</button>
					<button id="sales-info-last3month" type="button" class="btttn">3개월</button>
				</span>
				<span>
					<button id="sales-info-search" type="button" class="btttn">검색</button>
				</span>
				<span class="input-group input-daterange date">
					<input id="startDate" type="text" class="form-control my-date-input input-read-only" readonly="readonly">
					<input id="endDate" type="text" class="form-control my-date-input input-read-only" readonly="readonly">
        		</span>
        	</div>
			<hr style="margin-top: 15px; margin-bottom: 15px;">
			<div class="sales-manage-info">
				<div class="sales-info-table-container">
					<div class="sales-manage-info-2">
						매출 현황 상세
						<div class="sales-blank"></div>
						<b id="sales-sum">25,125,600</b>원
						<p>총 <b id="sales-count">6일</b>간 매출 현황입니다.</p>
					</div>
					<table id="sales-info-table" class="table leaderboards">
						<thead>
							<tr>
								<th>날짜</th>
								<th>건수</th>
								<th>매출(원)</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div id="pagination">
					</div>
				</div>
				<div class="sales-info-chart-container">
					<div class="sales-daily-chart">
						<div class="sales-manage-info-2">
							일별 매출
							<div class="sales-blank"></div>
						</div>
						<canvas id="daily-chart"></canvas>
						<div id="daily-chart-empty" class="chart-empty">
							매출이 없습니다
						</div>
					</div>
					<div class="sales-monthly-chart">
						<div class="sales-manage-info-2">
							월별 매출
							<div class="sales-blank"></div>
						</div>
						<canvas id="monthly-chart"></canvas>
						<div id="monthly-chart-empty" class="chart-empty">
							매출이 없습니다
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<jsp:include page="../main/footer.jsp"/>
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.min.js"></script>
		<script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
		<script type='text/javascript' src="https://momentjs.com/downloads/moment-with-locales.min.js"></script>
		<script>
			function loadSalesInfo(startDate, endDate) {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				
				$.ajax({
					url: "rest/salesInfo",
		    		type: 'POST',
		    		dataType: 'json',
		    		data: {
		    			startDate: startDate,
		    			endDate: endDate
		    		},
		    		beforeSend: function(xhr){
		    			xhr.setRequestHeader(header, token);
		    		},
		    		success: function(result) {
		    			
		    			if(result.hasSales) {
			    			$("#sales-sum").text(result.sales_sum.toLocaleString());
			    			$("#sales-count").text(result.sales_count+"일");
			    			
			    			$("#sales-info-table tbody").empty();	
			    			
			    			var container = $("#pagination");
			    			container.pagination({
			    				dataSource: result.sales_list,
			    				pageSize: 15,
			    				autoHidePrevious: true,
			    			    autoHideNext: true,
			    				callback: function(data, pagination) {
			    					var str = '';
			    					
			    					$.each(data, function(index, item) {
			    						str += 	'<tr>';
				        				str +=	'<td>'+moment(item.sales_date).format('YYYY-MM-DD (ddd)')+'</td>';
			        					str +=	'<td>'+item.daily_count+'</td>';
			        					str +=	'<td>'+item.daily_sales.toLocaleString()+'</td>';
			        					str +=	'</tr>';
			        				});
			    					
			    					$("#sales-info-table tbody").empty();	
			    					$("#sales-info-table tbody").append(str);
			    				}
			    			});
			    			
			    			$("#startDate").val(startDate);
			    			$("#endDate").val(endDate);
			    			
			    			
			    			if(dailyChartRunning) {
			    				dailyChart.destroy();
			    			}
			    			
			    			dailyChart = new Chart(document.getElementById("daily-chart").getContext('2d'), {
			    				type: 'bar',
			    			    data: {
			    			        datasets: [
			    			        	{
				    			            label: '일별 매출',
				    			            data: result.data1,
				    			            backgroundColor: '#68b6dc',
						                    borderColor: '#68b6dc',
						                    yAxisID: 'A',
						                    order: 2
			    			        	}, 
			    			        	{
				    			            label: '누적 매출',
				    			            data: result.data2,
				    						type: 'line',
				    						backgroundColor: '#fdda28',
						                    borderColor: '#fdda28',
						                    fill: false,
						                    borderWidth: 1,
						                    pointRadius: 2,
						                    yAxisID: 'B',
						                    order: 1
			    			        	}
			    			        ],
			    			        labels: result.labels
			    			   },
			    			   options: {
				           			responsive: true,
					                animation: {
					                    duration: 200
					                },
					                legend: {
					                    display: true,
					                    position: 'bottom'
					                },
					                maintainAspectRatio: false,
					                title: {
					                    display: false
					                },
					                tooltips: {
					                    mode: 'index',
					                    intersect: false,
					                    callbacks: {
					                    	title: function (tooltipItems, data) {
					                            var tooltipItem = tooltipItems[0];
					                            return data.labels[tooltipItem.index];
					                        },
					                        label: function (tooltipItem, data) {
					                            return " ₩ "+(tooltipItem.value*1).toLocaleString();
					                        }
					                    },
					                    backgroundColor: '#FFF',
					                    borderWidth: 1,
					                    borderColor: '#666',
					                    titleFontColor: '#000',
					                    bodyFontColor: '#666',
					                    bodyFontSize: 12
					                },
					                scales: {
					                    xAxes: [{
					                    	display: true,
					                    	scaleLabel: {
					                            display: false
					                        },
					                        ticks: {
					                            callback: function (value, index, values) {
					                                return value.toLocaleString();
					                            }
					                        },
					                        gridLines: {
					                            display: false,
					                        }
					                    }],
					                    yAxes: [
					                    	{	
					                    		id: 'A',
					                    		type: 'linear',
					                    		position: 'left',
					                    		display: true,
					                    		scaleLabel: {
						                            display: false
						                        },
						                        ticks: {
						                       		stepSize: 200000,
						                       		callback: function (value, index, values) {
						                                return value.toLocaleString();
						                            }
						                        }
						                    },
					                    	{
					                    		id: 'B',
					                    		type: 'linear',
					                    		position: 'right',
					                    		display: true,
					                    		scaleLabel: {
						                            display: true,
						                            labelString: "누적",
						                            fontColor: "#a0a0a0",
						                         	fontFamily: "'Spoqa Han Sans', sans-serif"
						                        },
						                        ticks: {
						                       		stepSize: 2000000,
						                       		callback: function (value, index, values) {
						                                return value.toLocaleString();
						                            }
						                        }
						                    }
					                    ]
					                }
				            	}
			    			});
			    			
			    			dailyChartRunning = true;
			    			
			    			$("#daily-chart-empty").css("display", "none");
			    			$("#daily-chart").css("display", "block");
		    			}else {
		    				$("#sales-sum").text("0");
			    			$("#sales-count").text("0일");
			    			
			    			$("#sales-info-table tbody").empty();
			    			
			    			var str = 	'<tr>';
			    				str +=	'<td class="sales-info-table-empty" colspan="3">매출이 없습니다</td>';
			    				str +=	'</tr>';
			    				
			    			$("#sales-info-table tbody").append(str);	
			    			$("#daily-chart").css("display", "none");
			    			$("#daily-chart-empty").css("display", "block");
			    			$("#pagination").empty();
		    			}
		    		}
				});
			}
			
		</script>
	</body>
</html>