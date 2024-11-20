<%-- 
    Document   : addNewDish
    Created on : Jul 15, 2024, 9:14:31 PM
    Author     : Kim Nha
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Trang quản lý</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.3/font/bootstrap-icons.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
        <link href="https://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"/>
        <style>
            header {
                padding: 10px;
                padding-left: 50px;
                align-items: center;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                width: 100%;
                z-index: 1000;
                background-color: #d4a7b4;
            }

            header h2 {
                margin: 0;
                color: #fff;
            }

            .logo-home {
                width: 200px;
            }

            .logo-container {
                align-items: center;
            }

            .dropdown-menu {
                border: 1px solid black;
            }

            #dropdownMenuButton {
                background-color: black;
                color: white;
                border-radius: 50px;
                padding: 5px 30px;
            }

            #dropdownMenuButton:hover, #dropdownMenuButton:focus, #dropdownMenuButton:active, #dropdownMenuButton.active {
                background-color: black;
                color: white;
                border-color: black;
                box-shadow: none;
            }

            .dropdown-toggle::after {
                display: none;
            }

            .dropdown-item {
                color: black;
            }
            .dropdown-item:hover, .dropdown-item:focus, .dropdown-item:active {
                background-color: #d4a7b4;
                color: white;
            }

            #sidebar {
                position: fixed;
                top: 0;
                bottom: 0;
                left: 0;
                width: 270px;
                background-color: #000;
                padding-top: 30px; /* space for header */
            }
            #sidebar a {
                color: #fff;
                padding: 10px;
                display: block;
                margin: 10px 10px;
            }

            #sidebar a.active {
                background-color: #fff;
                color: #000;
                border-radius: 10px;
            }

            #sidebar a:hover {
                background-color: #fff;
                color: #000;
                border-radius: 10px;
            }

            #sidebar h4 {
                display: inline-block;
                margin: 0 10px;
            }

            #main-content {
                padding: 30px 40px;
            }
            .form-info {
                width: 50vw;
            }
            .form-container {
                max-width: 60vw; /* Điều chỉnh chiều rộng tối đa của form */
                margin: 30px; /* Căn giữa form */
                padding: 30px; /* Thêm khoảng cách bên trong form */
                border-radius: 8px; /* Bo góc form */
                box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Thêm hiệu ứng bóng cho form */
            }
            .btn:hover {
                color: white;
            }
        </style>
    </head>
    <body>
        <header>
            <div class="container-fluid" id="header">
                <div class="row align-items-center">
                    <div class="col-md-10 row logo-container">
                        <div class="col-xxl-1 col-xl-3 col-lg-4 col-12 ">
                            <a href="adminDashBoard"><img class="logo-home" src="images/logo/logohomewhite.png" alt="home-logo"/></a>
                        </div>
                        <h2 class="col-xxl-11 col-xl-9 col-lg-8 col-12"><b>Trang quản lý</b></h2>
                    </div>
                    <div class="dropdown col-md-2 text-center">
                        <button class="btn btn-custom dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            ${sessionScope.LoginedAccount.username}
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="#">Tài khoản của tôi</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="logoutAction">Đăng xuất</a>
                        </div>
                    </div>
                </div>
            </div>
        </header>	
        <div class="main-body" id="main-body">
            <div id="sidebar">
                <a href="adminDashBoard"><i class="bi bi-house-door-fill"></i><h4><b>Trang chủ</b></h4></a>
                <a href="manageUserAction"><i class="bi bi-people-fill"></i><h4><b>Quản lý người dùng</b></h4></a>
                <a href="manageOrderPage"><i class="bi bi-journal-text"></i><h4><b>Quản lý đơn hàng</b></h4></a>
                <a href="manageDishPage"><i class="bi bi-tags-fill"></i><h4><b>Quản lý món ăn</b></h4></a>
                <a href="manageIngrePage" class="active"><i class="bi bi-tags-fill"></i><h4><b>Quản lý nguyên liệu</b></h4></a>
                <a href="#"><i class="bi bi-pencil-square"></i><h4><b>Quản lý thực đơn</b></h4></a>
            </div>
            <div id="main-content">
                <h3><b>Tạo mới nguyên liệu</b></h3>
                <div style="text-align: center;">
                    <c:if test="${requestScope.RESULT == 0}">
                        <h3><b>Thêm nguyên liệu thất bại!</b></h3>
                        <h4>Hãy thử lại</h4>
                        <a href="addNewIngre" class="btn btn-default">
                            <i class="bi bi-plus-lg"></i> Thêm nguyên liệu
                        </a>
                    </c:if>
                    <c:if test="${requestScope.RESULT != 0}">
                        <h3><b>Thêm nguyên liệu thành công!</b></h3>
                        <h4>Tiếp tục thêm nguyên liệu</h4>
                        <a href="addNewIngre" class="btn btn-default">
                            <i class="bi bi-plus-lg"></i> Thêm nguyên liệu
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
        <script>
            function marginSidebar() {
                var headerHeight = document.querySelector('header').offsetHeight;
                var windowHeight = window.innerHeight;
                var sidebar = document.getElementById('sidebar');
                var mainContent = document.getElementById('main-content');
                var sidebarWidth = sidebar.offsetWidth;

                var newHeight = windowHeight - headerHeight;
                sidebar.style.height = newHeight + 'px';
                sidebar.style.top = headerHeight + 'px';
                mainContent.style.marginLeft = sidebarWidth + 'px';
                mainContent.style.marginTop = headerHeight + 'px';
                // mainContent.style.minHeight = newHeight + 'px';
            }
            // Perform initial height adjustment when page loads
            window.addEventListener('DOMContentLoaded', marginSidebar);
            // Adjust height again if window is resized
            window.addEventListener('resize', marginSidebar);
        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Link Bootstrap JS -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
