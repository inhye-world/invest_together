<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>같이투자 | 유저 정보 수정</title>
   
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script> 
   <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
   <style>
      .member-container{
         width:100%;
         height:500px;
         text-align: center;
      }
      
      .usermodify-auth-title{
         padding-top: 10%;
         margin-left: -400px;
         margin-right: auto;
      }
       
      .ranking-notice{
         width:70%;
         margin-left: auto;
         margin-right: auto;
         margin-bottom: 0.5%;
         font-size: 1em;
      }
       
      .userPreCheck{
         width:30%;
         min-width:530px;
         border: 1px solid #000;
         margin-left: auto;
         margin-right: auto;
      }

      .userPreCheck th{
         background-color: #dfe5f8;
      }

      .userPreCheck th, td{
         border-bottom : 1px solid #000;
         padding: 10px;
      }

       .usermodify-auth-foot{
          text-align: center;
          margin-top: 20px;
       }
   
      .form-err{
         color:red;
         display: block;
         margin-top: 5px;
      }
      
      #usermodify-auth-submit, .usermodify-auth-cancel{
         border: 1px solid #112026;
         background-color:#fff;
         color:#112026;
         padding: 5px;
         cursor: pointer;
         border-radius: 3px;
         font-size: 13px;
      }
      
      #usermodify-auth-submit:hover{
         border: 1px solid #112026;
         background-color:#112026;
         color:#fff;
         padding: 5px;
         cursor: pointer;
         border-radius: 3px;
         font-size: 13px;
      }
      
      .usermodify-auth-cancel:hover{
         border: 1px solid #09cc7f;
         background-color:#09cc7f;
         color:#fff;
         padding: 5px;
         cursor: pointer;
         border-radius: 3px;
         font-size: 13px;
      }
      
   </style>
   
</head>
   <body>
   <jsp:include page="../main/header.jsp"/>
   
      <div class="member-container">
         <sec:authorize access="isAuthenticated()">
         <sec:authentication var="principal" property="principal"/>
         
         <form:form class="passwordConfirm" action="userModify" method="post">
            <h1 class="usermodify-auth-title">회원정보확인</h1>   
                  
                  <div>
                      <ul class="ranking-notice">
                      <li><strong class="usermodify-auth-nickname" style="color:#072366;">${principal.dto.nickname}</strong>
                  님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인 합니다.</li>
                  
               </ul>
                 </div>
                 
            <table class="userPreCheck">
               <tbody>
                  <tr>
                     <th scope="row">닉네임<th>
                     <td style="font-weight: bold;">${principal.dto.nickname}</td>
                  </tr>
                  <tr>
                      <th scope="row">비밀번호<th>
                     <td>
                     <input type="password" name="pw" placeholder="비밀번호 (8~32자리)">
                     <span class="form-err">${pw_error}</span>
                     </td>
                  </tr>
               </tbody>
            </table>
            
            <div class="usermodify-auth-foot">
               <button type="submit" id="usermodify-auth-submit" class="button5">확인</button>
            
               <button type="submit" class="usermodify-auth-cancel">취소</button>
            </div>   
         </form:form>
                     
         </sec:authorize>
      </div>
      <br><br><br>
      
      
      <jsp:include page="../main/footer.jsp"/>
      
      <script>
      
      $(document).ready(function (){
         $(".usermodify-auth-cancel").on("click",function() {
            $(".passwordConfirmForm").attr("action", "${pageContext.request.contextPath}").submit();
         });         
      });
      
      </script>
   </body>
</html>