<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix ="javatime" uri="http://sargue.net/jsptags/time" %>
<!DOCTYPE html>
<html>
	

<style>
		.test1{
			text-align:center;
		}
		
		.wrapper{
			margin:45px 50px 10px 10px;
		}

         body {
            font-family: sans-serif;
            font-size: 0.9em;
            margin:auto;
            
        } 
        table {
             border-collapse: collapse; 
             border-bottom: 1px solid #ddd;
            
        }
      
        thead,tbody {
            display: block;
        }
        
        th,td {
            padding: 5px 8px; 
            border: 1px solid #ddd; 
            width: 180px;
        }
        
        tbody {
            height: 180px;
            overflow-y: scroll 
        }
      
    
		::-webkit-scrollbar-track
		{
			-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0);
			background-color: #ffffff;
		}
		
		::-webkit-scrollbar
		{
			width: 6px;
			background-color: lightgray;
		}
		::-webkit-scrollbar-thumb
		{
			background-color: #EDEDED;
		}


</style>
<head>
	<meta charset="UTF-8">
	<title>통장내역</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link href="resources/sb_admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<script src="resources/sb_admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="resources/sb_admin/js/sb-admin-2.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 

</head>
	<body>
	
				<div class="wrapper">
				<div class="container">
				<div class="card shadow mb-4"  style="width:104%;">
           		<div class="card-header py-3">
            	  <h6 class="m-0 font-weight-bold text-primary" >통장 내역</h6>
          		  </div>
          			  <div class="card-body">
             			 <div class="table-responsive" >
               			 <table class="table1" width="98.1%" cellspacing="0">            
                 			 <thead>
								<tr style="background-color:#EDEDED">
									<th class="test1">회차</th>
									<th class="test1">납입일</th>
									<th class="test1">납입금</th>
									<th class="test1">납입 후 잔액</th>
									<th class="test1">입금 분류</th>
									
								</tr>
							</thead>
                		  <tbody>	
     						 <!-- <div class="force-overflow"></div> -->
						<c:forEach var="account" items="${accountTransactionList}" varStatus="status">
							<tr>
								<td class="test1">${status.count} 회차</td>
								<td class="test1"><javatime:format value="${account.tran_date_time}" pattern=" yyyy-MM-dd HH:mm:ss"/></td>
								<td class="test1"><fmt:formatNumber type="number" maxFractionDigits="3" value="${account.tran_amt}" /> 원</td>
								<td class="test1"><fmt:formatNumber type="number" maxFractionDigits="3" value="${account.after_balance_amt}"/> 원</td>
								<td class="test1">${account.branch_name}</td>	
							</tr>
						</c:forEach>
						</tbody>
					</table>
              </div>
            </div>
          	</div>
			</div>
			</div>

		</body>
			
</html>