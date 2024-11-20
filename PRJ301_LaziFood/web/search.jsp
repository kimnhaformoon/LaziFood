<%-- 
    Document   : search
    Created on : 20-06-2024, 09:25:06
    Author     : long
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tìm kiếm thực đơn</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.js"></script>
    </head>
    <body>
        <jsp:include page="headerHiddenNavigation.jsp"/>

        <div class="product menu container-fluid" style="margin-top:150px; margin-bottom:100px;">
            <label><b>Phân loại</b></label>
            <form action="searchMenuByNameAction" id="form-search-type">
                <input type="hidden" name="txtSearchValue" value="${param.txtSearchValue}" />
                <select class="form-control" name="categoryId" id="select" onchange="document.getElementById('form-search-type').submit()" style="width: 16vw" >
                    <option value="0">Chọn phân loại</option>
                    <c:forEach var="category" items="${requestScope.LIST_MENU_CATEGORIES}">
                        <option value="${category.id}">${category.name}</option>
                    </c:forEach>
                </select>
            </form>
            <div class="products-list mt-5">
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
        <jsp:include page="footer.jsp"/>
        <script>
            document.addEventListener('DOMContentLoaded', (event) => {
                const selectElement = document.getElementById('select');
                var categoryId = '${param.categoryId}';
                if (categoryId !== null && categoryId !== '') {
                    selectElement.value = categoryId;
                }
            });
        </script>
    </body>
</html>
