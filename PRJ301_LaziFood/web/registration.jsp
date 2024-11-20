<%-- 
    Document   : registration
    Created on : 20-06-2024, 08:02:35
    Author     : long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng kí</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
        <!--        <link href="css/styleLogin.css" rel="stylesheet" type="text/css"/>-->
        <style>.header {
                padding: 10px;
                padding-left: 50px;
                align-items: center;
            }

            .logo-home {
                width: 250px;
            }

            .login-container, .register-container {
                background-color: #D4A7B4;
                align-items: center;
            }

            .login-logo {
                text-align: center;
            }

            .login-logo img {
                width: 25vw;
                margin-top: 5vh;
            }

            .login-form button, #submitBtn {
                width: 100%;
                height: 40px;
                padding: 5px;
                background: black;
                border-radius: 5px;
                color: white;
                font-size: 16px;
            }

            .login-form form, .register-form form {
                background-color: white;
                border-radius: 5px;
                padding: 40px;
            }

            .login-form label, .register-form label {
                font-weight: bold;
            }

            .login-form, .register-form {
                padding: 5vw 10vw 5vw 2vw;
            }

            .register-btn a{
                color: #D4A7B4; 
                font-weight: bold;
            }

            .register-btn a:hover {
                color: #D4A7B4; 
                font-weight: bold;
            }

            .register-btn {
                text-align: center;
            }

            .slogan {
                margin-top: 30px;
                font-size: 28px;
                color: white;
            }

            @media screen and (max-width: 768px) {
                .login-form, .register-form {
                    padding: 10vw;
                }
            }
        </style>
        <script>
            function validatePasswordComfirm() {
                var password = document.getElementById("password").value;
                var confirmPassword = document.getElementById("confirmPassword").value;

                if (password !== confirmPassword) {
                    // Show error message
                    document.getElementById("confirmPasswordError").innerText = "Mật khẩu không trùng khớp";
                    document.getElementById("confirmPasswordError").style.color = "red";
                    document.getElementById("submitBtn").disabled = true;
                    return false; // Prevent form submission
                } else {
                    // Clear error message
                    document.getElementById("confirmPasswordError").innerText = "";
                    document.getElementById("submitBtn").disabled = false;
                    return true; // Allow form submission
                }
            }
        </script>
    </head>
    <body>
        <div class="container-fluid row header">
            <div class="col-md-8 ">
                <a href="homePage"><img class="logo-home" src="images/logo/logohome.png" alt="home-logo"></a>
            </div>
            <h2 class="col-md-4" style="text-align: center;">Đăng ký</h2>
        </div>
        <div class="container-fluid">
            <div class="row register-container">
                <div class="col-md-6 login-logo">
                    <img src="images/logo/logoblack.png" alt="login-logo" />
                    <p class="slogan">Giải pháp cho bữa ăn lành mạnh, tiết kiệm thời gian</p>
                </div>
                <div class="col-md-6 register-form">
                    <form action="registrationAction" method="POST" accept-charset="UTF-8">
                        <h3 style="text-align: center; margin-bottom: 30px;">Đăng ký</h3>
                        <c:if test="${not empty requestScope.Error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${requestScope.Error}
                            </div>                        
                        </c:if>
                        <div class="form-group">
                            <label for="username">Tên đăng nhập</label>
                            <input class="form-control" type="text" id="username" name="txtUsername" placeholder="Tên đăng nhập" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input class="form-control" type="email" id="email" name="txtEmail" placeholder="Email" required>
                        </div>
                        <div class="form-group">
                            <label for="fullName">Họ và tên</label>
                            <input class="form-control" type="text" id="fullName" name="txtFullName" placeholder="Họ và tên" required>
                        </div>
                        <div class="form-group">
                            <label for="phone">Số điện thoại</label>
                            <input class="form-control" type="text" id="phone" name="txtPhone" placeholder="Số điện thoại" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Mật khẩu</label>
                            <input class="form-control" type="password" id="password" name="txtPassword" placeholder="Mật khẩu" required>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Nhập lại mật khẩu</label>
                            <input class="form-control" type="password" id="confirmPassword" name="txtConfirmPassword" placeholder="Nhập lại mật khẩu" required oninput="validatePasswordComfirm() ">
                            <span id="confirmPasswordError" class="error-message"></span>
                        </div>
                        <div class="form-group">
                            <input type="submit" id="submitBtn" value="ĐĂNG KÝ" disabled>
                        </div>
                        <p style="text-align: center; color: gray;">HOẶC</p>
                        <p class="register-btn">Bạn đã có tài khoản? <a href="loginPage">Đăng nhập</a></p>
                    </form>
                </div>
            </div>
        </div>
        
        <jsp:include page="footer.jsp"/>

        
    </body>
</html>