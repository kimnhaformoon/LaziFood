<%-- 
    Document   : navigation
    Created on : 22-06-2024, 13:57:16
    Author     : long
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <style>
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
        </style>

    </head>

    <body>
        <div class="sidebar" id="sidebar">
            <div id="sidebar-heading"><h5 class="px-3 text-center">DANH MỤC SẢN PHẨM</h5></div>
            <div class="accordion" id="sidebarMenu">
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingOne">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne" id="heading1">
                            <h6>THỰC ĐƠN THEO TUẦN</h6>
                        </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne">
                        <div class="accordion-body">
                            <c:set var ="count" value ="0"/>
                            <c:forEach var="menuCategory" items="${requestScope.LIST_MENU_CATEGORIES}">
                                <c:url var = "url" value ="getMenuByCategoryAction">
                                    <c:set var = "count" value="${count + 1}"/>
                                    <c:param name = "txtCategoryId" value ="${menuCategory.id}"/>
                                </c:url>
                                <a href="${url}"  style ="color:black"><h6>${menuCategory.name}</h6></a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingTwo">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                            <h6>MÓN ĂN</h6>
                        </button>
                    </h2>
                    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo">
                        <div class="accordion-body">
                            <c:set var ="count" value ="0"/>

                            <c:forEach var="dishCategory" items="${requestScope.LIST_DISH_CATEGORIES}">
                                <c:url var = "url" value ="getProductByCategoryAction">
                                    <c:set var = "count" value="${count + 1}"/>
                                    <c:param name="type" value="Dish"/>
                                    <c:param name = "txtCategoryId" value ="${dishCategory.id}"/>
                                </c:url>
                                <a href="${url}"  style ="color:black"><h6>${dishCategory.name}<h6/></a>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingThree">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                <h6>NGUYÊN LIỆU</h6>
                            </button>
                        </h2>
                        <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree">
                            <div class="accordion-body">
                                <c:set var ="count" value ="0"/>

                                <c:forEach var="ingredientCategory" items="${requestScope.LIST_INGREDIENT_CATEGORIES}">
                                    <c:url var = "url" value ="getProductByCategoryAction">
                                        <c:param name="type" value="Ingredient"/>
                                        <c:param name = "txtCategoryId" value ="${ingredientCategory.id}"/>
                                    </c:url>
                                    <a href="${url}" style ="color:black"><h6>${ingredientCategory.name}</h6></a>
                                        </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>    
    </body>
</html>
