<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

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

  <title>같이투자 | 채권</title>
  
    <style>
  	#wrapper{
  		width: 100%;
  		height: 700px;
  	}
  	
  	#card-total{
  		width: 90%;
		margin: auto;
  	}
  	
  	#dataTable{
  		text-align: center;
  	}
  	
  </style>

</head>

<body id="page-top">
<jsp:include page="../main/header.jsp"/>

  <!-- Page Wrapper -->
  <div id="wrapper">

          <!-- DataTales -->
          <div class="card shadow mb-4" id="card-total">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">채권 현황</h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">
              
              <form:form id="frm">
              	<button type="button" class="btn btn-outline btn-primary pull-right" name="addRow">추가</button>
              	<button type="button" class="btn btn-outline btn-primary pull-right" name="modify">수정</button>
              	<button type="button" class="btn btn-outline btn-primary pull-right" name="delRow">삭제</button>
              	<button type="button" class="btn btn-outline btn-primary pull-right" id="downloadExel">엑셀파일로 다운</button>
                  
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">               
                  <thead>
                    <tr>
                   	 <th><input type="checkbox" id="checkAll" /></th>
                      <th>종목명</th>
                      <th>세후보유기간이자(%)</th>
                      <th>증권사</th>
                      <th>매수금액(&#8361;)</th>
                      <th>매수일자</th>
                      <th>발행이자율(%)</th> 
                      <th>할인발행율(%)</th>
                      <th>총상환금액(&#8361;)</th>
                      <th>만기일</th>
                      <th>신용등급</th>
                    </tr>
                  </thead>
              
                  <tbody id="bond_tbody"> 
	                  <c:forEach var = "dto" items= "${list}">
		                    <tr id="bondList_${dto.bond_num}">
			                    <td><input type="checkbox" class="checkRow" name="checkRow" data-symbols="${dto.bond_num}" /></td>
			                    <td style="display:none;">${dto.bond_num}</td> <!-- jQuery.Deferred exception의 원인 th, td 컬럼 수가 불일치 -->
			                    <td>${dto.bond_symbols}</td>
			                    <td>${dto.total_interest}</td>
			                    <td>${dto.bond_company}</td>
			                    <td>${dto.bond_price}</td>
			                    <td>${dto.bond_date}</td>
			                    <td>${dto.coupon_interest_rate}</td>
			                    <td>${dto.discount_rate}</td>
			                    <td>${dto.gross_price}</td>
			                    <td>${dto.maturity_date}</td>
			                    <td>${dto.grade}</td>
		                    </tr>
                    </c:forEach>	
                  </tbody>
                </table>                
                </form:form>
              </div>
            </div>
          </div>
         

          
          <!-- table script -->
          <script type="text/javascript">
          
      	//채권에 아무 값이 없을 때
       	$(document).ready(function(){
       	    if(${fn:length(list) } == 0){
       	    	document.getElementById("bond_tbody").innerHTML = '<tr><td colspan="11">보유 중인 채권 정보가 없습니다.</td></tr>';
       	    }
       	});
          
          function alerting(content){
        		AstNotif.dialog('알림', content, {
            	  theme: 'default',
            	});
        	}
          
          function confirming(content){
	      		AstNotif.snackbar(content, {
	          	  theme: 'default',
	          	});
      		}
          
          //날짜 validating
          $(document).on("input","input[name=maturity_date]",function(){
				    var startDate = document.getElementById("bond_date").value;
				    var endDate = document.getElementById("maturity_date").value;
				    
				    if ((Date.parse(startDate) >= Date.parse(endDate))) {
				        alerting("만기일이 매수일자보다 빠른 날짜를 선택하셨습니다.");
				        document.getElementById("maturity_date").value = "";
				    }
			}); 
          
          //특수문자, 공백 validating
           $(document).on("input","input[name=bond_symbols]",function(){
	        	  var bond_symbols = document.getElementById("bond_symbols").value;

 	        	  var pattern1 = /\s/;
	        	  var pattern2 = /[._+=-`~!@#$%^&*|\\\'\";:\/?]/gi;
	        	  
	         	  if(bond_symbols.search(pattern1) != -1 || bond_symbols.search(pattern2) != -1) {
	                  alerting("종목명을 다시 입력해주세요. 공백 및 특수문자는 사용할 수 없습니다.");
	                  document.getElementById("bond_symbols").value = "";
	                  return false;
	               }

          	}); 
          
          //숫자 validating 부동소수점 포함
          $(document).on("input","input[name=total_interest]",function(){
				var total_interest = document.getElementById("total_interest").value;

	        	var num = /^[+]?\d+\.?\d*$/;
	          
		        if(!num.test(total_interest)) {
		        	alerting("세후보유기간이자를 다시 입력해주세요");
		        	document.getElementById("total_interest").value = "";
	                return false;
		        } 
          });
          
          $(document).on("input","input[name=coupon_interest_rate]",function(){
				var coupon_interest_rate = document.getElementById("coupon_interest_rate").value;

	        	var num = /^[+]?\d+\.?\d*$/;     
		        
		        if(!num.test(coupon_interest_rate)) {
	                alerting("발행이자율을 다시 입력해주세요");
	                document.getElementById("coupon_interest_rate").value = "";
	                return false;
	             }
       	 });
          
          $(document).on("input","input[id=discount_rate]",function(){
				var discount_rate = document.getElementById("discount_rate").value;

	        	var num = /^[+]?\d+\.?\d*$/;     

		        if(!num.test(discount_rate)) {
	                alerting("할인이자율을 다시 입력해주세요");
	                document.getElementById("discount_rate").value = "";
	                return false;
	             }
 	     });
          
          
          
        //숫자 validating 정수
          $(document).on("input","input[name=bond_price]",function(){
				var bond_price = document.getElementById("bond_price").value;

	        	var num = /^\d+\.?\d*$/;
	          
		        if(!num.test(bond_price)) {
	                alerting("매수금액을 다시 입력해주세요");
	                document.getElementById("bond_price").value = "";
	                return false;
	             }
          });
        
          $(document).on("input","input[name=gross_price]",function(){
				var gross_price = document.getElementById("gross_price").value;

	        	var num = /^\d+\.?\d*$/;

		        if(!num.test(gross_price)) {
	                alerting("총상환금액을 다시 입력해주세요");
	                document.getElementById("gross_price").value = "";
	                return false;
	             }
        });
          
          

          	//전체선택 
          	$(document).ready(function(){
          	    //최상단 체크박스 클릭
          	    $("#checkAll").click(function(){
          	        //클릭되었으면
          	        if($("#checkAll").prop("checked")){
          	            //input태그의 class가  checkRow인 태그들을 찾아서 checked옵션을 true로 정의
          	            $(".checkRow").prop("checked",true);
          	            //클릭이 안되있으면
          	        }else{
          	            //input태그의 class가  checkRow인 태그들을 찾아서 checked옵션을 false로 정의
          	            $(".checkRow").prop("checked",false);
          	        }
          	    })
          	});
          	
          	//개별 체크박스가 선택되거나 선택해제되면 모두 선택 체크박스가 해체   
          	$(document).ready(function(){
          		$(".checkRow").click(function(){
      			  $("#checkAll").prop("checked", false);
      			 })
          	});
			 
          	
		    //추가 버튼
		    $(document).on("click","button[name=addRow]",function(){
		        
		        var addTableRow =     
		        	'	 <tr id="bondList_${dto.bond_num}">'+
		            '    <td><input type="checkbox" class="checkRow" name="checkRow" data-symbols="${dto.bond_num}" /></td>'+
		            '    <td style="display:none;"><input type="hidden" name="bond_num" value="${dto.bond_num}" /></td>'+
		            '    <td><input type="text" id="bond_symbols" name="bond_symbols" placeholder="종목명" /></td>'+
		            '    <td><input type="text" id="total_interest" name="total_interest" placeholder="세후보유기간이자" /></td>'+
		            '    <td><select id="bond_company" name="bond_company" placeholder="증권사">'+
		            '	 <option value="" disabled selected>증권사</option>'+
		            '	 <option value="한국투자증권">한국투자증권</option>'+
		            '	 <option value="미래에셋대우">미래에셋대우</option>'+
		            '	 <option value="메리츠종금증권">메리츠종금증권</option>'+
		            '	 <option value="NH투자증권">NH투자증권</option>'+
		            '	 <option value="삼성증권">삼성증권</option>'+
		            '	 <option value="신한금융투자">신한금융투자</option>'+
		            '	 <option value="키움증권">키움증권</option>'+
		            '	 <option value="KB증권">KB증권</option>'+
		            '	 <option value="하나금융투자">하나금융투자</option>'+
		            '	 <option value="대신증권">대신증권</option>'+
		            '	 <option value="유안타증권">유안타증권</option>'+
		            '	 </select></td>'+
		            '    <td><input type="text" id="bond_price" name="bond_price" placeholder="매수금액" /></td>'+
		            '    <td><input type="date" id="bond_date" name="bond_date" placeholder="매수일자" /></td>'+
		            '    <td><input type="text" id="coupon_interest_rate" name="coupon_interest_rate" placeholder="발행이자율" /></td>'+
		            '    <td><input type="text" id="discount_rate" name="discount_rate" placeholder="할인발행율" /></td>'+
		            '    <td><input type="text" id="gross_price" name="gross_price" placeholder="총상환금액" /></td>'+
		            '    <td><input type="date" id="maturity_date" name="maturity_date" placeholder="만기일" /></td>'+
		            '    <td><select id="grade" name="grade" placeholder="신용등급">'+
		            '	 <option value="" disabled selected>신용등급</option>'+
		            '	 <option value="AAA">AAA</option>'+
		            '	 <option value="AA">AA</option>'+
		            '	 <option value="A">A</option>'+
		            '	 <option value="BBB">BBB</option>'+
		            '	 <option value="BB">BB</option>'+
		            '	 <option value="B">B</option>'+
		            '	 <option value="CCC">CCC</option>'+
		            '	 <option value="CC">CC</option>'+
		            '	 <option value="C">C</option>'+
		            '	 <option value="D">D</option>'+
		            '	 </select>'+
		            '  	 <button type="button" class="btn btn-outline btn-primary" onclick="insertCheck();">+</button></td>'+
		            '</tr>';
		            
			        if(${fn:length(list) } == 0){
		       	    	document.getElementById("bond_tbody").innerHTML = addTableRow;
		       	    } else{
		       	    	$("#bond_tbody").append(addTableRow);
		       	    }
		    });

		    //null check B4 submit
		    function insertCheck(){
		    	
		    	// form안의 모든 text type 조회
		    	var txtEle = $("#frm input[type=text]");
		    	
		    	for(var i = 0; i < txtEle.length; i ++){
		    		if("" == $(txtEle[i]).val() || null == $(txtEle[i]).val()){
			    		var ele_id = $(txtEle[i]).attr("id");
			    		//console.log("id : " + ele_id);
			    		showAlert(ele_id);
			    		return true;
		    		}
		    	}
		    	
		    	//select값 조회
		    	if("" == $("#bond_company option:selected").val() || null == $("#bond_company option:selected").val()){
		    		var ele_id = "bond_company";
		    		showAlert(ele_id);
		    		return true;
	    		}
		    			    	
		    	if("" == $("#grade option:selected").val() || null == $("#grade option:selected").val()){
		    		var ele_id = "grade";
		    		//console.log("id : " + ele_id);
		    		showAlert(ele_id);
		    		return true;
	    		}
		    	
		    		theForm = document.form;
		    		document.getElementById("frm").action = "writeBond";
		    		document.getElementById("frm").submit();
    	
		    }
		    
		    //null check B4 modify
		    function modifyCheck(){
		    	
		    	// form안의 모든 text type 조회
		    	var txtEle = $("#frm input[type=text]");
		    	
		    	for(var i = 0; i < txtEle.length; i ++){
		    		if("" == $(txtEle[i]).val() || null == $(txtEle[i]).val()){
			    		var ele_id = $(txtEle[i]).attr("id");
			    		console.log("id : " + ele_id);
			    		showAlert(ele_id);
			    		return true;
		    		}
		    	}
		    	
		    	//select값 조회
		    	if("" == $("#bond_company option:selected").val() || null == $("#bond_company option:selected").val()){
		    		var ele_id = "bond_company";
		    		showAlert(ele_id);
		    		return true;
	    		}
		    			    	
		    	if("" == $("#grade option:selected").val() || null == $("#grade option:selected").val()){
		    		var ele_id = "grade";
		    		//console.log("id : " + ele_id);
		    		showAlert(ele_id);
		    		return true;
	    		}
		    	
		    		theForm = document.form;
		    		document.getElementById("frm").action = "modifyBond";
		    		document.getElementById("frm").submit();
    	
		    }
		    
		    
		    
		    //null값일 때 focus주기 
		    function showAlert(ele_id){

		    	var ele_name = $("#" + ele_id).attr('placeholder');
		    	alerting(ele_name + "을 입력해주세요.");

		    	// 해당 id에 focus.
		    	$("#" + ele_id).focus();
		    }

		    
		    //삭제 버튼
		    $(document).on("click","button[name=delRow]",function(){
		    	   var checkArr = [];
		    	   
		    	   $("input[class='checkRow']:checked").each(function(){
		    	    checkArr.push($(this).attr("data-symbols"));
		    	   });
		    	    
		    	   $.ajax({
		    	    url : "deleteBond",
		    	    type : "post",
		    	    data : {"checkRow" : checkArr},
		    	    dataType : "json",
		    	    success : function(result){
		    	    		if(result == 1){
		    	    			confirming("삭제했습니다.");
			    	    		setTimeout(function() {
			    	    			window.location.href = "bond";
			    	    			}, 1000);
		    	    		}
		    	    			
		    	    	}
		    	    });

 	        });
		    
		    //ajax csrf
		    $(document).ready(function(){
			    var token = $("meta[name='_csrf']").attr("content");
			    var header = $("meta[name='_csrf_header']").attr("content");
			    $(document).ajaxSend(function(e, xhr, options) {
			        xhr.setRequestHeader(header, token);
			    });
			});
		    
		    
		  //수정 input박스 띄우기 
			$(document).on("click","button[name=modify]",function(){
				$("input[class='checkRow']:checked").each(function(){
					
					var str = "";
					var tdArr = new Array();
					var checkBtn = $(this);
					var num = $(this).attr("data-symbols");
					console.log(num);
					
					// checkBtn.parent() : checkBtn의 부모는 <td>이다.
		            // checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
		            var tr = checkBtn.parent().parent();
		            var td = tr.children();
		            var id = tr.attr('id');
		            console.log("id: "+id);
					
					// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
					console.log("클릭한 row의 모든 데이터: "+tr.text());
					
					
					// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
		            td.each(function(i){
		                tdArr.push(td.eq(i).text());
		            });

					console.log("배열에 담긴 값: "+tdArr);

					str +=     
			            '    <td><input type="checkbox" class="checkRow" name="checkRow" data-symbols="${dto.bond_num}" /></td>'+
			            '    <td style="display:none;"><input type="hidden" name="bond_num" value='+tdArr[1]+' /></td>'+
			            '    <td><input type="text" id="bond_symbols" name="bond_symbols" value='+tdArr[2]+' placeholder='+tdArr[2]+' /></td>'+
			            '    <td><input type="text" id="total_interest" name="total_interest" value='+tdArr[3]+' placeholder='+tdArr[3]+' /></td>'+
			            '    <td><select id="bond_company" name="bond_company" placeholder="bond_company">'+
			            '	 <option value='+tdArr[4]+' selected>'+tdArr[4]+'</option>'+
			            '	 <option value="한국투자증권">한국투자증권</option>'+
			            '	 <option value="미래에셋대우">미래에셋대우</option>'+
			            '	 <option value="메리츠종금증권">메리츠종금증권</option>'+
			            '	 <option value="NH투자증권">NH투자증권</option>'+
			            '	 <option value="삼성증권">삼성증권</option>'+
			            '	 <option value="신한금융투자">신한금융투자</option>'+
			            '	 <option value="키움증권">키움증권</option>'+
			            '	 <option value="KB증권">KB증권</option>'+
			            '	 <option value="하나금융투자">하나금융투자</option>'+
			            '	 <option value="대신증권">대신증권</option>'+
			            '	 <option value="유안타증권">유안타증권</option>'+
			            '	 </select></td>'+
			            '    <td><input type="number" id="bond_price" name="bond_price" value='+tdArr[5]+' placeholder='+tdArr[5]+' /></td>'+
			            '    <td><input type="date" id="bond_date" name="bond_date" value='+tdArr[6]+' placeholder='+tdArr[6]+' /></td>'+
			            '    <td><input type="text" id="coupon_interest_rate" name="coupon_interest_rate" value='+tdArr[7]+' placeholder='+tdArr[7]+' /></td>'+
			            '    <td><input type="text" id="discount_rate" name="discount_rate" value='+tdArr[8]+' placeholder='+tdArr[8]+' /></td>'+
			            '    <td><input type="text" id="gross_price" name="gross_price" value='+tdArr[9]+' placeholder='+tdArr[9]+' /></td>'+
			            '    <td><input type="date" id="maturity_date" name="maturity_date" value='+tdArr[10]+' placeholder='+tdArr[10]+' /></td>'+
			            '    <td><select id="grade" name="grade" placeholder="grade">'+
			            '	 <option value='+tdArr[11]+' selected>'+tdArr[11]+'</option>'+
			            '	 <option value="AAA">AAA</option>'+
			            '	 <option value="AA">AA</option>'+
			            '	 <option value="A">A</option>'+
			            '	 <option value="BBB">BBB</option>'+
			            '	 <option value="BB">BB</option>'+
			            '	 <option value="B">B</option>'+
			            '	 <option value="CCC">CCC</option>'+
			            '	 <option value="CC">CC</option>'+
			            '	 <option value="C">C</option>'+
			            '	 <option value="D">D</option>'+
			            '	 </select>'+
			            '  	 <button type="button" class="btn btn-outline btn-primary" onclick="modifyCheck();">+</button></td>';
					
					$("#"+id).html(str);
		    	   });
				
		        
		    }); 


		  	//ExelExport
		  	$(document).ready(function () {
                $('#downloadExel').on('click', function (e) {
                    console.log("test");
                    e.preventDefault();

                    $('table').tableExport({type:'excel'});

                });
		  	});
		    
		</script>

  </div>
  <!-- End of Page Wrapper -->
  
  <!-- footer -->
  <jsp:include page="../main/footer.jsp"/>


  <!-- Page level plugins -->
  <script src="resources/sb_admin/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="resources/sb_admin/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="resources/sb_admin/js/demo/datatables-demo.js"></script>
  
	 <!-- Exel Export -->
	<script type="text/javascript" src="resources/sb_admin/js/FileSaver/FileSaver.min.js"></script>
	<script type="text/javascript" src="resources/sb_admin/js/js-xlsx/xlsx.core.min.js"></script>
	<script type="text/javascript" src="resources/sb_admin/js/tableExport.min.js"></script>

</body>

</html>
    