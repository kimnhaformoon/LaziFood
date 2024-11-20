<%-- 
    Document   : hiddenNavigation
    Created on : Jul 5, 2024, 3:37:48 PM
    Author     : Kim Nha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hidden Navigation</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <style>
            .sidebar-container {
                text-align: left;
                margin-top: 5px;
            }
            .sidebar.show {
                display: block; 
            }
            .sidebar {
                position: absolute;
                z-index: 1100;
                width: 300px;
                padding: 10px 0;
                border-radius: 6px;
                overflow-y: auto;
                display: none;
                background-color: #f8f9fa;
                height: 80vh;
                width: 350px;
                transition: 0.5s;
                border: 1px solid lightgray;
                text-align: left;
            }

            /* Ghi đè màu chữ của tiêu đề khi được mở rộng */
            .accordion-button:not(.collapsed) {
                background-color: #f8f9fa;
                color: black;
            }

            .accordion-button, .accordion-collapse {
                background-color: #f8f9fa;
                border-bottom: .5px solid black;
                border-right: .5px solid black;
            }

            #heading1 {
                border-top: .5px solid black;
            }
            #sidebarToggle {
                background-color: black;
                color: white;
                width: 200px;
            }
        </style>
    </head>
    <body>
        <div class="sidebar-container">
            <button class="btn btn-sm" id="sidebarToggle">
                <i class="fas fa-list"></i>
                <span class="mr-2 ml-2">DANH MỤC SẢN PHẨM</span>
            </button>
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
                                        <c:param name="listIndex" value="${count}"/>
                                        <c:set var = "count" value="${count + 1}"/>
                                        <c:param name = "categoryId" value ="${menuCategory.id}"/>
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
                                        <c:param name="listIndex" value="${count}"/>
                                        <c:set var = "count" value="${count + 1}"/>
                                        <c:param name="type" value="Dish"/>
                                        <c:param name = "categoryId" value ="${dishCategory.id}"/>
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
                                            <c:param name="listIndex" value="${count}"/>
                                            <c:set var = "count" value="${count + 1}"/>
                                            <c:param name="type" value="Ingredient"/>
                                            <c:param name = "categoryId" value ="${ingredientCategory.id}"/>
                                        </c:url>
                                        <a href="${url}" style ="color:black"><h6>${ingredientCategory.name}</h6></a>
                                            </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#sidebarToggle').click(function () {
                    $('#sidebar').toggleClass('show'); // Toggle the 'show' class on sidebar when button is clicked
                });
            });
        </script>
    </body>
</html>
