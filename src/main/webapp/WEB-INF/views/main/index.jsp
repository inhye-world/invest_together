<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  

<!doctype html>
<html class="no-js">
<head>
	<style>
		.point{
			cursor:pointer;
		}
	</style>

	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
	
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title> 같이투자 | 메인</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="manifest" href="site.webmanifest">
    <link rel="shortcut icon" type="image/x-icon" href="resources/main/assets/img/favicon.ico">

	<!-- CSS here -->
	<link rel="stylesheet" href="resources/main/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/main/assets/css/owl.carousel.min.css">
	<link rel="stylesheet" href="resources/main/assets/css/slicknav.css">
    <link rel="stylesheet" href="resources/main/assets/css/flaticon.css">
    <link rel="stylesheet" href="resources/main/assets/css/progressbar_barfiller.css">
    <link rel="stylesheet" href="resources/main/assets/css/gijgo.css">
    <link rel="stylesheet" href="resources/main/assets/css/animate.min.css">
    <link rel="stylesheet" href="resources/main/assets/css/animated-headline.css">
	<link rel="stylesheet" href="resources/main/assets/css/magnific-popup.css">
	<link rel="stylesheet" href="resources/main/assets/css/fontawesome-all.min.css">
	<link rel="stylesheet" href="resources/main/assets/css/themify-icons.css">
	<link rel="stylesheet" href="resources/main/assets/css/slick.css">
	<link rel="stylesheet" href="resources/main/assets/css/nice-select.css">
	<link rel="stylesheet" href="resources/main/assets/css/style.css">
	
</head>

