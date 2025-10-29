<%-- 
    Document   : TrainProgress
    Created on : Oct 23, 2025, 11:03:19 AM
    Author     : namv2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
                    <li><a href="${pageContext.request.contextPath}/AdminMenu.jsp"><i class="fas fa-home icon"></i>Trang chủ</a></li>
                    <li><a href="../SampleManage.html"><i class="fas fa-video icon"></i>Quản lý Mẫu</a></li>
                    <li><a href="ManageModelsServlet" class="active"><i class="fas fa-brain icon"></i>Quản lý Model</a>
                    </li>
                </ul>
            </nav>
        </aside>
        <main class="content">
            <h2 style="text-align: center">Đang huấn luyện</h2>

            <div class="card">
                <div style="text-align: center">
                    <div style="margin-bottom: 200px">Đang huấn luyện mô hình Violence Detection v1.2...</div>
                    <div style="margin-bottom: 25px"><strong>Tiến độ epoch: 0/10</strong></div>
                    <form action="TrainResultServlet" method="get">
                        <button type="submit" class="btn" style="background-color: #ff6565">
                       
                            Hủy bỏ
                       
                    </button>
                    </form>
                </div>
                    
                </div>
                </div>
            </div>

        </main>
    </div>
</body>

</html>
