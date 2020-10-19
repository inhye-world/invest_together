<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	<script>
		let countDay = 0;
	</script>
	
	
</head>
<style>
	.transListContainer{
		width:90%;
		margin-left: 100px;
	}

	.section{
			display:flex;
	}

	.transactionList{
		font-size: 2em;
	}
	
	.tranDay{
		border: 2px dotted #09cc7f;
		margin-bottom: 20px;
	}
	
	.hr-sect{
		fint-size: 40px;
		font-family: 'Nanum Pen Script', cursive;
		border-bottom: 2px dotted #09cc7f;
	}
	
	.tran{
		margin-left: 35px;
		margin-bottom: 25px;
	}
	
	#expense_analyze{
		padding: 10px;
		font-size:1em;
		border:1px solid #fff;
		background-color: #112026;
		color:#fff;
	}
	
	#expense_analyze:hover{
		border:1px solid #09cc7f;
		background-color: #09cc7f;
		color:#112026;
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
	
	#sec1 {
	width: 100px;
	height: 100px;
	float: left;
	line-height: 100px;
	font-size: 1em;
	}
	#sec2 {
		width: 40px;
		height: 100px;
		float: right;
		font-size: 1em;
		text-align: left;
		line-height: 100px;
	}
	#sec3 {
		width: 230px;
		height: 100px;
		float: right;
		display: table;
		text-align: left;
	}
	
	#sec4 {
		display: table-cell;
		vertical-align: middle;
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
	<body>
		<div class="wrapper">
		<jsp:include page="../main/header.jsp"/>
		
			<div class="transListContainer">
				<br>
				
				<br>
				<div class="tran-dropdown">
					<div class="section">
						<div id="sec1">
							</div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<div id="sec3">
								<div id="sec4">
								</div>
							</div>&nbsp;&nbsp;
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
				
				<div class="transactionList" >
					<c:forEach var="account" items="${accountTransactionList}" varStatus="status">
				
						<script>
							var day = ${account.day}
							
							if(countDay != day) {
								var div = $("<div>"+day+"일</div>").css("color", "#09cc7f")
								div.addClass("hr-sect");
								$(".transactionList").append(div);
								
								countDay = day;
							}
						</script>
					
						<div class="tran">
							<div>
								<div class="tran2">
									<span style="font-family: 'Jua', sans-serif;">
										${account.print_content} ${account.branch_name}
									</span>
									<span class="tran3" id="tran-${status.index}">
									</span>
								</div>
								<div style="font-family: 'Jua', sans-serif; font-size: 20px;">
									${account.tran_type} | ${account.product_name}
								</div>
							</div>
						</div>
						
						<script>
							var inout_type = "${account.inout_type}"
							var tran_amt = ${account.tran_amt}
							if(inout_type=="입금") {
								$("#tran-"+${status.index}).text("+"+tran_amt.toLocaleString()+"원");
								$("#tran-"+${status.index}).css("color","#F2BE22").css("font-family", "Jua, sans-serif"); 
							}
							if(inout_type=="출금") {
								$("#tran-"+${status.index}).text("-"+tran_amt.toLocaleString()+"원");
								$("#tran-"+${status.index}).css("color","#8C8C8C").css("font-family", "Jua, sans-serif"); 
							}
						</script>
						
					</c:forEach>
				</div>
				<br><br>
				<button id="expense_analyze">분석내역 보기</button>
				<br><br><br>
			</div>
			<jsp:include page="../main/footer.jsp"/>	
		</div>
		
		<script>
			$(function() {
				var year = ${year}
				var month = ${month}
				$("#sec1").html("<b>"+month+"</b>월").css("font-family", "Jua, sans-serif");
				
				var incomeSum = ${incomeSum}
				var expenseSum = ${expenseSum}
				$("#sec4").html("수입 <b>"+incomeSum.toLocaleString()+"</b>원<br>"
								+"지출 <b>"+expenseSum.toLocaleString()+"</b>원").css("font-family", "Jua, sans-serif").css("font-size","0.5em");
				
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
						a.text(y+"년 "+m+"월").css("font-family", "Nanum Pen Script, cursive");
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