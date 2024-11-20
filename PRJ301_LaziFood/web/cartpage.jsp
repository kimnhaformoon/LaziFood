<%-- 
    Document   : cartpage
    Created on : 27-06-2024, 10:45:01
    Author     : long
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ hàng của bạn</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.js"></script>


    </head>
    <body>
        <fmt:setLocale value="vi_VN"/>
        
        <jsp:include page="headerHiddenNavigation.jsp"/>

        <div style = "margin-top: 100px">
            <section class="bg-light my-5">
                <div class="container">
                    <div class="row">
                        <!-- cart -->
                        <div class="col-lg-9">
                            <div class="card border shadow-0">
                                <div class="m-4">
                                    <h4 class="card-title mb-4">Giỏ hàng của bạn</h4>
                                    <c:if test = "${empty sessionScope.CART.listIngredient && empty sessionScope.CART.listDish}">
                                        <h2 style="color:red">Không có gì trong giỏ hàng của bạn</h2><br/>
                                        <a href ="homePage">Quay lại trang chủ</a>
                                    </c:if>
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
                                                </div>
                                                <div class="">
                                                    <text class="h6 item-price"><fmt:formatNumber value="${quantity * ingredient.price}" type="currency" /></text> <br />
                                                    <small class="text-muted text-nowrap">
                                                        <fmt:formatNumber value="${ingredient.price}" type="currency" />
                                                         / 1 ${ingredient.unit}
                                                    </small>
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-sm-6 col-6 d-flex flex-row flex-lg-column flex-xl-row text-nowrap">
                                                <div class="d-flex align-items-center">
                                                    <div class="d-flex align-items-center">
                                                        <!-- Nút trừ số lượng -->
                                                        <form action="updateCartAction" method="post">
                                                            <input type="hidden" name="productId" value="${ingredient.id}" />
                                                            <input type="hidden" name="type" value="Ingredient" />
                                                            <input type="hidden" name="value" value="-1" />
                                                            <button type="submit" class="btn btn-link"><i class="fas fa-minus"></i></button>
                                                        </form>
                                                        <!-- Input số lượng sẽ được thay đổi bởi nút tăng/giảm số lượng -->
                                                        <input type="number" name="quantity" class="form-control text-center border border-secondary" style="width: 70px;" value="${quantity}" min="1" style="width: 50px;" disabled>
                                                        <form action="updateCartAction" method="post">
                                                            <input type="hidden" name="productId" value="${ingredient.id}" />
                                                            <input type="hidden" name="type" value="Ingredient" />
                                                            <input type="hidden" name="value" value="1" />
                                                            <button type="submit" class="btn btn-link"><i class="fas fa-plus"></i></button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg col-sm-6 d-flex justify-content-sm-center justify-content-md-start justify-content-lg-center justify-content-xl-end mb-2">
                                                <div class="float-md-end">
                                                    <c:url var = "url" value="removeCartAction">
                                                        <c:param name = "productId" value ="${ingredient.id}"/>
                                                        <c:param name = "type" value ="Ingredient"/>                                                                    
                                                    </c:url>
                                                    <a href="${url}" class="btn btn-light border text-danger icon-hover-danger"> Xóa</a>
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
                                                                <c:param name = "productId" value ="${dish.id}"/>
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
                                                    <form action="updateCartAction" method="post">

                                                        <div class="d-flex align-items-center">
                                                            <!-- Nút trừ số lượng -->
                                                            <form action="updateCartAction" method="post">
                                                                <input type="hidden" name="productId" value="${dish.id}" />
                                                                <input type="hidden" name="type" value="Dish" />
                                                                <input type="hidden" name="value" value="-1" />
                                                                <button type="submit" class="btn btn-link"><i class="fas fa-minus"></i></button>
                                                            </form>
                                                            <!-- Input số lượng sẽ được thay đổi bởi nút tăng/giảm số lượng -->
                                                            <input type="number" name="quantity" class="form-control text-center border border-secondary" style="width: 70px;" value="${quantity}" min="1" style="width: 50px;" disabled>
                                                            <form action="updateCartAction" method="post">
                                                                <input type="hidden" name="productId" value="${dish.id}" />
                                                                <input type="hidden" name="type" value="Dish" />
                                                                <input type="hidden" name="value" value="1" />
                                                                <button type="submit" class="btn btn-link"><i class="fas fa-plus"></i></button>
                                                            </form>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                            <div class="col-lg col-sm-6 d-flex justify-content-sm-center justify-content-md-start justify-content-lg-center justify-content-xl-end mb-2">
                                                <div class="float-md-end">
                                                    <c:url var = "url" value="removeCartAction">
                                                        <c:param name = "productId" value ="${dish.id}"/>
                                                        <c:param name = "type" value ="Dish"/>                                                                    
                                                    </c:url>
                                                    <a href="${url}" class="btn btn-light border text-danger icon-hover-danger"> Xóa</a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <!-- cart -->
                        <!-- summary -->
                        <c:if test = "${not empty sessionScope.CART.listIngredient || not empty sessionScope.CART.listDish}">
                            <div class="col-lg-3">

                                <div class="card shadow-0 border">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <p class="mb-2">Tổng tiền:</p>
                                            <p class="mb-2" id="totalPrice"><fmt:formatNumber value="${sessionScope.CART.totalPrice}" type="currency" /></p>
                                        </div>                                                                  
                                        <hr />
                                        <div class="mt-3">
                                            <a href="checkoutPage" class="btn btn-success w-100 shadow-0 mb-2"> Thanh toán </a>
                                            <a href="homePage" class="btn btn-light w-100 border mt-2"> Quay về cửa hàng </a>
                                        </div>
                                    </div>
                                </div>
                            </div>             
                        </c:if>
                        <!-- summary -->
                    </div>
                </div>
            </section> 
        </div>
            <jsp:include page="footer.jsp"/>


    </body>
</html>
