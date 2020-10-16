<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="manifest" href="site.webmanifest">
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/main/assets/img/favicon.ico">
    
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>

	<style>
		.point{
			cursor:pointer;
			}
	</style>
	
	<!-- CSS here -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/owl.carousel.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/slicknav.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/flaticon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/progressbar_barfiller.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/gijgo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/animate.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/animated-headline.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/magnific-popup.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/fontawesome-all.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/themify-icons.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/slick.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/nice-select.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main/assets/css/style.css">
	
	<script>
		$(function() {
			$("#logout-btn").click(function(){
				$("#logout-form").submit();
			});
		});
	</script>
	

</head>
<body>
    <!-- ? Preloader Start -->
    <div id="preloader-active">
        <div class="preloader d-flex align-items-center justify-content-center">
            <div class="preloader-inner position-relative">
                <div class="preloader-circle"></div>
                <div class="preloader-img pere-text">
                    <img src="${pageContext.request.contextPath}/resources/main/assets/img/logo/loder.png" alt="">
                </div>
            </div>
        </div>
    </div>
    
    <form:form id="logout-form" action="${pageContext.request.contextPath}/logout" method="POST"></form:form>
    <!-- Preloader Start -->
    <header>
        <!-- Header Start -->
        <div class="header-area">
            <div class="main-header ">
                <div class="header-bottom  header-sticky">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <!-- Logo -->
                            <div class="col-xl-2 col-lg-2">
                                <div class="logo">
                                    <a href="/into"><img src="${pageContext.request.contextPath}/resources/main/assets/img/logo/logo.png" alt=""></a>
                                </div>
                            </div>
                            <!-- Logo End -->
                            <div class="col-xl-10 col-lg-10">
                                <div class="menu-wrapper  d-flex align-items-center justify-content-end">
                                    <!-- Main-menu -->
                                    <div class="main-menu d-none d-lg-block">
                                        <nav>
                                            <ul id="navigation">   
                                          		<li class="point"><a id="accountTransaction">가계부</a></li>
                                                <li class="point"><a id="salaryList">월급관리</a></li>
                                                <li><a href="assets" id="assets">자산</a></li>
                                                <li><a href="calculator" id="calculator">계산기</a>
                                                	<ul class="submenu">
                                                        <li><a href="myCalculator">나의 기업관리</a></li>
                                                        <li><a href="target">적정주가계산</a></li>
                                                        <li><a href="calculator">계산기</a></li>
                                                    </ul>
                                                </li>
                                                <li><a href="subList" id="subList">구독목록</a></li>
                                                <li><a href="leaderboards" id="leaderboards">투자랭킹</a></li>
                                                <li><a href="boardList" id="boardList">게시판</a></li>
                                                <sec:authorize access="hasRole('ROLE_USER')">
												    <li><a id="modify">마이페이지</a>
												    	<ul class="submenu">
	                                                        <li><a href="addAccount">계좌 추가</a></li>
	                                                        <li><a href="modify">회원정보수정</a></li>
	                                                        <li><a href="purchaseDetails">구매/입금내역</a></li>
                                                    	</ul>
												    </li>
												</sec:authorize>
												<sec:authorize access="hasRole('ROLE_ADMIN')">
												    <li><a href="profits-admin" id="profits-admin">관리자모드</a>
												    	<ul class="submenu">
	                                                        <li><a href="profits-admin">매출관리</a></li>
	                                                        <li><a href="stats-admin">통계관리</a></li>
	                                                        <li><a href="write_notice">공지등록</a></li>
                                                    	</ul>
												    </li>
												</sec:authorize>
                                            </ul>
                                        </nav>
                                    </div>
                                    <!-- Header-btn -->
                                    <div class="header-right-btn d-none d-lg-block ml-20">
                                    	<sec:authorize access="isAnonymous()">
											<c:url value="/loginForm" var="loginForm" />
											<div class="log-box-1">
												<a class="btn header-btn" href="${loginForm}">로그인</a>
											</div>
										</sec:authorize>
										<sec:authorize access="isAuthenticated()">
											<sec:authentication var="principal" property="principal"/>
											<div class="log-box-2"> 
										    		<button class="btn header-btn" id="logout-btn">로그아웃 </button>
										    </div>
										</sec:authorize>
                                    </div>
                                </div>
                            </div> 
                            <!-- Mobile Menu -->
                            <div class="col-12">
                                <div class="mobile_menu d-block d-lg-none"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Header End -->
    </header>
    
    <!-- header end -->
    
    <script>   
    
  		// Get current URL
	    var href = document.location.href;
	
	 	// Get last part of current URL
	 	var page = href.substring(href.lastIndexOf('/') + 1);
	 	console.log(page);
	 	
	 	var hrefArr = ['accountTransaction', 'salaryList', 'assets', 'calculator', 'subList', 'leaderboards', 'boardList', 'modify', 'profits-admin'];

	 	console.log(hrefArr);
	 	
	 	//nav바 하이라이트
	 	for(i = 0; i < hrefArr.length; i++){
	 		if(page == hrefArr[i]){
	 			console.log("This page is " + hrefArr[i]);
		 		$('#'+hrefArr[i]).addClass('activated');
	 		} else{
	 			$('#'+hrefArr[i]).removeClass('activated');
	 		}
	 	}
	 	
	 	if(page == 'myCalculator' || page == 'target'){
	 		$('#calculator').addClass('activated');
	 	} else {
	 		$('#calculator').removeClass('activated');
	 		if(page == 'calculator'){
	 			$('#calculator').addClass('activated');
	 		}
	 	} 
	 	
	 	if(page == 'addAccount'){
	 		$('#modify').addClass('activated');
	 	} else {
	 		$('#modify').removeClass('activated');
	 		if(page == 'modify'){
	 			$('#modify').addClass('activated');
	 		}
	 	}
	 	
	 	if(page == 'write_notice' || page == 'stats-admin'){
	 		$('#profits-admin').addClass('activated');
	 	} else {
	 		$('#profits-admin').removeClass('activated');
	 		if(page == 'profits-admin'){
	 			$('#profits-admin').addClass('activated');
	 		}
	 	}

    </script>

    <!-- Scroll Up -->
    <div id="back-top" >
        <a title="Go to Top" href="#"> <i class="fas fa-level-up-alt"></i></a>
    </div>

    <!-- JS here -->

    <script src="${pageContext.request.contextPath}/resources/main/assets/js/vendor/modernizr-3.5.0.min.js"></script>
    
    <!-- Jquery, Popper, Bootstrap -->
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/vendor/jquery-1.12.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/bootstrap.min.js"></script>
    
    <!-- Jquery Mobile Menu -->
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/jquery.slicknav.min.js"></script>

    <!-- Jquery Slick , Owl-Carousel Plugins -->
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/slick.min.js"></script>
    
    <!-- One Page, Animated-HeadLin -->
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/wow.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/animated.headline.js"></script>
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/jquery.magnific-popup.js"></script>

    <!-- Date Picker -->
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/gijgo.min.js"></script>
    
    <!-- Nice-select, sticky -->
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/jquery.nice-select.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/jquery.sticky.js"></script>
    
    <!-- Progress -->
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/jquery.barfiller.js"></script>
    
    <!-- counter , waypoint,Hover Direction -->
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/jquery.counterup.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/jquery.countdown.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/hover-direction-snake.min.js"></script>

    <!-- contact js -->
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/contact.js"></script>
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/jquery.form.js"></script>
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/mail-script.js"></script>
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/jquery.ajaxchimp.min.js"></script>
    
    <!-- Jquery Plugins, main Jquery -->	
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/plugins.js"></script>
    <script src="${pageContext.request.contextPath}/resources/main/assets/js/main.js"></script>
    
    <script>
			function numberPad(n, width) {
			    n = n + '';
			    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
			}	
		
			var date = new Date();
			var year = date.getFullYear();
			var month = numberPad((date.getMonth()+1), 2);
			
			$(function() {
				$("#accountTransaction").attr("onclick", "location.href='accountTransaction-"+year+"-"+month+"'");
			});
		
			$(function() {
				$("#salaryList").attr("onclick", "location.href='salaryList-"+year+"-"+month+"'");
			});
	</script>
    </body>
</html>