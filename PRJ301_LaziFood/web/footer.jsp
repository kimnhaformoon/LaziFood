<%-- 
    Document   : footer
    Created on : Jun 21, 2024, 4:17:34 PM
    Author     : Kim Nha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Footer Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            .payment-methods img {
                width: 80px;
                height: auto;
                margin: 5px;
                background: white;
                border-radius: 2px;
                padding: 1px;
            }

            .chinh-sach {
                margin-left: 30px;
            }

            @media screen and (max-width: 768px) {
                .chinh-sach {
                    margin-left: 0;
                }
            }
        </style>
    </head>
    <body>
        <div id ="footer" class="bg-dark text-white pt-4">
        <div class="container">
            <div class="row py-3">
                <!-- Về chúng tôi -->
                <div class="col-md-4">
                    <h5>Về chúng tôi</h5>
                    <p style="text-align: justify;">
                        LaziFood cung cấp đa dạng các sản phẩm từ thực phẩm tươi sống, 
                        nguyên liệu nấu ăn đến các món ăn chế biến sẵn, 
                        tất cả đều được chọn lọc kỹ lưỡng để đảm bảo chất lượng cao nhất.</p>
                </div>
                <!-- Liên kết nhanh -->
                <div class="col-md-4">
                    <div class="chinh-sach">
                    <h5>Chính sách</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Chính sách khách hàng</a></li>
                        <li><a href="#" class="text-white">Chính sách giao hàng</a></li>
                        <li><a href="#" class="text-white">Chính sách đổi trả</a></li>
                    </ul>
                </div>
                </div>
                <!-- Phương thức thanh toán -->
                <div class="col-md-4">
                    <h5>Phương thức thanh toán</h5>
                    <div class="payment-methods">
                        <img src="images/payment/visa.png" alt="Visa">
                        <img src="images/payment/mastercard.png" alt="MasterCard">
                        <img src="images/payment/jcb.png" alt="JCB">
                        <img src="images/payment/cash.png" alt="Cash">
                    </div>
                </div>
                <!-- Phản hồi góp ý -->
                
            </div>
        </div>
        <div class="bg-secondary text-center py-3">
            &copy; 2024 Công ty TNHH LaziFood. Bản quyền được bảo lưu.<br/>
            Địa chỉ: Lô E2a-7, Đường D1, Long Thạnh Mỹ, Thành Phố Thủ Đức, Thành phố Hồ Chí Minh, Việt Nam <br/>
            Tổng đài hỗ trợ: 19001234 - Email: cskh@lazifood.vn
        </div>
    </div>
    </body>
</html>
