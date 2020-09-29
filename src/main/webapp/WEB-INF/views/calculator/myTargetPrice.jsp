<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>

<head>

	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
	
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  
  <!-- ajax사용 위해 csrf설정 -->
  <meta id="_csrf" name="_csrf" content="${_csrf.token}" />
  <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />

  <title>같이투자</title>

  <!-- Custom fonts for this template -->
  <link href="resources/sb_admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="resources/sb_admin/css/sb-admin-2.min.css" rel="stylesheet">

  <!-- Custom styles for this page -->
  <link href="resources/sb_admin/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">


</head>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">SB Admin <sup>2</sup></div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item">
        <a class="nav-link" href="index.html">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>Dashboard</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
        Interface
      </div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-fw fa-cog"></i>
          <span>Components</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Custom Components:</h6>
            <a class="collapse-item" href="buttons.html">Buttons</a>
            <a class="collapse-item" href="cards.html">Cards</a>
          </div>
        </div>
      </li>

      <!-- Nav Item - Utilities Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
          <i class="fas fa-fw fa-wrench"></i>
          <span>Utilities</span>
        </a>
        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Custom Utilities:</h6>
            <a class="collapse-item" href="utilities-color.html">Colors</a>
            <a class="collapse-item" href="utilities-border.html">Borders</a>
            <a class="collapse-item" href="utilities-animation.html">Animations</a>
            <a class="collapse-item" href="utilities-other.html">Other</a>
          </div>
        </div>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
        Addons
      </div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-fw fa-folder"></i>
          <span>Pages</span>
        </a>
        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Login Screens:</h6>
            <a class="collapse-item" href="login.html">Login</a>
            <a class="collapse-item" href="register.html">Register</a>
            <a class="collapse-item" href="forgot-password.html">Forgot Password</a>
            <div class="collapse-divider"></div>
            <h6 class="collapse-header">Other Pages:</h6>
            <a class="collapse-item" href="404.html">404 Page</a>
            <a class="collapse-item" href="blank.html">Blank Page</a>
          </div>
        </div>
      </li>

      <!-- Nav Item - Charts -->
      <li class="nav-item">
        <a class="nav-link" href="charts.html">
          <i class="fas fa-fw fa-chart-area"></i>
          <span>Charts</span></a>
      </li>

      <!-- Nav Item - Tables -->
      <li class="nav-item active">
        <a class="nav-link" href="tables.html">
          <i class="fas fa-fw fa-table"></i>
          <span>Tables</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Topbar Search -->
          <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
            <div class="input-group">
              <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
              <div class="input-group-append">
                <button class="btn btn-primary" type="button">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form>

          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">

            <!-- Nav Item - Search Dropdown (Visible Only XS) -->
            <li class="nav-item dropdown no-arrow d-sm-none">
              <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-search fa-fw"></i>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
                <form class="form-inline mr-auto w-100 navbar-search">
                  <div class="input-group">
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                      <button class="btn btn-primary" type="button">
                        <i class="fas fa-search fa-sm"></i>
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </li>

            <!-- Nav Item - Alerts -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-bell fa-fw"></i>
                <!-- Counter - Alerts -->
                <span class="badge badge-danger badge-counter">3+</span>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                <h6 class="dropdown-header">
                  Alerts Center
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-primary">
                      <i class="fas fa-file-alt text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 12, 2019</div>
                    <span class="font-weight-bold">A new monthly report is ready to download!</span>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-success">
                      <i class="fas fa-donate text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 7, 2019</div>
                    $290.29 has been deposited into your account!
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-warning">
                      <i class="fas fa-exclamation-triangle text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 2, 2019</div>
                    Spending Alert: We've noticed unusually high spending for your account.
                  </div>
                </a>
                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
              </div>
            </li>

            <!-- Nav Item - Messages -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-envelope fa-fw"></i>
                <!-- Counter - Messages -->
                <span class="badge badge-danger badge-counter">7</span>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown">
                <h6 class="dropdown-header">
                  Message Center
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/fn_BT9fwg_E/60x60" alt="">
                    <div class="status-indicator bg-success"></div>
                  </div>
                  <div class="font-weight-bold">
                    <div class="text-truncate">Hi there! I am wondering if you can help me with a problem I've been having.</div>
                    <div class="small text-gray-500">Emily Fowler · 58m</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/AU4VPcFN4LE/60x60" alt="">
                    <div class="status-indicator"></div>
                  </div>
                  <div>
                    <div class="text-truncate">I have the photos that you ordered last month, how would you like them sent to you?</div>
                    <div class="small text-gray-500">Jae Chun · 1d</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/CS2uCrpNzJY/60x60" alt="">
                    <div class="status-indicator bg-warning"></div>
                  </div>
                  <div>
                    <div class="text-truncate">Last month's report looks great, I am very happy with the progress so far, keep up the good work!</div>
                    <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="">
                    <div class="status-indicator bg-success"></div>
                  </div>
                  <div>
                    <div class="text-truncate">Am I a good boy? The reason I ask is because someone told me that people say this to all dogs, even if they aren't good...</div>
                    <div class="small text-gray-500">Chicken the Dog · 2w</div>
                  </div>
                </a>
                <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
              </div>
            </li>

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Valerie Luna</span>
                <img class="img-profile rounded-circle" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="#">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  Profile
                </a>
                <a class="dropdown-item" href="#">
                  <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                  Settings
                </a>
                <a class="dropdown-item" href="#">
                  <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                  Activity Log
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Logout
                </a>
              </div>
            </li>

          </ul>

        </nav>
        <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800">계산기</h1>

          <!-- DataTales -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">나의 적정 주가</h6>
            </div>
            <div class="card-body">
              
	          <!-- table script -->
	          <script type="text/javascript">
		          
		          function calculate(){
		        	 
		        	 	//null check
		        		// form안의 모든 text type 조회
				    var txtEle = $("#inputInfo input[type=text]");
				    	
				    for(var i = 0; i < txtEle.length; i ++){
				    	if("" == $(txtEle[i]).val() || null == $(txtEle[i]).val()){
					    	var ele_id = $(txtEle[i]).attr("id");
					    	//console.log("id : " + ele_id);
					    	showAlert(ele_id);
					    	return true;
				    	}
				    }
				    	
				    	
		        	  var material0 = parseInt(document.getElementById("ev").value);	//지배주주지분(기업가치)
		        	  var material1 = parseFloat(document.getElementById("roe").value);	//ROE
		        	  var material2 = parseInt(document.getElementById("ke").value);	//주주요구수익률
		        	  var material3 = parseInt(document.getElementById("shareIssued").value);	//발행주식수
		        	  //초과이익 = 기업가치 * (주주요구수익률 - 8%)
		        	  //기업가치 = 자기자본 + 초과이익 x w / (1+할인율-w)
		        	  //8%: 임의의 무위험수익률
		        	 
		        	  //초과이익
		        	  var material4 = material0*(material3 - 8);					
		        	  
		        	  //적정 주주가치
		        	  var material5 = material0 + material4/0.08;						
		        	  var material6 = material0 + material4*0.9/(1+0.08-0.9);
		        	  var material7 = material0 + material4*0.8/(1+0.08-0.8);
		        	  
		              //적정주가
		        	  var material8 = parseInt(material5/material3);								
		        	  var material9 = parseInt(material6/material3);
		        	  var material10 = parseInt(material7/material3);
		        	  
		        	  
		        	  document.getElementsByTagName('p')[0].innerHTML =
		                  '<div class="table-responsive">'+
		               	  '<table class="table table-bordered" width="100%" cellspacing="0">'+          
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
		                      '<td>'+material0+'억 원</td>'+
		                      '<td>'+material1+'%</td>'+
		                      '<td>'+material2+'%</td>'+
		                      '<td>'+material5+'억 원</td>'+
		                      '<td>'+material3+'주</td>'+
		                      '<td>'+material8+'원</td>'+
		                      '<td>매도</td></tr>'+
		                     '<tr><td>10%씩 감소</td>'+
		                      '<td>'+material0+'억 원</td>'+
		                      '<td>'+material1+'%</td>'+
		                      '<td>'+material2+'%</td>'+
		                      '<td>'+material6+'억 원</td>'+
		                      '<td>'+material3+'주</td>'+
		                      '<td>'+material9+'원</td>'+
		                      '<td>적정</td></tr>'+
		                    '<tr><td>20%씩 감소</td>'+
			                   '<td>'+material0+'억 원</td>'+
			                   '<td>'+material1+'%</td>'+
			                   '<td>'+material2+'%</td>'+
			                   '<td>'+material7+'억 원</td>'+
			                   '<td>'+material3+'주</td>'+
		                      '<td>'+material10+'원</td>'+
		                      '<td>매수</td></tr></tbody>'+
		                	'</table>'+
		             		'</div>';
		             		
		             		alert("저장되었습니다.");
		      		    } 
			
		        	//null값일 때 focus주기 
				    function showAlert(ele_id){
		
				    	var ele_name = $("#" + ele_id).attr('name');
				    	alert(ele_name + "을(를) 입력해주세요.");
		
				    	// 해당 id에 focus.
				    	$("#" + ele_id).focus();
				    }
		          
		          //숫자 validating 부동소수점 포함
		          $(document).on("input","input[id=ev]",function(){
						var ev_check = document.getElementById("ev").value;
		
			        	var num = /^[+]?\d+\.?\d*$/;
			          
				        if(!num.test(ev)) {
				        	alert("지배주주지분을 다시 입력해주세요");
				        	document.getElementById("ev").value = "";
			                return false;
				        } 
		      	    });
		    	  
		          $(document).on("input","input[id=roe]",function(){
						var roe_check = document.getElementById("roe").value;
		
			        	var num = /^[+]?\d+\.?\d*$/;
			          
				        if(!num.test(roe_check)) {
				        	alert("ROE를 다시 입력해주세요");
				        	document.getElementById("roe").value = "";
			                return false;
				        } 
		     		   });
		     	     
		          $(document).on("input","input[id=ke]",function(){
						var ke_check = document.getElementById("ke").value;
		
			        	var num = /^[+]?\d+\.?\d*$/;
			          
				        if(!num.test(ke_check)) {
				        	alert("주주요구수익률을 다시 입력해주세요");
				        	document.getElementById("ke").value = "";
			                return false;
				        } 
		       		 });
		          
		          $(document).on("input","input[id=shareIssued]",function(){
						var shareIssued_check = document.getElementById("shareIssued").value;
		
			        	var num = /^[+]?\d+\.?\d*$/;
			          
				        if(!num.test(shareIssued_check)) {
				        	alert("발행주식수를 다시 입력해주세요");
				        	document.getElementById("shareIssued").value = "";
			                return false;
				        } 
		       		 });
		
				function refresh(){
					document.getElementById("ev").value = "";
					document.getElementById("roe").value = "";
					document.getElementById("ke").value = "";
					document.getElementById("shareIssued").value = "";
					
					document.getElementsByTagName('p')[0].innerHTML = "";
				}
				
			</script>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

      <!-- Footer -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; Your Website 2019</span>
          </div>
        </div>
      </footer>
      <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="resources/sb_admin/vendor/jquery/jquery.min.js"></script>
  <script src="resources/sb_admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="resources/sb_admin/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="resources/sb_admin/js/sb-admin-2.min.js"></script>

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
    