<body>
    <!-- ? Preloader Start -->
    <div id="preloader-active">
        <div class="preloader d-flex align-items-center justify-content-center">
            <div class="preloader-inner position-relative">
                <div class="preloader-circle"></div>
                <div class="preloader-img pere-text">
                    <img src="resources/main/assets/img/logo/loder.png" alt="">
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
                                    <a href="/into"><img src="resources/main/assets/img/logo/logo.png" alt=""></a>
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
                                                <li><a href="assets">자산</a></li>
                                                <li><a href="calculator">계산기</a>
                                                	<ul class="submenu">
                                                        <li><a href="myCalculator">나의 기업관리</a></li>
                                                        <li><a href="target">적정주가계산</a></li>
                                                        <li><a href="calculator">계산기</a></li>
                                                    </ul>
                                                </li>
                                                <li><a href="blog.html">구독목록</a></li>
                                                <li><a href="leaderboards">투자랭킹</a></li>
                                                <li><a href="boardList">게시판</a></li>

                                                <sec:authorize access="hasRole('ROLE_USER')">
												    <li><a id="modify">마이페이지</a>
												    	<ul class="submenu">
	                                                        <li><a href="addAccount">계좌 추가</a></li>
	                                                        <li><a href="modify">회원정보수정</a></li>
	                                                        <li><a href="#">구매/입금내역</a></li>
                                                    	</ul>
												    </li>
												</sec:authorize>

												<sec:authorize access="hasRole('ROLE_ADMIN')">
												    <li><a href="profits-admin" id="profits-admin">관리자모드</a>
												    	<ul class="submenu">
	                                                        <li><a href="profits-admin">매출관리</a></li>
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
										    		<button type="button" class="btn header-btn" id="logoutBtn">로그아웃 </button>
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
    
    <main>
    <!-- slider Area Start-->
    <div class="slider-area">
        <div class="slider-active">
            <!-- Single Slider -->
            <div class="single-slider slider-height d-flex align-items-center">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-7 col-lg-7 col-md-8 col-sm-10">
                            <div class="hero__caption">
                                <h1 data-animation="fadeInUp" data-delay=".6s">같이투자와 <br>함께 하는 자산관리</h1>
                                <P data-animation="fadeInUp" data-delay=".8s" >현명한 자산관리, 같이투자와 함께 시작해요!</P>
                                <!-- Hero-btn -->
                                <div class="hero__btn">
                                	<sec:authorize access="isAnonymous()">
										<a href="registrationForm" class="btn hero-btn mb-10"  data-animation="fadeInLeft" data-delay=".8s">회원가입</a>
									</sec:authorize>
									<sec:authorize access="isAuthenticated()">
										<sec:authentication var="principal" property="principal"/>
										<P data-animation="fadeInUp" data-delay=".8s" >${principal.dto.name}님 , 반갑습니다</P>		
									</sec:authorize>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Single Slider -->
            <div class="single-slider slider-height d-flex align-items-center">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-6 col-lg-6 col-md-8 col-sm-10">
                            <div class="hero__caption">
                                <h1 data-animation="fadeInUp" data-delay=".6s">같이투자와<br>함께 하는 자산관리</h1>
                                <P data-animation="fadeInUp" data-delay=".8s" >현명한 자산관리, 같이투자와 함께 시작해요!</P>
                                <!-- Hero-btn -->
                                <div class="hero__btn">
                                    <a href="registrationForm" class="btn hero-btn mb-10"  data-animation="fadeInLeft" data-delay=".8s">회원가입</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- slider Area End-->
    
    <!--? Services Area Start -->
    <div class="service-area section-padding30">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-6 col-lg-7 col-md-10 col-sm-10">
                    <!-- Section Tittle -->
                    <div class="section-tittle text-center mb-80">
                        <span>What we are doing</span>
                        <h2>계좌 연동과 지출 분석으로 <br> 자산 관리를 편리하게!</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6 col-sm-6">
                    <div class="single-cat text-center mb-50">
                        <div class="cat-icon">
                            <span class="flaticon-null-1"></span>
                        </div>
                        <div class="cat-cap">
                            <h5><a href="accountBalance">가계부</a></h5>
                            <p>계좌를 연동해서 지출 내역을 관리하세요. </p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6">
                    <div class="single-cat active text-center mb-50">
                        <div class="cat-icon">
                            <span class="flaticon-think"></span>
                        </div>
                        <div class="cat-cap">
                            <h5><a href="calculator">계산기</a></h5>
                            <p>같이투자에서 제공하는 적정 주가 계산기로 편리하게 주식을 관리하세요.</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6">
                    <div class="single-cat text-center mb-50">
                        <div class="cat-icon">
                            <span class="flaticon-gear"></span>
                        </div>
                        <div class="cat-cap">
                            <h5><a href="leaderboards">투자 랭킹</a></h5>
                            <p>같이투자의 다양한 고객들은 어떻게 자산관리를 하고 있는지 구독을 통해 확인해보세요.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Services Area End -->

    
    <!--? Testimonial Start -->
    <div class="testimonial-area testimonial-padding">
        <div class="container">
            <!-- Testimonial contents -->
            <div class="row d-flex justify-content-center">
                <div class="col-xl-8 col-lg-8 col-md-10">
                    <div class="h1-testimonial-active dot-style">
                        <!-- Single Testimonial -->
                        <div class="single-testimonial text-center">
                            <div class="testimonial-caption ">
                                <!-- founder -->
                                <div class="testimonial-founder">
                                    <div class="founder-img mb-40">
                                        <img src="resources/main/assets/img/gallery/testimonial.png" alt="">
                                        <span>마가렛 로손</span>
                                        <p>32세 무직</p>
                                    </div>
                                </div>
                                <div class="testimonial-top-cap">
                                    <p>가치투자와 함께하고우 천마눤 모아써요우! 완전히 추천해요우! very good</p>
                                </div>
                            </div>
                        </div>
                        <!-- Single Testimonial -->
                        <div class="single-testimonial text-center">
                            <div class="testimonial-caption ">
                                <!-- founder -->
                                <div class="testimonial-founder">
                                    <div class="founder-img mb-40">
                                        <img src="resources/main/assets/img/gallery/testimonial.png" alt="">
                                        <span>Margaret Lawson</span>
                                        <p>Creative Director</p>
                                    </div>
                                </div>
                                <div class="testimonial-top-cap">
                                    <p>âI am at an age where I just want to be fit and healthy our bodies are our responsibility! So start caring for your body and it will care for you. Eat clean it will care for you and workout hard.â</p>
                                </div>
                            </div>
                        </div>
                        <!-- Single Testimonial -->
                        <div class="single-testimonial text-center">
                            <div class="testimonial-caption ">
                                <!-- founder -->
                                <div class="testimonial-founder">
                                    <div class="founder-img mb-40">
                                        <img src="resources/main/assets/img/gallery/testimonial.png" alt="">
                                        <span>Margaret Lawson</span>
                                        <p>Creative Director</p>
                                    </div>
                                </div>
                                <div class="testimonial-top-cap">
                                    <p>âI am at an age where I just want to be fit and healthy our bodies are our responsibility! So start caring for your body and it will care for you. Eat clean it will care for you and workout hard.â</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Testimonial End -->

    
    <!--? Count Down Start -->
    <div class="count-down-area pt-25 section-bg" data-background="resources/main/assets/img/gallery/background.png">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-12 col-md-12">
                    <div class="count-down-wrapper" >
                        <div class="row justify-content-between">
                            <div class="col-lg-3 col-md-6 col-sm-6">
                                <!-- Counter Up -->
                                <div class="single-counter text-center">
                                    <span class="counter color-green">200,000</span>
                                    <span class="plus">+</span>
                                    <p class="color-green">총 가입자 수</p>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6 col-sm-6">
                                <!-- Counter Up -->
                                <div class="single-counter text-center">
                                    <span class="counter color-green">1,000</span>
                                    <span class="plus">+</span>
                                    <p class="color-green">신규 가입자 수</p>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6 col-sm-6">
                                <!-- Counter Up -->
                                <div class="single-counter text-center">
                                    <span class="counter color-green">2,540,000</span>
                                    <span class="plus">+</span>
                                    <p class="color-green">누적 접속자 수</p>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6 col-sm-6">
                                <!-- Counter Up -->
                                <div class="single-counter text-center">
                                    <span class="counter color-green">2,560</span>
                                    <span class="plus">+</span>
                                    <p class="color-green">오늘 접속자 수</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Count Down End -->
    </main>
    
    <footer>
        <div class="footer-wrapper section-bg2" data-background="resources/main/assets/img/gallery/footer_bg.png">
            <!-- Footer Top-->
            <div class="footer-area footer-padding">
                <div class="container">
                    <div class="row d-flex justify-content-between">
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6">
                        <div class="single-footer-caption mb-50">
                            <div class="single-footer-caption mb-30">
                                <div class="footer-tittle">
                                    <div class="footer-logo mb-20">
                                        <a href="/into"><img src="resources/main/assets/img/logo/logo2_footer.png" alt=""></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                            <div class="single-footer-caption mb-50">
                                <div class="footer-tittle">
                                    <h4>Contact Info</h4>
                                    <ul>
                                        <li>
                                            <p>주소 : 서울특별시 서대분구 신촌로32길 14-4 대박빌딩 23층 235호</p>
                                        </li>
                                        <li><a href="#">전화번호 : +82 02 5555 5555</a></li>
                                        <li><a href="#">이메일 : info@investogether.com</a></li>
                                    </ul>
                                </div>

                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                            <div class="single-footer-caption mb-50">
                                <div class="footer-tittle">
                                    <h4>Important Link</h4>
                                    <ul>
                                        <li><a href="#">About Us</a></li>
                                        <li><a href="#">Contact Us</a></li>
                                        <li><a href="#">Support</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                            <div class="single-footer-caption mb-50">
                                <div class="footer-tittle">
                                    <h4>Newsletter</h4>
                                    <div class="footer-pera footer-pera2">
                                    <p>자산관리에 유용한 정보를 받아보세요!</p>
                                </div>
                                <!-- Form -->
                                <div class="footer-form" >
                                    <div id="mc_embed_signup">
                                        <form target="_blank" action="https://spondonit.us12.list-manage.com/subscribe/post?u=1462626880ade1ac87bd9c93a&amp;id=92a4423d01"
                                        method="get" class="subscribe_form relative mail_part">
                                            <input type="email" name="email" id="newsletter-form-email" placeholder="Email Address"
                                            class="placeholder hide-on-focus" onfocus="this.placeholder = ''"
                                            onblur="this.placeholder = ' Email Address '">
                                            <div class="form-icon">
                                                <button type="submit" name="submit" id="newsletter-submit"
                                                class="email_icon newsletter-submit button-contactForm"><img src="resources/main/assets/img/gallery/form.png" alt=""></button>
                                            </div>
                                            <div class="mt-10 info"></div>
                                        </form>
                                    </div>
                                </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- footer-bottom -->
            <div class="footer-bottom-area">
                <div class="container">
                    <div class="footer-border">
                        <div class="row d-flex justify-content-between align-items-center">
                            <div class="col-xl-10 col-lg-9 ">
                                <div class="footer-copy-right">
                                    <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                                </div>
                            </div>
                            <div class="col-xl-2 col-lg-3">
                                <div class="footer-social f-right">
                                    <a href="#"><i class="fab fa-twitter"></i></a>
                                    <a  href="https://www.facebook.com/sai4ull"><i class="fab fa-facebook-f"></i></a>
                                    <a href="#"><i class="fas fa-globe"></i></a>
                                    <a href="#"><i class="fab fa-behance"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    
    <script>
	$(function() {
		$("#logoutBtn").click(function(){
			$("#logout-form").submit();
		});
	});
	</script>

    <!-- Scroll Up -->
    <div id="back-top" >
        <a title="Go to Top" href="#"> <i class="fas fa-level-up-alt"></i></a>
    </div>

    <!-- JS here -->

    <script src="./resources/main/assets/js/vendor/modernizr-3.5.0.min.js"></script>
    <!-- Jquery, Popper, Bootstrap -->
    <script src="./resources/main/assets/js/vendor/jquery-1.12.4.min.js"></script>
    <script src="./resources/main/assets/js/popper.min.js"></script>
    <script src="./resources/main/assets/js/bootstrap.min.js"></script>
    <!-- Jquery Mobile Menu -->
    <script src="./resources/main/assets/js/jquery.slicknav.min.js"></script>

    <!-- Jquery Slick , Owl-Carousel Plugins -->
    <script src="./resources/main/assets/js/owl.carousel.min.js"></script>
    <script src="./resources/main/assets/js/slick.min.js"></script>
    <!-- One Page, Animated-HeadLin -->
    <script src="./resources/main/assets/js/wow.min.js"></script>
    <script src="./resources/main/assets/js/animated.headline.js"></script>
    <script src="./resources/main/assets/js/jquery.magnific-popup.js"></script>

    <!-- Date Picker -->
    <script src="./resources/main/assets/js/gijgo.min.js"></script>
    <!-- Nice-select, sticky -->
    <script src="./resources/main/assets/js/jquery.nice-select.min.js"></script>
    <script src="./resources/main/assets/js/jquery.sticky.js"></script>
    <!-- Progress -->
    <script src="./resources/main/assets/js/jquery.barfiller.js"></script>
    
    <!-- counter , waypoint,Hover Direction -->
    <script src="./resources/main/assets/js/jquery.counterup.min.js"></script>
    <script src="./resources/main/assets/js/waypoints.min.js"></script>
    <script src="./resources/main/assets/js/jquery.countdown.min.js"></script>
    <script src="./resources/main/assets/js/hover-direction-snake.min.js"></script>

    <!-- contact js -->
    <script src="./resources/main/assets/js/contact.js"></script>
    <script src="./resources/main/assets/js/jquery.form.js"></script>
    <script src="./resources/main/assets/js/jquery.validate.min.js"></script>
    <script src="./resources/main/assets/js/mail-script.js"></script>
    <script src="./resources/main/assets/js/jquery.ajaxchimp.min.js"></script>
    
    <!-- Jquery Plugins, main Jquery -->	
    <script src="./resources/main/assets/js/plugins.js"></script>
    <script src="./resources/main/assets/js/main.js"></script>
    
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