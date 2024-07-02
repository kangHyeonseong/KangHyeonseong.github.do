<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <% 
        String userID = (String) session.getAttribute("userID");
  		String userName = (String) session.getAttribute("userName");
    %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"> <!-- 참조  -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom.css">
<title>돼지름길</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <style>
        
         body {
            font-family: Arial, sans-serif;
        }
        .floor-plan {
            width: 100%;
            max-width: 1000px;
            margin: 0 auto;
            position: relative;
        }
        .table {
            width: 80px;
            height: 100px;
            border: 2px solid #343a40;
            position: absolute;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
            border-radius: 10px;
        }
        .table.available {
            background-color: #28a745; /* 예약 가능할 때 초록색 */
            color: #fff;
        }
        .table.reserved {
            background-color: gray; /* 예약된 테이블은 빨간색 */
            color: #fff;
        }
        .chair {
            width: 20px;
            height: 20px;
            background-color: #343a40;
            border-radius: 50%;
            position: absolute;
        }
        .chair-left-top {
            left: -30px;
            top: 10px;
        }
        .chair-left-bottom {
            left: -30px;
            bottom: 10px;
        }
        .chair-right-top {
            right: -30px;
            top: 10px;
        }
        .chair-right-bottom {
            right: -30px;
            bottom: 10px;
        }
        /* 레이어 팝업 스타일 */
        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border: 1px solid #ccc;
            z-index: 1000;
            width: 300px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-radius: 12px;
        }
        .popup h2 {
            font-size: 18px;
            margin-bottom: 15px;
        }
        .popup label {
            display: block;
            margin-bottom: 10px;
        }
        .popup input[type="number"],
        .popup select {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .popup button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            cursor: pointer;
            border-radius: 4px;
        }
        .popup button:hover {
            background-color: #0056b3;
        }
        .close {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
        }
         .menu-name {
            font-size: 24px;
            font-weight: bold;
            color: #444;
        }
        .menu-price {
            font-size: 18px;
            color: #D3B484; /* 메인 컬러 */
        }
        .menu-description {
            font-size: 16px;
            color: #666;
        }
        .modal-content {
            background-color: #fff;
            border-radius: 10px;
        }
        .menu-item {
         	padding: 20px;
            background-color: #ffffff;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
        }
         .menu-img {
           	max-width: 100%;
            height: auto;
            display: block;
            margin: 0 auto;
            margin-bottom: 10px;
            border-radius: 10px;
        }
        
           .loading-bar-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background-color: #f3f3f3;
            z-index: 9999;
        }
        .loading-bar {
            height: 100%;
            background-color: black;
            width: 0;
        }
        .scroll::-webkit-scrollbar {
		  display: none;
		}
		.navbar-item {
            color: white;
            padding: 10px;
            cursor: pointer;
        }
        .navbar-item.active {
            background-color: #555;
            border-radius: 5px;
        }
        
        .menu-board {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-top: 20px;
        }
        .menu-board h1 {
            font-size: 36px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 40px;
            color: #444;
        }
        .box {
               border: 5px solid #808080;
                border-top: none;
                padding: 14px;
                width: 315px;
                border-radius: 3px;
                margin: 0 auto;
                margin-bottom: -18px;
                background-color: rgba(255, 255, 255, 0.1);
                z-index: 999;
                position: relative;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                margin-bottom: -10%;
                margin-top: 5%;
        }
        .movie{
        	position: relative;
		    display: table;
		    width: 100%;
		    height: 100vh;
		    background: #000;
		    overflow: hidden;
        }
    </style>
    <script>
    
    document.addEventListener("DOMContentLoaded", function() {
        var targetElement = document.getElementById("myCarousel");
        if (targetElement) {
            targetElement.scrollIntoView({ behavior: "smooth" });
        }
    });
    
    window.onscroll = function() {
        var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
        var scrollHeight = document.documentElement.scrollHeight || document.body.scrollHeight;
        var clientHeight = document.documentElement.clientHeight || window.innerHeight;
        var scrollPercent = (scrollTop / (scrollHeight - clientHeight)) * 100;
        document.getElementById('loading-bar').style.width = scrollPercent + '%';
        
        
        var menuItems = document.querySelectorAll('[data-name="menu-var"]');
        var navbarItems = document.querySelectorAll('.navbar-item');
        menuItems.forEach((item, index) => {
            var rect = item.getBoundingClientRect();
            if (rect.top >= 0 && rect.bottom <= window.innerHeight) {
                navbarItems.forEach(navItem => navItem.classList.remove('active'));
                navbarItems[index].classList.add('active');
//  					if (navbarItems[index]) {
// 				            navbarItems[index].classList.add('active');
// 				        	} else {
// 				            console.error(`navbarItems[${index}] is undefined`);
// 				        }
            }
        });
    };
    
    $(document).ready(function() {
    	
    	 var tableList = ${tableList}; // tableList 데이터를 JavaScript 변수에 할당
         // tableList의 각 항목을 반복하며 HTML을 생성하여 출력
      	for (var i = 0; i < tableList.length; i++) {
    	    var item = tableList[i];
    	    $('#table-' + item.tableid).removeClass('available').addClass('reserved').text('예약 완료');
    	}
    	
        // 테이블 클릭 시 팝업 열기
        $('.table').click(function() {
        	 var userID = "<%= userID %>";
             if(userID == "" || userID == "null"){
             	alert("로그인 후 사용바랍니다.");
             	openLoginModal();
             	return;
             }
            var tableId = $(this).attr('id'); // 클릭한 테이블의 ID 가져오기
            if($('#' + tableId).text() == "예약 완료"){
            	alert("예약이 완료된 좌석입니다.");
            	return;
            }
            $('#popup-' + tableId).fadeIn(); // 해당 테이블에 대응하는 팝업 보이기
        });

        // 팝업 닫기
        $('.close').click(function() {
            $(this).parent('.popup').fadeOut(); // 클릭한 팝업 닫기
        });

        // 예약하기 버튼 클릭 시 처리 (임시 구현)
        $('.popup button').click(function() {
            var popup = $(this).closest('.popup');
            var tableId = popup.data('table-id'); // 팝업의 ID에서 숫자 부분 추출
            var numberOfPeople = $('#numberOfPeople-' + tableId).val(); // 인원 수 가져오기
            var reservationTime = $('#reservationTime-' + tableId).val(); // 예약 시간 가져오기
            var userID = "<%= userID %>";
            if(userID == "" || userID == "null"){
            	alert("로그인 후 사용바랍니다.");
            	return;
            }
            if(tableId == ""){
            	alert("테이블 선택 바랍니다.");
            	return;
            }
            if(numberOfPeople == ""){
            	alert("인원수를 체크 해주세요.");
            	return;
            }
            if(reservationTime == ""){
            	alert("예약 시간을 설정해주세요.");
            	return;
            }
            var formData = {
            		userID: userID,
            		tableid: tableId,
                    number_of_people: numberOfPeople,
                    reservation_Time: reservationTime
                };
            $.ajax({
                type: 'POST',
                url: '/TableProcess',
                data: formData,
                success: function(response) {
                        alert(reservationTime + "분 , " + numberOfPeople + "명 예약이 완료되었습니다.");
                     // 예약 완료 시 테이블 상태 변경 (여기서는 클래스만 추가하여 색 변경)
                        $('#table-' + tableId).removeClass('available').addClass('reserved');
                        location.reload();
                },
                error: function(xhr, status, error) {
                    // 로그인 실패 시 처리
                    alert('예약실패: ' + xhr.responseText);
                }
            });
            // 팝업 닫기
            popup.fadeOut();
        });
    });
    
        function openLoginModal() {
            $('#loginModal').modal('show');
        	}
        
        function openMember() {
            $('#MemberModal').modal('show');
        	}
        
        // 로그인
        function submitLoginForm() {
            var formData = $('#loginForm').serialize();
            $.ajax({
                type: 'POST',
                url: '/loginProcess',
                data: formData,
                success: function(response) {
                    // 로그인 성공 시 처리
                    alert('로그인 성공');
                    $('#loginModal').modal('hide');
                    // 페이지 리로드 또는 추가 작업
                    location.reload(); // 예시로 페이지 리로드
                },
                error: function(xhr, status, error) {
                    // 로그인 실패 시 처리
                    alert('로그인 실패: ' + xhr.responseText);
                }
            });
        }
        
        // 회원가입       
        function submitMemberForm() {
            var formData = $('#MemberForm').serialize();
            var memberCheck =  $('#memberYN').val();
            if(memberCheck =="N"){
                alert("아이디 여부확인을 진행해주세요 ");
                return;
            }
            if($('#member_userID').val().trim() == ""){
                alert("아이디를 입력해 주세요");
                return;
            }
            if($('#member_userPassword').val() == ""){
                alert("비밀번호를 입력해 주세요");
                return;
            }
            if($('#member_userName').val() == ""){
                alert("성함을 입력해 주세요");
                return;
            }
            if($('#member_userEmail').val() == ""){
                alert("이메일을 입력해 주세요");
                return;
            }
            $.ajax({
                type: 'POST',
                url: '/MemberProcess',
                data: formData,
                success: function(response) {
                    // 로그인 성공 시 처리
                    alert('회원가입 성공');
                    $('#loginModal').modal('hide');
                    // 페이지 리로드 또는 추가 작업
                    location.reload(); // 예시로 페이지 리로드
                },
                error: function(xhr, status, error) {
                    // 로그인 실패 시 처리
                    alert('회원가입 실패: ' + xhr.responseText);
                }
            });
        }
        
        // 아이디 체크 
        function MemberCheck() {
            if($('#member_userID').val().trim() == ""){
                alert("아이디를 입력해 주세요");
                return;
            }
            var formData = $('#MemberForm').serialize();
            $.ajax({
                type: 'POST',
                url: '/MemberCheckProcess',
                data: formData,
                success: function(response) {
                    if(response =="failure"){
                        alert("이미 사용중인 아이디 입니다");
                    } else if(response =="success"){
                        alert("사용 가능한 아이디 입니다");
                        $('#memberYN').val("Y");
                        $('#memberbutton').removeClass('btn btn-default').addClass('btn btn-success');
                    }
                },
                error: function(xhr, status, error) {
                    // 로그인 실패 시 처리
                    alert('로그인 실패: ' + xhr.responseText);
                }
            });
        }
        
        // 로그아웃    
        function logout() {
            $.ajax({
                type: 'POST',
                url: '/logoutProcess',
                success: function(response) {
                    // 로그인 성공 시 처리
                    alert('로그아웃 되었습니다');
                    location.reload(); // 예시로 페이지 리로드
                },
                error: function(xhr, status, error) {
                    // 로그인 실패 시 처리
                    alert('로그아웃 실패' + xhr.responseText);
                }
            });
        }
        
        function navmenu(val){
        	$('#' + val).focus();
//         	$('#').focus();
        }
    </script>
