<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 

<!DOCTYPE html>
<html>

<head>
   
  <title>같이투자 | 거래내역</title>   
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  
  <!-- alert -->
  <link rel="stylesheet" href="resources/sb_admin/css/ast-notif.css" />
  <script src="resources/sb_admin/js/ast-notif.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script> 
  <link href="resources/ranking.css" rel="stylesheet" type="text/css">
  <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">

   <style type="text/css">
      .error{
         color:red;
      }
   </style>
  
</head>

   <style>
   
	  .sub-list-empty {
		 padding-top: 100px !important;
		 padding-bottom: 100px !important;
		 font-family: 'Noto Sans KR', sans-serif;
		 font-size: 20px;
	  }
   
      .setPriceCon{
         width: 80%;
         margin-left:auto;
         margin-right:auto;
         margin-bottom:150px;
         padding-top: 150px;
         padding-bottom: 300px;
         height: 1000px;
      }
      
      .setPrice{
         padding-bottom: 100px;
      }
      
      #priceArea{
         display: flex;
      }
      
      .hero-cap h2 {
          color: #072366;
          font-size: 35px;
          font-weight: 600;
          text-transform: capitalize;
          line-height: 1;
          padding-bottom: 30px;
      }
      
      .priceSet{
         height:30px !important;
         margin-left: 5px;
      }
   </style>
   
   <body>
      <jsp:include page="../main/header.jsp"/>
   
         <div class="setPriceCon">
            <div class="setPrice">
               <div class="hero-cap">
                       <h2>보유자산 판매금액 설정</h2>
                  </div>  
               
                <form:form class="setPrice-form" action="setPrice" method="post">
                   <div id="priceArea">
                        <div id="inputArea"><input type="text" name="set_price" placeholder="판매금액" maxlength="8" style="color:#000;"></div>
                        <input class="priceSet" type="submit" value="입력"> 
                     </div>
                  </form:form>
                                       
                  <div>
                     <c:if test="${empty price}">
                        <tr>
                           <td>입력된 가격이 없습니다.<td>
                        </tr>
                     </c:if>
                     <c:if test="${!empty price}">
                           <p>현재 판매금액 :<fmt:formatNumber value="${price}"/>원</p>
                     </c:if>
                  </div>
                  
            </div>
               
             <div class="hero-cap">
                    <h2>판매현황</h2>
               </div>     
               
               <table class="table leaderboards">
                  <thead>
                     <tr>
                        <th>판매일</th>
                        <th>구매자 닉네임</th>
                        <th>거래대금</th>
                        <th>만료일</th>
                     </tr>
                  </thead>
                  <tbody>
                     <c:if test="${empty list}">
                        <tr>
                           <td class="sub-list-empty" colspan="7">판매내역이 없습니다.</td>
                        </tr>
                     </c:if>
                     
                     <c:forEach var="dto" items="${list}" varStatus="status">
                        <tr>
                           <td><fmt:formatDate value="${dto.sub_date}" pattern="yyyy-MM-dd" /></td>
                           <td>${dto.buyer_nickname}</td>
                           <td><fmt:formatNumber value="${dto.sub_price}"/>원</td>
                           <td><fmt:formatDate value="${dto.sub_maturity_date}" pattern="yyyy-MM-dd" /></td>
                        </tr>
                        
                     </c:forEach>
                  </tbody>
               </table>
               
            </div>
         
         <script type="text/javascript">
            
            $(document).ready(function (){
            
            $.validator.addMethod("priceRegex", function(value, element) {
               return this.optional(element) || value.match(/^[0-9]+$/);   
            });
            
            $(".setPrice-form").validate({
               //규칙
               rules:{
                  set_price:{
                     required : true, //필수입력여부
                     maxlength : 8,  //최대 입력 글자수
                     priceRegex : true,
                  },
               },

               //메시지
               messages:{
                  set_price:{
                     required : "금액을 입력해주세요.",
                     maxlength : "최대 8자리까지 입력가능합니다.",
                     priceRegex : "숫자만 입력가능합니다.",
                  },
               },

               //메시지 태그
               errorElement : 'div',    //태그
               errorClass: 'error',   //클래스 이름
               validClass:'vaild' 
            });
         });
            
         </script>   
            
      <!-- footer -->
      <jsp:include page="../main/footer.jsp"/>
   </body>
</html>
    