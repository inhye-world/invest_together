<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>

<html>

<head>
   <meta charset="UTF-8">
   <title>같이투자 | 월급관리</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
   <link href="resources/sb_admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
   <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
   <script src="resources/sb_admin/vendor/jquery/jquery.min.js"></script>
   <script src="resources/sb_admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
   <script src="resources/sb_admin/vendor/jquery-easing/jquery.easing.min.js"></script>
   <script src="resources/sb_admin/vendor/chart.js/Chart.min.js"></script> 
   <link href="resources/ranking.css" rel="stylesheet" type="text/css">
   <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">


   <style>
   
      .button {
          width:60px;
          background-color: #ffffff;
          border: none;
          color:#000000;
          text-align: center;
          text-decoration: none;
          display: inline-block;
          font-size: 15px;
          margin: 4px;
          cursor:pointer;
         }
         
        #modifySalT{
            padding: 20px;
            font-size:1em;
            border:1px solid #fff;
            background-color: #595959;
            border-radius: 4px;
         }
        
      .portfolio {
          display:flex;
      }
      
      input,.test2 {
         text-align:center;
         font-size:15px;
      }
      #myPieChart{
         height:250px;
      }
      
      #test{
      	 text-align: center;
      	 padding-top: 25px;
      }
      #salary-modify-form{
         width:100%;
      }
      .salary-table-empty{
      	 padding-top: 100px !important;
   		 padding-bottom: 100px !important;
      }
	
   </style>
            
