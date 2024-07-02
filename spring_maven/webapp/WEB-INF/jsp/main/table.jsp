<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loading Bar Example</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .menu-item {
            text-align: center;
            padding: 20px;
            border-bottom: 1px solid #ddd;
        }
        .menu-item img {
            display: block;
            margin: 0 auto;
            border-radius: 10px;
        }
        /* Navigation Bar Styles */
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #333;
            color: white;
            padding: 10px;
            z-index: 1000;
            display: flex;
            justify-content: space-around;
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
        /* Loading Bar Styles */
        .loading-bar-container {
            position: fixed;
            top: 50px; /* Adjust according to navbar height */
            left: 0;
            width: 100%;
            height: 5px;
            background-color: #f3f3f3;
            z-index: 999;
        }
        .loading-bar {
            height: 100%;
            background-color: #4caf50;
            width: 0;
            position: relative;
        }
        .loading-bar::after {
            content: "🐖";
            position: absolute;
            right: 0;
            top: -15px; /* Adjust to position icon correctly */
            font-size: 20px;
        }
    </style>
</head>
<body>
    <div class="navbar" id="navbar">
        <div class="navbar-item" id="nav-item-1">한돈 삼겹살</div>
        <div class="navbar-item" id="nav-item-2">메뉴 2</div>
        <div class="navbar-item" id="nav-item-3">메뉴 3</div>
    </div>
    <div class="loading-bar-container">
        <div class="loading-bar" id="loading-bar"></div>
    </div>
    <div class="menu-item" id="menu-1">
        <h4 class="menu-name">한돈 삼겹살</h4>
        <img width="300" height="400" src="resources/images/samgyeopsal.jpg" />
        <p class="menu-price">가격: 15,000원</p>
        <p class="menu-description">설명: 한돈 삼겹살 200g</p>
    </div>
    <div class="menu-item" id="menu-2">
        <h4 class="menu-name">메뉴 2</h4>
        <img width="300" height="400" src="resources/images/samgyeopsal.jpg" />
        <p class="menu-price">가격: 20,000원</p>
        <p class="menu-description">설명: 메뉴 2의 설명</p>
    </div>
    <div class="menu-item" id="menu-3">
        <h4 class="menu-name">메뉴 3</h4>
        <img width="300" height="400" src="resources/images/samgyeopsal.jpg" />
        <p class="menu-price">가격: 25,000원</p>
        <p class="menu-description">설명: 메뉴 3의 설명</p>
    </div>
    <script>
        window.onscroll = function() {
            var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
            var scrollHeight = document.documentElement.scrollHeight || document.body.scrollHeight;
            var clientHeight = document.documentElement.clientHeight || window.innerHeight;
            var scrollPercent = (scrollTop / (scrollHeight - clientHeight)) * 100;
            document.getElementById('loading-bar').style.width = scrollPercent + '%';

            // Highlight the current section in the navbar
            var menuItems = document.querySelectorAll('.menu-item');
            var navbarItems = document.querySelectorAll('.navbar-item');
            menuItems.forEach((item, index) => {
                var rect = item.getBoundingClientRect();
                if (rect.top >= 0 && rect.bottom <= window.innerHeight) {
                    navbarItems.forEach(navItem => navItem.classList.remove('active'));
                    navbarItems[index].classList.add('active');
                }
            });
        };
    </script>
</body>
</html>
