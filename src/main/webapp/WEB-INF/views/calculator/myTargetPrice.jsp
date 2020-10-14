<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>

<head>

	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
	
  <!-- alert -->
  <link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css?v=<%=System.currentTimeMillis() %>" />
  <script src="resources/sb_admin/js/ast-notif.js?v=<%=System.currentTimeMillis() %>"></script>
	
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  
  <!-- ajax사용 위해 csrf설정 -->
  <meta id="_csrf" name="_csrf" content="${_csrf.token}" />
  <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />

  <title>같이투자 : 나의적정주가</title>

  <!-- Custom styles for this page -->
  <link href="resources/sb_admin/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  
  <!-- CSS here -->
  <link rel="stylesheet" href="resources/main/assets/css/backbutton.css">
  
  <style>
  
    .ctn {
  		padding: 100px;
  	}
  
  	#myTable{
  		margin: auto;
  		margin-top: 20px;
  		width: 90%;
  		text-align: center;
  	}
  	
  	#symbolTable{
  		margin-left: 80px;
  	}
  	
  	#headTitle{
  		margin-left: 40px;
  	}
  	
  	.back-btn{
  		float: right;
  	}
  	
  </style>


</head>

<body id="page-top">
<jsp:include page="../main/header.jsp"/>

<main>
<div class="our-cases-area">
        <div class="ctn">
        	<div class="row">
        		<div class="col-xl-10 col-lg-10 col-md-10 col-sm-10">
        			<h1 id="headTitle">나의 적정 주가</h1>
        		</div>
        		<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2">
        			<button class="back-btn" onclick="location.href='calculator'"><span>계산기</span></button>
        		</div>
        	</div>
            <div class="row">
              	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
              	<div class="card shadow">
			  	<div class="single-cases mb-40">
				<div class="cases-caption">
           		<table id="symbolTable">
           			<tr>
           				<td>종목명:</td>
           				<td><select id="symbols" onchange="selectSymbols(this.value)">
            						<option value="" disabled selected>종목명</option>
            					<c:forEach var = "dto" items= "${symbolsList}">
				           			<option value="${dto.stockinfo_symbols}" >${dto.stockinfo_symbols}</option>
				           		</c:forEach>
		           			</select>
		           		</td>
		           		<td id="deleteButton"></td>
           			</tr>
           		</table>
           		
           		 <div class="table-responsive">
               	  <table class="table table-bordered" id="myTable">    
	                  <thead>
	               	  	  <tr><th>초과이익 가정(w)</th>
	                      <th>지배주주지분</th>
	                      <th>ROE</th>
	                      <th>주주요구수익률</th>
	                      <th>적정주주가치</th>
	                      <th>발행주식수</th>
	                      <th>적정주가</th>
	                      <th>매수/매도 여부</th></tr>
	                  </thead>
	                  <tbody id="ajaxTable">
	                  </tbody>
                	</table>
	             </div>
	             </div>
	             </div>
	             </div>
	             </div>
	             
	            </div>
	           </div>
	          </div>


