<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>

<head>

  <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
	
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  
  <!-- alert -->
  <link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
  <script src="resources/sb_admin/js/ast-notif.js"></script>
  
  <!-- ajax사용 위해 csrf설정 -->
  <meta id="_csrf" name="_csrf" content="${_csrf.token}" />
  <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />

  <title>같이투자 : 계산기</title>

  <!-- Custom styles for this page -->
  <link href="resources/sb_admin/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  
  
  <style>

  	.tableTitle{
  		width: 200px;
  	}

  	.ctn {
  		padding: 100px;
  	}
  	
  	#inputInfo, #resultTable{
  		margin: 20px 10px; 
  	}
  	
  	#inputInfo td, #resultTable td{
  		height: 40px;
  	}
  	
  	#inputName{
  		width: 120px;
  	}
  	
  	.tableContent{
  		vertical-align: top;
  	}

  </style>


</head>

<body id="page-top">
<jsp:include page="../main/header.jsp"/>

	<main>
    <!-- Our Cases Start -->
    <div class="our-cases-area">
        <div class="ctn">
            <div class="row">
                <div class="col-xl-7 col-lg-12 col-md-12 col-sm-12">
                    <div class="single-cases mb-40">
	                    <div class="card shadow">
	                        <div class="cases-caption">	                        	
				                <table> 
				                	<sec:authorize access="isAuthenticated()">
									    <tr>
											<td class="tableTitle"><h3><a href="myCalculator">나의 기업관리</a></h3></td>
											<td class="tableContent">계산한 적정주가를 저장하여 관리할 수 있습니다.</td>
				                    	</tr> 
									</sec:authorize>
				                	<tr>
										<td class="tableTitle"><h3><a href="target">적정 주가 계산</a></h3></td>
										<td class="tableContent">잔여이익모델로 현재 주식의 향후 적정 주가를 계산할 수 있습니다.</td>
				                    </tr>  
				                	<tr>
										<td class="tableTitle"><h3><a onclick="nwc();">순운전자본</a></h3></td>
										<td class="tableContent">때로는 단순히 운전 자본이라고도하는 순 운전 자본 (NWC)의 공식은 회사의 유동 부채를 감안하여 유동 자산의 가용성을 결정하는 데 사용됩니다.</td>
				                    </tr>              
				                    <tr>
										<td class="tableTitle"><h3><a onclick="debtRatio();">부채비율</a></h3></td>
										<td class="tableContent">회사의 의무 이행 능력을 측정하기 위해 다른 금융 레버리지 비율과 함께 사용하는 재무 레버리지 비율입니다.</td>
				                    </tr>
				                    <tr>
										<td class="tableTitle"><h3><a onclick="roe();">ROE</a></h3></td>
										<td class="tableContent">ROE(Return on Equity)의 수식은 ROE로 간략히 표시되며 회사의 순 수입을 평균 주주의 자본으로 나눈 값입니다.</td>
				                    </tr>
				                    <tr>
										<td class="tableTitle"><h3><a onclick="atr();">자산회전율</a></h3></td>
										<td class="tableContent">자산수익률은 회사가 자산을 활용하여 순이익을 얻는 능력을 보여줍니다.</td>
				                    </tr>
				                    <tr>
										<td class="tableTitle"><h3><a onclick="itr();">재고자산회전율</a></h3></td>
										<td class="tableContent">재고자산회전율은 회사가 재고를 판매로 얼마나 잘 전환하고 있는지를 측정합니다.</td>
				                    </tr>
				                </table>				                
	                        </div>
	                       </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-lg-12 col-md-12 col-sm-12" id="calculator">
                </div>
                
                <div class="col-xl-2 col-lg-12 col-md-12 col-sm-2" id="outcome">
                </div>
                
            </div>
        </div>
    </div>

    </main>
    
    <script>
	    //alerting
		function alerting(content){
			AstNotif.dialog('알림', content, {
	  	  theme: 'default',
	  	  imgIcon: "resources/sb_admin/img/error_hitam_garis.png",
	  	});
		}
		
	   //새로고침
	   function refresh(){
		$('.inputHere').val('');
		document.getElementById("outcome").innerHTML = "";
		}
    </script>

 	<!-- Calculating src -->
	<jsp:include page="variousCalculator.jsp"/>
 
	<!-- footer -->
	<jsp:include page="../main/footer.jsp"/>

  <!-- Page level plugins -->
  <script src="resources/sb_admin/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="resources/sb_admin/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="resources/sb_admin/js/demo/datatables-demo.js"></script>

</body>

</html>
    