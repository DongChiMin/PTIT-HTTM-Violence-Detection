<%-- 
    Document   : SelectSamples
    Created on : Oct 23, 2025, 10:49:25 AM
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
                <h2 style="text-align: center">Huấn luyện model mới</h2>
                <h3 style="color: var(--primary-color); font-size: 25px">1. Chọn mẫu</h3>

                <div style="display: flex; justify-content: center; gap: 30px;">
                    <div class="card results-table">
                        <div style="display: flex; justify-content:space-between;">
                            <h3><i class="fas fa-list-ul"></i>  Chọn mẫu bạo lực</h3>
                            <div>
                                <button class="btn">Chọn tất cả</button>
                                <button class="btn">Bỏ chọn tất cả</button>
                            </div>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <th><strong> Tên file</strong></th>
                                    <th>Thời lượng</th>
                                    <th>Ngày upload</th>
                                    <th>Người upload</th>
                                    <th>Chọn</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>vio1.mp4</td>
                                    <td>00:00:05</td>
                                    <td>11:00:23 12/09/2025</td>
                                    <td>Bùi Ngọc Hiếu</td>
                                    <td>
                                        <input type="checkbox"> 
                                    </td>
                                </tr>

                                <tr>
                                    <td>vio3.mp4</td>
                                    <td>00:00:05</td>
                                    <td>11:02:30 12/09/2025</td>
                                    <td>Bùi Ngọc Hiếu</td>
                                    <td>
                                        <input type="checkbox"> 
                                    </td>
                                </tr>

                                <tr>
                                    <td>vio4.mp4</td>
                                    <td>00:00:05</td>
                                    <td>11:04:20 12/09/2025</td>
                                    <td>Bùi Ngọc Hiếu</td>
                                    <td>
                                        <input type="checkbox"> 
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                    </div>

                    <div class="card results-table">
                        <div style="display: flex; justify-content:space-between;">
                            <h3><i class="fas fa-list-ul"></i>  Chọn mẫu không bạo lực</h3>
                            <div>
                                <button class="btn">Chọn tất cả</button>
                                <button class="btn">Bỏ chọn tất cả</button>
                            </div>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <th>Tên file</th>
                                    <th>Thời lượng</th>
                                    <th>Ngày upload</th>
                                    <th>Người upload</th>
                                    <th>Chọn</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>vio1.mp4</td>
                                    <td>00:00:05</td>
                                    <td>11:00:23 12/09/2025</td>
                                    <td>Trịnh Hoàng Hiệp</td>
                                    <td>
                                        <input type="checkbox"> 
                                    </td>
                                </tr>

                                <tr>
                                    <td>vio1.mp4</td>
                                    <td>00:00:05</td>
                                    <td>11:02:30 12/09/2025</td>
                                    <td>Nguyễn Thị Hiền</td>
                                    <td>
                                        <input type="checkbox"> 
                                    </td>
                                </tr>

                                <tr>
                                    <td>vio1.mp4</td>
                                    <td>00:00:05</td>
                                    <td>11:04:20 12/09/2025</td>
                                    <td>Nguyễn Thị Hiền</td>
                                    <td>
                                        <input type="checkbox"> 
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                </div>

                <h3 style="color: var(--primary-color); font-size: 25px">2. Xác nhận và train mô hình</h3>
                <div class="card">
                    <div style="display: flex; justify-content: space-between;">
                        <div>
                            <div style="display: flex; justify-content: space-between; width: 300px; margin-bottom: 20px">
                                <label><strong>tên mô hình: </strong></label>
                                <input>
                            </div>
                            <div style="display: flex; justify-content: space-between; width: 300px">
                                <label><strong>Ghi chú: </strong></label>
                                <input>
                            </div>
                        </div>
                        <div>
                            <div style="margin-bottom: 20px"><strong>Số mẫu bạo lực đã chọn:</strong> 0</div>
                            <div><strong>Số mẫu không bạo lực đã chọn:</strong> 0</div>
                        </div>
                        <div>
                            <form action="TrainProgressServlet" method="get">
                                <button type="submit" class="btn" style="background-color: #ff6565">
                                    Hủy bỏ
                                </button>
                                <button type="submit" class="btn" style="background-color: #28a745">
                                    Huấn luyện model 
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </body>

</html>