</main>
  
  
      
      <script>
	      function alerting(content){
	    	  AstNotif.snackbar(content, {
				  theme: 'default',
				});
	    	}
      		
      		function selectSymbols() {
      			var optVal = $("#symbols option:selected").val();
      			
      			if(optVal == null || optVal == ""){
      				document.getElementById("ajaxTable").innerHTML = '<tr><td colspan="8">종목명을 선택해주세요.</td></tr>';
      			} else {
      				$.ajax({
    		    	    url : "list",
    		    	    type : "get",
    		    	    data : {"stockinfo_symbols" : optVal},
    		    	    dataType : "json",
    		    	    success: function(data){
    		    	    	console.log(data);
    		    	    	
    		    	    	  var material0 = parseInt(data.ev);	//지배주주지분(기업가치)
    			        	  var material1 = parseFloat(data.roe);	//ROE
    			        	  var material2 = parseFloat(data.ke);	//주주요구수익률
    			        	  var material3 = parseInt(data.share_issued);	//발행주식수
    			        	  //초과이익 = 기업가치 * (주주요구수익률 - 8%)
    			        	  //기업가치 = 자기자본 + 초과이익 x w / (1+할인율-w)
    			        	  //8%: 임의의 무위험수익률
    			        	 
    			        	  //초과이익
    			        	  var material4 = material0*(material1 - material2)*1000000;					
    			        	  
    			        	  //적정 주주가치
    			        	  var material5 = material0*100000000 + material4/(material2*0.01);						
    			        	  var material6 = material0*100000000 + material4*0.9/(1+(material2*0.01)-0.9);
    			        	  var material7 = material0*100000000 + material4*0.8/(1+(material2*0.01)-0.8);
    			        	  
    			              //적정주가
    			        	  var material8 = parseInt(material5/material3);								
    			        	  var material9 = parseInt(material6/material3);
    			        	  var material10 = parseInt(material7/material3);
    		    	    	
    		    	    	document.getElementById("ajaxTable").innerHTML = '<tr><td>영원히 지속</td>'+
    													                      '<td>'+material0.toLocaleString()+'억 원</td>'+
    													                      '<td>'+material1+'%</td>'+
    													                      '<td>'+material2+'%</td>'+
    													                      '<td>'+(material5/100000000).toLocaleString()+'억 원</td>'+
    													                      '<td>'+material3.toLocaleString()+'주</td>'+
    													                      '<td>'+material8.toLocaleString()+'원</td>'+
    													                      '<td>매도</td></tr>'+
    													                     '<tr><td>10%씩 감소</td>'+
    													                      '<td>'+material0.toLocaleString()+'억 원</td>'+
    													                      '<td>'+material1+'%</td>'+
    													                      '<td>'+material2+'%</td>'+
    													                      '<td>'+(material6/100000000).toLocaleString()+'억 원</td>'+
    													                      '<td>'+material3.toLocaleString()+'주</td>'+
    													                      '<td>'+material9.toLocaleString()+'원</td>'+
    													                      '<td>적정</td></tr>'+
    													                    '<tr><td>20%씩 감소</td>'+
    														                   '<td>'+material0.toLocaleString()+'억 원</td>'+
    														                   '<td>'+material1+'%</td>'+
    														                   '<td>'+material2+'%</td>'+
    														                   '<td>'+(material7/100000000).toLocaleString()+'억 원</td>'+
    														                   '<td>'+material3.toLocaleString()+'주</td>'+
    													                      '<td>'+material10.toLocaleString()+'원</td>'+
    													                      '<td>매수</td></tr>;'
    													                      
    						document.getElementById("deleteButton").innerHTML = '<button type="button" id="delete" class="genric-btn primary radius">삭제</button>';
    													                      
    		    	    },
    		    	    error: function(request, status, error){
    		    	    	alert("error");
    		    	    }
    		    	 });
      			}
      			
      			
      		}
      		
      		window.onload = function(){
	      		selectSymbols();
      		}
      		
      		 $(document).on("click","button[id=delete]",function(){
      			var optVal = $("#symbols option:selected").val();
      			
      			$.ajax({
		    	    url : "delete",
		    	    type : "get",
		    	    data : {"stockinfo_symbols" : optVal},
		    	    dataType : "json",
		    	    success: function(result){
		    	    	if(result == 1) {
		    	    		alerting("삭제했습니다.");
		    	    		setTimeout(function() {
		    	    			window.location.href = "myCalculator";
		    	    			}, 1000);
		    	    	}				                      
		    	    },
		    	    error: function(request, status, error){
		    	    	alert("error");
		    	    }
		    	 });
      			
      		 });
      		
      		
      </script>
      
    <!-- footer -->
	<jsp:include page="../include/footer.jsp"/>

  <!-- Page level plugins -->
  <script src="resources/sb_admin/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="resources/sb_admin/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="resources/sb_admin/js/demo/datatables-demo.js"></script>


</body>

</html>