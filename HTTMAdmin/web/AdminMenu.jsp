<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang chủ Admin</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body>
        <header class="header">
            <div class="logo">
                <h1>AI System</h1>
            </div>
            <div class="user-profile">
                <span class="admin-name">Xin chào, Bùi Ngọc Hiếu!</span>
                <img src="https://i.pinimg.com/736x/bc/43/98/bc439871417621836a0eeea768d60944.jpg" alt="Avatar"
                     class="avatar">
                <a href="/logout">Đăng xuất</a>
            </div>
        </header>
        <div class="main-layout">
            <aside class="sidebar">
                <nav>
                    <ul>
                        <li><a href="AdminMenu.jsp" class="active"><i class="fas fa-home icon"></i>Trang chủ</a></li>
                        <li><a href="ManageSamplesServlet"><i class="fas fa-video icon"></i>Quản lý Mẫu</a></li>
                        <li>
                            <a href="ManageModelsServlet">
                           
                                    <i class="fas fa-brain icon"></i>Quản lý Model

                            </a>
                        </li>
                    </ul>
                </nav>
            </aside>
            <main class="content">
                <div class="card" >
                    <div style="text-align: center">
                        <h2>Chào mừng quay trở lại</h2>
                        <div>
                            Dùng thanh bên trái để sử dụng các chức năng của hệ thống admin
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </body>
</html>
