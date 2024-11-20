<%-- 
    Document   : manageIngredient
    Created on : Jul 15, 2024, 10:15:24 PM
    Author     : Kim Nha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Trang quản lý món ăn</title>
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
            body {
                background: #fff;
            }
            .search-bar {
                position: relative;
            }
            .search-input {
                height: 35px;
                padding-left: 4rem; 
                border-radius: 8px;
                border: 1px solid #ccc; 
                width: 250px;
            }
            .search-input:focus {
                border-color: #3985d1; 
                outline: none; 
            }
            .search-icon {
                position: absolute;
                left: 1.5rem; /* Điều chỉnh để đặt biểu tượng */
                top: 50%;
                transform: translateY(-50%);
            }

            .main-box.no-header {
                padding-top: 20px;
            }
            .main-box {
                background: #ffffff;
                box-shadow: 1px 1px 2px 0 #cccccc;
                margin-bottom: 16px;
                border-radius: 3px;
            }
            .table button.table-link.danger {
                color: #e74c3c;
            }
            .table button.table-link.unlock {
                color: #5CB85C;
            }
            .label {
                border-radius: 3px;
                font-size: 0.875em;
                font-weight: 600;
            }
            .user-list tbody td .user-subhead {
                font-size: 0.875em;
                font-style: italic;
            }
            .user-list tbody td .user-link {
                display: block;
                font-size: 1.25em;
                padding-top: 3px;
                margin-left: 60px;
            }
            a {
                color: #3498db;
                outline: none !important;
                padding-top: 10px !important;
                margin-top: 10px !important;
            }

            .user-list tbody td .user-container > img {
                position: relative;
                max-width: 90px;
                float: left;
                margin-right: 15px;
            }

            .table thead tr th {
                text-transform: uppercase;
                font-size: 0.875em;
            }
            .table thead tr th {
                border-bottom: 2px solid #e7ebee;
            }
            .table tbody tr td:first-child {
                font-size: 1.125em;
                font-weight: 300;
            }
            .table tbody tr td {
                font-size: 1.125em;
                vertical-align: middle;
                border-top: 1px solid #e7ebee;
                padding: 12px 8px;
            }
            a:hover {
                text-decoration: none;
            }

            input[type="checkbox"] {
                width: 15px;
                height: 15px;
                margin-left: 10px;
            }

            button.table-link {
                background: none;
                border: none;
                padding: 0;
                cursor: pointer;
            }

            button:focus {
                outline: none;
            }
            .search-container {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                margin-bottom: 20px;
            }
            .search-container label {
                margin: 0 10px 0 20px;
            }
            .page-button {
                display: inline-block;
                padding: 10px 15px;
                margin: 5px;
                font-size: 16px;
                color: white;
                background-color: #d4a7b4;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                cursor: pointer;
                transition: background-color 0.1s;
            }

            .page-button:hover {
                text-decoration:none;
                color:white;
                background-color: black;
            }
            .page-active {
                background-color: black;
            }
            .button-container{
                display:flex;
                justify-content:center;
            }
        </style>
    </head>
    <body>
        <fmt:setLocale value="vi_VN"/>
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
                <a href="manageMenuPage"><i class="bi bi-pencil-square"></i><h4><b>Quản lý thực đơn</b></h4></a>
            </div>
            <div id="main-content">
                <h3><b>Quản lý nguyên liệu</b></h3>
                <a href="addNewIngre" class="btn btn-default">
                    <i class="bi bi-plus-lg"></i> Thêm nguyên liệu
                </a>
                <div class="search-container" >
                    <label>Phân loại</label>
                    <form action="manageIngrePage" id="form-search-type">
                        <input type="hidden" name="txtSearchName" value="${requestScope.searchName}" />
                        <select class="form-control" name="categoryId" id="select" onchange="document.getElementById('form-search-type').submit()" style="width: 16vw" >
                            <option value="-1">Chọn phân loại</option>
                            <c:forEach var="category" items="${requestScope.LIST_INGREDIENT_CATEGORIES}">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </form>
                    <label>Tên nguyên liệu</label>
                    <form action="manageIngrePage">
                        <div class="search-bar-container">
                            <div class="search-bar">
                                <span class="search-icon"><i class="fas fa-search"></i></span>
                                <input type="hidden" name="categoryId" value="${requestScope.categoryId}" />
                                <input type="text" class="form-control search-input" 
                                       name="txtSearchName" value="${requestScope.searchName}" placeholder="Tìm kiếm"
                                       >
                            </div>
                        </div>
                    </form>
                </div>

                <c:if test="${empty requestScope.LIST_INGRE}">
                    <label>Không có nguyên liệu nào</label>
                </c:if>
                <c:if test="${not empty requestScope.LIST_INGRE}">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="main-box no-header clearfix">
                                <div class="main-box-body clearfix">
                                    <div class="table-responsive">
                                        <table class="table user-list">
                                            <thead>
                                                <tr>
                                                    <th class="text-center"><span>Nguyên liệu</span></th>
                                                    <th><span>Đơn giá</span></th>
                                                    <th><span>Trạng thái</span></th>
                                                    <th></th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="ingre" items="${requestScope.LIST_INGRE}">
                                                    <tr>
                                                        <td>
                                                            <div class="user-container">
                                                                <img src="${ingre.image}" alt/>
                                                                <a href="#" class="user-link">${ingre.name}</a>
                                                            </div>
                                                        </td>
                                                        <td><fmt:formatNumber value="${ingre.price}" type="currency" /> / ${ingre.unit}</td>
                                                        <td>
                                                            <c:if test="${ingre.status}">
                                                                <span class="label label-success">Active</span>
                                                            </c:if>
                                                            <c:if test="${!ingre.status}">
                                                                <span class="label label-danger">Locked</span>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <c:if test="${ingre.status}">
                                                                <form action="updateProductStatusAction">
                                                                    <input type="hidden" name="ingreId" value="${ingre.id}" />
                                                                    <input type="hidden" name="status" value="${!ingre.status}" />
                                                                    <input type="hidden" name="categoryId" value="${requestScope.categoryId}" />
                                                                    <input type="hidden" name="txtSearchName" value="${requestScope.searchName}" />
                                                                    <input type="hidden" name="index" value="${requestScope.index}" />
                                                                    <button type="submit" class="table-link danger" onclick="return showConfirmLock()">
                                                                        <span class="fa-stack">
                                                                            <i class="fa fa-square fa-stack-2x"></i>
                                                                            <i class="bi bi-trash-fill fa-stack-1x fa-inverse"></i>
                                                                        </span>
                                                                    </button>
                                                                </form>
                                                            </c:if>
                                                            <c:if test="${!ingre.status}">
                                                                <form action="updateProductStatusAction">
                                                                    <input type="hidden" name="ingreId" value="${ingre.id}" />
                                                                    <input type="hidden" name="status" value="${!ingre.status}" />
                                                                    <input type="hidden" name="categoryId" value="${requestScope.categoryId}" />
                                                                    <input type="hidden" name="txtSearchName" value="${requestScope.searchName}" />
                                                                    <input type="hidden" name="index" value="${requestScope.index}" />
                                                                    <button type="submit" class="table-link unlock">
                                                                        <span class="fa-stack">
                                                                            <i class="fa fa-square fa-stack-2x"></i>
                                                                            <i class="fa fa-unlock fa-stack-1x fa-inverse"></i>
                                                                        </span>
                                                                    </button>
                                                                </form>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <form action="editIngrePage" method="POST">
                                                                <input type="hidden" name="ingreId" value="${ingre.id}" />
                                                                <input type="hidden" name="ingreName" value="${ingre.name}" />
                                                                <input type="hidden" name="ingrePrice" value="${ingre.price}" />
                                                                <input type="hidden" name="ingreUnit" value="${ingre.unit}" />
                                                                <input type="hidden" name="ingreImage" value="${ingre.image}" />
                                                                <input type="hidden" name="ingreCategory" value="${ingre.category_id}" />
                                                                <button class="btn-link" type="submit">Chỉnh sửa</button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                <div class ="button-container">
                    <c:forEach var = "page" begin= "1" end ="${requestScope.pageNum}">
                        <c:url var = "url" value="manageIngrePage">
                            <c:param name = "index" value="${page}"/>
                            <c:param name = "categoryId" value="${requestScope.categoryId}"/>
                            <c:param name = "txtSearchName" value="${requestScope.searchName}"/>
                        </c:url>
                        <a href="${url}" class="page-button <c:if test="${page == requestScope.index}">page-active</c:if>">${page}</a>
                    </c:forEach>
                </div>
            </div>
        </div>
        <script>
            function showConfirmLock() {
                return confirm("Bạn có chắc chắn muốn xóa nguyên liệu này không?");
            }

            document.addEventListener('DOMContentLoaded', (event) => {
                const selectElement = document.getElementById('select');
                var categoryId = '${requestScope.categoryId}';
                if (categoryId !== null && categoryId !== '') {
                    selectElement.value = categoryId;
                }
            });

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