<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
</head>

<body>
     
  <script>
  	 //Begin of 순운전자본
     function nwc(){
 		document.getElementById("calculator2").innerHTML = "";
 		document.getElementById("calculator2").innerHTML = '<div class="card shadow">'+
 														  '<div class="single-cases">'+
        													  '<div class="cases-caption">'+
          											      '<h1>순운전자본</h1>'+
          											      '<table id="inputInfo">'+
          							            		  '<tr><td class="inputName">유동자산 :</td>'+
          							            		  '<td><input type="text" id="currentAssets" name="유동자산" class="inputHere" /> 원</td></tr>'+
          							            		  '<tr><td class="inputName">유동부채 :</td>'+
          							            		  '<td><input type="text" id="currentDebts" name="유동부채" class="inputHere" /> 원</td></tr>'+
          							            		  '</table>'+
          							            		  '<button type="button" class="genric-btn primary" onclick="calculateNwc();">계산</button>&nbsp;'+
          							            		  '<button type="button" class="genric-btn primary" onclick="refresh();">초기화</button>'+
         												  '</div>'+
         												  '</div>'+
    														  '</div>';
 		document.getElementById("outcome").innerHTML = "";
 	}

 	function calculateNwc(){
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
  	
  	 var currentAssets = parseInt(document.getElementById("currentAssets").value);	
  	 var currentDebts = parseInt(document.getElementById("currentDebts").value);	
  	 var result = currentAssets/currentDebts;
  	 
  	 document.getElementById("outcome").innerHTML = '<div class="card shadow">'+
   		 											'<div class="single-cases">'+
													  '<div class="cases-caption">'+
													      '<h1>결과</h1>'+
													      '<table id="resultTable"><tr><td>순운전자본</td></tr>'+
															 '<tr><td>= 유동자산 / 유동부채</td></tr>'+
															 '<tr><td>= <span class="red" style="color:red">'+result.toFixed(2)+'</span></td></tr></table>'+
													  '</div>'+
													 '</div>'+
												'</div>';
 	}
     	
     	function showAlert(ele_id){
     		var ele_name = $("#" + ele_id).attr('name');	
   	alerting(ele_name + '을(를) 입력해주세요.');

	// 해당 id에 focus.
	$("#" + ele_id).focus();
     	}
     	
     	//숫자 validating 부동소수점 포함
$(document).on("input","input[id=currentAssets]",function(){
		var check = document.getElementById("currentAssets").value;

       	var num = /^[+]?\d+\.?\d*$/;
         
        if(!num.test(check)) {
        	alerting('유동자산을 다시 입력해주세요.');
			document.getElementById("currentAssets").value = "";
			$("#currentAssets").focus();
           	return false;
        } 
});
     	
$(document).on("input","input[id=currentDebts]",function(){
	var check = document.getElementById("currentDebts").value;

      	var num = /^[+]?\d+\.?\d*$/;
        
       if(!num.test(check)) {
       	alerting('유동부채를 다시 입력해주세요.');
		document.getElementById("currentDebts").value = "";
		$("#currentDebts").focus();
          	return false;
       } 
});
//End of 순운전자본
     
     /////////////////////////////////////Begin of 자산회전율///////////////////////////////////////////////////////////////////////
 	function atr(){
 		document.getElementById("calculator2").innerHTML = "";
 		document.getElementById("calculator2").innerHTML = '<div class="card shadow">'+
 														  '<div class="single-cases">'+
        													  '<div class="cases-caption">'+
          											      '<h1>자산회전율</h1>'+
          											      '<table id="inputInfo">'+
          							            		  '<tr><td class="inputName">매출액 :</td>'+
          							            		  '<td><input type="text" id="revenue" name="매출액" class="inputHere" /> 원</td></tr>'+
          							            		  '<tr><td class="inputName">자산총계 :</td>'+
          							            		  '<td><input type="text" id="assetTotal" name="자산총계" class="inputHere" /> 원</td></tr>'+
          							            		  '</table>'+
          							            		  '<button type="button" class="genric-btn primary" onclick="calculateAtr();">계산</button>&nbsp;'+
          							            		  '<button type="button" class="genric-btn primary" onclick="refresh();">초기화</button>'+
         												  '</div>'+
         												  '</div>'+
    														  '</div>';
 		document.getElementById("outcome").innerHTML = "";
 	}

 	function calculateAtr(){
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
  	
  	 var revenue = parseInt(document.getElementById("revenue").value);	
  	 var assetTotal = parseInt(document.getElementById("assetTotal").value);	
  	 var result = revenue/assetTotal;
  	 
  	 document.getElementById("outcome").innerHTML = '<div class="card shadow">'+
   		 											'<div class="single-cases">'+
													  '<div class="cases-caption">'+
													      '<h1>결과</h1>'+
													      '<table id="resultTable"><tr><td>자산회전율</td></tr>'+
															 '<tr><td>= 매출액 / 자산총계</td></tr>'+
															 '<tr><td>= <span class="red" style="color:red">'+result.toFixed(2)+'</span></td></tr></table>'+
													  '</div>'+
													 '</div>'+
												 '</div>';
 	}
     	
     	function showAlert(ele_id){
     		var ele_name = $("#" + ele_id).attr('name');	
   	alerting(ele_name + '을(를) 입력해주세요.');

	// 해당 id에 focus.
	$("#" + ele_id).focus();
     	}
     	
     	//숫자 validating 부동소수점 포함
