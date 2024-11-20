<%-- 
    Document   : personalplan
    Created on : Jul 10, 2024, 5:28:57 PM
    Author     : long
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thực đơn của tôi</title>
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

        <div class="idance col-md-12" style="margin-top:140px; margin-bottom: 100px" >
            <c:if test="${empty requestScope.Plan}">
                <h2 style = "color:red">Bạn chưa có thực đơn cá nhân nào cả</h2>
            </c:if>
            <div>
                <form action="createNewPlanAction" method="POST">
                    Tên thực đơn mới <input type="text" name="name" value="" />
                    <input type="submit" value="Tạo thực đơn mới"/>
                </form>
            </div>
            <c:if test = "${not empty requestScope.Plan}">
                <div class="container mt-4">
                    <form id="customerPlanForm" action="viewPersonalPlanAction" method="POST">
                        <div class="form-group">
                            <label for="planSelect">Chọn kế hoạch của bạn:</label>
                            <select name="txtPlanId" id="planSelect" class="form-control form-control-sm" onchange="document.getElementById('customerPlanForm').submit();">
                                <c:forEach var="i" items="${requestScope.LIST_PLAN_ID}" varStatus="loop">
                                    <c:choose>
                                        <c:when test="${i == requestScope.Plan.id}">
                                            <option value="${i}" selected>Tuần ${loop.index + 1}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${i}">Tuần ${loop.index + 1}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>           
                            </select>                       
                        </div>
                        <button type="button" class="btn btn-danger" onclick="deletePlan()">Delete</button>
                    </form>

                </div>
                <div class="schedule content-block" style="margin-top:10px;">
                    <div class="container">
                        <div class="timetable">
                            <!-- Schedule Top Navigation -->
                            <nav class="nav nav-tabs">  
                                <c:forEach var = "i" begin="2" end = "7">
                                    <c:url var = "url" value="viewPersonalPlanAction">
                                        <c:param name="txtPlanId" value="${requestScope.Plan.id}"/>
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
                                        <c:set var ="PlanDetail" value="${requestScope.Plan.details}"/> 
                                        <c:set var="DayPlan" value="${PlanDetail.get(requestScope.day)}"/>
                                        <!-- Morning Column -->
                                        <div class="col-md-4">
                                            <h3>Buổi sáng</h3>
                                            <c:forEach var = "dish" items ="${DayPlan.get(Integer.parseInt('1'))}">
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
                                                    </div>
                                                    <form action="deleteDishFromPlanAction" method="POST" style="margin-top: 50px;">
                                                        <input type="hidden" name="txtPlanId" value="${requestScope.Plan.id}" />
                                                        <input type="hidden" name="txtDay" value="${requestScope.day}" />
                                                        <input type="hidden" name="txtPeriod" value="1" />
                                                        <input type="hidden" name="txtDishId" value="${dish.id}" />
                                                        <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                                                    </form>
                                                </div>
                                            </c:forEach> 
                                            <div style="margin-top:20px;">
                                                <form action="addDishToPlanAction" method="post">
                                                    <input type="hidden" id="planId" name="txtPlanId" value="${requestScope.Plan.id}"> <!-- Thay thế giá trị "1" bằng giá trị thực -->
                                                    <input type="hidden" id="day" name="txtDay" value="${requestScope.day}"> <!-- Thay thế giá trị "Monday" bằng giá trị thực -->
                                                    <input type="hidden" id="period" name="txtPeriod" value="1"> <!-- Thay thế giá trị "morning" bằng giá trị thực -->
                                                    <button type="submit" class="btn btn-primary">Thêm món ăn vào bữa</button>
                                                </form>
                                            </div>
                                        </div>
                                        <!-- Afternoon Column -->
                                        <div class="col-md-4">
                                            <h3>Buổi trưa</h3>
                                            <c:forEach var = "dish" items ="${DayPlan.get(Integer.parseInt('2'))}">
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
                                                    </div>
                                                    <form action="deleteDishFromPlanAction" method="POST" style="margin-top: 50px;">
                                                        <input type="hidden" name="txtPlanId" value="${requestScope.Plan.id}" />
                                                        <input type="hidden" name="txtDay" value="${requestScope.day}" />
                                                        <input type="hidden" name="txtPeriod" value="2" />
                                                        <input type="hidden" name="txtDishId" value="${dish.id}" />
                                                        <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                                                    </form>
                                                </div>
                                            </c:forEach>
                                            <div style="margin-top:20px;">
                                                <form action="addDishToPlanAction" method="POST">
                                                    <input type="hidden" id="planId" name="txtPlanId" value="${requestScope.Plan.id}"> <!-- Thay thế giá trị "1" bằng giá trị thực -->
                                                    <input type="hidden" id="day" name="txtDay" value="${requestScope.day}"> <!-- Thay thế giá trị "Monday" bằng giá trị thực -->
                                                    <input type="hidden" id="period" name="txtPeriod" value="2"> <!-- Thay thế giá trị "morning" bằng giá trị thực -->
                                                    <button type="submit" class="btn btn-primary">Thêm món ăn vào bữa</button>
                                                </form>
                                            </div>
                                        </div>
                                        <!-- Evening Column -->
                                        <div class="col-md-4">
                                            <h3>Buổi tối</h3>
                                            <c:forEach var = "dish" items ="${DayPlan.get(Integer.parseInt('3'))}">
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
                                                    </div>
                                                    <form action="deleteDishFromPlanAction" method="POST" style="margin-top: 50px;">
                                                        <input type="hidden" name="txtPlanId" value="${requestScope.Plan.id}" />
                                                        <input type="hidden" name="txtDay" value="${requestScope.day}" />
                                                        <input type="hidden" name="txtPeriod" value="3" />
                                                        <input type="hidden" name="txtDishId" value="${dish.id}" />
                                                        <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                                                    </form>
                                                </div>
                                            </c:forEach>
                                            <div style="margin-top:20px;">
                                                <form action="addDishToPlanAction" method="post">
                                                    <input type="hidden" id="planId" name="txtPlanId" value="${requestScope.Plan.id}"> <!-- Thay thế giá trị "1" bằng giá trị thực -->
                                                    <input type="hidden" id="day" name="txtDay" value="${requestScope.day}"> <!-- Thay thế giá trị "Monday" bằng giá trị thực -->
                                                    <input type="hidden" id="period" name="txtPeriod" value="3"> <!-- Thay thế giá trị "morning" bằng giá trị thực -->
                                                    <button type="submit" class="btn btn-primary">Thêm món ăn vào bữa</button>
                                                </form>
                                            </div>
                                        </div>
                                        <!-- You can repeat the same structure for other days -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </c:if>
        </div>
        <script>
            function deletePlan() {
                if (confirm("Bạn có chắc là muốn xóa không?")) {
                    const form = document.getElementById('customerPlanForm');
                    form.action = 'deletePersonalPlanAction';  // Set the delete action URL
                    form.submit();
                }

            }
        </script>

    </body>

</html>
