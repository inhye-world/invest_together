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

  <title>같이투자</title>

  <!-- Custom styles for this page -->
  <link href="resources/sb_admin/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  
  <style>
  	.title{
  		font-size: 1.3em;
  		font-weight: bold;
  		width: 200px;
  	}
  	td{
  		height: 50px;
  	}
  	#wrapper{
  		width: 100%;
  		height: 600px;
  	}
  	#card-total{
  		width: 90%;
  		margin: auto;
  		margin-top: 50px;
  	}

  </style>


</head>

<body id="page-top">
<jsp:include page="../include/header.jsp"/>

		<div id="wrapper">
		
          <!-- DataTales -->
          <div class="card shadow mb-4" id="card-total">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">수식 계산기</h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                  
                <table> 
                	<tr>
						<td class="title"><a href="${pageContext.request.contextPath}/calculator/nwc.do">순운전자본</a></td>
						<td>때로는 단순히 운전 자본이라고도하는 순 운전 자본 (NWC)의 공식은 회사의 유동 부채를 감안하여 유동 자산의 가용성을 결정하는 데 사용됩니다</td>
                    </tr>              
                    <tr>
						<td class="title"><a href="${pageContext.request.contextPath}/calculator/debtRatio.do">부채비율</a></td>
						<td>회사의 의무 이행 능력을 측정하기 위해 다른 금융 레버리지 비율과 함께 사용하는 재무 레버리지 비율입니다.</td>
                    </tr>
                    <tr>
						<td class="title"><a href="${pageContext.request.contextPath}/calculator/roe.do">ROE</a></td>
						<td>ROE(Return on Equity)의 수식은 ROE로 간략히 표시되며 회사의 순 수입을 평균 주주의 자본으로 나눈 값입니다.</td>
                    </tr>
                    <tr>
						<td class="title"><a href="${pageContext.request.contextPath}/calculator/atr.do">자산회전율</a></td>
						<td>자산수익률은 회사가 자산을 활용하여 순이익을 얻는 능력을 보여줍니다.</td>
                    </tr>
                    <tr>
						<td class="title"><a href="${pageContext.request.contextPath}/calculator/itr.do">재고자산회전율</a></td>
						<td>재고자산회전율은 회사가 재고를 판매로 얼마나 잘 전환하고 있는지를 측정합니다.</td>
                    </tr>
                </table>                

              </div>
            </div>
          </div>
          
         </div>

	<!-- footer -->
	<jsp:include page="../include/footer.jsp"/>


  <!-- Page level plugins -->
  <script src="resources/sb_admin/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="resources/sb_admin/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="resources/sb_admin/js/demo/datatables-demo.js"></script>

</body>

</html>
    