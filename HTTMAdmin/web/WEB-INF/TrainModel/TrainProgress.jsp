<%-- 
    Document   : TrainProgress
    Created on : Oct 23, 2025, 11:03:19 AM
    Author     : namv2
--%>

<%@page import="java.time.LocalDateTime"%>
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
            int trainSamples = (int) request.getAttribute("trainSamples");
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
                <h2 style="text-align: center">Huấn luyện mô hình mới</h2>
                <div class="card">
                    <div>
                        <div style="margin-bottom: 20px">Đang huấn luyện mô hình <%=modelName%>...</div>
                        <div class="card" style="width: 70vw; height: 350px; background:#111; color:#0f0; padding:10px;">
                            <div class="card-header" style="margin-bottom: 20px">
                                Training Log
                            </div>
                            <div class="card-body" style="height: 350px; overflow: auto;">
                                <pre id="logArea" style="margin:0; white-space: pre;">
                                </pre>
                            </div>
                        </div>

                        <div style="display: flex; justify-content: space-between">
                            <form action="SelectSamplesServlet" method="get">
                                <button type="submit" class="btn" style="background-color: #ff6565">
                                    Hủy bỏ
                                </button>
                            </form>
                            <form action="TrainResultServlet" method="get">
                                <input hidden name="modelNote" value="<%=modelNote%>">
                                <input hidden name="modelName" value="<%=modelName%>">
                                <input hidden name="trainStartTime" value="<%=trainStartTime%>">
                                <input hidden name="trainEndTime" id="trainEndTime">
                                <input hidden name="trainSamples" value="<%=trainSamples%>">
                                <input hidden name="testSamples" id="testSamples" value="0">
                                
                                <input hidden name="trainDuration" id="trainDuration">

                                <input type="hidden" name="accuracy_Non_Violence" id="accuracy_Non_Violence">
                                <input type="hidden" name="precision_Non_Violence" id="precision_Non_Violence">
                                <input type="hidden" name="recall_Non_Violence" id="recall_Non_Violence">
                                <input type="hidden" name="f1_Non_Violence" id="f1_Non_Violence">
                                <input type="hidden" name="support_Non_Violence" id="support_Non_Violence">

                                <input type="hidden" name="accuracy_Violence" id="accuracy_Violence">
                                <input type="hidden" name="precision_Violence" id="precision_Violence">
                                <input type="hidden" name="recall_Violence" id="recall_Violence">
                                <input type="hidden" name="f1_Violence" id="f1_Violence">
                                <input type="hidden" name="support_Violence" id="support_Violence">

                                <button disabled id="viewResult" type="submit" class="btn-green">
                                    Xem kết quả
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <script>
            let logInterval; // giữ ID interval để dừng
            let trainingDone = false;
            let lastLength = 0;
            let trainDuration = 0;
            function fetchLog() {
                if (trainingDone)
                    return;

                fetch("TrainProgressServlet")
                        .then(response => response.text())
                        .then(data => {
                            document.getElementById("logArea").textContent = data;

                            const viewResultButton = document.getElementById("viewResult");
                            if (data.includes("DONE")) {
                                // Dừng fetch
                                trainingDone = true;
                                clearInterval(logInterval);

                                // Lọc JSON giữa tag ===JSON_RESULT_START=== và ===JSON_RESULT_END===
                                const startTag = "===JSON_RESULT_START===";
                                const endTag = "===JSON_RESULT_END===";
                                const startIdx = data.indexOf(startTag);
                                const endIdx = data.indexOf(endTag);
                                let totalSupport = 0;

                                if (startIdx !== -1 && endIdx !== -1) {
                                    const jsonStr = data.substring(startIdx + startTag.length, endIdx).trim();
                                    try {
                                        const result = JSON.parse(jsonStr);

                                        // Gán giá trị vào các input theo label
                                        result.classes.forEach(cls => {
                                            // Giả sử bạn có input id = "accuracy_Violence", "precision_Non_Violence", ...
                                            const label = cls.label.replace(/\s+/g, '_'); // Non_Violence, Violence
                                            const accuracyInput = document.getElementById('accuracy_' + label);
                                            const precisionInput = document.getElementById('precision_' + label);
                                            const recallInput = document.getElementById('recall_' + label);
                                            const f1Input = document.getElementById('f1_' + label);
                                            const supportInput = document.getElementById('support_' + label);

                                            if (accuracyInput)
                                                accuracyInput.value = cls.accuracy;
                                            if (precisionInput)
                                                precisionInput.value = cls.precision;
                                            if (recallInput)
                                                recallInput.value = cls.recall;
                                            if (f1Input)
                                                f1Input.value = cls.f1_score;
                                            if (supportInput)
                                                supportInput.value = cls.support;
                                            totalSupport += cls.support;
                                        });

                                        const totalAccInput = document.getElementById("total_accuracy");
                                        if (totalAccInput)
                                            totalAccInput.value = result.total_accuracy;

                                    } catch (err) {
                                        console.error("Error parsing JSON result:", err);
                                    }
                                }

                                document.getElementById("trainDuration").value = trainDuration;
                                document.getElementById("trainEndTime").value = new Date().toISOString().slice(0, 19).replace('T', ' ');
                                document.getElementById("testSamples").value = totalSupport;
                                console.log(totalSupport + " " + new Date().toISOString().slice(0, 19));
                                viewResultButton.disabled = false;  // bật nút
                            } else {
                                trainDuration += 2;
                                viewResultButton.disabled = true;   // tạm thời tắt
                            }
                        });
            }

            logInterval = setInterval(fetchLog, 2000); // Mỗi 2 giây cập nhật log
        </script>
    </body>

</html>
