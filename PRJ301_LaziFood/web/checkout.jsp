<%-- 
    Document   : checkout.jsp
    Created on : 03-07-2024, 13:15:59
    Author     : long
--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh toán</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    </head>
    <body>
        <fmt:setLocale value="vi_VN"/>
        <jsp:include page="headerHiddenNavigation.jsp"/>
        <c:if test = "${(empty sessionScope.CART.listIngredient && empty sessionScope.CART.listDish) || emptysessionScope.CART}">
            <div style = "margin-top:140px; margin-bottom:100px;">
                <h2 style="color:red">Không có gì trong giỏ hàng của bạn</h2><br/>
                <a href ="homePage">Quay lại trang chủ</a>
            </div>
        </c:if>
        <c:if test = "${not empty sessionScope.CART.listIngredient || not empty sessionScope.CART.listDish}">
            <div style = "margin-top:140px; margin-bottom:100px;">
                <div class="container mt-5">
                    <h2>Thông tin đặt hàng</h2>
                    <form action="checkoutAction" method="post">
                        <input type="hidden" class="form-control" id="name" name="accountId" required value = "${sessionScope.LoginedAccount.id}">
                        <div class="form-group">
                            <label for="name">Họ và tên:</label>
                            <input type="text" class="form-control" id="name" name="name" required value = "${sessionScope.LoginedAccount.fullname}">
                        </div>
                        <div class="form-group">
                            <label for="phone">Số điện thoại:</label>
                            <input type="tel" class="form-control" id="phone" name="phone" required value = "${sessionScope.LoginedAccount.phone}">
                        </div>
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" class="form-control" id="email" name="email" required value = "${sessionScope.LoginedAccount.email}">
                        </div>
                        <div class="form-group">
                            <label for="address">Địa chỉ:</label>
                            <input type="text" class="form-control" id="address" name="address" placeholder="Số nhà, đường" value = "${sessionScope.LoginedAccount.address}">
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="city">Thành phố:</label>
                                <input type="text" class="form-control" id="city" name="city" required value = "${sessionScope.LoginedAccount.city}">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="district">Quận:</label>
                                <input type="text" class="form-control" id="district" name="district" required value = "${sessionScope.LoginedAccount.district}">
                            </div>
                        </div>

                        <c:forEach var="entry" items = "${sessionScope.CART.listIngredient}">
                            <div class="row gy-3 mb-4">
                                <div class="col-lg-5">
                                    <div class="me-lg-5">
                                        <div class="d-flex">
                                            <c:set var="ingredient" value="${entry.key}" />
                                            <c:set var="quantity" value="${entry.value}" />
                                            <img src="${ingredient.image}" class="border rounded me-3" style="width: 96px; height: 96px;" />
                                            <div class="">
                                                <c:url var = "url" value="viewProductDetailAction">
                                                    <c:param name = "txtProductId" value ="${ingredient.id}"/>
                                                    <c:param name = "type" value ="Ingredient"/>                                                                    
                                                </c:url>
                                                <a href="${url}" class="nav-link">${ingredient.name}</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-sm-6 col-6 d-flex flex-row flex-lg-column flex-xl-row text-nowrap">

                                    <div class="">
                                        <text class="h6 item-price"><fmt:formatNumber value="${quantity * ingredient.price}" type="currency" /></text> <br />
                                        <small class="text-muted text-nowrap"> <fmt:formatNumber value="${ingredient.price}" type="currency" /> / 1 ${ingredient.unit} </small>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-sm-6 col-6 d-flex flex-row flex-lg-column flex-xl-row text-nowrap">
                                    <div class="d-flex align-items-center">
                                        <div class="d-flex align-items-center">
                                            <input type="number" name="quantity" class="form-control text-center border border-secondary" style="width: 70px;" value="${quantity}" min="1" style="width: 50px;" disabled>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:forEach var="entry" items = "${sessionScope.CART.listDish}">
                            <div class="row gy-3 mb-4">
                                <div class="col-lg-5">
                                    <div class="me-lg-5">
                                        <div class="d-flex">
                                            <c:set var="dish" value="${entry.key}" />
                                            <c:set var="quantity" value="${entry.value}" />
                                            <img src="${dish.image}" class="border rounded me-3" style="width: 96px; height: 96px;" />
                                            <div class="">
                                                <c:url var = "url" value="viewProductDetailAction">
                                                    <c:param name = "txtProductId" value ="${dish.id}"/>
                                                    <c:param name = "type" value ="Dish"/>                                                                    
                                                </c:url>
                                                <a href="${url}" class="nav-link">${dish.name}</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-2 col-sm-6 col-6 d-flex flex-row flex-lg-column flex-xl-row text-nowrap">
                                    <div class="">

                                    </div>
                                    <div class="">
                                        <text class="h6 item-price"><fmt:formatNumber value="${quantity * dish.price}" type="currency" /></text> <br />
                                        <small class="text-muted text-nowrap"> <fmt:formatNumber value="${dish.price}" type="currency" /> / 1 phần </small>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-sm-6 col-6 d-flex flex-row flex-lg-column flex-xl-row text-nowrap">
                                    <div class="d-flex align-items-center">
                                        <div class="d-flex align-items-center">
                                            <input type="number" name="quantity" class="form-control text-center border border-secondary" style="width: 70px;" value="${quantity}" min="1" style="width: 50px;" disabled>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <div class="form-group">
                            <label>Tổng giá:</label>
                            <p><fmt:formatNumber value="${sessionScope.CART.totalPrice}" type="currency" /></p>
                        </div>
                        <div class="form-group">
                            <label>Giá ship:</label>
                            <c:set var="shippingFee" value="30000" /> <!-- Ví dụ giá ship cố định là 30,000 VND -->
                            <p><fmt:formatNumber value="${shippingFee}" type="currency" /></p>
                        </div>
                        <div class="form-group">
                            <label for="totalAmount">Tổng cộng:</label>
                            <c:set var="totalAmount" value="${sessionScope.CART.totalPrice + shippingFee}" />
                            <input type="text" class="form-control" id="totalAmount" name="totalAmount" value="${totalAmount}" readonly>
                        </div>
                        <button type="submit" class="btn btn-primary">Đặt hàng</button>
                    </form>
                </div>
            </div>
        </c:if>
        <jsp:include page="footer.jsp"/>

        <!-- Include Bootstrap JS and dependencies if needed -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </body>
</html>
