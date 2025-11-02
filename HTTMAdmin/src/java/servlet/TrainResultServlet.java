/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.AdminDAO;
import dao.ModelDAO;
import dao.ModelMetricDAO;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Admin;
import model.Model;
import model.ModelMetric;
import util.DBUtil;

/**
 *
 * @author namv2
 */
@WebServlet(name = "TrainResultServlet", urlPatterns = {"/TrainResultServlet"})
public class TrainResultServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");  // << quan trọng
        resp.setContentType("text/html;charset=UTF-8");

        // Lấy các giá trị từ request
        String accuracyNon = req.getParameter("accuracy_Non_Violence");
        String precisionNon = req.getParameter("precision_Non_Violence");
        String recallNon = req.getParameter("recall_Non_Violence");
        String f1Non = req.getParameter("f1_Non_Violence");
        String supportNon = req.getParameter("support_Non_Violence");

        String trainDuration = req.getParameter("trainDuration");

        String accuracyViolence = req.getParameter("accuracy_Violence");
        String precisionViolence = req.getParameter("precision_Violence");
        String recallViolence = req.getParameter("recall_Violence");
        String f1Violence = req.getParameter("f1_Violence");
        String supportViolence = req.getParameter("support_Violence");

        String modelNote = req.getParameter("modelNote");
        String modelName = req.getParameter("modelName");
        String trainStartTime = req.getParameter("trainStartTime");
        String trainEndTime = req.getParameter("trainEndTime");
        String trainSamples = req.getParameter("trainSamples");
        String testSamples = req.getParameter("testSamples");
