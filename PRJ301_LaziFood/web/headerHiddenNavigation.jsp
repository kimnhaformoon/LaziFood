<%-- 
    Document   : header
    Created on : 24-06-2024, 10:51:19
    Author     : long
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <style>
            .header {
                background-color: #d4a7b4;
                color: black;
                padding: 10px 30px 0 30px; /* Tăng chiều cao header */
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
            }
            .header .logo {
                max-width: 200px;
            }
            .search-bar input {
                height: 40px;
                margin-left: 20px;
            }
            .search-bar input.form-control:focus {
                outline: none;
                box-shadow: none;
            }
            .search-bar .btn {
                outline: none;
                box-shadow: none;
            }
            .search-bar .btn:hover {
                outline: none;
                box-shadow: none;
                background-color: black;
                position:relative;
            }
            #dropdownMenuButton::after {
                display: none;
            }
            #dropdownMenuButton {
                margin-top: 10px;
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
            .dropdown-menu {
                border: 1px solid black;
            }
            .dropdown-item {
                color: black;
            }
            .dropdown-item:hover, .dropdown-item:focus, .dropdown-item:active {
                background-color: #d4a7b4;
                color: white;
            }
            .dropdown-divider {
                border-color: black;
            }
            .search-form{
                display: flex;
                width: 500px;
            }

        </style>
    </head>
    <body>
        <header class="header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-3">
                        <a href="homePage"><img src="images/logo/logohomewhite.png" alt="Logo" class="logo" /></a>
                        <jsp:include page="hiddenNavigation.jsp"/>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group search-bar">
                            <form action ="searchMenuByNameAction" method="POST" class = "search-form">
                                <input type="text" class="form-control" placeholder="Bạn muốn tìm gì?" name = "txtSearchValue" value ="${param.txtSearchValue}"/>
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary" type="submit" style="background-color: black;">
                                        <i class="fas fa-search text-white"></i>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-md-3 text-right">
                        <c:if test="${empty sessionScope.LoginedAccount}">
                            <a href="registrationPage" class="text-black mr-3"><h6 style="display: inline-block;">Đăng ký</h6></a>|
                            <a href="loginPage" class="text-black mr-3"><h6 style="display: inline-block;">Đăng nhập</h6></a>
                            <a href="cartPage"><i class="fas fa-shopping-cart text-black" style="scale: 150% ;"></i></a>
                            </c:if>
                            <c:if test="${not empty sessionScope.LoginedAccount}">
                            <a href="cartPage" ><i class="fas fa-shopping-cart text-black" style="scale: 150%;"></i></a>
                            <div class="dropdown">
                                <button class="btn btn-custom dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    ${sessionScope.LoginedAccount.username}
                                </button>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    <a class="dropdown-item" href="viewOrderAction">Đơn hàng</a>
                                    <a class="dropdown-item" href="viewPersonalPlanAction">Thực đơn của tôi</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="logoutAction">Đăng xuất</a>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </header>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Link Bootstrap JS -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
