<%-- 
    Document   : productdetail
    Created on : 26-06-2024, 17:42:15
    Author     : long
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết sản phẩm</title>
        <!-- Include Bootstrap CSS -->

        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.js"></script>

        <style>
            .related-products .card {
                margin-bottom: 20px;
            }
            .related-products card img {
                width:100%;
                height: 200px;
                object-fit: cover;
            }

            .main-body{
                margin-top: 150px;
            }
            .btn.btn-primary:focus {
                box-shadow: none; /* Loại bỏ shadow khi focus */
                outline: none; /* Loại bỏ outline khi focus */
            }
            .btn.btn-primary {
                background-color: black;
                border: none;
            }
            .btn.btn-primary:focus {
                box-shadow: none; /* Loại bỏ shadow khi focus */
                outline: none; /* Loại bỏ outline khi focus */
            }
            .btn.btn-primary {
                background-color: black;
                border: none;
            }
            .recipe-section {
                margin-top: 20px;
                margin-bottom: 20px;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #f9f9f9;
            }
            .recipe-section h5 {
                font-size: 1.2rem;
                margin-bottom: 10px;
            }
            .recipe-section table {
                width: 100%;
                border-collapse: collapse;
            }
            .recipe-section table th,
            .recipe-section table td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            .recipe-section table th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
        <fmt:setLocale value="vi_VN"/>
        <jsp:include page="headerHiddenNavigation.jsp"/>
        <div style="margin-top: 100px; margin-bottom:100px;">
            <c:if test="${empty requestScope.product}">
                <h2>This product does not exist</h2>
            </c:if>
        </div>
        <c:if test="${not empty requestScope.product}">
            <div style="margin-top: 100px; margin-bottom:100px;">
                <section class="py-5">
                    <div class="container">
                        <div class="row gx-5">
                            <aside class="col-lg-6">
                                <div class="border rounded-4 mb-3 d-flex justify-content-center">
                                    <a data-fslightbox="mygalley" class="rounded-4" target="_blank" data-type="image" href="${requestScope.product.image}" >
                                        <img style="max-width: 100%; max-height: 100vh; margin-top:10vh; margin-bottom:10vh;" class="rounded-4 fit" src="${requestScope.product.image}" alt="${requestScope.product.name}"/>
                                    </a>
                                </div>
                            </aside>
                            <main class="col-lg-6">

                                <div class="ps-lg-3">
                                    <h4 class="title text-dark">
                                        ${requestScope.product.name}
                                    </h4>
                                    <div class=" flex-row my-3">
                                        <p class="text-muted"><i class="fas fa-shopping-basket fa-sm mx-1" style = "margin-right: 100px;"></i>Đã bán ${requestScope.numberOfSold}</p><br/>
                                        <c:if test="${requestScope.type eq 'Dish'}">
                                            <c:if test="${not empty requestScope.product.recipe}">
                                                <div class="recipe-section">
                                                    <h5>Công thức</h5>
                                                    <table>
                                                        <thead>
                                                            <tr>
                                                                <th>Tên nguyên liệu</th>
                                                                <th>Số lượng</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="entry" items="${requestScope.product.recipe}">
                                                                <tr>
                                                                    <td>${entry.key}</td>
                                                                    <td>${entry.value}</td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:if>
                                        </c:if>

                                        <p class="text-success ms-2">Còn hàng</p>
                                    </div>

                                    <div class="mb-3">
                                        <span class="h5"><fmt:formatNumber value="${requestScope.product.price}" type="currency" /></span>
                                    </div>
                                    <hr />
                                    <div class="row mb-4">
                                        <!-- col.// -->
                                        <form id="addToCartForm_${requestScope.product.id}" action="addToCartAction" method="POST">
                                            <div class="col-md-4 col-6 mb-3">
                                                <label class="mb-2 d-block" style = "display: flex;
                                                       margin-right: 10px;">Số lượng</label>
                                                <div class="input-group mb-3" style="width: 170px;">
                                                    <input type ="hidden" name ="productId" value ="${requestScope.product.id}"/>
                                                    <input type ="hidden" name = "type" value = "${requestScope.type}"/>
                                                    <button class="btn btn-white border border-secondary px-3" type="button" id="button-addon1" data-mdb-ripple-color="dark" onclick="changeQuantity(-1)">
                                                        <i class="fas fa-minus"></i>
                                                    </button>
                                                    <input type="number" id="quantityInput" name="quantity" class="form-control text-center border border-secondary" value="1" min="1" />
                                                    <button class="btn btn-white border border-secondary px-3" type="button" id="button-addon2" data-mdb-ripple-color="dark" onclick="changeQuantity(1)">
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <input type="hidden" id="cooked" name="cooked" value=""/>
                                            <button type="button" class="btn btn-primary shadow-0" onclick="handleAddToCart('${requestScope.product.id}', '${param.type}')">
                                                <i class="fas fa-shopping-cart"></i>
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </main>

                        </div>
                    </c:if>
                    <c:if test="${not empty requestScope.LIST_RELATED_PRODUCT}">
                        <div class="related-products mt-5">
                            <h2>Related Products</h2>
                            <div class="row">
                                <c:forEach var="relatedProduct" items="${requestScope.LIST_RELATED_PRODUCT}">
                                    <div class="col-lg-3 col-md-4 col-sm-6 col-12" style="margin-bottom:20px"> 
                                        <div class="card mb-4 card-product">
                                            <img src="${relatedProduct.image}" class="card-img-top" alt="Ảnh của ${relatedProduct.name}">
                                            <div class="card-body">
                                                <div style ="height:50px">
                                                    <h5 class="card-title">${relatedProduct.name}</h5>
                                                </div>
                                                <p class="card-text"><fmt:formatNumber value="${relatedProduct.price}" type="currency" /></p>

                                                <div style="display: flex">
                                                    <div style="flex:1 ;margin-right:10px">
                                                        <c:url var = "url" value="viewProductDetailAction">
                                                            <c:param name = "txtProductId" value ="${relatedProduct.id}"/>

                                                            <c:if test = "${requestScope.type eq 'Dish'}">
                                                                <c:param name = "type" value ="Ingredient"/>
                                                            </c:if>
                                                            <c:if test = "${requestScope.type eq 'Ingredient'}">
                                                                <c:param name = "type" value ="Ingredient"/>
                                                            </c:if>
                                                        </c:url>
                                                        <a href="${url}" class="btn btn-primary" style="width:100%">Chi tiết</a>
                                                    </div>  
                                                </div>

                                            </div>
                                        </div>
                                    </div>           
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
            </section>
        </div>

        <jsp:include page="footer.jsp"/>

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

        function changeQuantity(amount) {
            var input = document.getElementById('quantityInput');
            var currentValue = parseInt(input.value);
            if (!isNaN(currentValue)) {
                var newValue = currentValue + amount;
                if (newValue >= 1) {
                    input.value = newValue;
                }
            }
        }
    </script>
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

            if (option === 'cooked') {
                document.getElementById('cooked').value = 'true';
            } else {
                document.getElementById('cooked').value = 'false';
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