$(document).on("input","input[id=revenue]",function(){
		var check = document.getElementById("revenue").value;

       	var num = /^[+]?\d+\.?\d*$/;
         
        if(!num.test(check)) {
        	alerting('매출액을 다시 입력해주세요.');
			document.getElementById("revenue").value = "";
			$("#revenue").focus();
           	return false;
        } 
});
     	
$(document).on("input","input[id=assetTotal]",function(){
	var check = document.getElementById("assetTotal").value;

      	var num = /^[+]?\d+\.?\d*$/;
        
       if(!num.test(check)) {
       	alerting('자산총계를 다시 입력해주세요.');
		document.getElementById("assetTotal").value = "";
		$("#assetTotal").focus();
          	return false;
       } 
});
//End of 자산회전율

	///////////////////////////////////////////////Begin of 부채비율/////////////////////////////////////////////////////////////
   function debtRatio(){
   	document.getElementById("calculator2").innerHTML = "";
 		document.getElementById("calculator2").innerHTML = '<div class="card shadow">'+
 														  '<div class="single-cases">'+
        												  '<div class="cases-caption">'+
          											      '<h1>부채비율</h1>'+
          											      '<table id="inputInfo">'+
          							            		  '<tr><td class="inputName">총 부채 :</td>'+
          							            		  '<td><input type="text" id="debtT" name="총 부채" class="inputHere" /> 원</td></tr>'+
          							            		  '<tr><td class="inputName">총 자산 :</td>'+
          							            		  '<td><input type="text" id="assetT" name="총 자산" class="inputHere" /> 원</td></tr>'+
          							            		  '</table>'+
          							            		  '<button type="button" class="genric-btn primary" onclick="calculateDebtRatio();">계산</button>&nbsp;'+
          							            		  '<button type="button" class="genric-btn primary" onclick="refresh();">초기화</button>'+
         												  '</div>'+
         												  '</div>'+
    													  '</div>';
 		document.getElementById("outcome").innerHTML = "";
 		}

    	function calculateDebtRatio(){
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
	   	
	   	 var assetT = parseInt(document.getElementById("assetT").value);	
	   	 var debtT = parseInt(document.getElementById("debtT").value);	
	   	 var result = debtT/assetT;
	   	 
	   	 document.getElementById("outcome").innerHTML = '<div class="card shadow">'+
	   		 												'<div class="single-cases">'+
															 '<div class="cases-caption">'+
														     '<h1>결과</h1>'+
														     '<table id="resultTable"><tr><td>부채비율</td></tr>'+
															 '<tr><td>= 총 부채 / 총 자산</td></tr>'+
															 '<tr><td>= <span class="red" style="color:red">'+result.toFixed(2)+'</span></td></tr></table>'+
														  	 '</div>'+
														  	 '</div>'+
														'</div>';
	     	}
	     	
	     function showAlert(ele_id){
	     	var ele_name = $("#" + ele_id).attr('name');	
		   	alerting(ele_name + '을(를) 입력해주세요.');
		
			// 해당 id에 focus.
			$("#" + ele_id).focus();
	     }
    	
     	//숫자 validating 부동소수점 포함
		$(document).on("input","input[id=assetT]",function(){
			var check = document.getElementById("assetT").value;
	
	       	var num = /^[+]?\d+\.?\d*$/;
	         
	        if(!num.test(check)) {
	        	alerting('총 자산을 다시 입력해주세요.');
				document.getElementById("assetT").value = "";
				$("#assetT").focus();
	           	return false;
        	} 
		});
     	
		$(document).on("input","input[id=debtT]",function(){
			var check = document.getElementById("debtT").value;
		
		      	var num = /^[+]?\d+\.?\d*$/;
		        
		       if(!num.test(check)) {
		       	alerting('총 부채를 다시 입력해주세요.');
				document.getElementById("debtT").value = "";
				$("#debtT").focus();
		          	return false;
		       } 
		});	
		//End of 부채비율
		