</head>
<body class="scroll" style="background-color: black;">
	<div class="loading-bar-container">
        <div class="loading-bar" id="loading-bar"></div>
    </div>
    <nav class="navbar navbar-default navbar-fixed-top" style="background-color: #ffffff; min-height: 95px;">
        <div class="navbar-header"> <!-- 홈페이지의 로고 -->
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
                <span class="icon-bar"></span> <!-- 줄였을때 옆에 짝대기 -->
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <img width="319" height="85" src="resources/images/piglogo.jpg"/>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" style="margin-top: 16px; font-weight: bold;">
            <% if (userID == null) { %>
                <ul class="nav navbar-nav navbar-right">
	                <li><a href="/" class="navbar-item" id="nav-item-1">메인</a></li> <!-- 메인 페이지 -->
	                <li><a class="navbar-item" id="nav-item-2" onclick="navmenu('menu2')">예약현황</a></li>
	                <li><a class="navbar-item" id="nav-item-3" onclick="navmenu(menu3)">예약</a></li>
	                <li><a class="navbar-item" id="nav-item-5" onclick="navmenu(menu5)">메뉴판</a></li>
	                <li><a class="navbar-item" id="nav-item-4" onclick="navmenu(menu4)">찾아오시는 길</a></li>
                    <li><a href="#" onclick="openLoginModal()">로그인</a></li>
                    <li><a href="#" onclick="openMember()">회원가입</a></li>
                </ul>
            <% } else { %>
                <ul class="nav navbar-nav navbar-right">
                	<li><a href="/" class="navbar-item" id="nav-item-1">메인</a></li> <!-- 메인 페이지 -->
	                <li><a class="navbar-item" id="nav-item-2" onclick="navmenu(menu2)">예약현황</a></li>
	                <li><a class="navbar-item" id="nav-item-3" onclick="navmenu(menu3)">예약</a></li>
	                <li><a class="navbar-item" id="nav-item-5" onclick="navmenu(menu5)">메뉴판</a></li>
	                <li><a class="navbar-item" id="nav-item-4" onclick="navmenu(menu4)">찾아오시는 길</a></li>
                	<li><a><%= userName %> 님 환영합니다</a></li>
                    <li><a href="#" onclick="logout()">로그아웃</a></li>
                </ul>
            <% } %>
        </div>
    </nav>

    <!-- Login Modal -->
    <div id="loginModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">로그인</h4>
                </div>
                <div class="modal-body">
                    <!-- 로그인 폼 -->
                    <form id="loginForm">
                        <div class="form-group">
                            <label for="username">아이디:</label>
                            <input type="text" class="form-control" id="userID" name="userID">
                        </div>
                        <div class="form-group">
                            <label for="password">비밀번호:</label>
                            <input type="password" class="form-control" id="userPassword" name="userPassword">
                        </div>
                        <button type="button" class="btn btn-default" onclick="submitLoginForm()">로그인</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Member Modal -->
    <div id="MemberModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">회원가입</h4>
                </div>
                <div class="modal-body">
                    <!-- 로그인 폼 -->
                    <form id="MemberForm">
                        <div class="form-group">
                            <label for="username">아이디:</label>
                            <input type="text" class="form-control" style="width: 75%;" id="member_userID" name="userID">
                            <button type="button" id="memberbutton" class="btn btn-default" style="margin-top: -10%; margin-left: 86%;" onclick="MemberCheck()">여부확인</button>
                        </div>
                        <div class="form-group">
                            <label for="password">비밀번호:</label>
                            <input type="password" class="form-control" id="member_userPassword" name="userPassword">
                        </div>
                        <div class="form-group">
                            <label for="text">성함:</label>
                            <input type="text" class="form-control" id="member_userName" name="userName">
                        </div>
                        <div class="form-group">
                            <label for="email">이메일주소:</label>
                            <input type="email" class="form-control" id="member_userEmail" name="userEmail">
                        </div>
                        <button type="button" class="btn btn-default" onclick="submitMemberForm()">회원가입</button>
                    </form>
                    <input type="hidden" id="memberYN" value="N">
                </div>
            </div>
        </div>
    </div>
