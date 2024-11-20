<%-- 
    Document   : homepage
    Created on : 20-06-2024, 09:21:44
    Author     : long
--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang chủ</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Font Awesome for icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.js"></script>

        <style>
            .main-body {
                display: flex;
                padding-left: 5vw;
                padding-right: 5vw;
            }
            .main-content {
                margin-bottom: 10px;
            }
            .sidebar {
                position: fixed;
                width: 300px;
                background-color: #ffffff;
                padding: 10px 0;
                border-radius: 6px;
                overflow-y: auto;
                border: 1px solid black;
                min-height: 90vh;
            }
            .accordion-button:not(.collapsed) {
                background-color: #ffffff;
                color: black;
            }
            .accordion-button, .accordion-collapse {
                background-color: #ffffff;
                border-bottom: .5px solid black;
                border-right: .5px solid black;
            }
            #heading1 {
                border-top: .5px solid black;
            }

            #banner {
                padding: 20px;
                margin-bottom: 30px;
                border: 1px solid black;
                border-radius: 6px;
            }
            .product-heading {
                margin-bottom: 20px;
                border: .5px solid black;
                border-radius: 30px;
                background-color: #d4a7b4;
                padding: 10px;
            }
            .product {
                padding: 30px;
                border: .5px solid black;
                border-radius: 6px;
                margin-bottom: 30px;
            }
            .card-img-top{
                width:150px;
                height: 250px;
            }
            .carousel-item img {
                width: 100%; 
                height: 40vh; 
            }
            .btn.btn-primary:focus {
                box-shadow: none; /* Loại bỏ shadow khi focus */
                outline: none; /* Loại bỏ outline khi focus */
            }
            .btn.btn-primary {
                background-color: black;
                border: none;
            }
            .accordion-button:focus {
                box-shadow: none;
                outline: none;
            }
            .pagination .page-item.active .page-link {
                background-color: rgb(163, 163, 163);
                border-color: #007bff;
                color: #fff;
            }
            #footer {
                background-color: #343a40;
            }
            #footer .row {
                margin-left: 20px;
                margin-right: 20px;
            }
            .payment-methods img {
                width: 80px;
                height: auto;
                margin: 5px;
                background: white;
                border-radius: 2px;
                padding: 1px;
            }
            .chinh-sach {
                margin-left: 30px;
            }
            .card-product{
                height:100%;
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
            .button-container{
                display:flex;
                justify-content:center;
            }

            @media screen and (max-width: 768px) {
                .chinh-sach {
                    margin-left: 0;
                }
                .sidebar {
                    display: none;
                }
            }
        </style>
    </head>
    <body>
        <fmt:setLocale value="vi_VN"/>
        <jsp:include page="header.jsp"/>

        <div class="main-body mt-2">
            <!-- sidebar -->
            <jsp:include page ="navigation.jsp"/>
            <!-- end of sidebar-->

            <div class="main-content" id="main-content">
                <!-- banner -->
                <div class="container" id="banner">
                    <div id="myCarousel" class="carousel slide" data-ride="carousel">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                            <li data-target="#myCarousel" data-slide-to="1"></li>
                            <li data-target="#myCarousel" data-slide-to="2"></li>
                            <li data-target="#myCarousel" data-slide-to="3"></li>
                        </ol>
                        <!-- Wrapper for slides -->
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="https://anvat.langsonweb.com/wp-content/uploads/2020/06/banner.jpg" class="d-block w-100" alt="Slide 1">
                            </div>

                            <div class="carousel-item">
                                <img src="https://fedudesign.vn/wp-content/uploads/2020/07/combo-an-trua-ivivu-3.png" class="d-block w-100" alt="Slide 2">
                            </div>

                            <div class="carousel-item">
                                <img src="https://youth.ueh.edu.vn/wp-content/uploads/2022/08/70536496-thumbnail.jpg" class="d-block w-100" alt="Slide 3">
                            </div>
                            <div class="carousel-item">
                                <img src="https://img.pikbest.com/templates/20210824/bg/01f852f4c783dff91952e84e9d453ef8_87690.png!bw700" class="d-block w-100" alt="Slide 3">
                            </div>
                        </div>
                        <!-- Left and right controls -->
                        <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </div>
                <!-- product -->
                <div>
                    <c:if test="${empty requestScope.LIST_MENU and empty requestScope.LIST_PRODUCT}">
                        <h2>No product or menu with this category</h2>
                    </c:if>
                </div>
                <c:if test = "${not empty requestScope.LIST_MENU}">
                    <div class="product-heading text-center">
                        <c:forEach var="item" items = "${requestScope.LIST_MENU_CATEGORIES}">
                            <c:if test = "${item.id == requestScope.categoryId}">
                                <h5>${item.name}</h5>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="product menu">
                        <div class="products-list">
                            <c:forEach var = "i" begin = "1" end ="5">
                                <div class="row list-row">
                                    <c:forEach var = "j" begin = "0" end ="3">
                                        <c:set var ="menu" value ="${requestScope.LIST_MENU[j+4 * (i-1)]}"/>
                                        <c:if test="${not empty menu}">
                                            <div class="col-lg-3 col-md-4 col-sm-6 col-12" style="margin-bottom:20px">

                                                <div class="card mb-4 card-product">
                                                    <img src="${menu.image}" class="card-img-top " alt="Ảnh của ${menu.name}">
                                                    <div class="card-body">
                                                        <div style ="height:50px">
                                                            <h5 class="card-title">${menu.name}</h5>
                                                        </div>
                                                        <div style="display: flex">
                                                            <div style="flex:1 ;margin-right:5px">
                                                                <c:url var ="url" value="viewMenuDetailAction">
                                                                    <c:param name="txtMenuId" value="${menu.id}"/>
                                                                    <c:param name="txtDay" value="2"/>
                                                                </c:url>
                                                                <a href="${url}" class="btn btn-primary" style="width:100%">Chi tiết</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </c:forEach>

                            <div class ="button-container">
                                <c:forEach var = "page" begin= "1" end ="${requestScope.pageNum}">
                                    <c:url var = "url" value="getMenuByCategoryAction">
                                        <c:param name = "txtIndex" value="${page}"/>
                                        <c:param name = "txtCategoryId" value="${param.txtCategoryId}"/>
                                    </c:url>
                                    <a href="${url}" class="page-button">${page}</a>
                                </c:forEach>
                            </div>

                        </div>
                    </div>
                </c:if>
                <c:if test="${not empty requestScope.LIST_PRODUCT}">
                    <div class="product-heading text-center">
                        <c:if test="${param.type eq 'Ingredient'}">
                            <c:set var="listcategory" value ="${requestScope.LIST_INGREDIENT_CATEGORIES}"/>
                        </c:if>
                        <c:if test="${param.type eq 'Dish'}">
                            <c:set var="listcategory" value ="${requestScope.LIST_DISH_CATEGORIES}"/>
                        </c:if>
                        <c:forEach var="item" items = "${listcategory}">
                            <c:if test = "${item.id == requestScope.categoryId}">
                                <h5>${item.name}</h5>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="product menu">
                        <div class="products-list">
                            <c:forEach var = "i" begin = "1" end ="5">
                                <div class="row list-row">
                                    <c:forEach var = "j" begin = "0" end ="3">
                                        <c:set var ="Product" value ="${requestScope.LIST_PRODUCT[j+4 * (i-1)]}"/>
                                        <c:if test="${not empty Product}">
                                            <div class="col-lg-3 col-md-4 col-sm-6 col-12" style="margin-bottom:20px">

                                                <div class="card mb-4 card-product">
                                                    <img src="${Product.image}" class="card-img-top " alt="Ảnh của ${Product.name}">
                                                    <div class="card-body">
                                                        <div style ="height:50px">
                                                            <h5 class="card-title">${Product.name}</h5>
                                                        </div>
                                                        <p class="card-text"><fmt:formatNumber value="${Product.price}" type="currency" /></p>

                                                        <div style="display: flex">
                                                            <div style="flex:1 ;margin-right:5px">
                                                                <c:url var = "url" value="viewProductDetailAction">
                                                                    <c:param name = "txtProductId" value ="${Product.id}"/>
                                                                    <c:param name = "type" value ="${param.type}"/>                                                                    
                                                                </c:url>
                                                                <a href="${url}" class="btn btn-primary" style="width:100%">Chi tiết</a>
                                                            </div>
                                                            <div>
                                                                <form id="addToCartForm_${Product.id}" action="addToCartAction" method="POST">
                                                                    <input type ="hidden" name ="productId" value ="${Product.id}"/>
                                                                    <input type ="hidden" name = "type" value = "${param.type}"/>
                                                                    <input type ="hidden" name ="quantity" value ="1"/>
                                                                    <input type="hidden" id="cooked_${Product.id}" name="cooked" value=""/>
                                                                    <button type="button" class="btn btn-primary shadow-0" onclick="handleAddToCart('${Product.id}', '${param.type}')">
                                                                        <i class="fas fa-shopping-cart"></i>
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>

                                    </c:forEach>

                                </div>
                            </c:forEach>

                            <div class ="button-container">
                                <c:forEach var = "page" begin= "1" end ="${requestScope.pageNum}">
                                    <c:url var = "url" value="getProductByCategoryAction">
                                        <c:param name = "txtIndex" value="${page}"/>
                                        <c:param name = "txtCategoryId" value="${param.txtCategoryId}"/>
                                        <c:param name = "type" value = "${param.type}"/>
                                    </c:url>
                                    <a href="${url}" class="page-button">${page}</a>
                                </c:forEach>
                            </div>

                        </div>
                    </div>
                </c:if>
                <jsp:include page="footer.jsp"/>

            </div>
            <div class="modal fade" id="dishModal" tabindex="-1" role="dialog" aria-labelledby="dishModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="dishModalLabel">Chọn món</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>Bạn muốn chọn món ăn nấu sẵn hay nguyên liệu cho món ăn?</p>
                            <input type="hidden" id="modalProductId" name="modalProductId">
                            <button type="button" class="btn btn-primary" onclick="selectOption('cooked')">Món ăn nấu sẵn</button>
                            <button type="button" class="btn btn-secondary" onclick="selectOption('ingredient')">Nguyên liệu</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <script>
            function adjustSidebarHeight() {
                var headerHeight = document.querySelector('header').offsetHeight;
                var windowHeight = window.innerHeight;
                var sidebar = document.getElementById('sidebar');
                var mainContent = document.getElementById('main-content');
                var sidebarWidth = sidebar.offsetWidth;

                var newHeight = windowHeight - headerHeight - 30;
                var top = headerHeight + 20;
                sidebar.style.minHeight = newHeight + 'px';
                sidebar.style.maxHeight = newHeight + 'px';
                sidebar.style.top = top + 'px';
                mainContent.style.marginTop = headerHeight + 10 + 'px';
                mainContent.style.marginLeft = sidebarWidth + 30 + 'px';
            }

            // Perform initial height adjustment when page loads
            window.addEventListener('DOMContentLoaded', adjustSidebarHeight);
            // Adjust height again if window is resized
            window.addEventListener('resize', adjustSidebarHeight);

            // Activate Carousel
            $(document).ready(function () {
                $("#myCarousel").carousel({interval: 5000}); // Chuyển slide mỗi 5 giây
            });
        </script>
        <!-- JavaScript để xử lý modal và gọi hàm -->
        <script>
            function handleAddToCart(productId, type) {
                var formId = 'addToCartForm_' + productId;
                var form = document.getElementById(formId);

                if (type === "Dish") {
                    // Lưu productId vào input hidden của modal
                    document.getElementById('modalProductId').value = productId;
                    // Mở modal
                    $('#dishModal').modal('show');
                } else {
                    // Trường hợp khác, submit form ngay lập tức
                    submitFormWithNotification(form);
                }
            }

            function selectOption(option) {
                var productId = document.getElementById('modalProductId').value;
                var formId = 'addToCartForm_' + productId;
                var form = document.getElementById(formId);
                var cookedId = 'cooked_' + productId;
                if (option === 'cooked') {
                    document.getElementById(cookedId).value = 'true';
                } else {
                    document.getElementById(cookedId).value = 'false';
                }

                $('#dishModal').modal('hide');
                submitFormWithNotification(form);
            }

            function submitFormWithNotification(form) {
                var xhr = new XMLHttpRequest();
                xhr.open('POST', form.action, true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Thành công',
                                text: 'Sản phẩm đã được thêm vào giỏ hàng!',
                                showConfirmButton: false,
                                timer: 1500
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Lỗi',
                                text: 'Đã xảy ra lỗi. Vui lòng thử lại sau!',
                                showConfirmButton: false,
                                timer: 1500
                            });
                        }
                    }
                };

                var formData = new FormData(form);
                var params = new URLSearchParams(formData).toString();
                xhr.send(params);
            }
        </script>


        <!-- Bootstrap JS and dependencies (optional) -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Link Bootstrap JS -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
    </body>

</html>
