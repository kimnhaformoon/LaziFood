<%-- 
    Document   : editmenuview
    Created on : Jul 15, 2024, 10:34:08 AM
    Author     : long
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.js"></script>
        <style>
            .card-product img {
                height: 250px;
                object-fit: cover;
            }
            .button-container {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }
            .page-button {
                margin: 0 5px;
                padding: 5px 10px;
                background-color: #007bff;
                color: white;
                border-radius: 5px;
                text-decoration: none;
            }
            .page-button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <fmt:setLocale value="vi_VN"/>
        <jsp:include page="headerHiddenNavigation.jsp"/>
        <div style="margin-top:130px; margin-bottom:100px;">
            <div class="container mt-5">
                <h2 class="text-center mb-4">Thêm món ăn vào thực đơn cá nhân</h2>
                <div class="text-center mb-3">
                    <h3>Mã thực đơn: ${param.txtMenuId}</h3>
                    <h3>
                        Thứ ${param.txtDay}
                        <c:if test="${param.txtPeriod == 1}">Buổi sáng</c:if>
                        <c:if test="${param.txtPeriod == 2}">Buổi trưa</c:if>
                        <c:if test="${param.txtPeriod == 3}">Buổi chiều</c:if>
                        </h3>
                    </div>
                <c:if test="${not empty requestScope.LIST_PRODUCT}">
                    <div class="row">
                        <c:forEach var="Product" items="${requestScope.LIST_PRODUCT}">
                            <div class="col-lg-3 col-md-4 col-sm-6 col-12 mb-4">
                                <div class="card card-product">
                                    <img src="${Product.image}" class="card-img-top" alt="Ảnh của ${Product.name}">
                                    <div class="card-body">
                                        <h5 class="card-title" style="height:50px">${Product.name}</h5>
                                        <p class="card-text"><fmt:formatNumber value="${Product.price}" type="currency" /></p>
                                        <div class="d-flex justify-content-between">
                                            <c:url var="url" value="viewProductDetailAction">
                                                <c:param name="txtProductId" value="${Product.id}"/>
                                                <c:param name="type" value="Dish"/>
                                            </c:url>
                                            <a href="${url}" class="btn btn-primary">Chi tiết</a>
                                            <form action="addDishToMenuAction" method="POST" class="ml-2">
                                                <input type="hidden" name="txtMenuId" value="${param.txtMenuId}">
                                                <input type="hidden" name="txtDay" value="${param.txtDay}">
                                                <input type="hidden" name="txtPeriod" value="${param.txtPeriod}">
                                                <input type="hidden" name="txtDishId" value="${Product.id}">
                                                <button type="submit" class="btn btn-success">Thêm vào</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="button-container">
                        <c:forEach var="page" begin="1" end="${requestScope.pageNum}">
                            <c:url var="url" value="addDishToMenuAction">
                                <c:param name="txtMenuId" value="${param.txtMenuId}"/>
                                <c:param name="txtDay" value="${param.txtDay}"/>
                                <c:param name="txtPeriod" value="${param.txtPeriod}"/>
                                <c:param name="txtIndex" value="${page}"/>
                            </c:url>
                            <a href="${url}" class="page-button">${page}</a>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </div>
    </body>
</html>
