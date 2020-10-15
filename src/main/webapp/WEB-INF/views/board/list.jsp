<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="utf-8">
	    <meta http-equiv="x-ua-compatible" content="ie=edge">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	    <title> 같이투자 | 메인</title>
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

	<style>
	
		.table .title{
			font-weight: bold;
		    background-color: whitesmoke;
		}
	
		.container{
			padding-top: 100px;
		}
	
		.pagination {
	    	justify-content: center;
	    	padding-bottom: 100px;
		}
		
		.hero-cap h2 {
		    color: #072366;
		    font-size: 35px;
		    font-weight: 600;
		    text-transform: capitalize;
		    line-height: 1;
		    padding-bottom: 30px;
		}
		
		
	</style>
	
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
                                                <li><a href="accountBalance">가계부</a></li>
                                                <li><a href="program.html">월급관리</a></li>
                                                <li><a href="stockBondTable">주식</a></li>
                                                <li><a href="bond">채권</a></li>
                                                <li><a href="calculator">계산기</a></li>
                                                <li><a href="blog.html">구독목록</a></li>
                                                <li><a href="leaderboards">투자랭킹</a></li>
                                                <li><a href="boardList">게시판</a></li>
                                                <sec:authorize access="isAuthenticated()">
												    <li><a href="user/myPage">마이페이지</a></li>
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
		    <div class="container">
		    <div class="hero-cap">
                 <h2>자유게시판</h2>
            </div>     
				<table class="table">
					<tr class="title">
						<td>글번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>작성일</td>
						<td>조회수</td>
					</tr>
					<c:forEach items="${list}" var="dto">
					<tr id="content" onmouseover="this.style.backgroundColor='rgba(9, 204, 127, 0.4)'" onmouseout="this.style.backgroundColor='white'" onclick="location.href='content_view?board_num=${dto.board_num}'">
						<td>${dto.board_num}</td>
						<td>${dto.board_title}</td>
						<td>${dto.board_name}</td>
						<td><fmt:formatDate value="${dto.board_date}" dateStyle="full" /></td>
						<td>${dto.board_hit}</td>
					</tr>
					</c:forEach>
				</table>
				<tr>
					<td colspan="5"> <input class="button button-contactForm btn_1 boxed-btn" onclick="location.href='write_view'" type="button" value="글작성"/> </td>
				</tr>
			</div>			
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li class="page-item">
				      	<a class="page-link" href="boardList${pageMaker.makeQuery(pageMaker.startPage - 1) }" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					        <span class="sr-only">Previous</span>
				    	</a>
				    </li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					<li><c:out value="${pageMaker.cri.page_num == idx?'':''}" /><a class="page-link" href="boardList${pageMaker.makeQuery(idx)}">${idx}</a></li>
				</c:forEach>
				
				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li class="page-item">
					    <a class="page-link" href="boardList${pageMaker.makeQuery(pageMaker.endPage +1) }" aria-label="Next">
						    <span aria-hidden="true">&raquo;</span>
						    <span class="sr-only">Next</span>
					    </a>
					</li>
				</c:if>
			</ul>
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
	$(function() {
		$("#logoutBtn").click(function(){
			$("#logout-form").submit();
		});
	});
	</script>	
		
	</body>
</html>