<!--     바디부분 시작 -->
    <div class="container1" id="menu-1" data-name="menu-var">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1" ></li>
				<li data-target="#myCarousel" data-slide-to="2" ></li>
				<li data-target="#myCarousel" data-slide-to="3" ></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					 <img src="resources/images/mainimage1.jpeg" style="width:100%; margin-top: 6%;"/>
				</div>
				<div class="item">
					 <img src="resources/images/mainimage2.jpeg" style="width:100%; margin-top: 6%;"/>
				</div>
				<div class="item">
					 <img src="resources/images/mainimage3.jpeg" style="width:100%; margin-top: 6%;"/>
				</div>
				<div class="item">
					 <img src="resources/images/mainimage4.jpeg" style="width:100%; margin-top: 6%;"/>
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	
    <div class="container1" id="menu-2" data-name="menu-var">
        <div class="jumbotron" style="background-color: black; color: white">
            <div class="container" style="padding-bottom: 4%; font-weight: bold; font-size: 24px;" id="menu2">
            예약현황
            <div>
            </div>
            </div>
        </div>
    </div>
  <div class="container floor-plan" >
    <!-- 예약 가능한 테이블들 -->
    <%
        // 테이블 수
        int tableCount = 10;
        for (int i = 1; i <= tableCount; i++) {
    %>
    <div class="table available" id="table-<%=i%>" data-status="available" style="top: <%= (i-1) / 5 * 200 + 50 %>px; left: <%= ((i-1) % 5) * 200 + 50 %>px;">
        <div class="chair chair-left-top"></div>
        <div class="chair chair-left-bottom"></div>
        <%=i%>
        <div class="chair chair-right-top"></div>
        <div class="chair chair-right-bottom"></div>
    </div>
    <% } %>
