<%-- 
    Document   : login
    Created on : Jun 19, 2024, 8:22:49 PM
    Author     : Kim Nha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng nhập</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
        <!--        <link href="css/styleLogin.css" rel="stylesheet" type="text/css"/>-->
        <style>
            .header {
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
                min-height: 90vh;
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
    </head>
    <body>
        <div class="container-fluid row header">
            <div class="col-md-8 ">
                <a href="homePage"><img class="logo-home" src="images/logo/logohome.png" alt="home-logo"></a>
            </div>
            <h2 class="col-md-4" style="text-align: center;">Đăng nhập</h2>
        </div>
        <div class="container-fluid">
            <div class="row login-container">
                <div class="col-md-6 login-logo">
                    <img src="images/logo/logoblack.png" alt="login-logo" />
                    <p class="slogan">Giải pháp cho bữa ăn lành mạnh, tiết kiệm thời gian</p>
                </div>
                <div class="col-md-6 login-form">
                    <form action="loginAction" method="post">
                        <h3 style="text-align: center; margin-bottom: 30px;">Đăng nhập</h3>
                        <label>TÊN ĐĂNG NHẬP</label>
                        <p><input class="form-control" type="text" placeholder="Tên đăng nhập" name="txtusername" value="${param.txtusername}" required/></p>
                        <label>MẬT KHẨU</label>
                        <p><input class="form-control" type="password" placeholder="Mật khẩu" name="txtpassword" value="${param.txtpassword}" required/></p>
                        <p><button type="submit">ĐĂNG NHẬP</button></p>
                        <c:if test="${not empty requestScope.ERROR}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${requestScope.ERROR}
                            </div>
                        </c:if>
                        <p style="text-align: center; color: gray;">HOẶC</p>
                        <p class="register-btn">Chưa có tài khoản? <a href="registrationPage">Đăng ký</a></p>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>

