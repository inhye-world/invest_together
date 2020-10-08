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
  <link rel="stylesheet" href="../resources/sb_admin/css/ast-notif.css" />
  <script src="../resources/sb_admin/js/ast-notif.js"></script>
  
  <!-- ajax사용 위해 csrf설정 -->
  <meta id="_csrf" name="_csrf" content="${_csrf.token}" />
  <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />

  <title>같이투자</title>

  <!-- Custom styles for this page -->
  <link href="../resources/sb_admin/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  
  <style>
  	tr {
  		height: 40px;
  	}
  	
  	#inputTable, #inputButton{
  		margin: 10px;
  		
  	}
  	
  	.table-responsive{
  		margin: auto;
  	}
  	
	#resultTap{
		width: 50%;
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
<jsp:include page="../include/header2.jsp"/>

  <!-- Page Wrapper -->
  <div id="wrapper">

          <!-- DataTales -->
          <div class="card shadow mb-4" id="card-total">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">ROE</h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                  
                <table id="inputInfo">

            			<tr>
            				<td>당기순이익 :</td>
            				<td>
            					<input type="text" id="ni" name="당기순이익" /> 원
            				</td>
            				<td id="resultTap" rowspan="2"></td>
            			</tr>
            			<tr>
            				<td>평균 주주 자본 :</td>
            				<td>
            					<input type="text" id="equity" name="평균주주자본" /> 원
            				</td>
            				<td></td>
            			</tr>
            		</table>
            		<table id="inputButton">
            			<tr>
            				<td><button type="button" class="btn btn-outline btn-primary pull-right" onclick="calculate();">계산</button></td>
            				<td><button type="button" class="btn btn-outline btn-primary pull-right" onclick="refresh();">초기화</button></td>
            				<td><span id="submitButton"></span></td>
            			</tr>
            		</table>              

              </div>
            </div>
          </div>
          <!-- End of DataTales -->
          
          <div id="outcome"></div>

        </div>
        <!-- wrapper -->
        
        <script>

        	function calculate(){
        		//null check
	    		// form안의 모든 text type 조회
		    	var txtEle = $("#inputInfo input[type=text]");
		    	
		    	for(var i = 0; i < txtEle.length; i ++){
		    		if("" == $(txtEle[i]).val() || null == $(txtEle[i]).val()){
			    		var ele_id = $(txtEle[i]).attr("id");
			    		showAlert(ele_id);
			    		return true;
		    		}
		    	}
		    	
		    	 var ni = parseInt(document.getElementById("ni").value);	
		    	 var equity = parseInt(document.getElementById("equity").value);	
		    	 var result = ni/equity;
		    	 
		    	 document.getElementById("outcome").innerHTML = '<div class="card shadow mb-4" id="card-total">'+
		            											'<div class="card-header py-3">'+
		              											'<h6 class="m-0 font-weight-bold text-primary">결과</h6>'+
		            											'</div>'+
		            											'<div class="card-body">'+
		              											'<div class="table-responsive">'+
		                										'<table><tr><td>ROE</td></tr>'+
		            											'<tr><td>= 당기순이익 / 평균주주자본</td></tr>'+
																'<tr><td>'+result.toFixed(2)+'</td></tr></table>';
        	}
        	
        	function showAlert(ele_id){
        		var ele_name = $("#" + ele_id).attr('name');	
		    	alerting(ele_name + '을(를) 입력해주세요.');
			
				// 해당 id에 focus.
				$("#" + ele_id).focus();
        	}
        	
        	//숫자 validating 부동소수점 포함
			$(document).on("input","input[id=ni]",function(){
					var check = document.getElementById("ni").value;
		
		        	var num = /^[+]?\d+\.?\d*$/;
		          
			        if(!num.test(check)) {
			        	alerting('당기순이익을 다시 입력해주세요.');
						document.getElementById("ni").value = "";
						$("#ni").focus();
		            	return false;
			        } 
			});
        	
			$(document).on("input","input[id=equity]",function(){
				var check = document.getElementById("equity").value;
	
	        	var num = /^[+]?\d+\.?\d*$/;
	          
		        if(!num.test(check)) {
		        	alerting('평균주주자본을 다시 입력해주세요.');
					document.getElementById("equity").value = "";
					$("#equity").focus();
	            	return false;
		        } 
			});
			
			function alerting(content){
          		AstNotif.dialog('알림', content, {
              	  theme: 'default',
              	  imgIcon: "../resources/sb_admin/img/error_hitam_garis.png",
              	});
          	}
			
			//새로고침 
		    function refresh(){
				document.getElementById("ni").value = "";
				document.getElementById("equity").value = "";			
				document.getElementById("outcome").innerHTML = "";
			}
	
        </script>

	<!-- footer -->
	<jsp:include page="../include/footer2.jsp"/>

  <!-- Page level plugins -->
  <script src="../resources/sb_admin/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="../resources/sb_admin/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="../resources/sb_admin/js/demo/datatables-demo.js"></script>

</body>

</html>
    