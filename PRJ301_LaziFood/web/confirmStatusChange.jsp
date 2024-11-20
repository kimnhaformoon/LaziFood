<%-- 
    Document   : confirmStatusChange
    Created on : Jul 4, 2024, 11:41:49 AM
    Author     : Kim Nha
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirm</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="modal fade" id="confirmLockModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmModalLabel">Xác nhận khóa người dùng</h5>
                        <a href="manageUserPage" class="close" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </a>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn muốn khóa người dùng <b>${param.username}</b>?
                    </div>
                    <div class="modal-footer">
                        <a href="manageUserPage" class="btn btn-secondary">HỦY</a>
                        <!-- Replace {id} with the actual account ID -->
                        <c:url var="urlLock" value="updateStatusAccountAction">
                            <c:param name="action" value="lock"/>
                            <c:param name="username" value="${param.username}"/>
                        </c:url>
                        <a href="${urlLock}" class="btn btn-danger">OK</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="confirmUnlockModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmModalLabel">Xác nhận mở khóa người dùng</h5>
                        <a href="manageUserPage" class="close" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </a>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn muốn mở khóa người dùng <b>${param.username}</b>?
                    </div>
                    <div class="modal-footer">
                        <a href="manageUserPage" class="btn btn-secondary">HỦY</a>
                        <!-- Replace {id} with the actual account ID -->
                        <c:url var="urlUnlock" value="updateStatusAccountAction">
                            <c:param name="action" value="unlock"/>
                            <c:param name="username" value="${param.username}"/>
                        </c:url>
                        <a href="${urlUnlock}" class="btn btn-success">OK</a>
                    </div>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                // Hiển thị modal khi trang được tải
                if (${requestScope.LOCK})
                    $('#confirmLockModal').modal('show');
                else 
                    $('#confirmUnlockModal').modal('show');
            });
        </script>
    </body>
</html>
