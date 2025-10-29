<%-- 
    Document   : TrainResult
    Created on : Oct 23, 2025, 11:04:41 AM
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
                    </uql>
                </nav>
            </aside>
            <main class="content">
                <h2 style="text-align: center">Kết quả huấn luyện: Violence Detection V1.2</h2>

                <div style="display: flex; justify-content: space-between; align-items: stretch; gap:25px; margin-top: 20px;">

                    <!-- Thông tin model -->
                    <div class="card" style="flex: 1;">
                        <h3>Thông tin model</h3>
                        <p><strong>Tên model:</strong> Violence Detection V1.2</p>
                        <p><strong>Thời gian bắt đầu:</strong> 15:23:00 27/10/2025</p>
                        <p><strong>Thời lượng training:</strong> 3h15m27s</p>
                        <p><strong>Số lượng mẫu train:</strong> 700</p>
                        <p><strong>Số lượng mẫu test:</strong> 300</p>
                        <p><strong>Ghi chú:</strong> </p>
                    </div>

                    <!-- Kết quả trên tập test -->
                    <div class="card" style="flex: 1.2;">
                        <h3>Kết quả trên tập test</h3>
                        <p><strong>Số lượng mẫu test:</strong> 300</p>
                        <table border="1" cellspacing="0" cellpadding="6" style="width: 100%; text-align: center; border-collapse: collapse;">
                            <thead>
                                <tr style="background-color: #f0f0f0;">
                                    <th>Nhãn</th>
                                    <th>Accuracy</th>
                                    <th>Precision</th>
                                    <th>Recall</th>
                                    <th>F1-Score</th>
                                    <th>Support</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Violence</td>
                                    <td rowspan="2">0.82</td>
                                    <td>0.81</td>
                                    <td>0.76</td>
                                    <td>0.78</td>
                                    <td>150</td>
                                </tr>
                                <tr>
                                    <td>Non_Violence</td>
                                    <td>0.77</td>
                                    <td>0.82</td>
                                    <td>0.80</td>
                                    <td>150</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Các nút thao tác -->
                <div style="display: flex; justify-content: center; gap: 60px; margin-top: 40px;">
                    <button class="btn" style=" background-color: #ff6565">
                        <a href="ManageModelsServlet" style="text-decoration:none; color:inherit;">
                            Hủy bỏ
                        </a>
                    </button>
                    <button class="btn" style="background-color: #28a745">Lưu mô hình</button>
                    <button class="btn" style="background-color: #28a745">Lưu & kích hoạt mô hình</button>
                </div>

            </main>

        </div>
    </body>
</html>
