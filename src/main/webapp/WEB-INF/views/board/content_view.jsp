<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
   <meta charset="utf-8">
   <meta http-equiv="x-ua-compatible" content="ie=edge">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <title> Charity | Teamplate</title>
   <meta name="description" content="">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="shortcut icon" type="image/x-icon" href="resources/main/assets/img/favicon.ico">

  <!-- CSS here -->
   <link rel="stylesheet" href="resources/main/assets/css/bootstrap.min.css">
   <link rel="stylesheet" href="resources/main/assets/css/owl.carousel.min.css">
   <link rel="stylesheet" href="resources/main/assets/css/slicknav.css">
   <link rel="stylesheet" href="resources/main/assets/css/animate.min.css">
   <link rel="stylesheet" href="resources/main/assets/css/hamburgers.min.css">
   <link rel="stylesheet" href="resources/main/assets/css/magnific-popup.css">
   <link rel="stylesheet" href="resources/main/assets/css/fontawesome-all.min.css">
   <link rel="stylesheet" href="resources/main/assets/css/themify-icons.css">
   <link rel="stylesheet" href="resources/main/assets/css/slick.css">
   <link rel="stylesheet" href="resources/main/assets/css/nice-select.css">
   <link rel="stylesheet" href="resources/main/assets/css/style.css">
</head>