//        // In ra console để test
//        System.out.println("modelNote: " + modelNote);
//        System.out.println("modelName: " + modelName);
//
//        System.out.println("Non_Violence: accuracy=" + accuracyNon + ", precision=" + precisionNon
//                + ", recall=" + recallNon + ", f1=" + f1Non + ", support=" + supportNon);
//
//        System.out.println("Violence: accuracy=" + accuracyViolence + ", precision=" + precisionViolence
//                + ", recall=" + recallViolence + ", f1=" + f1Violence + ", support=" + supportViolence);

        String formattedDuration = "00:00:00";

        if (trainDuration != null && !trainDuration.isEmpty()) {
            try {
                int totalSeconds = Integer.parseInt(trainDuration);
                int hours = totalSeconds / 3600;
                int minutes = (totalSeconds % 3600) / 60;
                int seconds = totalSeconds % 60;

                formattedDuration = String.format("%02d:%02d:%02d", hours, minutes, seconds);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // --- Truyền giá trị sang JSP ---
        req.setAttribute("modelNote", modelNote);
        req.setAttribute("modelName", modelName);
        req.setAttribute("trainStartTime", trainStartTime);
        req.setAttribute("trainEndTime", trainEndTime);
        req.setAttribute("trainSamples", trainSamples);
        req.setAttribute("testSamples", testSamples);

        req.setAttribute("trainDuration", formattedDuration);

        // Thống kê Non_Violence
        req.setAttribute("accuracyNon", accuracyNon);
        req.setAttribute("precisionNon", precisionNon);
        req.setAttribute("recallNon", recallNon);
        req.setAttribute("f1Non", f1Non);
        req.setAttribute("supportNon", supportNon);

        // Thống kê Violence
        req.setAttribute("accuracyViolence", accuracyViolence);
        req.setAttribute("precisionViolence", precisionViolence);
        req.setAttribute("recallViolence", recallViolence);
        req.setAttribute("f1Violence", f1Violence);
        req.setAttribute("supportViolence", supportViolence);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/TrainModel/TrainResult.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");  // << quan trọng
        resp.setContentType("text/html;charset=UTF-8");

        //thông tin model ---
        String modelName = req.getParameter("modelName");
        String modelNote = req.getParameter("modelNote");
        String trainStartTime = req.getParameter("trainStartTime");
        String trainEndTime = req.getParameter("trainEndTime");
        String trainSamples = req.getParameter("trainSamples");
        String testSamples = req.getParameter("testSamples");
        //String trainDuration = req.getParameter("trainDuration");
        String fileName = modelName.toLowerCase().replaceAll("[^a-z0-9]+", "_").replaceAll("^_+|_+$", "");
        String modelPath = "D:/School/MonHoc/PTC HTTM/PTIT-HTTM-Violence-Detection/HTTMAdmin/data/model/" + fileName + ".pth";

        //kết quả training Non_Violence ---
        String accuracyNon = req.getParameter("accuracyNon");
        String precisionNon = req.getParameter("precisionNon");
        String recallNon = req.getParameter("recallNon");
        String f1Non = req.getParameter("f1Non");
        String supportNon = req.getParameter("supportNon");

        //kết quả training Violence ---
        String accuracyViolence = req.getParameter("accuracyViolence");
        String precisionViolence = req.getParameter("precisionViolence");
        String recallViolence = req.getParameter("recallViolence");
        String f1Violence = req.getParameter("f1Violence");
        String supportViolence = req.getParameter("supportViolence");

        //nút hành động ---
        String action = req.getParameter("action");
        switch (action) {
            case "delete_model":
                System.out.println("Hủy bỏ model: " + modelName + "ở địa chỉ" + modelPath);
                // Chuyển thành chữ thường -> Thay tất cả ký tự không phải a-z, 0-9 thành "_" -> Bỏ "_" dư ở đầu và cuối
                File file = new File(modelPath);
                if (file.exists()) {
                    file.delete();
                } else {
                    System.out.println("file không tồn tại");
                }
                break;

            case "save":
                System.out.println("Lưu model: " + modelName);
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                ModelDAO modelDao = new ModelDAO();
                ModelMetricDAO modelMetricDao = new ModelMetricDAO();

                //Admin
                AdminDAO adminDao = new AdminDAO();
                Admin admin = adminDao.getAdminById(1);

                //BẮT ĐẦU TRANSACTION
                try {
                    Connection conn = DBUtil.getConnection(); // bắt đầu transaction
                    conn.setAutoCommit(false);
                    
                    //1. MODEL
                    Model model = new Model();
                    model.setName(modelName);
                    model.setPath(modelPath);
                    model.setAccuracy(Float.parseFloat(accuracyNon));
                    model.setRecallViolence(Float.parseFloat(accuracyNon));
                    model.setTrainStartTime(LocalDateTime.parse(trainStartTime, formatter));
                    model.setTrainEndTime(LocalDateTime.parse(trainEndTime, formatter));
                    model.setTrainSamples(Integer.parseInt(trainSamples));
                    model.setTestSamples(Integer.parseInt(testSamples));
                    model.setNote(modelNote);
                    model.setIsActive(false);
                    model.setTrainedBy(admin);
                    int modelId = modelDao.insertModel(conn, model);
                    model.setId(modelId);

                    //2.MODEL METRIC NonViolence
                    ModelMetric nonViolenceMetric = new ModelMetric();
                    nonViolenceMetric.setLabelName("Non_Violence");
                    nonViolenceMetric.setPrecisionScore(Float.parseFloat(precisionNon));
                    nonViolenceMetric.setRecall(Float.parseFloat(recallNon));
                    nonViolenceMetric.setF1score(Float.parseFloat(f1Non));
                    nonViolenceMetric.setSupport(Integer.parseInt(supportNon));
                    nonViolenceMetric.setModel(model);
                    modelMetricDao.insertModelMetric(conn, nonViolenceMetric);

                    //3. MODEL METRIC VIOLENCE
                    ModelMetric violenceMetric = new ModelMetric();
                    violenceMetric.setLabelName("Violence");
                    violenceMetric.setPrecisionScore(Float.parseFloat(precisionViolence));
                    violenceMetric.setRecall(Float.parseFloat(recallViolence));
                    violenceMetric.setF1score(Float.parseFloat(f1Violence));
                    violenceMetric.setSupport(Integer.parseInt(supportViolence));
                    violenceMetric.setModel(model);

                    modelMetricDao.insertModelMetric(conn, violenceMetric);

                    conn.commit(); // commit nếu thành công
                } catch (Exception e) {
                    try {
                        DBUtil.getConnection().rollback(); // rollback nếu lỗi
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                    e.printStackTrace();
                } finally {
                    try {
                        DBUtil.getConnection().setAutoCommit(true); // trả về auto commit
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
                break;
        }

        resp.sendRedirect(req.getContextPath() + "/ManageModelsServlet");
    }
}
