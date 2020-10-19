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
	<title>같이투자 : 구독목록</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<link href="resources/sb_admin/css/bttn.css" rel="stylesheet" type="text/css">
	<link href="resources/ranking.css" rel="stylesheet" type="text/css">
	<link href="resources/sub.css" rel="stylesheet" type="text/css">
	
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
	
	<script src="resources/sb_admin/vendor/chart.js/Chart.min.js"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
	
	<script>
		var chart;
		var nickArr = [];
		
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
	
		
	    function driveBackscreen(nickname) {
			$.ajax({
				type: "GET",
				url: "rest/getRankDetails",
				dataType: "json",
				data: {"nickname": nickname},
				success: function(result) {
					
					$(".black-model-section-title u").text(nickname);
					
					if(result.ranking.league=="empty") {
						$("#backscreen-3 .black-model-section-place img").attr("src", "resources/icon/question.png");
						$("#backscreen-3 .black-model-section-place span:nth-child(2)").addClass("color-place-grey").text(" 순위없음");
						$("#backscreen-3 .black-model-section-place span:nth-child(3)").text("");
					}else {
						$("#backscreen-3 .black-model-section-place img").attr("src", "resources/icon/"+result.ranking.league+".png");
						$("#backscreen-3 .black-model-section-place span:nth-child(2)").addClass("color-place-"+result.ranking.league).text(result.ranking.place.toLocaleString()+"위");
						$("#backscreen-3 .black-model-section-place span:nth-child(3)").text("(상위 "+result.ranking.percentile+"%)");
					}
					
					
					chart = new Chart($('#black-model-section-canvas')[0].getContext('2d'), {
		            	type: 'line',
		            	data: {
		                	labels: result.labels,
			           	 	datasets: [{
			                	data: result.data,
			                    backgroundColor: '#227FEC',
			                    borderColor: '#227FEC',
			                    fill: false,
			                    borderWidth: 1,
			                    pointRadius: 2,
			                }]
		            	},
		           		options: {
		           			responsive: true,
			                animation: {
			                    duration: 200
			                },
			                layout: {
			                    padding: {
			                        left: 15,
			                        right: 15,
			                        top: 20,
			                        bottom: 5
			                    }
			                },
			                legend: {
			                    display: false
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
			                            return data.labels[tooltipItem.index].date;
			                        },
			                        label: function (tooltipItem, data) {
			                            return ' '+data.labels[tooltipItem.index].net_profit_ratio+'%';
			                        },
			                        afterLabel: function (tooltipItem, data) {
			                            return ' '+data.labels[tooltipItem.index].net_profit.toLocaleString()+'원';
			                        }
			                        
			                    }
			                },
			                scales: {
			                    xAxes: [{
			                        display: true,
			                        scaleLabel: {
			                            display: false
			                        },
			                        ticks: {
			                            fontColor: "#a0a0a0",
			                            callback: function (value, index, values) {
			                                return value.date;
			                            }
			                        },
			                        gridLines:{
			                        	zeroLineColor: "#393939",
			    						color: "#393939",
			    						lineWidth: 1
			    					 }
			                    }],
			                    yAxes: [{
			                        display: true,
			                        scaleLabel: {
			                            display: false
			                        },
			                        ticks: {
			                       		fontColor: "#a0a0a0",
				                       	stepSize: 100
			                        },
			                        gridLines:{
			                       	 	color: "transparent",
			                            display: true,
			                            drawBorder: false,
			                            zeroLineColor: "#393939",
			                            zeroLineWidth: 1
			     					 }
			                    }]
			                }
		            	}
		            });
					
					
					$("#backscreen-3").css("display", "block");
				}
			});
		}
	    
	    function goSubInfo(seller_num) {
	    	var newForm = $("<form></form>");
	    	newForm.attr("action", "subInfo");
	    	newForm.attr("method", "POST");
	    	
	    	var input = $("<input type='hidden' value='"+seller_num+"' name='seller_num' />");
	    	var input_csrf = $("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}' />")
	    	newForm.append(input);
	    	newForm.append(input_csrf);
	    	
	    	newForm.appendTo("body");
	    	newForm.submit();
	    }
	    
	    
		$(function() {
			
			for(var i=0; i<nickArr.length; ++i) {
				(function(j) {
					$.ajax({
						url: "rest/findRanking",
						type: 'GET',
						dataType: 'json',
						data: {"nickname": nickArr[j]},
						
						success: function(result) {
							if(result.league == "empty") {
									$("#sub-list-tr-"+j+" td:nth-child(2)").html("-");
									$("#sub-list-tr-"+j+" td:nth-child(3)").html("-");
									$("#sub-list-tr-"+j+" td:nth-child(4)").html("-");
							}else {
								if(result.net_profit>0) {
									$("#sub-list-tr-"+j+" td:nth-child(2)").addClass("profit-rise").html(result.net_profit_ratio+"%");
									$("#sub-list-tr-"+j+" td:nth-child(3)").addClass("profit-rise").html(result.net_profit.toLocaleString()+"원");
									$("#sub-list-tr-"+j+" td:nth-child(4)").html(result.investment_amount.toLocaleString()+"원");
								}else {
									$("#sub-list-tr-"+j+" td:nth-child(2)").addClass("profit-fall").html(result.net_profit_ratio+"%");
									$("#sub-list-tr-"+j+" td:nth-child(3)").addClass("profit-fall").html(result.net_profit.toLocaleString()+"원");
									$("#sub-list-tr-"+j+" td:nth-child(4)").html(result.investment_amount.toLocaleString()+"원");
								}
							}
						}
					});
				})(i);
			}
			
			$(".black-model-close-btn").click(function() {
				$(".ranking-backscreen").css("display","none");
				
				$(".black-model-section-place span:nth-child(2)").removeClass();
				
				chart.destroy();
			});
			
			$(".ranking-backscreen").mouseup(function(e){ 
		 		var blackmodel = $(".ranking-black-model");
		 		
		 		if (!blackmodel.is(e.target) && blackmodel.has(e.target).length === 0){
		 			$(".ranking-backscreen").css("display","none");
		 			
		 			$(".black-model-section-place span:nth-child(2)").removeClass();
				
					chart.destroy();
				}	
			});
		});
	</script>
