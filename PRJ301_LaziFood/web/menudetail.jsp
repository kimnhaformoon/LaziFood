<%-- 
    Document   : menudetail
    Created on : Jul 7, 2024, 6:47:50 PM
    Author     : long
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết thực đơn</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.js"></script>
        <style>
            body{margin-top:20px;}
            .idance .classes-details ul.timetable {
                margin: 0 0 22px;
                padding: 0;
            }
            .idance .classes-details ul.timetable li {
                list-style: none;
                font-size: 15px;
                color: #7f7f7f;
            }
            .idance .timetable {
                max-width: 900px;
                margin: 0 auto;
            }
            .idance .timetable-item {
                border: 1px solid #d8e3eb;
                padding: 15px;
                margin-top: 20px;
                position: relative;
                display: block;
            }
            @media (min-width: 768px) {
                .idance .timetable-item {
                    display: -webkit-box;
                    display: -ms-flexbox;
                    display: flex;
                }
            }
            .idance .timetable-item-img {
                overflow: hidden;
                height: 100px;
                width: 100px;
                display: none;
            }
            .idance .timetable-item-img img {
                height: 100%;
            }

            @media (min-width: 768px) {
                .idance .timetable-item-img {
                    display: block;
                }
            }
            .idance .timetable-item-main {
                -webkit-box-flex: 1;
                -ms-flex: 1;
                flex: 1;
                position: relative;
                margin-top: 12px;
            }
            @media (min-width: 768px) {
                .idance .timetable-item-main {
                    margin-top: 0;
                    padding-left: 15px;
                }
            }
            .idance .timetable-item-time {
                font-weight: 500;
                font-size: 16px;
                margin-bottom: 4px;
                height:3rem;
            }
            .idance .timetable-item-name {
                font-size: 14px;
                margin-bottom: 19px;
            }
            .idance .btn-book {
                padding: 6px 30px;
                width: 100%;
            }
            .idance .timetable-item-like {
                position: absolute;
                top: 3px;
                right: 3px;
                font-size: 20px;
                cursor: pointer;
            }
            .idance .timetable-item-like .fa-heart-o {
                display: block;
                color: #b7b7b7;
            }
            .idance .timetable-item-like .fa-heart {
                display: none;
                color: #f15465;
            }
            .idance .timetable-item-like:hover .fa-heart {
                display: block;
            }
            .idance .timetable-item-like:hover .fa-heart-o {
                display: none;
            }
            .idance .timetable-item-like-count {
                font-size: 12px;
                text-align: center;
                padding-top: 5px;
                color: #7f7f7f;
            }
            .idance .timetable-item-book {
                width: 200px;
            }
            .idance .timetable-item-book .btn {
                width: 100%;
            }
            .idance .schedule .nav-tabs {
                border-bottom: 2px solid #104455;
            }
            .idance .schedule .nav-link {
                -webkit-box-flex: 1;
                -ms-flex: 1;
                flex: 1;
                font-size: 12px;
                text-align: center;
                text-transform: uppercase;
                color: #3d3d3d;
                font-weight: 500;
                -webkit-transition: none;
                -o-transition: none;
                transition: none;
                border-radius: 2px 2px 0 0;
                padding-left: 0;
                padding-right: 0;
                cursor: pointer;
            }
            @media (min-width: 768px) {
                .idance .schedule .nav-link {
                    font-size: 16px;
                }
            }
            .idance .schedule .nav-link.active {
                background: #104455;
                border-color: #104455;
                color: #fff;
            }
            .idance .schedule .nav-link.active:focus {
                border-color: #104455;
            }
            .idance .schedule .nav-link:hover:not(.active) {
                background: #46c1be;
                border-color: #46c1be;
                color: #fff;
            }
            .idance .schedule .tab-pane {
                padding-top: 10px;
            }
            /* Additional custom styles for the menu card */
            .card {
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .card-img-top {
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
            }

            .card-title {
                font-size: 1.25rem;
                font-weight: bold;
                color: #333;
            }

            .card-text {
                font-size: 1rem;
                color: #555;
                line-height: 1.6;
            }

        </style>
    </head>
    <body>
        <fmt:setLocale value="vi_VN"/>
        <jsp:include page="headerHiddenNavigation.jsp"/>
        <div class ="container-fluid" style="margin-top: 200px; margin-bottom:200px;">
            <div class = "row">
                <div class="col-md-4">
                    <div class="card mt-4">
                        <img src="${requestScope.Menu.image}" class="card-img-top" alt="Menu Image">
                        <div class="card-body">
                            <h5 class="card-title">${requestScope.Menu.name}</h5>
                            <p class="card-text">${requestScope.Menu.description}</p>
                        </div>
                    </div>
                    <c:if test="${sessionScope.LoginedAccount.role != true}">
                        <form action="addMenuToPlanAction" method="POST">
                            <input type="hidden" name="txtMenuId" value = "${requestScope.Menu.id}"/>
                            <input type="submit" value="Thêm vào thực đơn cá nhân"/>
                        </form>
                    </c:if>
                </div>
                <div class="idance col-md-8" >
                    <c:if test = "${sessionScope.LoginedAccount.role == true}">
                        <div class="container mt-4">
                            <form id="customerPlanForm" action="deleteMenuAction" method="POST">     
                                <input type="hidden" name="txtMenuId" value="${requestScope.Menu.id}"/>
                                <input type ="submit" value="Xóa menu này"/>
                            </form>
                            
                        </div>
                    </c:if>
                    <div class="schedule content-block" style ="margin-top:20px;">
                        <div class="container">
                            <div class="timetable">
                                <!-- Schedule Top Navigation -->
                                <nav class="nav nav-tabs">  
                                    <c:forEach var = "i" begin="2" end = "7">
                                        <c:url var = "url" value="viewMenuDetailAction">
                                            <c:param name="txtMenuId" value="${param.txtMenuId}"/>
                                            <c:param name="txtDay" value="${i}"/>                                                      
                                        </c:url>
                                        <c:if test="${i != requestScope.day}">
                                            <a href = "${url}" class="nav-link">Thứ ${i}</a>
                                        </c:if>
                                        <c:if test="${i == requestScope.day}">
                                            <a href = "${url}" class="nav-link active">Thứ ${i}</a>
                                        </c:if>
                                    </c:forEach>                                                  
                                </nav>
                                <div class="tab-content">
                                    <div class="tab-pane show active">
                                        <div class="row">
                                            <c:set var ="MenuDetail" value="${requestScope.Menu.details}"/> 
                                            <c:set var="DayMenu" value="${MenuDetail.get(requestScope.day)}"/>
                                            <!-- Morning Column -->
                                            <div class="col-md-4">
                                                <h3>Buổi sáng</h3>
                                                <c:forEach var = "dish" items ="${DayMenu.get(Integer.parseInt('1'))}">
                                                    <div class="timetable-item">
                                                        <div class="timetable-item-img">
                                                            <img src="${dish.image}" alt="">
                                                        </div>
                                                        <div class="timetable-item-main">
                                                            <c:url var = "url" value="viewProductDetailAction">
                                                                <c:param name="txtProductId" value = "${dish.id}"/>
                                                                <c:param name="type" value = "Dish"/>
                                                            </c:url>
                                                            <a href = "${url}" style="text-decoration:none; color:black;">
                                                                <div class="timetable-item-time">${dish.name}</div>
                                                            </a>
                                                            <div class="timetable-item-name"><fmt:formatNumber value="${dish.price}" type="currency" /></div>
                                                            <c:if test="${sessionScope.LoginedAccount.role != true}">
                                                                <div>
                                                                    <form id="addToCartForm_${dish.id}" action="addToCartAction" method="POST">
                                                                        <input type ="hidden" name ="productId" value ="${dish.id}"/>
                                                                        <input type ="hidden" name = "type" value = "Dish"/>
                                                                        <input type ="hidden" name ="quantity" value ="1"/>
                                                                        <input type="hidden" id="cooked_${dish.id}" name="cooked" value=""/>
                                                                        <button type="button" class="btn btn-primary shadow-0" onclick="handleAddToCart('${dish.id}', 'Dish')">
                                                                            <i class="fas fa-shopping-cart"></i>
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${sessionScope.LoginedAccount.role == true}">
                                                                <form action="deleteDishFromMenuAction" method="POST" style="margin-top: 20px;">
                                                                    <input type="hidden" name="txtMenuId" value="${requestScope.Menu.id}" />
                                                                    <input type="hidden" name="txtDay" value="${requestScope.day}" />
                                                                    <input type="hidden" name="txtPeriod" value="1" />
                                                                    <input type="hidden" name="txtDishId" value="${dish.id}" />
                                                                    <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                                                                </form>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                                <c:if test="${sessionScope.LoginedAccount.role == true}">
                                                    <div style="margin-top:20px;">
                                                        <form action="addDishToMenuAction" method="POST">
                                                            <input type="hidden" id="planId" name="txtMenuId" value="${requestScope.Menu.id}"> <!-- Thay thế giá trị "1" bằng giá trị thực -->
                                                            <input type="hidden" id="day" name="txtDay" value="${requestScope.day}"> <!-- Thay thế giá trị "Monday" bằng giá trị thực -->
                                                            <input type="hidden" id="period" name="txtPeriod" value="1"> <!-- Thay thế giá trị "morning" bằng giá trị thực -->
                                                            <button type="submit" class="btn btn-primary">Thêm món ăn vào bữa</button>
                                                        </form>
                                                    </div>
                                                </c:if>
                                            </div>

                                            <!-- Afternoon Column -->
                                            <div class="col-md-4">
                                                <h3>Buổi trưa</h3>
                                                <c:forEach var = "dish" items ="${DayMenu.get(Integer.parseInt('2'))}">
                                                    <div class="timetable-item">
                                                        <div class="timetable-item-img">
                                                            <img src="${dish.image}" alt="">
                                                        </div>
                                                        <div class="timetable-item-main">
                                                            <c:url var = "url" value="viewProductDetailAction">
                                                                <c:param name="txtProductId" value = "${dish.id}"/>
                                                                <c:param name="type" value = "Dish"/>
                                                            </c:url>
                                                            <a href = "${url}" style="text-decoration:none; color:black;">
                                                                <div class="timetable-item-time">${dish.name}</div>
                                                            </a>
                                                            <div class="timetable-item-name"><fmt:formatNumber value="${dish.price}" type="currency" /></div>
                                                            <c:if test="${sessionScope.LoginedAccount.role != true}">
                                                                <div>
                                                                    <form id="addToCartForm_${dish.id}" action="addToCartAction" method="POST">
                                                                        <input type ="hidden" name ="productId" value ="${dish.id}"/>
                                                                        <input type ="hidden" name = "type" value = "Dish"/>
                                                                        <input type ="hidden" name ="quantity" value ="1"/>
                                                                        <input type="hidden" id="cooked_${dish.id}" name="cooked" value=""/>
                                                                        <button type="button" class="btn btn-primary shadow-0" onclick="handleAddToCart('${dish.id}', 'Dish')">
                                                                            <i class="fas fa-shopping-cart"></i>
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${sessionScope.LoginedAccount.role == true}">
                                                                <form action="deleteDishFromMenuAction" method="POST" style="margin-top: 20px;">
                                                                    <input type="hidden" name="txtMenuId" value="${requestScope.Menu.id}" />
                                                                    <input type="hidden" name="txtDay" value="${requestScope.day}" />
                                                                    <input type="hidden" name="txtPeriod" value="2" />
                                                                    <input type="hidden" name="txtDishId" value="${dish.id}" />
                                                                    <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                                                                </form>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                                <c:if test="${sessionScope.LoginedAccount.role == true}">
                                                    <div style="margin-top:20px;">
                                                        <form action="addDishToMenuAction" method="POST">
                                                            <input type="hidden" id="planId" name="txtMenuId" value="${requestScope.Menu.id}"> <!-- Thay thế giá trị "1" bằng giá trị thực -->
                                                            <input type="hidden" id="day" name="txtDay" value="${requestScope.day}"> <!-- Thay thế giá trị "Monday" bằng giá trị thực -->
                                                            <input type="hidden" id="period" name="txtPeriod" value="2"> <!-- Thay thế giá trị "morning" bằng giá trị thực -->
                                                            <button type="submit" class="btn btn-primary">Thêm món ăn vào bữa</button>
                                                        </form>
                                                    </div>
                                                </c:if>
                                            </div>

                                            <!-- Evening Column -->
                                            <div class="col-md-4">
                                                <h3>Buổi tối</h3>
                                                <c:forEach var = "dish" items ="${DayMenu.get(Integer.parseInt('3'))}">
                                                    <div class="timetable-item">
                                                        <div class="timetable-item-img">
                                                            <img src="${dish.image}" alt="">
                                                        </div>
                                                        <div class="timetable-item-main">
                                                            <c:url var = "url" value="viewProductDetailAction">
                                                                <c:param name="txtProductId" value = "${dish.id}"/>
                                                                <c:param name="type" value = "Dish"/>
                                                            </c:url>
                                                            <a href = "${url}" style="text-decoration:none; color:black;">
                                                                <div class="timetable-item-time">${dish.name}</div>
                                                            </a>
                                                            <div class="timetable-item-name"><fmt:formatNumber value="${dish.price}" type="currency" /></div>
                                                            <c:if test="${sessionScope.LoginedAccount.role != true}">
                                                                <div>
                                                                    <form id="addToCartForm_${dish.id}" action="addToCartAction" method="POST">
                                                                        <input type ="hidden" name ="productId" value ="${dish.id}"/>
                                                                        <input type ="hidden" name = "type" value = "Dish"/>
                                                                        <input type ="hidden" name ="quantity" value ="1"/>
                                                                        <input type="hidden" id="cooked_${dish.id}" name="cooked" value=""/>
                                                                        <button type="button" class="btn btn-primary shadow-0" onclick="handleAddToCart('${dish.id}', 'Dish')">
                                                                            <i class="fas fa-shopping-cart"></i>
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${sessionScope.LoginedAccount.role == true}">
                                                                <form action="deleteDishFromMenuAction" method="POST" style="margin-top: 20px;">
                                                                    <input type="hidden" name="txtMenuId" value="${requestScope.Menu.id}" />
                                                                    <input type="hidden" name="txtDay" value="${requestScope.day}" />
                                                                    <input type="hidden" name="txtPeriod" value="3" />
                                                                    <input type="hidden" name="txtDishId" value="${dish.id}" />
                                                                    <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                                                                </form>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                                <c:if test="${sessionScope.LoginedAccount.role == true}">
                                                    <div style="margin-top:20px;">
                                                        <form action="addDishToMenuAction" method="POST">
                                                            <input type="hidden" id="planId" name="txtMenuId" value="${requestScope.Menu.id}"> <!-- Thay thế giá trị "1" bằng giá trị thực -->
                                                            <input type="hidden" id="day" name="txtDay" value="${requestScope.day}"> <!-- Thay thế giá trị "Monday" bằng giá trị thực -->
                                                            <input type="hidden" id="period" name="txtPeriod" value="3"> <!-- Thay thế giá trị "morning" bằng giá trị thực -->
                                                            <button type="submit" class="btn btn-primary">Thêm món ăn vào bữa</button>
                                                        </form>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <!-- You can repeat the same structure for other days -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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
            </div>
        </div>

        <footer>
            <jsp:include page="footer.jsp"/>
        </footer>
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
        
    </body>
</html>
