<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script>
		let countDay = 0;
	</script>
	
</head>
	<body>
		<div class="wrapper">
		<jsp:include page="../include/header.jsp"/>
		
			<div class="container">
				<a class="mainA" href="/into"> 같이투자 API TEST</a>
				<br><br>
				
				<h2>-가계부-</h2>
				<br>
				<div class="tran-dropdown">
					<div class="section">
						<div id="sec1">
						</div>
						<div id="sec2">
							▼
						</div>
						<div id="sec3">
							<div id="sec4">
							</div>
						</div>	
					</div>
					<div id="tran-dropdown-content" class="tran-dropdown-content">
					</div>
				</div>
				<br>
				
				<div class="transactionList">
					<c:forEach var="account" items="${accountTransactionList}" varStatus="status">
						<script>
							var day = ${account.day}
							
							if(countDay != day) {
								var div = $("<div>"+day+"일</div>")
								div.addClass("hr-sect");
								$(".transactionList").append(div);
								
								countDay = day;
							}
						</script>
					
						<div class="tran">
							<div>
								<div class="tran2">
									<span>
										${account.print_content} ${account.branch_name}
									</span>
									<span class="tran3" id="tran-${status.index}">
									</span>
								</div>
								<div>
									${account.tran_type} | ${account.product_name}
								</div>
							</div>
						</div>
						
						<script>
							var inout_type = "${account.inout_type}"
							var tran_amt = ${account.tran_amt}
							if(inout_type=="입금") {
								$("#tran-"+${status.index}).text("+"+tran_amt.toLocaleString()+"원");
								$("#tran-"+${status.index}).css("color","#81c147"); 
							}
							if(inout_type=="출금") {
								$("#tran-"+${status.index}).text("-"+tran_amt.toLocaleString()+"원");
							}
						</script>
					</c:forEach>
				</div>
				
				<button id="expense_analyze" class="button5">분석내역 보기</button>
			</div>
			<jsp:include page="../include/footer.jsp"/>	
		</div>
		
		<script>
			$(function() {
				var year = ${year}
				var month = ${month}
				$("#sec1").html("<b>"+month+"</b>월")
				
				var incomeSum = ${incomeSum}
				var expenseSum = ${expenseSum}
				$("#sec4").html("수입 <b>"+incomeSum.toLocaleString()+"</b>원<br>"
								+"지출 <b>"+expenseSum.toLocaleString()+"</b>원");
				
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
						a.attr("href", "accountTransaction-"+y+"-"+numberPad(m, 2));
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
		<script>
			function numberPad(n, width) {
			    n = n + '';
			    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
			}	
		
			var date = new Date();
			var year = date.getFullYear();
			var month = numberPad((date.getMonth()+1), 2);
			
			$(function() {
				$("#expense_analyze").attr("onclick", "location.href='expenseAnalyze-"+year+"-"+month+"'");
			})
		</script>
		
	</body>
</html>