</head>
	<body>
	<jsp:include page="../main/header.jsp"/>
	
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
							<th>구독시작일</th>
							<th>구독만료일</th>
							<th>상세정보</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list}">
							<tr>
								<td class="sub-list-empty" colspan="7">아직 구독한 회원이 없습니다</td>
							</tr>
						</c:if>
						
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr id="sub-list-tr-${status.index}">
								<td><a href="javascript:driveBackscreen('${dto.seller_nickname}')">${dto.seller_nickname}</a></td>
								<td></td>
								<td></td>
								<td></td>
								<td><fmt:formatDate value="${dto.sub_date}" pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${dto.sub_maturity_date}" pattern="yyyy-MM-dd" /></td>
								<td><button onclick="goSubInfo(${dto.seller_num})" class="bttn-simple bttn-xs bttn-ggreen">보기</button></td>
							</tr>
							<script>
								var nick = "${dto.seller_nickname}";
								nickArr.push(nick);
							</script>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		<div id="backscreen-3" class="ranking-backscreen">
			<div class="ranking-model-container">
				<div class="ranking-black-model">
					<button class="black-model-close-btn">
					</button>
					<div class="black-model-section">
						<h2 class="black-model-section-title"><u></u></h2>
						<div class="black-model-section-place">
							<span><img width="28px" height="28px" /></span>
							<span></span>
							<span class="color-place-grey"></span>
						</div>
						<div class="black-model-section-chart">
							<p>수익률 그래프</p>
							<canvas id="black-model-section-canvas"></canvas>
						</div>
					</div>
				</div>
			</div>	
		</div>
		
	<jsp:include page="../main/footer.jsp"/>
	</body>
</html>