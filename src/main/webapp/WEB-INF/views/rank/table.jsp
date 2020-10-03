<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>같이투자 투자랭킹</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<link href="resources/ranking.css" rel="stylesheet" type="text/css">
	
	<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css' rel='stylesheet' type='text/css'>
	<script src="https://kit.fontawesome.com/80d121b39f.js" crossorigin="anonymous"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
	
	<script>
		
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
						str += "<td>"+result.nickname+"</td>";
						str += "<td>"+result.net_profit_ratio+"%</td>";
						str += "<td>"+result.net_profit.toLocaleString()+"원</td>";
						str += "<td>"+result.investment_amount.toLocaleString()+"원</td>";
						str += "</tr>";
						
						$("#ranking-individual-table tbody").html(str);
						
						if(result.net_profit_ratio>0) {
							$("#ranking-individual-table tbody tr td:nth-child(4)").css("background-color", "#fef7f7").css("color", "#ed6767");
							$("#ranking-individual-table tbody tr td:nth-child(5)").css("background-color", "#fef7f7").css("color", "#ed6767");
						}else if(result.net_profit_ratio<0) {
							$("#ranking-individual-table tbody tr td:nth-child(4)").css("background-color", "#E6E8FF").css("color", "#5A67ED");
							$("#ranking-individual-table tbody tr td:nth-child(5)").css("background-color", "#E6E8FF").css("color", "#5A67ED");
						}
					}
				}
			});
		}
	
		$(function() {
			$(".header-nav ul li").removeClass("header-li-active");
			$(".header-nav ul li:nth-child(6)").addClass("header-li-active");
			
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
		});
	</script>
</head>
	<body>
		<jsp:include page="../include/header.jsp"/>
		
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
										주식·채권 탭에서 주식을 추가해주세요
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
							<div id="whaleLeague" class="whaleLeague-active">
								고래리그
							</div>
						</li>
						<li>
							<div id="mackerelLeague">
								고등어리그
							</div>
						</li>
						<li>
							<div id="shrimpLeague">
								새우리그
							</div>
						</li>
					</ul>
				</div>
				<ul class="ranking-notice">
					<li>리그 구분은 투자금액(매수가)을 기준으로 고래리그는 5000만원 이상, 고등어리그는 1000만원 이상, 새우리그는 100만원 이상 주식을 보유한 회원이 배정됩니다.</li>
					<li>투자금액 100만원 미만의 순위는 집계되지 않습니다.</li>
					<li>랭킹은 수익률순으로 산정하며 수익률이 동일한경우, 투자금액순으로 순위가 결정됩니다.</li>
					<li>3시간 주기로 랭킹 정보를 업데이트 합니다.</li>
					<li>리더보드의 닉네임을 클릭해서 해당 회원을 구독할 수 있습니다.</li>
				</ul>
			</div>
			
			<table class="table leaderboards">
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
				</tbody>
			</table>
		</div>
		
		<jsp:include page="../include/footer.jsp"/>	
	</body>
</html>