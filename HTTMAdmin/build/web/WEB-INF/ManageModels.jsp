<%-- 
    Document   : ManageModel
    Created on : Oct 23, 2025, 10:25:47 AM
    Author     : namv2
--%>
<%@page import="java.util.List"%>
<%@page import="model.Model"%>
<%@page import="model.Admin"%>
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
        <%
            List<Model> modelList = (List<Model>) request.getAttribute("modelList");
            Model activeModel = new Model();
            String activeModelAdmin = "";

            for (Model m : modelList) {
                if (m.getIsActive()) {
                    activeModel = m;
                    Admin trainedBy = m.getTrainedBy();
                    activeModelAdmin = trainedBy.getFullName();
                    break;
                }
            }

        %>
        <header class="header">
            <div class="logo">
                <h1>AI System</h1>
            </div>
            <div class="user-profile">
                <span class="admin-name">Xin chào, Nguyễn Văn A!</span>
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
                        <% if (activeModel != null) {%>
                        <h3><i class="fas fa-bolt"></i> Model đang kích hoạt: 
                            <span class="highlight"><%= activeModel.getName()%></span>
                        </h3>
                        <div class="model-details">
                            <div class="model-stats">
                                <p><strong>Accuracy:</strong> <%= activeModel.getAccuracy()%></p>
                                <p><strong>Recall (Violence):</strong> <%= activeModel.getRecallViolence()%></p>
                                <p><strong>Số lượng mẫu train:</strong> <%= activeModel.getTrainSamples()%></p>
                            </div>
                            <div class="model-meta">
                                <p><strong>Người tạo:</strong> <%= activeModelAdmin%></p>
                                <p><strong>Thời lượng training:</strong> 
                                    <%
                                        // Tính thời lượng training
                                        java.time.Duration duration = java.time.Duration.between(
                                                activeModel.getTrainStartTime(), activeModel.getTrainEndTime());
                                        long hours = duration.toHours();
                                        long minutes = duration.toMinutesPart();
                                        long seconds = duration.toSecondsPart();
                                    %>
                                    <%= String.format("%02d:%02d:%02d", hours, minutes, seconds)%>
                                </p>
                                <p><strong>Số lượng mẫu test:</strong> <%= activeModel.getTestSamples()%></p>
                            </div>
                        </div>
                    </div>
                    <% } else { %>
                    <p>Chưa có model nào đang được kích hoạt.</p>
                    <% } %>

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
                                <th>ID</th>
                                <th>Tên model</th>
                                <th>Recall (Violence)</th>
                                <th>Ngày tạo</th>
                                <th>Note</th>
                                <th>Người tạo</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("HH:mm:ss dd/MM/yyyy");
                                if (modelList != null && !modelList.isEmpty()) {
                                    for (Model model : modelList) {
                                        Admin trainedBy = model.getTrainedBy();
                            %>
                            <tr>
                                <td><%= model.getId()%></td>
                                <td><%= model.getName()%></td>
                                <td><%= String.format("%.2f", model.getRecallViolence())%></td>
                                <td>
                                    <%= model.getTrainStartTime().format(formatter)%>
                                </td>
                                <td>
                                    <%= model.getNote()%>
                                </td>
                                <td style="width: 120px"><%= trainedBy.getFullName()%></td>
                                <td class="action-buttons" style="width: 260px;">
                                    <%
                                        if (!model.getIsActive()) {
                                    %>
                                    <form action="ManageModelsServlet" method="post">
                                        <input hidden name="modelId" value="<%=model.getId()%>">
                                        <button
                                            type="submit" name="action" value="activate_model"
                                            onclick="return confirm('Bạn có chắc chắn muốn kích hoạt model này không?');"
                                            class="btn-add btn-activate">
                                            <i class="fas fa-check-circle"></i> Kích hoạt
                                        </button>
                                        <button 
                                            type="submit" name="action" value="retrain_model"
                                            class="btn-edit">
                                            <i class="fas fa-edit"></i> Retrain
                                        </button>
                                        <button 
                                            type="submit" name="action" value="delete_model"
                                            onclick="return confirm('Bạn có chắc chắn muốn xóa model này không?');"
                                            class="btn-delete">
                                            <i class="fas fa-trash-alt"></i> Xóa
                                        </button>
                                    </form>
                                    <%
                                    } else {
                                    %>
                                    <p style="font-weight: bold; color: #28a745">Model đang kích hoạt</p>
                                    <%
                                        }
                                    %>

                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="7" style="text-align:center;">Không có model nào.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </main>

        </div>
    </body>
</html>
