<%-- 
    Document   : SelectSamples
    Created on : Oct 23, 2025, 10:49:25 AM
    Author     : namv2
--%>

<%@page import="model.Admin"%>
<%@page import="model.RawSample"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.VideoSample"%>
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
            List<VideoSample> videoSampleList = (List<VideoSample>) request.getAttribute("videoSampleList");
            List<VideoSample> violenceSampleList = new ArrayList<>();
            List<VideoSample> nonViolenceSampleList = new ArrayList<>();

            for (VideoSample vs : videoSampleList) {
                if (vs.getLabel().equalsIgnoreCase("violence")) {
                    violenceSampleList.add(vs);
                } else {
                    nonViolenceSampleList.add(vs);
                }
            }
        %>
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
                <form action="TrainProgressServlet" method="get">
                    <h2 style="text-align: center">Huấn luyện model mới</h2>
                    <h3 style="color: var(--primary-color); font-size: 25px">1. Chọn mẫu</h3>

                    <div style="display: flex; justify-content: center; gap: 30px;">
                        <div class="card results-table">
                            <div style="display: flex; justify-content:space-between;">
                                <h3><i class="fas fa-list-ul"></i>  Chọn mẫu bạo lực</h3>
                                <div>
                                    <button class="btn" onclick="toggleCheckboxes('violenceTable', true)">Chọn tất cả</button>
                                    <button class="btn" onclick="toggleCheckboxes('violenceTable', false)">Bỏ chọn tất cả</button>
                                </div>
                            </div>
                            <table id="violenceTable">
                                <thead>
                                    <tr>
                                        <th><strong> id</strong></th>
                                        <th><strong> Tên file</strong></th>
                                        <th>Video gốc</th>
                                        <th>Người upload</th>
                                        <th>Chọn</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (VideoSample vs : violenceSampleList) {
                                            RawSample rawSample = vs.getRawSample();
                                            Admin admin = rawSample.getUploadBy();
                                    %>
                                    <tr>
                                        <td><%= vs.getId()%></td>
                                        <td><%= vs.getFileName()%></td>
                                        <td>(<%= vs.getStartSecond()%>s - <%= vs.getEndSecond()%>s) <%= rawSample.getFileName()%></td>
                                        <td><%= admin.getFullName()%></td>
                                        <td>
                                            <input type="checkbox" name="violenceSamples" value="<%= vs.getId()%>">
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>

                        <div class="card results-table">
                            <div style="display: flex; justify-content:space-between;">
                                <h3><i class="fas fa-list-ul"></i>  Chọn mẫu không bạo lực</h3>
                                <div>

                                    <button class="btn" onclick="toggleCheckboxes('nonViolenceTable', true)">Chọn tất cả</button>
                                    <button class="btn" onclick="toggleCheckboxes('nonViolenceTable', false)">Bỏ chọn tất cả</button>
                                </div>
                            </div>
                            <table id="nonViolenceTable">
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
                                    <%
                                        for (VideoSample vs : nonViolenceSampleList) {
                                            RawSample rawSample = vs.getRawSample();
                                            Admin admin = rawSample.getUploadBy();
                                    %>
                                    <tr>
                                        <td><%= vs.getId()%></td>
                                        <td><%= vs.getFileName()%></td>
                                        <td>(<%= vs.getStartSecond()%>s - <%= vs.getEndSecond()%>s) <%= rawSample.getFileName()%></td>
                                        <td><%= admin.getFullName()%></td>
                                        <td>
                                            <input type="checkbox" name="violenceSamples" value="<%= vs.getId()%>">
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
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
                            <div style="display: flex; gap:20px; align-items:  center">
                                <button class="btn" style=" background-color: #ff6565">
                                    <a href="ManageModelsServlet" style="text-decoration:none; color:inherit;">
                                        Hủy bỏ
                                    </a>
                                </button>
                                <button type="submit" class="btn" style="background-color: #28a745">
                                    Huấn luyện model 
                                </button>

                            </div>
                        </div>
                    </div>
                </form>
            </main>
        </div>
        <script>
            function toggleCheckboxes(tableId, checked) {
                const table = document.getElementById(tableId);
                const checkboxes = table.querySelectorAll('input[type="checkbox"]');
                checkboxes.forEach(cb => cb.checked = checked);
            }
        </script>

    </body>

</html>