</div>

<!-- 예약 정보 입력을 위한 팝업들 -->
<%
    for (int i = 1; i <= tableCount; i++) {
%>
<div class="popup" id="popup-table-<%=i%>" data-table-id="<%=i%>">
    <span class="close">&times;</span>
    <h2>테이블 <%=i%> 예약하기</h2>
    <form>
        <div class="form-group">
            <label for="numberOfPeople-<%=i%>">인원 수:</label>
            <input type="number" class="form-control" id="numberOfPeople-<%=i%>" min="1" required>
        </div>
        <div class="form-group">
            <label for="reservationTime-<%=i%>">예약 시간:</label>
            <input type="time" class="form-control" id="reservationTime-<%=i%>" required>
        </div>
        <button type="button" class="btn btn-primary">예약하기</button>
    </form>
</div>
<% } %>
<div class="table available" id="table-0" data-status="available" style="top: 50px; left: 50px; display: none">
        <div class="chair chair-left-top"></div>
        <div class="chair chair-left-bottom"></div>
        0
        <div class="chair chair-right-top"></div>
        <div class="chair chair-right-bottom"></div>
    </div>
    
    <div class="container1" id="menu-3" data-name="menu-var">
        <div class="jumbotron" style="background-image: url('resources/images/table.png');">
            <div class="container" style="padding-bottom: 22%;" id="menu3">
            <div style="margin-left: 80%; margin-top: 28%; margin-bottom: -30%; font-weight: 700; font-size: 15px;">
              #좌석 선택후 예약 진행 바랍니다.
            </div>
            </div>
        </div>
    </div>
	
	<img width="100%" height="100%" src="resources/images/maxresdefault.jpg"/>
	<div class="movie">
	<iframe src="//player.vimeo.com/video/875793812?quality=1080p&amp;autopause=0&amp;playsinline=1&amp;autoplay=1&amp;loop=1&amp;background=1" width="100%" height="100%" frameborder="0" autoplay="" muted="" playsinline="" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
    </div>
	<div class="container1" style="margin-top: 5%;">
        <div class="jumbotron"  style="padding-top: 27px; padding-bottom: 33px;">

		<h1 class="box"></h1>
    
    <!-- 메뉴판 영역 -->
    <div class="menu-board">
        <h1>돼지름길 메뉴판</h1>
        
        <div class="row">
            <div class="col-md-3" id="menu-5" data-name="menu-var">
                <div class="menu-item" onclick="showDetails('한돈 삼겹살', 15000, '한돈 삼겹살 200g', 'resources/images/samgyeopsal.jpg')">
                    <h4 class="menu-name">한돈 삼겹살</h4>
                    <p class="menu-price">가격: 15,000원</p>
                    <p class="menu-description">설명: 삼겹살 200g</p>
                    <img src="resources/images/samgyeopsal.jpg" class="menu-img">
                </div>
            </div>
            <div class="col-md-3">
                <div class="menu-item" onclick="showDetails('항정살', 18000, '항정살 300g', 'resources/images/Porkneckmeat.jpg')">
                    <h4 class="menu-name">한돈 항정살</h4>
                    <p class="menu-price">가격: 18,000원</p>
                    <p class="menu-description">설명: 항정살  300g</p>
                    <img src="resources/images/Porkneckmeat.jpg" class="menu-img">
                </div>
            </div>
            <div class="col-md-3">
                <div class="menu-item" onclick="showDetails('목살', 22000, '목살 250g', 'resources/images/moksal.jpg')">
                    <h4 class="menu-name">한돈 목살 </h4>
                    <p class="menu-price">가격: 22,000원</p>
                    <p class="menu-description">설명: 목살 250g</p>
                    <img src="resources/images/moksal.jpg" class="menu-img">
                </div>
            </div>
            <div class="col-md-3">
                <div class="menu-item" onclick="showDetails('돼지불고기', 17000, '돼지불고기 200g', 'resources/images/moksal.jpg')">
                    <h4 class="menu-name">돼지불고기</h4>
                    <p class="menu-price">가격: 17,000원</p>
                    <p class="menu-description">설명: 불고기 200g</p>
                    <img src="resources/images/moksal.jpg" class="menu-img">
                </div>
            </div>
        </div>
    </div>
		</div>
    </div>
    
    <div class="container" id="menu-4" data-name="menu-var">
        <div class="jumbotron">
            <div class="container" style="padding-bottom: 4%; font-weight: bold; font-size: 24px;" id="menu4"> 
			    오시는 길
			</div>
            <div id="map" style="width:100%;height:400px;"></div>
        </div>
    </div>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=37b4df0ec220e2197b6fa48608071934"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=37b4df0ec220e2197b6fa48608071934&libraries=services"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=37b4df0ec220e2197b6fa48608071934&libraries=services,clusterer,drawing"></script>
    <script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(37.428970287646884, 127.15101826232208),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		var imageSrc = 'resources/images/pinlogo.png', // 마커이미지의 주소입니다    
	    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
	    imageOption = {offset: new kakao.maps.Point(27, 69)};
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	    markerPosition = new kakao.maps.LatLng(37.428970287646884, 127.15101826232208); // 마커가 표시될 위치입니다

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition, 
		    image: markerImage // 마커이미지 설정 
		});
		marker.setMap(map); 
	</script>
	