</head>

   <body>
      
         <div class="wrapper">
           <jsp:include page="../main/header.jsp"/> 
         
            <div class="container" >
            
            <br><br><br>
            
             <!-- Page Heading -->
                   <h1>월급 관리</h1>
                   <div>
                       <ul class="ranking-notice">
                     <li>회원님의 적금·예금 현황을 나타냅니다.</li>
                     <li>'수정'을 클릭하여 카테고리를 선택해주세요.</li>
                     <li>'통장이름' 클릭시 해당 통장의 상세 내역을 나타냅니다.</li>
                  </ul>
                  </div>
               <c:if test="${!( sum1==0 and sum2==0 and sum3==0)}"> 
                  <div class="portfolio">
                     <canvas id="myPieChart"></canvas>
                     <br>
                  </div>
               </c:if>
                  <div id="test">
                     <span >
                              <i class="fas fa-circle text-primary"></i> 적금 &nbsp;
                        </span>
                        <span >
                            <i class="fas fa-circle text-warning"></i> 예금 &nbsp;
                        </span> 
                        <span >
                            <i class="fas fa-circle text-success"></i> 자유 입출금 &nbsp;
                        </span> 
                      </div><br>
               <div class="account-list">
                  <div >
                     <button id="modifySalT" class="btn">수정</button>
                  </div> 
                  <form:form id="salary-modify-form" name="salary-modify-form" method = "post">
                     <table id="account-table" class="table leaderboards" width="100%" cellspacing="0">
                        <thead>
                           <tr class="test2">
                              <th>카테고리</th>
                              <th>통장이름</th>
                              <th>은행/증권사</th>
                              <th>연이자(%)</th>
                              <th>예상입금액</th>
                              <th>실입금액</th>
                              <th>누적액</th>
                              <th>만기</th>
                              <th> </th>
                           </tr>
                        </thead>
                        <tbody>
                        
                        <c:if test="${empty accountSalaryList}">
							<tr>
								<td class="salary-table-empty" colspan="9" style="text-align:center; font-family:'Noto Sans KR', sans-serif; font-size: 20px;">
									계좌를 추가해주세요.
								</td>
							</tr>
						</c:if>
                        
                           <c:forEach var="salary" items="${accountSalaryList}" varStatus="status" >
                           <tr id="salary-${status.index}">
                              <td class="test2"><span id="hello-${status.index}"><select name="category" id="category" disabled  >
                                 <option value="적금" ${salary.category=="적금" ? "selected" : ""} >적금</option>   
                                 <option value="예금" ${salary.category=="예금" ? "selected" : ""} >예금</option>   
                                 <option value="자유 입출금" ${salary.category=="자유 입출금" ? "selected" : ""} >자유 입출금</option>         
                              </select></span></td>
                               <td class="test2"><button class="button" onclick="window.open('${pageContext.request.contextPath}/account_salary?fin=${salary.fintech_use_num}','통장 내역','width=1100,height=420,left=400, top=300,location=no,status=no');">${salary.account_alias}</button></td>
                              <td class="test2">${salary.bank_name}</td>
                              <td class="test2"><input type="text"  name="interest" id="interest" value="${salary.interest}" disabled required="required"/></td>
                              <td class="test2"><input type="text" numberOnly name="expected_amt" id="expected_amt" value="${salary.expected_amt}" disabled required="required"/></td>
                              <td class="test2"><fmt:formatNumber type="number" maxFractionDigits="3" value="${salary.tran_amt}" />원</td>
                              <td class="test2"><fmt:formatNumber type="number" maxFractionDigits="3" value="${salary.balance_amt}" />원</td>
                              <td class="test2"><input type="date" name="strMaturity" id="strMaturity" value="${salary.strMaturity}" disabled required="required"/></td>
                              <td class="test2"><input type="hidden" name="fintech_use_num" value="${salary.fintech_use_num}" /><button id="modifyBtn-${status.index}" class="btn" style="padding: 20px;font-size:1em;border:1px solid #fff;background-color: #595959;border-radius: 4px;">저장</button></td>
                           </tr>
                           <script>
                               var count = ${status.count} 
                           </script>
                           <script>
                               var accountSum = ${sum1}
                               accountSum += sum1;
                           </script>
                           <script>
                              var accountSum2= ${sum2}
                              accountSum2 += sum2;   
                           </script>   
                           <script>
                              var accountSum3= ${sum3}
                              accountSum3 += sum3;   
                           </script>   
                        </c:forEach>                
                     </tbody>
                  </table>
               </form:form>
            </div>
         </div>
      </div>
      
      <script type="text/javascript">
         $("#modifySalT").click(function(){
            
            var tdArr = new Array();
            
            for(var m=0; m<count; ++m){
               $("#salary-"+m).find('input').attr("disabled", false);
                $("#salary-"+m).find('select').attr("disabled", false); 
            }
         })
      </script>
      
      <script>
         for(var i=0; i<count; ++i) {
            (function(k){
               $("#modifyBtn-"+k).click(function() {
                  for(var j=0; j<count; ++j) {
                     if(j!=k) {
                        $("#salary-"+j).find('input').attr("disabled", true);
                        $("#salary-"+j).find('select').attr("disabled", true);
                     }
                     
                     $.ajax({
                        url: "salary_modify",
                        type:'POST',
                        data:$('#salary-modify-form').serialize(),
                        sucess:function(response, status, request){
                           alert('성공');   
                        }
                     });
                  }
               });
            })(i);
         }
      </script>
      
      <script>
      $("input:text[numberOnly]").on("keyup", function() {
          $(this).val($(this).val().replace(/[^0-9]/g,""));
      });
      </script>
      
      <script>
      
      // Set new default font family and font color to mimic Bootstrap's default styling
      Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
      Chart.defaults.global.defaultFontColor = '#858796';

      // Pie Chart Example
      var ctx = document.getElementById("myPieChart");
      var myPieChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
          labels: ["적금", "예금","자유 입출금"],
          datasets: [{
            data: [accountSum, accountSum2,accountSum3],
            backgroundColor: ['#28b2c7','#ffb94b','#50c09c'],
            hoverBackgroundColor: ['#0568bf', '#F6d55c', '#28a745'],
            hoverBorderColor: "rgba(234, 236, 244, 1)",
          }],
        },
        options: {
          maintainAspectRatio: false,
          tooltips: {
            backgroundColor: "rgb(255,255,255)",
            bodyFontColor: "#858796",
            borderColor: '#dddfeb',
            borderWidth: 1,
            xPadding: 15,
            yPadding: 15,
            displayColors: false,
            caretPadding: 10,
          },
          legend: {
            display: false
          },
          cutoutPercentage: 65,
        },
      });

      </script>
         <script src="resources/sb_admin/vendor/chart.js/Chart.min.js"></script>
         <script src="resources/tableExport/tableExport.min.js" type="text/javascript"></script>
         <script src="resources/tableExport/xlsx.core.min.js" type="text/javascript"></script>
         <script src="resources/tableExport/FileSaver.min.js" type="text/javascript"></script>
      </body>
      
         <br><br><br><br>
      <jsp:include page="../main/footer.jsp"/>
</html>