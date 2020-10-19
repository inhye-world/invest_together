<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <!-- ajax사용 위해 csrf설정 -->
  <meta id="_csrf" name="_csrf" content="${_csrf.token}" />	
  <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
  
  <title>같이투자 : 적정주가계산</title>
  
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  <!-- Custom styles for this page -->
  <link href="resources/sb_admin/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  
 <!-- alert -->
  <link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css?v=<%=System.currentTimeMillis() %>" />
  <script src="resources/sb_admin/js/ast-notif.js?v=<%=System.currentTimeMillis() %>"></script>

  <style>

  	.ctn {
  		padding: 100px;
  	}
  	
  	#inputTable{
  		margin: 20px 10px; 
  	}
  	
  	
  	#resultTable{
  		margin-top: 20px;
  		margin-left: 10px;
  	}
  	
  	#inputTable td, #resultTable td{
  		height: 50px;
  	}
  	
  	#resultTap{
  		padding: 20px;
  	}
  	
  	#inputCalculator{
  		 min-width: 438px;
  	}


  </style>

</head>

<body id="page-top">
<jsp:include page="../main/header.jsp"/>

	<main>
	    <div class="our-cases-area">
	        <div class="ctn">
	            <div class="row">
	                <div class="col-xl-4 col-lg-12 col-md-12 col-sm-12" id="inputCalculator">
	                    <div class="single-cases mb-40">
	                    	<div class="card shadow">
	                       	 	<div class="cases-caption">
	                       	 		<h1>적정 주가 계산</h1>
				            		<table id="inputTable">
				            			<tr>
				            				<td>종목명:</td>
				            				<td>
				            					<select id="stockinfo_symbols" name="종목명" onchange="getInfo(this.value)">
					            				<option value="" disabled selected>종목명</option>
					            				<c:forEach var = "list" items= "${stockinfo}">
								           		<option id="listCode" value="${list.stockinfo_symbols}" value2="${list.code}">${list.stockinfo_symbols}</option>
								           		</c:forEach>
							           			</select> <span id="currentPrice"></span>
				            				</td>
				            			</tr>
				            			<tr>
				            				<td>지배주주 지분 :</td>
				            				<td>
				            					<input type="text" id="ev" name="지배주주 지분" /> 억 원
				            				</td>
				            			</tr>
				            			<tr>
				            				<td>ROE :</td>
				            				<td>
				            					<input type="text" id="roe" name="ROE" /> %
				            				</td>
				            			</tr>
				            			<tr>
				            				<td>주주요구수익률 :</td>
				            				<td>
				            					<input type="text" id="ke" name="주주요구수익률 " placeholder="8" value="8" /> %
				            				</td>
				            			</tr>
				            			<tr>
				            				<td>발행주식수 :</td>
				            				<td>
				            					<span id="amount"><input type="text" id="shareIssued" name="발행주식수" /> 주</span>
				            				</td>		
				            			</tr>
				            		</table>
				            		<table id="inputButton">
				            			<tr>
				            				<td><button type="button" class="genric-btn info" onclick="calculate();">계산</button></td>
				            				<td><button type="button" class="genric-btn info" onclick="refresh();">초기화</button></td>
				            				<sec:authorize access="isAuthenticated()">
												<td><button type="button" class="genric-btn info" onclick="location.href='myCalculator'">나의 기업 관리</button></td>
											</sec:authorize>
				            				<td><span id="submitButton"></span></td>
				            			</tr>
				            		</table>
	                        	</div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-xl-8 col-lg-12 col-md-12 col-sm-12" id="myTable">
	                </div>
	            </div>
	        </div>
	    </div>
    </main>
   	
  	<script>
     function alerting(content){
   		AstNotif.dialog('알림', content, {
       	  theme: 'default',
       	});
   	}
     
     function calculate(){
   	 
   	 	//null check
   		//select값 조회
    	if("" == $("#stockinfo_symbols option:selected").val() || null == $("#stockinfo_symbols option:selected").val()){
    		var ele_id = "stockinfo_symbols";
    		showAlert(ele_id);
    		return true;
   		}
   	 	
   		// form안의 모든 text type 조회
    	var txtEle = $("#inputInfo input[type=text]");
    	
    	for(var i = 0; i < txtEle.length; i ++){
    		if("" == $(txtEle[i]).val() || null == $(txtEle[i]).val()){
	    		var ele_id = $(txtEle[i]).attr("id");
	    		showAlert(ele_id);
	    		return true;
    		}
    	}

      var symbols = document.getElementById("stockinfo_symbols").value;
   	  var material0 = parseInt(document.getElementById("ev").value);	//지배주주지분(기업가치)
   	  var material1 = parseFloat(document.getElementById("roe").value);	//ROE
   	  var material2 = parseFloat(document.getElementById("ke").value);	//주주요구수익률
   	  var material3 = parseInt(document.getElementById("shareIssued").value.replace(/,/g, ''));	//발행주식수
   	  //초과이익 = 기업가치 * (주주요구수익률 - 8%)
   	  //기업가치 = 자기자본 + 초과이익 x w / (1+할인율-w)
   	  //8%: 임의의 무위험수익률
   	 
   	  //초과이익
   	  var material4 = material0*(material1 - material2)*1000000;
   	  console.log("material4: "+material4);
   	  
   	  //적정 주주가치
   	  var material5 = material0*100000000 + material4/(material2*0.01);						
   	  var material6 = material0*100000000 + material4*0.9/(1+(material2*0.01)-0.9);
   	  var material7 = material0*100000000 + material4*0.8/(1+(material2*0.01)-0.8);
   	  
         //적정주가
   	  var material8 = parseInt(material5/material3);								
   	  var material9 = parseInt(material6/material3);
   	  var material10 = parseInt(material7/material3);
   	  
   	  document.getElementById("myTable").innerHTML = "";
   	  document.getElementById("myTable").innerHTML =
   			 '<div class="card shadow" id="resultTap">'+
			 '<h1>계산 결과</h1>'+
          	 '<table id="resultTable">'+          
             '<thead>'+
          	  	  '<tr><th>초과이익 가정(w)</th>'+
                 '<th>지배주주지분</th>'+
                 '<th>ROE</th>'+
                 '<th>주주요구수익률</th>'+
                 '<th>적정주주가치</th>'+
                 '<th>발행주식수</th>'+
                 '<th>적정주가</th>'+
                 '<th>매수/매도 여부</th></tr></thead>'+
             '<tbody>'+
                '<tr><td>영원히 지속</td>'+
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
                 '<td>매수</td></tr></tbody>'+
           	'</table>'+


        	'</div>';
        		
        	document.getElementById('submitButton').innerHTML =
        	  '<form id="frm" action="writeCalculator" method="post">'+
        	  '<input type="hidden" name="member_num" value="1">'+
        	  '<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />'+
        		  '<input type="hidden" name="stockinfo_symbols" value='+symbols+'>'+
        		  '<input type="hidden" name="ev" value='+material0+'>'+
                 '<input type="hidden" name="roe" value='+material1+'>'+
                 '<input type="hidden" name="ke" value='+material2+'>'+
                 '<input type="hidden" name="share_issued" value='+material3+'>'+
                 '<input type="submit" id="save" class="genric-btn info" onclick="send();" value="저장" />'+
                 '</form>';	
 		    } 
 
	//null값일 때 focus주기 
    function showAlert(ele_id){
	   	var ele_name = $("#" + ele_id).attr('name');	
	   	alerting(ele_name + '을(를) 입력해주세요.');
	
		// 해당 id에 focus.
		$("#" + ele_id).focus();
   }
     
    //숫자 validating 부동소수점 포함
	$(document).on("input","input[id=ev]",function(){
			var roe_check = document.getElementById("ev").value;
	
	       	var num = /^[+]?\d+\.?\d*$/;
	         
	        if(!num.test(roe_check)) {
	
	        	alerting('지배주주지분을 다시 입력해주세요.');
				document.getElementById("ev").value = "";
				$("#ev").focus();
	           	return false;
	        } 
	});
  
     $(document).on("input","input[id=roe]",function(){
		var roe_check = document.getElementById("roe").value;

       	var num = /^[+]?\d+\.?\d*$/;
         
        if(!num.test(roe_check)) {
        	alerting('ROE를 다시 입력해주세요.');
        	document.getElementById("roe").value = "";
               return false;
        } 
		   });
	     
     $(document).on("input","input[id=ke]",function(){
		var ke_check = document.getElementById("ke").value;

       	var num = /^[+]?\d+\.?\d*$/;
         
        if(!num.test(ke_check)) {
        	alerting('주주요구수익률을 다시 입력해주세요.');
        	document.getElementById("ke").value = "";
               return false;
        } 
  		 });
     
     $(document).on("input","input[id=shareIssued]",function(){
		var shareIssued_check = document.getElementById("shareIssued").value;

       	var num = /^[+]?\d+\.?\d*$/;
         
        if(!num.test(shareIssued_check)) {
        	alerting('발행주식수를 다시 입력해주세요.');
        	document.getElementById("shareIssued").value = "";
               return false;
        } 
  		 });

   //새로고침 
   function refresh(){   	
		$("#stockinfo_symbols option:eq(0)").prop("selected", true);
		document.getElementById("ev").value = "";
		document.getElementById("roe").value = "";
		document.getElementById("ke").value = "";
		document.getElementById("shareIssued").value = "";
		$("#shareIssued").attr('placeholder', '');
		$("#currentPrice").text("");
		
		var saveButton = document.getElementById("save");
	   	saveButton.type = "hidden";
		
	   	document.getElementById("myTable").innerHTML = "";
	}
   
   //krx api
   function getInfo(){
	   	var code = $("#stockinfo_symbols option:selected").attr('value2');  
	   	var url = 'stockInfo/'+code+'.json';
		
		$.ajax({
			url: url,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				
				var curJuka = result.stockprice.TBL_StockInfo.CurJuka;
				var amount = result.stockprice.TBL_StockInfo.Amount;
	
				document.getElementById("amount").innerHTML 
					= '<input type="text" id="shareIssued" name="발행주식수" placeholder='+amount+' value='+amount+' /> 주 <br>'	
	
				$("#currentPrice").text("현재가: "+curJuka.toLocaleString()+"원").css("color", "red");
			}
		});
   }
   
   </script>
  
   <!-- Footer -->
   <jsp:include page="../main/footer.jsp"/>


  <!-- Page level plugins -->
  <script src="resources/sb_admin/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="resources/sb_admin/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="resources/sb_admin/js/demo/datatables-demo.js"></script>

</body>

</html>
    