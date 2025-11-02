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
        <%
            String modelName = (String) request.getAttribute("modelName");
            String modelNote = (String) request.getAttribute("modelNote");
            String trainStartTime = (String) request.getAttribute("trainStartTime");
            String trainEndTime = (String) request.getAttribute("trainEndTime");
            String trainSamples = (String) request.getAttribute("trainSamples");
            String testSamples = (String) request.getAttribute("testSamples");

            String trainDuration = (String) request.getAttribute("trainDuration");

            String accuracyNon = (String) request.getAttribute("accuracyNon");
            String precisionNon = (String) request.getAttribute("precisionNon");
            String recallNon = (String) request.getAttribute("recallNon");
            String f1Non = (String) request.getAttribute("f1Non");
            String supportNon = (String) request.getAttribute("supportNon");

            String accuracyViolence = (String) request.getAttribute("accuracyViolence");
            String precisionViolence = (String) request.getAttribute("precisionViolence");
            String recallViolence = (String) request.getAttribute("recallViolence");
            String f1Violence = (String) request.getAttribute("f1Violence");
            String supportViolence = (String) request.getAttribute("supportViolence");
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
                        <li><a href="../SampleManage.html"><i class="fas fa-video icon"></i>Quản lý Mẫu</a></li>
                        <li><a href="ManageModelsServlet" class="active"><i class="fas fa-brain icon"></i>Quản lý Model</a>
                        </li>
                        </uql>
                </nav>
            </aside>
            <main class="content">
                <h2 style="text-align: center">Kết quả huấn luyện: <%=modelName%></h2>

                <div style="display: flex; justify-content: space-between; align-items: stretch; gap:25px; margin-top: 20px;">

                    <!-- Thông tin model -->
                    <div class="card" style="flex: 1;">
                        <h3>Thông tin model</h3>
                        <p><strong>Tên model:</strong> <%= modelName%></p>
                        <p><strong>Thời gian bắt đầu:</strong> <%=trainStartTime%></p>
                        <p><strong>Thời lượng training:</strong> <%=trainDuration%></p>
                        <p><strong>Số lượng mẫu train:</strong> <%=trainSamples%></p>
                        <p><strong>Số lượng mẫu test:</strong> <%=testSamples%></p>
                        <p><strong>Ghi chú:</strong> <%=modelNote%></p>
                    </div>

                    <!-- Kết quả trên tập test -->
                    <div class="card" style="flex: 1.2;">
                        <h3>Kết quả trên tập test</h3>
                        <p><strong>Số lượng mẫu test:</strong> <%=testSamples%></p>
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
                                    <td>Non_Violence</td>
                                    <td><%= String.format("%.2f", Double.parseDouble(accuracyNon))%></td>
                                    <td><%= String.format("%.2f", Double.parseDouble(precisionNon))%></td>
                                    <td><%= String.format("%.2f", Double.parseDouble(recallNon))%></td>
                                    <td><%= String.format("%.2f", Double.parseDouble(f1Non))%></td>
                                    <td><%= supportNon%></td> 
                                </tr>
                                <tr>
                                    <td>Violence</td>
                                    <td><%= String.format("%.2f", Double.parseDouble(accuracyViolence))%></td>
                                    <td><%= String.format("%.2f", Double.parseDouble(precisionViolence))%></td>
                                    <td><%= String.format("%.2f", Double.parseDouble(recallViolence))%></td>
                                    <td><%= String.format("%.2f", Double.parseDouble(f1Violence))%></td>
                                    <td><%= supportViolence%></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Các nút thao tác -->
                <form action="TrainResultServlet" method="post">
                    <!-- dữ liệu model -->
                    <input type="hidden" name="modelName" value="<%=modelName%>">
                    <input type="hidden" name="modelNote" value="<%=modelNote%>">
                    <input type="hidden" name="trainStartTime" value="<%=trainStartTime%>">
                    <input type="hidden" name="trainEndTime" value="<%=trainEndTime%>">
                    <input type="hidden" name="trainSamples" value="<%=trainSamples%>">
                    <input type="hidden" name="testSamples" value="<%=testSamples%>">
                    <input type="hidden" name="trainDuration" value="<%=trainDuration%>">

                    <!--kết quả test -->
                    <input type="hidden" name="accuracyNon" value="<%=accuracyNon%>">
                    <input type="hidden" name="precisionNon" value="<%=precisionNon%>">
                    <input type="hidden" name="recallNon" value="<%=recallNon%>">
                    <input type="hidden" name="f1Non" value="<%=f1Non%>">
                    <input type="hidden" name="supportNon" value="<%=supportNon%>">

                    <input type="hidden" name="accuracyViolence" value="<%=accuracyViolence%>">
                    <input type="hidden" name="precisionViolence" value="<%=precisionViolence%>">
                    <input type="hidden" name="recallViolence" value="<%=recallViolence%>">
                    <input type="hidden" name="f1Violence" value="<%=f1Violence%>">
                    <input type="hidden" name="supportViolence" value="<%=supportViolence%>">

                    <div style="display: flex; justify-content: center; gap: 60px; margin-top: 40px;">
                        <button type="submit" name="action" value="delete_model" class="btn" style="background-color: #ff6565"
                                onclick="return confirm('Bạn có chắc chắn muốn hủy bỏ model này không?');">Hủy bỏ model</button>
                        <button type="submit" name="action" value="save" class="btn"
                                onclick="return confirm('Lưu model vào cơ sở dữ liệu?');">Lưu mô hình</button>
                    </div>
                </form>

            </main>

        </div>
    </body>
</html>
