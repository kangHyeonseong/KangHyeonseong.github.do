<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 세션에서 userID 가져오기 (로그인 상태 확인)
    String userID = (String) session.getAttribute("userID");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>돼지름길 메뉴판</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 80px; /* 네비게이션 바 때문에 padding-top을 조정해줍니다. */
            font-family: 'Noto Sans KR', sans-serif;
        }
        .navbar {
            background-color: #D3B484; /* 돼지름길 고기집 메인 컬러 */
        }
        .navbar-brand {
            color: #fff;
            font-size: 24px;
            font-weight: bold;
        }
        .navbar-brand:hover {
            color: #ffc107; /* 메인 컬러와 대조되는 하이라이트 컬러 */
        }
        .nav-link {
            color: #fff;
            font-size: 18px;
        }
        .nav-link:hover {
            color: #ffc107; /* 메인 컬러와 대조되는 하이라이트 컬러 */
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
        .menu-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 8px rgba(0,0,0,0.2);
        }
        .menu-img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 0 auto;
            margin-bottom: 10px;
            border-radius: 10px;
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
        .modal-header {
            background-color: #D3B484; /* 메인 컬러 */
            color: #fff;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .modal-title {
            font-size: 24px;
            font-weight: bold;
        }
        .modal-body {
            text-align: center;
        }
        .btn-secondary {
            background-color: #D3B484; /* 메인 컬러 */
            border-color: #D3B484; /* 메인 컬러 */
        }
        .btn-secondary:hover {
            background-color: #c1965c; /* 메인 컬러와 대조되는 하이라이트 컬러 */
            border-color: #c1965c; /* 메인 컬러와 대조되는 하이라이트 컬러 */
        }
        .close {
            color: #fff;
        }
        /* 바디 배경 스타일 */
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
                margin-bottom: -8%;
                margin-top: 5%;
        }
    </style>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    function showDetails(name, price, description, imageSrc) {
        $('#menuName').text(name);
        $('#menuPrice').text(price.toLocaleString());
        $('#menuDescription').text(description);
        $('#menuImage').attr('src', imageSrc).show();
        $('#menuDetailModal').modal('show');
    }
</script>
</head>
<body>

<!-- 네비게이션 바 -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <img width="319" height="85" src="resources/images/piglogo.jpg"/>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#">메뉴판</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">예약하기</a>
                </li>
                <!-- 로그인 상태에 따라 다르게 표시 -->
                <% if (userID == null) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="#">로그인</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">회원가입</a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="#">마이페이지</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">로그아웃</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <!-- box 부분 -->
    <h1 class="box"></h1>
    
    <!-- 메뉴판 영역 -->
    <div class="menu-board">
        <h1>돼지름길 메뉴판</h1>
        
        <div class="row">
            <div class="col-md-3">
                <div class="menu-item" onclick="showDetails('한돈 삼겹살', 15000, '한돈 삼겹살 200g', 'resources/images/samgyeopsal.jpg')">
                    <h4 class="menu-name">한돈 삼겹살</h4>
                    <p class="menu-price">가격: 15,000원</p>
                    <p class="menu-description">설명: 한돈 삼겹살 200g</p>
                    <img src="resources/images/samgyeopsal.jpg" class="menu-img">
                </div>
            </div>
            <div class="col-md-3">
                <div class="menu-item" onclick="showDetails('항정살', 18000, '항정살 300g', 'resources/images/Porkneckmeat.jpg')">
                    <h4 class="menu-name">항정살</h4>
                    <p class="menu-price">가격: 18,000원</p>
                    <p class="menu-description">설명: 항정살  300g</p>
                    <img src="resources/images/Porkneckmeat.jpg" class="menu-img">
                </div>
            </div>
            <div class="col-md-3">
                <div class="menu-item" onclick="showDetails('목살스테이크', 22000, '목살스테이크 250g', 'resources/images/moksal.jpg')">
                    <h4 class="menu-name">목살스테이크</h4>
                    <p class="menu-price">가격: 22,000원</p>
                    <p class="menu-description">설명: 목살스테이크 250g</p>
                    <img src="resources/images/moksal.jpg" class="menu-img">
                </div>
            </div>
            <div class="col-md-3">
                <div class="menu-item" onclick="showDetails('돼지불고기', 17000, '돼지불고기 200g', 'resources/images/dwaejibulgogi.jpg')">
                    <h4 class="menu-name">돼지불고기</h4>
                    <p class="menu-price">가격: 17,000원</p>
                    <p class="menu-description">설명: 돼지불고기 200g</p>
                    <img src="resources/images/dwaejibulgogi.jpg" class="menu-img">
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 상세 정보 모달 -->
<div class="modal fade" id="menuDetailModal" tabindex="-1" role="dialog" aria-labelledby="menuDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="menuDetailModalLabel">메뉴 상세 정보</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h4 id="menuName"></h4>
                <img id="menuImage" class="menu-img" src="" style="display: none;">
                <p><strong>가격:</strong> <span id="menuPrice"></span>원</p>
                <p><strong>설명:</strong> <span id="menuDescription"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