///////////////////////////////////////////////Begin of ROE/////////////////////////////////////////////////////////////
   function roe(){
   	document.getElementById("calculator2").innerHTML = "";
 		document.getElementById("calculator2").innerHTML = '<div class="card shadow">'+
 														  '<div class="single-cases">'+
        												  '<div class="cases-caption">'+
          											      '<h1>ROE</h1>'+
          											      '<table id="inputInfo">'+
          							            		  '<tr><td class="inputName">당기순이익 :</td>'+
          							            		  '<td><input type="text" id="ni" name="당기순이익" class="inputHere" /> 원</td></tr>'+
          							            		  '<tr><td class="inputName">평균주주자본 :</td>'+
          							            		  '<td><input type="text" id="avgEquity" name="평균주주자본" class="inputHere" /> 원</td></tr>'+
          							            		  '</table>'+
          							            		  '<button type="button" class="genric-btn primary" onclick="calculateROE();">계산</button>&nbsp;'+
          							            		  '<button type="button" class="genric-btn primary" onclick="refresh();">초기화</button>'+
         												  '</div>'+
         												  '</div>'+
    													  '</div>';
 		document.getElementById("outcome").innerHTML = "";
 		}

    	function calculateROE(){
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
	   	 var avgEquity = parseInt(document.getElementById("avgEquity").value);	
	   	 var result = ni/avgEquity;
	   	 
	   	 document.getElementById("outcome").innerHTML =  '<div class="card shadow">'+
	   		 												'<div class="single-cases">'+
															  '<div class="cases-caption">'+
														      '<h1>결과</h1>'+
														      '<table id="resultTable"><tr><td>ROE</td></tr>'+
																 '<tr><td>= 당기순이익 / 평균주주자본</td></tr>'+
																 '<tr><td>= <span class="red" style="color:red">'+result.toFixed(2)+'</span></td></tr></table>'+
														  	'</div>'+
														  	'</div>'+
															'</div>';
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
     	
		$(document).on("input","input[id=avgEquity]",function(){
			var check = document.getElementById("avgEquity").value;
		
		      	var num = /^[+]?\d+\.?\d*$/;
		        
		       if(!num.test(check)) {
		       	alerting('평균주주자본을 다시 입력해주세요.');
				document.getElementById("avgEquity").value = "";
				$("#avgEquity").focus();
		          	return false;
		       } 
		});	
		//End of ROE
		
///////////////////////////////////////////////Begin of 재고자산회전율/////////////////////////////////////////////////////////////
   function itr(){
   	document.getElementById("calculator2").innerHTML = "";
 		document.getElementById("calculator2").innerHTML = '<div class="card shadow">'+
 														  '<div class="single-cases">'+
        												  '<div class="cases-caption">'+
          											      '<h1>재고자산회전율</h1>'+
          											      '<table id="inputInfo">'+
          							            		  '<tr><td class="inputName">매출액 :</td>'+
          							            		  '<td><input type="text" id="revenue" name="매출액" class="inputHere" /> 원</td></tr>'+
          							            		  '<tr><td class="inputName">평균재고자산 :</td>'+
          							            		  '<td><input type="text" id="avgInventory" name="평균재고자산" class="inputHere" /> 원</td></tr>'+
          							            		  '</table>'+
          							            		  '<button type="button" class="genric-btn primary" onclick="calculateITR();">계산</button>&nbsp;'+
          							            		  '<button type="button" class="genric-btn primary" onclick="refresh();">초기화</button>'+
         												  '</div>'+
         												  '</div>'+
    													  '</div>';
 		document.getElementById("outcome").innerHTML = "";
 		}

    	function calculateITR(){
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
	   	
	   	 var revenue = parseInt(document.getElementById("revenue").value);	
	   	 var avgInventory = parseInt(document.getElementById("avgInventory").value);	
	   	 var result = revenue/avgInventory;
	   	 
	   	 document.getElementById("outcome").innerHTML =  '<div class="card shadow">'+
	   		 												'<div class="single-cases">'+
															  '<div class="cases-caption">'+
														      '<h1>결과</h1>'+
														      '<table id="resultTable"><tr><td>재고자산회전율</td></tr>'+
																 '<tr><td>= 매출액 / 평균재고자산</td></tr>'+
																 '<tr><td>= <span class="red" style="color:red">'+result.toFixed(2)+'</span></td></tr></table>'+
															  '</div>'+
															  '</div>'+
														'</div>';
	     	}
	     	
	     function showAlert(ele_id){
	     	var ele_name = $("#" + ele_id).attr('name');	
		   	alerting(ele_name + '을(를) 입력해주세요.');
		
			// 해당 id에 focus.
			$("#" + ele_id).focus();
	     }
    	
     	//숫자 validating 부동소수점 포함
		$(document).on("input","input[id=revenue]",function(){
			var check = document.getElementById("revenue").value;
	
	       	var num = /^[+]?\d+\.?\d*$/;
	         
	        if(!num.test(check)) {
	        	alerting('매출액을 다시 입력해주세요.');
				document.getElementById("revenue").value = "";
				$("#revenue").focus();
	           	return false;
        	} 
		});
     	
		$(document).on("input","input[id=avgInventory]",function(){
			var check = document.getElementById("avgInventory").value;
		
		      	var num = /^[+]?\d+\.?\d*$/;
		        
		       if(!num.test(check)) {
		       	alerting('평균재고자산을 다시 입력해주세요.');
				document.getElementById("avgInventory").value = "";
				$("#avgInventory").focus();
		          	return false;
		       } 
		});	
		//End of 재고자산회전율
     </script>

</body>

</html>
    