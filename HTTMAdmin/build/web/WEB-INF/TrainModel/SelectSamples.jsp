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
            Integer pathError = (Integer) request.getAttribute("pathError");
            Integer modelNameExistsError = (Integer) request.getAttribute("modelNameExistsError");

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
                    </ul>
                </nav>
            </aside>
            <main class="content">
                <form action="SelectSamplesServlet" method="post">
                    <h2 style="text-align: center">Huấn luyện model mới</h2>

                    <div style="display: flex; justify-content: center; align-items: flex-start; gap: 30px;">
                        <div class="card results-table" style="width: 35vw">
                            <div style="display: flex; justify-content:space-between;">
                                <h3><i class="fas fa-list-ul"></i>  Chọn mẫu bạo lực</h3>
                                <div>
                                    <button type="button" class="btn" onclick="toggleCheckboxes('violenceTable', true)">Chọn tất cả</button>
                                    <button type="button" class="btn" onclick="toggleCheckboxes('violenceTable', false)">Bỏ chọn tất cả</button>
                                </div>
                            </div>
                            <table id="violenceTable" style="width: 100%; table-layout: fixed; min-height: 50vh;">
                                <thead>
                                    <tr>
                                        <th style="text-align: center; width: 10%;">ID</th>
                                        <th style="text-align: center; width: 25%;">Tên file</th>
                                        <th style="text-align: center; width: 30%;">Video gốc</th>
                                        <th style="text-align: center; width: 25%;">Người upload</th>
                                        <th style="text-align: center; width: 10%;">Chọn</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (VideoSample vs : violenceSampleList) {
                                            RawSample rawSample = vs.getRawSample();
                                            Admin admin = rawSample.getUploadBy();
                                    %>
                                    <tr>
                                        <td style="text-align: center;"><%= vs.getId()%></td>
                                        <td><%= vs.getFileName()%></td>
                                        <td>(<%= vs.getStartSecond()%>s - <%= vs.getEndSecond()%>s) <%= rawSample.getFileName()%></td>
                                        <td style="text-align: center;"><%= admin.getFullName()%></td>
                                        <td style="text-align: center;">
                                            <input type="checkbox" name="violenceSamplePaths" value="<%= vs.getPath()%>">
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>

                            <div id="pagination1" class="pagination"></div>
                        </div>

                        <div class="card results-table" style="width: 35vw">
                            <div style="display: flex; justify-content:space-between;">
                                <h3><i class="fas fa-list-ul"></i>  Chọn mẫu không bạo lực</h3>
                                <div>
                                    <button type="button" class="btn" onclick="toggleCheckboxes('nonViolenceTable', true)">Chọn tất cả</button>
                                    <button type="button" class="btn" onclick="toggleCheckboxes('nonViolenceTable', false)">Bỏ chọn tất cả</button>
                                </div>
                            </div>
                            <table id="nonViolenceTable" style="width: 100%; table-layout: fixed; min-height: 50vh;">
                                <thead>
                                    <tr>
                                        <th style="text-align: center; width: 10%;">ID</th>
                                        <th style="text-align: center; width: 25%;">Tên file</th>
                                        <th style="text-align: center; width: 30%;">Video gốc</th>
                                        <th style="text-align: center; width: 25%;">Người upload</th>
                                        <th style="text-align: center; width: 10%;">Chọn</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (VideoSample vs : nonViolenceSampleList) {
                                            RawSample rawSample = vs.getRawSample();
                                            Admin admin = rawSample.getUploadBy();
                                    %>
                                    <tr>
                                        <td style="text-align: center;"><%= vs.getId()%></td>
                                        <td><%= vs.getFileName()%></td>
                                        <td>(<%= vs.getStartSecond()%>s - <%= vs.getEndSecond()%>s) <%= rawSample.getFileName()%></td>
                                        <td style="text-align: center;"><%= admin.getFullName()%></td>
                                        <td style="text-align: center;">
                                            <input type="checkbox" name="nonViolenceSamplePaths" value="<%= vs.getPath()%>">
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>

                            <div id="pagination2" class="pagination"></div>
                        </div>
                    </div>

                    <div class="card">
                        <div style="display: flex; justify-content: space-between;">
                            <div>
                                <div style="display: flex; justify-content: space-between; width: 320px; margin-bottom: 20px; align-items: center;">
                                    <label><strong>Tên mô hình<span style="color: red;">*</span></strong></label>
                                    <input type="text" name="modelName" required>
                                </div>
                                 <div style="display: flex; justify-content: space-between; width: 320px; align-items: center;">
                                    <label><strong>Ghi chú </strong></label>
                                    <input type="text" name="modelNote">
                                </div>
                            </div>
                                                           
                            <!--                            <div>
                                                            <div style="margin-bottom: 20px"><strong>Số mẫu bạo lực đã chọn:</strong> 0</div>
                                                            <div><strong>Số mẫu không bạo lực đã chọn:</strong> 0</div>
                                                        </div>
                            -->
                            <div style="display: flex; gap:20px; align-items:  center">
                                <button type="button" class="btn" style=" background-color: #ff6565">
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


        <%
            if (pathError != null) {
        %>
        <script>
            alert("PLease select at least 1 sample!")
        </script>


        <%
        } else if (modelNameExistsError != null) {
        %>
        <script>
            alert("Model name existed!")
        </script>
        <%
            }
        %>

        <script>
            function toggleCheckboxes(tableId, checked) {
                const table = document.getElementById(tableId);
                const checkboxes = table.querySelectorAll('input[type="checkbox"]');
                checkboxes.forEach(cb => cb.checked = checked);
            }
        </script>

        <!--Phân trang-->
        <script>
            function setupPagination(tableId, paginationId, rowsPerPage) {
                const table = document.getElementById(tableId);
                const tbody = table.querySelector("tbody");
                const rows = Array.from(tbody.querySelectorAll("tr"));
                const pagination = document.getElementById(paginationId);

                let currentPage = 1;
                const totalPages = Math.ceil(rows.length / rowsPerPage);

                function showPage(page) {
                    currentPage = page;
                    const start = (page - 1) * rowsPerPage;
                    const end = start + rowsPerPage;

                    rows.forEach((row, index) => {
                        row.style.display = (index >= start && index < end) ? "" : "none";
                    });

                    renderPagination();
                }

                function renderPagination() {
                    pagination.innerHTML = "";

                    const prev = document.createElement("button");
                    prev.textContent = "Prev";
                    prev.disabled = currentPage === 1;
                    prev.onclick = () => showPage(currentPage - 1);
                    pagination.appendChild(prev);

                    for (let i = 1; i <= totalPages; i++) {
                        const btn = document.createElement("button");
                        btn.textContent = i;
                        if (i === currentPage) btn.classList.add("active");
                        btn.disabled = i === currentPage;
                        btn.onclick = () => showPage(i);
                        pagination.appendChild(btn);
                    }

                    const next = document.createElement("button");
                    next.textContent = "Next";
                    next.disabled = currentPage === totalPages;
                    next.onclick = () => showPage(currentPage + 1);
                    pagination.appendChild(next);
                }

                showPage(1);
            }

            setupPagination("violenceTable", "pagination1", 5);
            setupPagination("nonViolenceTable", "pagination2", 5);
        </script>

    </body>

</html>