<!-- 	마지막페이 -->
     <div class="container1">
        <div class="jumbotron" style="background-color: black">
            <div class="container">
            <div>
            	<p style="line-height: 2; text-align: left;"><img src="resources/images/piglogo.jpg" class="fr-fil fr-dii" style="width: 120px;"></p>
	            	<p style="line-height: 2; text-align: left;"><br></p><p style="line-height: 2; text-align: left;"><br></p>
	            	<p style="line-height: 2; text-align: left;">
		            	<span style="font-size: 16px;">
		            	<span style="color: rgb(255, 255, 255);">명가 FNB |&nbsp;</span>
		            	</span>
		            	<span style="font-size: 16px;">
		            		<span style="color: rgb(255, 255, 255);">사업자등록번호&nbsp;</span>:<span style="color: rgb(255, 255, 255);">&nbsp;000-00-00000&nbsp;</span>
		            	</span>
	            	</p>
	            	<p style="line-height: 2; text-align: left;">
		            	<span style="font-size: 16px;">
		            		<span style="color: rgb(255, 255, 255);">대표 : 명형로 | 전화 : 0000-0000&nbsp;</span>
		            	</span>
	            	</p>
	            	<p style="line-height: 2; text-align: left;">
		            	<span style="font-size: 16px;">
		            		<span style="color: rgb(255, 255, 255);">mail: <a href="mailto:sj@ddok.co">aaa@aaaaa.co</a>.kr</span>
		            	</span>
	            	</p>
	            	<p style="line-height: 2; text-align: left;">
		            	<span style="font-size: 16px;">
		            		<span style="color: rgb(255, 255, 255);">주소 : 서울시 송파구&nbsp;</span>
		            	</span>
	            	</p>
	            	<hr>
	            	<p style="line-height: 2; text-align: left;">
		            	<span style="font-size: 16px;">
			            	<span style="color: rgb(255, 255, 255);">
			            		<span style="color: rgb(255, 255, 255);">Copyrights ⓒ 명가FNB 2023 All rights reserved.</span>
			            	</span>
		            	</span>
	            	</p>
	            </div>
            </div>
        </div>
    </div>
</body>
</html>
