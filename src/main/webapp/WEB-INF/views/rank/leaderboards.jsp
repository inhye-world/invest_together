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
	<title>같이투자 | 투자랭킹</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
 	<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
	
	<link href="resources/ranking.css" rel="stylesheet" type="text/css">
	
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
	<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css' rel='stylesheet' type='text/css'>
	<script src="https://kit.fontawesome.com/80d121b39f.js" crossorigin="anonymous"></script>
	
	<script src="resources/sb_admin/vendor/chart.js/Chart.min.js"></script>
	
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
	
	<!-- alert -->
  	<link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
  	<script src="resources/sb_admin/js/ast-notif.js"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
	<script>
		var chart;
		
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
		
		function getIndividualRank(nickname) {
			$.ajax({
				type: "GET",
				url: "rest/findRanking",
				dataType: "json",
				data: {"nickname": nickname},
				
				success: function(result) {
					
					if(result.league == "empty") {
						var str = "<tr>";
						str += "<td class='ranking-individual-notice' colspan='6'>";
						str += "검색 결과가 없습니다";
						str += "<p>랭킹에서 "+nickname+" 님을 찾을 수 없습니다.</p>";
						str += "</td></tr>";
						
						$("#ranking-individual-table tbody").html(str);
					}else {
						var str = "<tr>";
						str += "<td><img src='resources/icon/"+result.league+".png' width='36px' height='36px'/></td>";
						str += "<td>"+result.place.toLocaleString()+"<p>(상위 "+result.percentile+"%)</p></td>";
						str += "<td><a href='javascript:driveBackscreen(`"+result.nickname+"`)'>"+result.nickname+"</a></td>";
						str += "<td>"+result.net_profit_ratio+"%</td>";
						str += "<td>"+result.net_profit.toLocaleString()+"원</td>";
						str += "<td>"+result.investment_amount.toLocaleString()+"원</td>";
						str += "</tr>";
						
						$("#ranking-individual-table tbody").html(str);
						
						if(result.net_profit_ratio>0) {
							$("#ranking-individual-table tbody tr td:nth-child(4)").addClass("profit-rise");
							$("#ranking-individual-table tbody tr td:nth-child(5)").addClass("profit-rise");
						}else {
							$("#ranking-individual-table tbody tr td:nth-child(4)").addClass("profit-fall");
							$("#ranking-individual-table tbody tr td:nth-child(5)").addClass("profit-fall");
						}
					}
				}
			});
		}
		
		function driveBackscreen(nickname) {
			$.ajax({
				type: "GET",
				url: "rest/getRankDetails",
				dataType: "json",
				data: {"nickname": nickname},
				success: function(result) {
					if(result.ranking.league=="empty") {
						return;
					}
					
					$(".black-model-section-title u").text(nickname);
					$("#backscreen-1 .black-model-section-place img").attr("src", "resources/icon/"+result.ranking.league+".png");
					$("#backscreen-1 .black-model-section-place span:nth-child(2)").addClass("color-place-"+result.ranking.league).text(result.ranking.place.toLocaleString()+"위");
					$("#backscreen-1 .black-model-section-place span:nth-child(3)").text("(상위 "+result.ranking.percentile+"%)");
					
					if(!result.valid.isLogin) {
						$("#backscreen-1 #subscribe-btn").addClass("black-model-bottom-btn-enabled").addClass("black-model-bottom-btn-"+result.ranking.league).text("구독하기").attr("onclick", "location.href='/into/loginForm'").prop("disabled", false);
					}else {
						if(result.valid.isMe) {
							$("#backscreen-1 #subscribe-btn").addClass("black-model-bottom-btn-disabled").text("자기 자신은 구독할수 없습니다").prop("disabled", true);
						}else if(result.valid.isSubscribe) {
							$("#backscreen-1 #subscribe-btn").addClass("black-model-bottom-btn-disabled").text("이미 구독한 회원입니다").prop("disabled", true);
						}else {
							$("#backscreen-1 #subscribe-btn").addClass("black-model-bottom-btn-enabled").addClass("black-model-bottom-btn-"+result.ranking.league).text("구독하기").attr("onclick", "driveBackscreen2()").prop("disabled", false);
							
							if(!result.valid.hasSetPrice) {
								$("#backscreen-2 #payment-btn").addClass("black-model-bottom-btn-disabled").text("설정금액을 설정하지 않았습니다").prop("disabled", true);
							}else {
								$("#backscreen-2 #payment-btn").addClass("black-model-bottom-btn-enabled").text(result.valid.setPrice.toLocaleString()+"원 결제").attr("onclick", "drivePayment("+result.ranking.member_num+","+result.valid.setPrice+")").prop("disabled", false);
							}
						}
					}
					
					if(result.ranking.league=='whale') {
						var chartcolor = "#227fec";
					}else if(result.ranking.league=='mackerel') {
						var chartcolor = "#a593e0";
					}else if(result.ranking.league=='shrimp') {
						var chartcolor = "#f7630c";
					}
					
					
					
					chart = new Chart($('#black-model-section-canvas')[0].getContext('2d'), {
		            	type: 'line',
		            	data: {
		                	labels: result.labels,
			           	 	datasets: [{
			                	data: result.data,
			                    backgroundColor: chartcolor,
			                    borderColor: chartcolor,
			                    fill: false,
			                    borderWidth: 1,
			                    pointRadius: 2
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
					
					
					$("#backscreen-1").css("display", "block");
				}
			});
		}
		
		function driveBackscreen2() {
			$("#backscreen-1").css("display", "none");
			$("#backscreen-2").css("display", "block");
		}
		
		function getMerchantSeq() {
			var seq;
			
			(function() {
				$.ajax({
					type: "GET",
					url: "rest/getMerchantSeq",
					dataType: "json",
					async: false,
					success: function(result) {
						seq = result.seq;
					}
				});
			})();
			
			return seq;
		}
		
		function drivePayment(seller_num, set_price) {
			var seq = getMerchantSeq();
			
			var today = new Date();
			var yyyy = today.getFullYear();
			var mm = today.getMonth()+1;
			var dd = today.getDate();
			if(dd<10) {
			    dd='0'+dd;
			} 

			if(mm<10) {
			    mm='0'+mm;
			} 
			
			<sec:authorize access="isAnonymous()">
				location.href = "/into/loginForm";
			</sec:authorize>	
		
			<sec:authorize access="isAuthenticated()">
				<sec:authentication var="principal" property="principal"/>
				
				var memnum = ${principal.dto.member_num};
				var memname = "${principal.dto.name}";
				var memphone = "${principal.dto.phone}";
				var mememail = "${principal.dto.email}";
				var merchantid = "INV"+yyyy+mm+dd+seq;
				
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				
				IMP.init("imp85973823");
				
				IMP.request_pay({ 
				    pg: "html5_inicis",
				    pay_method: "card",
				    merchant_uid: merchantid,
				    name: "같이투자 구독상품",
				    amount: set_price,
				    buyer_email: mememail,
				    buyer_name: memname,
				    buyer_tel: memphone,
				    }, 
				 	function(rsp) { 
				    	
				    	if(rsp.success) {
				        
				        	$.ajax({
				        		url: "rest/completePayment",
				        		type: 'POST',
				        		dataType: 'json',
				        		data: {
				        			merchant_uid: merchantid,
				        			member_num: memnum,
				        			name: memname,
				        			phone: memphone,
				        			seller_num: seller_num,
				        			sub_price: set_price
				        		},
				        		beforeSend: function(xhr){
				        			xhr.setRequestHeader(header, token);
				        		}
				        	}).done(function(result){
				        		if(result.successPayment) {
				        			location.href = "/into/paymentComplete?merchant_uid="+merchantid;
				        		}else {
				        			if(result.hasSetPrice) {
				        				alerting("결제하신 금액과 판매자가 설정한 금액이 다릅니다.");
				        				var reason = "price not equals";
				        			}else {
				        				alerting("판매자가 구독을 비활성화 했습니다.");
				        				var reason = "price null";
				        			}
				        			
				        			(function() {
					        			$.ajax({
					        				url: "rest/cancelPayment",
					        				type: 'POST',
					        				dataType: 'json',
					        				data: {
					        					merchant_uid: merchantid,
					        					reason: reason
					        				},
					        				beforeSend: function(xhr){
							        			xhr.setRequestHeader(header, token);
							        		}
					        			}).done(function(result2){
					        				if(result2.code==0) {
					        					alerting("자동으로 결제가 취소되었습니다.");
					        				}else {
					        					alerting("결제가 취소되지 않았습니다. 관리자에게 문의해주세요.")
					        				}
					        			});
				        			})();
				        		}
				        	});
				        
				    	}else {
				        	alerting("결제에 실패하셨습니다.");
				        }
			  		}
				);
			</sec:authorize>
			
		}
		
		
		$(function() {
			
			$("#ranking-individual-find").click(function() {
				$(".ranking-individual-myplace").css("display", "none");
				
				var nickname = $("#ranking-individual-search-nickname").val();
				getIndividualRank(nickname);
			});
			
			$("#ranking-individual-search-nickname").keyup(function() {
				if(event.keyCode === 13) {
					$("#ranking-individual-find").click();
				}
			});
			
			$(".black-model-close-btn").click(function() {
				$(".ranking-backscreen").css("display","none");
				
				$(".black-model-section-place span:nth-child(2)").removeClass();
				$("#subscribe-btn").removeClass();
				$("#subscribe-btn").removeAttr("onclick");
				$("#payment-btn").removeClass();
				$("#payment-btn").removeAttr("onclick");
				
				chart.destroy();
			});
			
			$(".ranking-backscreen").mouseup(function(e){ 
		 		var blackmodel = $(".ranking-black-model");
		 		
		 		if (!blackmodel.is(e.target) && blackmodel.has(e.target).length === 0){
		 			$(".ranking-backscreen").css("display","none");
		 			
		 			$(".black-model-section-place span:nth-child(2)").removeClass();
					$("#subscribe-btn").removeClass();
					$("#subscribe-btn").removeAttr("onclick");
					$("#payment-btn").removeClass();
					$("#payment-btn").removeAttr("onclick");
					
					chart.destroy();
				}	
			});
			
			
		});
	</script>	
</head>
	<body>
		<jsp:include page="../main/header.jsp"/>
		
		<div class="container mt-4 mb-4 px-0">
			<div class="ranking-individual">
				<div>
					<span class="ranking-individual-myplace">
						내 순위
					</span>
					<span class="ranking-individual-searchbox">
						<input id="ranking-individual-search-nickname" type="text" maxlength="30" placeholder="닉네임으로 검색" spellcheck="false"/>

						<button id="ranking-individual-find">
							<i class="fas fa-search"></i>
						</button>
					</span>
				</div>
				<table id="ranking-individual-table" class="table leaderboards">
					<thead>
						<tr>
							<th>리그</th>
							<th>순위</th>
							<th>닉네임</th>
							<th>수익률</th>
							<th>수익금액</th>
							<th>투자금액</th>
						</tr>
					</thead>
					<tbody>	
						<sec:authorize access="isAnonymous()">
							<tr>
								<td class="ranking-individual-notice" colspan="6">
									로그인 후 이용해주세요
								</td>
							</tr>
						</sec:authorize>	
						
						<sec:authorize access="isAuthenticated()">
							<sec:authentication var="principal" property="principal"/>
							<c:if test="${principal.dto.rankDTO.enabled eq 0}">
								<tr>
									<td class="ranking-individual-notice" colspan="6">
										자산 탭에서 주식을 추가해주세요
										<p>(랭킹 업데이트시 반영됩니다)</p>
									</td>
								</tr>
							</c:if>
							<c:if test="${principal.dto.rankDTO.enabled eq 1}">
								<c:if test="${principal.dto.rankDTO.investment_amount < 1000000}">
									<tr>
										<td class="ranking-individual-notice" colspan="6">
											회원님의 투자금액이 100만원 미만이라 랭킹에 집계되지 않았습니다
											<p>(랭킹 업데이트시 반영됩니다)</p>
										</td>
									</tr>
								</c:if>
								<c:if test="${principal.dto.rankDTO.investment_amount >= 1000000}">
									<script>
										var nickname = "${principal.dto.nickname}";
										getIndividualRank(nickname);
									</script>
								</c:if>
							</c:if>
						</sec:authorize>				
					</tbody>
				</table>
			</div>
			
			<div>
				<div class="ranking-reague">
					<ul>
						<li>
							<div id="whaleLeague" class="${pageMaker.cri.league == 'whale'?'whaleLeague-active':''}" onclick="location.href='leaderboards?league=whale'">
								고래리그
							</div>
						</li>
						<li>
							<div id="mackerelLeague" class="${pageMaker.cri.league == 'mackerel'?'mackerelLeague-active':''}" onclick="location.href='leaderboards?league=mackerel'">
								고등어리그
							</div>
						</li>
						<li>
							<div id="shrimpLeague" class="${pageMaker.cri.league == 'shrimp'?'shrimpLeague-active':''}" onclick="location.href='leaderboards?league=shrimp'">
								새우리그
							</div>
						</li>
					</ul>
				</div>
				<ul class="ranking-notice">
					<li>리그 구분은 투자금액(매수가)을 기준으로 고래리그는 5000만원 이상, 고등어리그는 1000만원 이상, 새우리그는 100만원 이상 주식을 보유한 회원이 배정됩니다.</li>
					<li>투자금액 100만원 미만의 순위는 집계되지 않습니다.</li>
					<li>랭킹은 수익률순으로 산정하며 수익률이 동일한경우, 투자금액순으로 순위가 결정됩니다.</li>
					<li>4시간 주기로 랭킹 정보를 업데이트 합니다.</li>
					<li>리더보드의 닉네임을 클릭해서 해당 회원을 구독할 수 있습니다.</li>
				</ul>
			</div>
			
			<table id="ranking-table" class="table leaderboards">
				<thead>
					<tr>
						<th>순위</th>
						<th>닉네임</th>
						<th>수익률</th>
						<th>수익금액</th>
						<th>투자금액</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list}">
						<tr>
							<td class="ranking-table-empty" colspan="5">
								<img src="resources/icon/${pageMaker.cri.league}.png" width="48px" height="48px"/><br><br>
								아직 해당리그에 등록된 회원이 없습니다
							</td>
						</tr>
					</c:if>
					
					<c:forEach var="dto" items="${list}">
						<tr>
							<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.place}" /></td>
							<td><a href="javascript:driveBackscreen('${dto.nickname}')">${dto.nickname}</a></td>
							<td class="${dto.net_profit > 0?'profit-rise':'profit-fall'}">${dto.net_profit_ratio}%</td>
							<td class="${dto.net_profit > 0?'profit-rise':'profit-fall'}"><fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.net_profit}" />원</td>
							<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.investment_amount}" />원</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			
			
			<div class="w-100 pt-2 text-center">
				<c:set var="league" value="${pageMaker.cri.league}" />
				
				<c:if test="${!empty list}">
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="page-item">
						      	<a class="page-link" href="leaderboards${pageMaker.makeQuery(league, pageMaker.startPage-1)}" aria-label="Previous">
							        <span aria-hidden="true">&laquo;</span>
							        <span class="sr-only">Previous</span>
						    	</a>
						    </li>
						</c:if>
						
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
							<li class="page-item ${pageMaker.cri.page == idx?'active':''}"><a class="page-link" href="leaderboards${pageMaker.makeQuery(league, idx)}">${idx}</a></li>
						</c:forEach>
						
						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li class="page-item">
							    <a class="page-link" href="leaderboards${pageMaker.makeQuery(league, pageMaker.endPage+1)}" aria-label="Next">
								    <span aria-hidden="true">&raquo;</span>
								    <span class="sr-only">Next</span>
							    </a>
							</li>
						</c:if>
					</ul>
				</c:if>
			</div>
		</div>
		
		<div id="backscreen-1" class="ranking-backscreen">
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
					<div class="black-model-bottom-btn-container">
						<button id="subscribe-btn"></button>
					</div>
				</div>
			</div>	
		</div>
		
		<div id="backscreen-2" class="ranking-backscreen">
			<div class="ranking-model-container">
				<div class="ranking-black-model">
					<button class="black-model-close-btn">
					</button>
					<div class="black-model-section">
						<h2 class="black-model-section-title"><u></u> 구독</h2>
						<div class="black-model-section-info">
							<p>혜택</p>
							<ul>
								<li>구독한 회원의 실시간 보유 주식정보 확인</li>
								<li>구독한 회원의 보유 채권정보 확인</li>
								<li>구독한 회원의 현금·주식·채권 보유비율 확인</li>
								<li>구독한 회원의 보유주식별 적정주가 확인</li>
							</ul>
						</div>
						<div class="black-model-section-notice">
							<ul>
								<li>결제금액에는 VAT가 포함되어 있습니다.</li>
								<li>이용기간은 결제일로부터 30일 입니다.</li>
								<li>이용기간이 종료되도 정기결제 되지 않습니다.</li>
								<li>상품 특성상 환불이 불가능합니다.</li>
								<li>적정주가는 해당 회원이 산정한 금액입니다.</li>
								<li>서비스로 인한 금전적 손해 또는 손실에 대해서는 회사는 책임지지 않습니다.</li>
							</ul>
						</div>
					</div>
					<div class="black-model-bottom-btn-container">
						<button id="payment-btn"></button>
					</div>
					
				</div>
			</div>	
		</div>
		
		<jsp:include page="../main/footer.jsp"/>
	</body>
</html>