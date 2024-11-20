<%-- 
    Document   : manageOrder
    Created on : Jul 4, 2024, 2:07:07 PM
    Author     : Kim Nha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>@
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Trang quản lý đơn hàng</title>
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

            .search-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .area {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                margin-bottom: 20px;
            }
            .area label {
                width: 9vw;
            }

            .search-bar {
                position: relative;
            }
            .search-input {
                height: 35px;
                padding-left: 4rem; 
                border-radius: 8px;
                border: 1px solid #ccc; 
                width: 16vw;
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

            .label {
                border-radius: 3px;
                font-size: 0.875em;
                font-weight: 600;
            }
            .user-list tbody td .user-subhead {
                font-size: 0.875em;
                font-style: italic;
            }

            a {
                color: #3498db;
                outline: none !important;
                padding-top: 10px !important;
                margin-top: 0 !important;
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
            #table-detail tbody tr td {
                border-top: 1px solid #e7ebee;
            }
            a:hover {
                text-decoration: none;
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
            label {
                width: 200px;
                text-align: right;
                margin-right: 10px;
            }
            form {
                margin-bottom: 0;
            }
            #table-detail {
                width: 100%;
                background-color: #F7F7F7;
            }
            #table-detail a {
                color: black;
            }
            .product-name-container img {
                width: 60px;
            }
            .product-name-container a {
                margin-left: 20px;
            }
            .area-label {
                text-align: left;
                font-size: 2rem;
                width: 100%;
                margin: 20px 0;
            }
            .none-label {
                text-align: left;
                width: 100%;
                color: gray;
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
                <a href="manageOrderPage" class="active"><i class="bi bi-journal-text"></i><h4><b>Quản lý đơn hàng</b></h4></a>
                <a href="manageDishPage"><i class="bi bi-tags-fill"></i><h4><b>Quản lý sản phẩm</b></h4></a>
                <a href="manageIngrePage"><i class="bi bi-tags-fill"></i><h4><b>Quản lý nguyên liệu</b></h4></a>
                <a href="manageMenuPage"><i class="bi bi-pencil-square"></i><h4><b>Quản lý thực đơn</b></h4></a>
            </div>
            <div id="main-content">
                <h3 style="margin-bottom: 30px"><b>Quản lý đơn hàng</b></h3>
                <div class="search-container">

                    <label>Trạng thái</label>
                    <form action="manageOrderPage" id="form-search">
                        <select class="form-control" name="searchStatus" id="select-status" onchange="document.getElementById('form-search').submit()" style="width: 16vw" >
                            <option value="-1">Chọn trạng thái</option>
                            <option value="1">Chưa xử lý</option>
                            <option value="2">Đang giao hàng</option>
                            <option value="3">Đã giao hàng</option>
                            <option value="0">Đã hủy</option>
                        </select>
                    </form>

                    <label>Số điện thoại</label>
                    <form action="manageOrderPage">
                        <div class="search-bar-container">
                            <div class="search-bar">
                                <span class="search-icon"><i class="fas fa-search"></i></span>
                                <input type="text" class="form-control search-input" 
                                       name="txtSearchPhone" value="${requestScope.searchPhone}" placeholder="Tìm kiếm"
                                       >
                            </div>
                        </div>
                    </form>

                    <label>Ngày đặt hàng</label>
                    <form action="manageOrderPage" id="form-search-date">
                        <div class="search-bar-container">
                            <div class="search-bar">
                                <span class="search-icon"><i class="fas fa-search"></i></span>
                                <input type="text" class="form-control search-input" id="date-input"
                                       name="txtSearchDate" value="${requestScope.searchDate}" placeholder="Tìm kiếm"
                                       >
                            </div>
                        </div>
                    </form>
                </div>
                <p id="error-msg" style="text-align: right; color: red; display: none">Vui lòng nhập đúng định dạng 'dd-mm-yyyy'</p>
                <c:if test="${empty requestScope.BatchList}">
                    <label class="none-label">Không có đơn hàng nào</label>
                </c:if>
                <c:if test="${not empty requestScope.BatchList}">
                    <c:forEach var="batchDTO" items="${requestScope.BatchList}">
                        <label class="area-label">${batchDTO.city} - ${batchDTO.district}</label>
                        <c:if test="${empty batchDTO.getListOrder()}">
                            <label class="none-label">Không có đơn hàng nào</label>
                        </c:if>
                        <c:if test="${not empty batchDTO.getListOrder()}">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="main-box no-header clearfix">
                                        <div class="main-box-body clearfix">
                                            <div class="table-responsive">
                                                <table class="table user-list">
                                                    <thead>
                                                        <tr>
                                                            <th class="text-center"><span>Mã đơn hàng</span></th>
                                                            <th><span>Khách hàng</span></th>
                                                            <th><span>Số điện thoại</span></th>
                                                            <th><span>Ngày đặt hàng</span></th>
                                                            <th class="text-center"><span>Trạng thái</span></th>
                                                            <th></th>
                                                            <th></th>
                                                            <th></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="dto" items="${batchDTO.getListOrder()}">
                                                            <tr>
                                                                <td class="text-center">${dto.id}</td>
                                                                <td>${dto.fullname}</td>
                                                                <td>${dto.phone}</td>
                                                                <td><fmt:formatDate value="${dto.orderDate}" pattern="dd-MM-yyyy" /></td>
                                                                <c:choose>
                                                                    <c:when test="${dto.status == 1}">
                                                                        <td class="text-center">
                                                                            <span class="label label-warning">Chưa xử lý</span>
                                                                        </td>
                                                                        <td>
                                                                            <c:url var="url1" value="updateStatusOrderAction">
                                                                                <c:param name="orderId" value="${dto.id}"/>
                                                                                <c:param name="newStatus" value="2"/>
                                                                            </c:url>
                                                                            <c:url var="url0" value="updateStatusOrderAction">
                                                                                <c:param name="orderId" value="${dto.id}"/>
                                                                                <c:param name="newStatus" value="0"/>
                                                                            </c:url>
                                                                            <a href="${url1}">Giao hàng</a> |<br>
                                                                            <a href="${url0}">Hủy đơn</a>
                                                                        </td>
                                                                    </c:when>
                                                                    <c:when test="${dto.status == 2}">
                                                                        <td class="text-center">
                                                                            <span class="label label-primary">Đang giao hàng</span>
                                                                        </td>
                                                                        <td>
                                                                            <c:url var="url2" value="updateStatusOrderAction">
                                                                                <c:param name="orderId" value="${dto.id}"/>
                                                                                <c:param name="newStatus" value="3"/>
                                                                            </c:url>
                                                                            <a href="${url2}">Xác nhận đã giao</a>
                                                                        </td>
                                                                    </c:when>
                                                                    <c:when test="${dto.status == 3}">
                                                                        <td class="text-center">
                                                                            <span class="label label-success">Đã giao hàng</span>
                                                                        </td>
                                                                        <td></td>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <td class="text-center">
                                                                            <span class="label label-danger">Đã hủy</span>
                                                                        </td>
                                                                        <td></td>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <td>
                                                                    <button class="btn-link" onclick="displayDetail('${dto.id}')">Chi tiết</button>
                                                                </td>
                                                            </tr>
                                                            <tr id="${dto.id}" style="display: none">
                                                                <td colspan="4" style="vertical-align: top">
                                                                    <table id="table-detail" >
                                                                        <c:forEach var="entry" items="${dto.listDish}">
                                                                            <tr>
                                                                                <c:set var="dish" value="${entry.key}"/>
                                                                                <c:set var="quantity" value="${entry.value}"/>
                                                                                <td>
                                                                                    <div class="product-name-container">
                                                                                        <img src="${dish.image}" alt="Dish Image"/>
                                                                                        <a href="#">${dish.name}</a>
                                                                                    </div>
                                                                                </td>
                                                                                <td><p class="small">Số lượng: ${quantity}</p></td>
                                                                            </tr>
                                                                        </c:forEach>
                                                                        <c:forEach var="entry" items="${dto.listIngredient}">
                                                                            <tr>
                                                                                <c:set var="ingredient" value="${entry.key}"/>
                                                                                <c:set var="quantity" value="${entry.value}"/>
                                                                                <td>
                                                                                    <div class="product-name-container">
                                                                                        <img src="${ingredient.image}" alt="Dish Image"/>
                                                                                        <a href="#">${ingredient.name}</a>
                                                                                    </div>
                                                                                </td>
                                                                                <td><p class="small">Số lượng: ${quantity}</p></td>
                                                                            </tr>
                                                                        </c:forEach>    
                                                                    </table>
                                                                </td>
                                                                <td colspan="3" style="vertical-align: top">
                                                                    <div style="width: 100%; font-size: 16px;">
                                                                        <p><b>Địa chỉ giao hàng:</b><br>${dto.address}, ${dto.district}, ${dto.city}<br></p>
                                                                        <p style="margin-top: 20px"><b>Ngày giao hàng dự kiến:</b><br>
                                                                            <fmt:formatDate value="${dto.shipDate}" pattern="dd-MM-yyyy" />
                                                                        </p>
                                                                        <p style="margin-top: 20px; text-align: right"><b>Thành tiền:</b><br>
                                                                            <fmt:formatNumber value="${dto.totalPrice}" type="currency" />
                                                                        </p>
                                                                    </div>
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



                    </c:forEach>
                </c:if>


            </div>
        </div>
        <script>
            function displayDetail(id) {
                var orderDetail = document.getElementById(id);
                if (orderDetail.style.display === 'none')
                    orderDetail.style.display = 'table-row';
                else
                    orderDetail.style.display = 'none'
            }
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

            document.addEventListener('DOMContentLoaded', (event) => {
                const selectElement = document.getElementById('select-status');
                var searchStatus = "${requestScope.searchStatus}";
                if (searchStatus !== null && searchStatus !== '') {
                    selectElement.value = searchStatus;
                }
            });
            // Ngăn chặn gửi form nếu date không hợp lệ
            const dateInput = document.getElementById('date-input');
            const errorMsg = document.getElementById('error-msg');
            const form = document.getElementById('form-search-date');
            form.addEventListener('submit', function (event) {
                const value = dateInput.value;
                const isValid = /^\d{2}-\d{2}-\d{4}$/.test(value);
                if (!isValid) {
                    errorMsg.style.display = 'block';
                    dateInput.style.border = '1px solid red';
                    event.preventDefault();
                } else {
                    errorMsg.style.display = 'none';
                }
            });
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