<body>
   <!--? Preloader Start -->
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
                                                <li><a href="about.html">가계부</a></li>
                                                <li><a href="program.html">월급관리</a></li>
                                                <li><a href="events.html">주식/채권</a></li>
                                                <li><a href="blog.html">계산기</a></li>
                                                <li><a href="blog.html">구독목록</a></li>
                                                <li><a href="blog.html">투자랭킹</a></li>
                                                <li><a onclick="location.href='${pageContext.request.contextPath}/boardList'">게시판</a></li>
                                            </ul>
                                        </nav>
                                    </div>
                                    <!-- Header-btn -->
                                    <div class="header-right-btn d-none d-lg-block ml-20">
                                        <a href="loginForm" class="btn header-btn">로그인</a>
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
   <main>
      <!--? Blog Area Start -->
         <div class="container">
               <div class="col-lg-11 posts-list">
                  <div class="single-post">       
                     <div class="blog_details">
                        <h2 style="color: #2d2d2d;">${content_view.board_title}</h2>
                        <ul class="blog-info-link mt-3 mb-4">
                           <li><a href="#"><i>작성자:</i>${content_view.board_name}</a></li>
                           <li><a href="#"><i>작성일:</i><fmt:formatDate value="${content_view.board_date}"/></a></li>
                           <li><a href="#"><i>조회수:</i>${content_view.board_hit}</a></li>
                        </ul>
                        <p class="excert">
                           ${content_view.board_content}
                        </p>
                     </div>
                  </div>
				  <br>
                  <a class="button button-contactForm btn_1 boxed-btn" onclick="location.href='modify_view?board_num=${content_view.board_num}'">수정</a> &nbsp;&nbsp; 
                  <a class="button button-contactForm btn_1 boxed-btn" onclick="location.href='boardDelete?board_num=${content_view.board_num}'">삭제</a> &nbsp;&nbsp; 
				  <a class="button button-contactForm btn_1 boxed-btn" onclick="location.href='${pageContext.request.contextPath}/boardList'">목록보기</a>                
                  <div class="navigation-top">
                  <div class="comments-area">
                     <h4>${total} comments</h4>
                     <c:forEach items="${comments}" var="dto">
                     <div class="comment-list" id="${dto.comment_num}">
                        <div class="single-comment justify-content-between d-flex">
                           <div class="user justify-content-between d-flex">
                              <div class="thumb">
                                 <img src="resources/main/assets/img/blog/comment_1.png" alt="">
                              </div>
                              <div class="desc">
                                 <p class="comment">
                                    ${dto.comment_content}
                                 </p>
                                 <div class="d-flex justify-content-between">
                                    <div class="d-flex align-items-center">
                                       <h5>
                                          <a href="#">Emilly Blunt</a>
                                       </h5>
                                       <a class="date"><fmt:formatDate value="${dto.comment_date}" dateStyle="full" /></a>
                                    </div>
                                    <div class="reply-btn">&nbsp;&nbsp;
                                       <a type="button" class="btn-modity" onmouseover="this.style.color='#09CC7F'" onmouseout="this.style.color='black'">수정</a>
                                    </div>
                                    <div>&nbsp;&nbsp;
                                       <a type="button" class="btn-delete" onclick="location.href='${pageContext.request.contextPath}/delete_comments?board_num=${content_view.board_num}&comment_num=${dto.comment_num}'" onmouseover="this.style.color='#09CC7F'" onmouseout="this.style.color='black'">삭제</a>
                                    </div>
                                 </div>
                              </div>
                           </div> 
                        </div>
                     </div>
                     <div id="comments-${dto.comment_num}">
                     	<div class="reply-comments" style="display: none;">
                        	<form:form class="reply-comments-form" action="modify_comments" id="commentForm">
                       	<div class="col-12">
                          <div class="form-group">
                             <textarea class="form-control w-100" name="comment_content" id="comment" cols="100" rows="3"
                                placeholder="${dto.comment_content}"></textarea>
		                  </div>
		                </div>
		                  <div class="form-group">
		                     <input type="hidden" name="comment_num" value="${dto.comment_num}"> 
		                     <input type="hidden" name="board_num" value="${content_view.board_num}">
		                     <button type="submit" class="button button-contactForm btn_1 boxed-btn">수정하기</button>
                    	  </div>
              				</form:form>
                       	</div>
                     </div>        
                     <script>
                     	$("#"+${dto.comment_num}+" .btn-modity").click(function() {
                     		$("#comments-"+${dto.comment_num}+" .reply-comments").css("display", "block");
                     	});
                     </script>                  
                     </c:forEach>
                     <ul class="pagination">
                      <c:if test="${content_view.board_num eq pageMaker.board_num}">
						<c:if test="${pageMaker.prev}">
							<li class="page-item">
						      	<a class="page-link" href="content_view${pageMaker.makeQuery(pageMaker.startPage - 1) }?board_num=${content_view.board_num}" aria-label="Previous">
							        <span aria-hidden="true">&laquo;</span>
							        <span class="sr-only">Previous</span>
						    	</a>
						    </li>
						</c:if>
						
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
							<li><c:out value="${pageMaker.cri.page_num == idx?'':''}" /><a class="page-link" href="content_view?board_num=${content_view.board_num}&${pageMaker.makeQuery(idx)}">${idx}</a></li>
						</c:forEach>
						
						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li class="page-item">
							    <a class="page-link" href="content_view${pageMaker.makeQuery(pageMaker.endPage +1) }?board_num=${content_view.board_num}" aria-label="Next">
								    <span aria-hidden="true">&raquo;</span>
								    <span class="sr-only">Next</span>
							    </a>
							</li>
						</c:if>
					  </c:if>
					</ul>
                  </div>
                  <div class="comment-form">
                     <h4>Leave a Reply</h4>
                     <form:form class="form-contact comment_form" action="writeComment" id="commentForm">
                           <div class="col-12">
                              <div class="form-group">
                                 <textarea class="form-control w-100" name="comment_content" id="comment" cols="30" rows="9" placeholder="Write Comment"></textarea>
                              </div>
                           </div>
                        <div class="form-group">
                           <input type="hidden" name="board_num" value="${content_view.board_num}">
                           <button type="submit" class="button button-contactForm btn_1 boxed-btn">댓글 입력</button>
                        </div>
                     </form:form>
                  </div>
               </div>
            </div>  
      <!-- Blog Area End -->
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
                                      <a href="index.html"><img src="resources/main/assets/img/logo/logo2_footer.png" alt=""></a>
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
                                          <p>Address :Your address goes here, your demo address.</p>
                                      </li>
                                      <li><a href="#">Phone : +8880 44338899</a></li>
                                      <li><a href="#">Email : info@colorlib.com</a></li>
                                  </ul>
                              </div>

                          </div>
                      </div>
                      <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                          <div class="single-footer-caption mb-50">
                              <div class="footer-tittle">
                                  <h4>Important Link</h4>
                                  <ul>
                                      <li><a href="#"> View Project</a></li>
                                      <li><a href="#">Contact Us</a></li>
                                      <li><a href="#">Testimonial</a></li>
                                      <li><a href="#">Proparties</a></li>
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
                                  <p>Heaven fruitful doesn't over lesser in days. Appear creeping.</p>
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
   </body>
</html>