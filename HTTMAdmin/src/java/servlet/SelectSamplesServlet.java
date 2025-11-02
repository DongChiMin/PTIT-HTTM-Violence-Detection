/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.ModelDAO;
import dao.VideoSampleDAO;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.VideoSample;

/**
 *
 * @author namv2
 */
@WebServlet(name = "SelectSamplesServlet", urlPatterns = {"/SelectSamplesServlet"})
public class SelectSamplesServlet extends HttpServlet {
    private static Process trainProcess;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        
        //Nếu đang có process python đang chạy thì dừng
        if(trainProcess != null && trainProcess.isAlive()){
            trainProcess.destroy();
            System.out.println("Python process stopped!");
        } else {
            System.out.println("No running process to stop.");
        }
        
        //Lấy các thông tin cần thiết cho trang
        VideoSampleDAO videoSampleDAO = new VideoSampleDAO();
        List<VideoSample> videoSampleList = videoSampleDAO.getvideoSampleList();
        req.setAttribute("videoSampleList", videoSampleList);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/TrainModel/SelectSamples.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        
        //Lấy dữ liệu từ trang chọn mẫu
        String modelName = req.getParameter("modelName").toLowerCase();
        String modelNote = req.getParameter("modelNote");
        String[] violenceSamplePaths = req.getParameterValues("violenceSamplePaths");
        String[] nonViolenceSamplePaths = req.getParameterValues("nonViolenceSamplePaths");
        if (modelNote.isEmpty()) {
            modelNote = null;
        }
        
        //Kiểm tra lỗi chưa chọn mẫu nào
        if(violenceSamplePaths == null && nonViolenceSamplePaths == null){
            req.setAttribute("pathError", 1);
            doGet(req, resp);
            return;
        }
        
        //Kiểm tra lỗi tên model đã tồn tại
        ModelDAO modelDao = new ModelDAO();
        if(modelDao.isNameExists(modelName)){
            req.setAttribute("modelNameExistsError", 1);
            doGet(req, resp);
            return;
        }
        
        //Kiểm tra danh sách path null (không chọn mẫu của 1 nhãn bất kì) thì khởi tạo mảng rỗng
        if(violenceSamplePaths == null){
            violenceSamplePaths = new String[0];
        }
        else if(nonViolenceSamplePaths == null){
            nonViolenceSamplePaths = new String[0];
        }

        //TRAIN MODEL
        Map<String, Object> config = new HashMap<>();
        config.put("modelName", modelName);
        config.put("violenceSamplePaths", violenceSamplePaths);
        config.put("nonViolenceSamplePaths", nonViolenceSamplePaths);

        // Convert sang JSON
        File tempJson = File.createTempFile("train_config", ".json");
        ObjectMapper mapper = new ObjectMapper();
        mapper.writeValue(tempJson, config);

        // Tạo ID duy nhất cho job (dùng để lấy log)
        String jobId = UUID.randomUUID().toString();
        req.getSession().setAttribute("trainJobId", jobId);

        // Tạo luồng riêng để chạy python
        new Thread(() -> {
            try {
                ProcessBuilder pb = new ProcessBuilder("python",
                        "D:/School/MonHoc/PTC HTTM/PTIT-HTTM-Violence-Detection/HTTMAdmin/python_scripts/train_script.py",
                        tempJson.getAbsolutePath());
                pb.environment().put("PYTHONUTF8", "1");
                pb.redirectErrorStream(true);
                trainProcess = pb.start();

                // Ghi log ra file
                File logFile = new File("D:/School/MonHoc/PTC HTTM/PTIT-HTTM-Violence-Detection/HTTMAdmin/logs/train_" + jobId + ".log");
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(trainProcess.getInputStream())); BufferedWriter writer = new BufferedWriter(new FileWriter(logFile, true))) {

                    String line;
                    while ((line = reader.readLine()) != null) {
                        writer.write(line);
                        writer.newLine();
                        writer.flush();
                        System.out.println(line);
                    }
                }

                int exitCode = trainProcess.waitFor();
                System.out.println("Python exited with code: " + exitCode);

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                tempJson.delete();
            }
        }).start();

        //Set thuộc tính cho trang mới
        req.setAttribute("modelName", modelName);
        req.setAttribute("modelNote", modelNote);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        req.setAttribute("trainStartTime", LocalDateTime.now().format(formatter));
        int totalTrainSamples = violenceSamplePaths == null ? 0 : violenceSamplePaths.length + (nonViolenceSamplePaths == null ? 0 : nonViolenceSamplePaths.length);
        req.setAttribute("trainSamples", totalTrainSamples);
        

        //CHUYỂN TRANG
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/TrainModel/TrainProgress.jsp");
        dispatcher.forward(req, resp);
    }
}
