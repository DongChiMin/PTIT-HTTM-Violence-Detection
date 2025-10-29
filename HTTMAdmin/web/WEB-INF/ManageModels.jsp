<%-- 
    Document   : ManageModel
    Created on : Oct 23, 2025, 10:25:47 AM
    Author     : namv2
--%>

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
                        <li><a href="${pageContext.request.contextPath}/AdminMenu.jsp"><i class="fas fa-home icon"></i>Trang chủ</a></li>
                        <li><a href="SampleManage.html"><i class="fas fa-video icon"></i>Quản lý Mẫu</a></li>
                        <li><a href="ManageModelsServlet" class="active"><i class="fas fa-brain icon"></i>Quản lý Model</a>
                        </li>
                    </ul>
                </nav>
            </aside>
            <main class="content">
    <h2>Quản lý Model AI</h2>

    <!-- Khu vực thông tin model & chức năng -->
    <div class="model-overview">
        <!-- Thông tin model đang kích hoạt -->
        <div class="card model-active">
            <h3><i class="fas fa-bolt"></i> Model đang kích hoạt: <span class="highlight">Violence Detection v1.1</span></h3>
            <div class="model-details">
                <div class="model-stats">
                    <p><strong>Accuracy:</strong> 92%</p>
                    <p><strong>Recall (Violence):</strong> 88%</p>
                    <p><strong>Số lượng mẫu train:</strong> 700</p>
                </div>
                <div class="model-meta">
                    <p><strong>Người tạo:</strong> Bùi Ngọc Hiếu</p>
                    <p><strong>Thời lượng training:</strong> 03h12m23s</p>
                    <p><strong>Số lượng mẫu test:</strong> 300</p>
                </div>
            </div>
        </div>

        <!-- Tính năng -->
        <div class="card model-actions">
            <h3><i class="fas fa-tools"></i> Tính năng</h3>
            <form action="SelectSamplesServlet" method="get">
                <button type="submit" class="btn btn-train-full">
                    <i class="fas fa-cogs"></i> Huấn luyện model mới
                </button>
            </form>
        </div>
    </div>

    <!-- Danh sách các model -->
    <div class="card results-table">
        <h3><i class="fas fa-list-ul"></i> Danh sách Model đã huấn luyện</h3>
        <table>
            <thead>
                <tr>
                    <th>id</th>
                    <th>Tên model</th>
                    <th>Recall (Violence)</th>
                    <th>Ngày tạo</th>
                    <th>Note</th>
                    <th>Người tạo</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>2</td>
                    <td>Violence Detection v1.1</td>
                    <td>0.96</td>
                    <td>23:59:02 05/10/2025</td>
                    <td><span class="status status-active">Cải thiện mẫu train</span></td>
                    <td>Trịnh Hoàng Hiệp</td>
                    <td class="action-buttons">
                        <button class="btn-add btn-activate"><i class="fas fa-check-circle"></i> Kích hoạt</button>
                        <button class="btn-edit"><i class="fas fa-edit"></i> Retrain</button>
                        <button class="btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa model này?')">
                            <i class="fas fa-trash-alt"></i> Xóa
                        </button>
                    </td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>Violence Detection v1.0</td>
                    <td>0.83</td>
                    <td>07:45:16 12/05/2025</td>
                    <td><span class="status status-inactive">—</span></td>
                    <td>Bùi Ngọc Hiếu</td>
                    <td class="action-buttons">
                        <button class="btn-add btn-activate"><i class="fas fa-check-circle"></i> Kích hoạt</button>
                        <button class="btn-edit"><i class="fas fa-edit"></i> Retrain</button>
                        <button class="btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa model này?')">
                            <i class="fas fa-trash-alt"></i> Xóa
                        </button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</main>

        </div>
    </body>
</html>
