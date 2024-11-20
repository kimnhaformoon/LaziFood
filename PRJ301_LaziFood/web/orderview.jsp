<%-- 
    Document   : orderview
    Created on : 04-07-2024, 21:01:50
    Author     : long
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Theo dõi đơn hàng</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .row-custom {
                width: 120vh;
                margin: auto;
            }
        </style>
    </head>
    <body>
        <fmt:setLocale value="vi_VN"/>
        <jsp:include page="headerHiddenNavigation.jsp"/>

        <section class="h-100 gradient-custom" style = "margin-top:130px; margin-bottom:100px;">
            <div class="container py-5 h-100">
                <c:if test="${empty requestScope.LIST_ORDER}">
                    <h2>
                        Không có đơn hàng nào cả
                    </h2>
                </c:if>
                <c:forEach var="order" items="${requestScope.LIST_ORDER}"> 
                    <div class="row row-custom d-flex justify-content-center align-items-center h-100" style="margin-bottom: 40px;">
                        <div class="col-lg-10 col-xl-8">
                            <div class="card" style="border-radius: 10px;">
                                <div class="card-header px-4 py-5">
                                    <h5 class="text-muted mb-0">Đơn hàng giao cho <span style="color: #a8729a;">${order.fullname}</span>!</h5>
                                </div>
                                <div class="card-body p-4">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <p class="lead fw-normal mb-0" style="color: #a8729a;">Chi tiết</p>
                                    </div>
                                    <div class="card shadow-0 border mb-4">
                                        <div class="card-body">
                                            <c:forEach var="entry" items="${order.listDish}">
                                                <div class="row" style = "margin-bottom:20px;">
                                                    <c:set var="dish" value="${entry.key}"/>
                                                    <c:set var="quantity" value="${entry.value}"/>
                                                    <div class="col-md-2">
                                                        <img src="${dish.image}" class="img-fluid" alt="Dish Image">
                                                    </div>
                                                    <div class="col-md-4 text-center d-flex justify-content-center align-items-center">
                                                        <c:url var = "url" value="viewProductDetailAction">
                                                            <c:param name = "txtProductId" value ="${dish.id}"/>
                                                            <c:param name = "type" value ="Dish"/>                                                                    
                                                        </c:url>
                                                        <a href="${url}"><p class="text-muted mb-0">${dish.name}</p></a>
                                                    </div>
                                                    <div class="col-md-2 text-center d-flex justify-content-center align-items-center">
                                                        <p class="text-muted mb-0 small">Số lượng: ${quantity}</p>
                                                    </div>
                                                    <div class="col-md-4 text-center d-flex justify-content-center align-items-center">
                                                        <p class="text-muted mb-0 small"><fmt:formatNumber value="${dish.price}" type="currency" /></p>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            <c:forEach var="entry" items="${order.listIngredient}">
                                                <div class="row" style = "margin-bottom:20px;">
                                                    <c:set var="ingredient" value="${entry.key}"/>
                                                    <c:set var="quantity" value="${entry.value}"/>
                                                    <div class="col-md-2">
                                                        <img src="${ingredient.image}" class="img-fluid" alt="Ingredient Image">
                                                    </div>
                                                    <div class="col-md-4 text-center d-flex justify-content-center align-items-center">
                                                        <c:url var = "url" value="viewProductDetailAction">
                                                            <c:param name = "txtProductId" value ="${ingredient.id}"/>
                                                            <c:param name = "type" value ="Ingredient"/>                                                                    
                                                        </c:url>
                                                        <a href="${url}"><p class="text-muted mb-0">${ingredient.name}</p></a>
                                                    </div>

                                                    <div class="col-md-2 text-center d-flex justify-content-center align-items-center">
                                                        <p class="text-muted mb-0 small">Số lượng: ${quantity}</p>
                                                    </div>
                                                    <div class="col-md-4 text-center d-flex justify-content-center align-items-center">
                                                        <p class="text-muted mb-0 small"><fmt:formatNumber value="${ingredient.price}" type="currency" /></p>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            <hr class="mb-4" style="background-color: #e0e0e0; opacity: 1;">           
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-left:40px; margin-right:40px;">
                                    <div class="d-flex justify-content-between pt-2">
                                        <b><p class="fw-bold mb-0">Chi tiết đơn hàng</p></b>
                                    </div>
                                    <div class="d-flex justify-content-between pt-2">
                                        <p class="text-muted mb-0">Tổng tiền</p>
                                        <p class="text-muted mb-0"><fmt:formatNumber value="${order.totalPrice}" type="currency" /></p>
                                    </div>
                                    <div class="d-flex justify-content-between pt-2">
                                        <p class="text-muted mb-0">Mã đơn hàng</p>
                                        <p class="text-muted mb-0">${order.id}</p>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <p class="text-muted mb-0">Ngày đặt</p>
                                        <p class="text-muted mb-0"><fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy" /></p>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <p class="text-muted mb-0">Ngày giao</p>
                                        <p class="text-muted mb-0"><fmt:formatDate value="${order.shipDate}" pattern="dd-MM-yyyy" /></p>
                                    </div>
                                </div>
                                <hr class="mb-4" style="background-color: #e0e0e0; opacity: 1;">           

                                <!-- Order Tracking Status -->
                                <div style="margin-left:40px; margin-right:40px; margin-bottom:20px;">
                                    <div class="d-flex justify-content-between pt-2">

                                        <div class="progress" style="width: 100%;">
                                            <c:choose>
                                                <c:when test="${order.status == 1}">
                                                    <div class="progress-bar" role="progressbar" style="width: 33%;" aria-valuenow="33" aria-valuemin="0" aria-valuemax="100">Đã đặt hàng</div>
                                                </c:when>
                                                <c:when test="${order.status == 2}">
                                                    <div class="progress-bar" role="progressbar" style="width: 66%;" aria-valuenow="66" aria-valuemin="0" aria-valuemax="100">Đang giao hàng</div>
                                                </c:when>
                                                <c:when test="${order.status == 3}">
                                                    <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">Đã giao hàng</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="progress-bar" role="progressbar" style="width: 100%; background-color: #ff0000;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">Đã hủy</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>

                                <c:if test="${order.status == 1}">
                                    <div class="d-flex justify-content-end pt-2">
                                        <form action="cancelOrderAction" method="post">
                                            <input type="hidden" name="orderId" value="${order.id}">
                                            <button type="submit" class="btn btn-danger" style="margin:10px;">Hủy đơn hàng</button>
                                        </form>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>
        <jsp:include page="footer.jsp"/>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
