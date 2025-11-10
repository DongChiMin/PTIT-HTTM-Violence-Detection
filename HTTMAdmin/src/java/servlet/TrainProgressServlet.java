/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import dao.VideoSampleDAO;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.VideoSample;
import util.PathUtil;

/**
 *
 * @author namv2
 */
@WebServlet(name = "TrainProgressServlet", urlPatterns = {"/TrainProgressServlet"})
public class TrainProgressServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");  // << quan trọng
        resp.setContentType("text/html;charset=UTF-8");        
        
        String jobId = (String) req.getSession().getAttribute("trainJobId");
        File logFile = new File(PathUtil.getProjectPath() +   "/logs/train_" + jobId + ".log");

        resp.setContentType("text/plain; charset=UTF-8");
        if (logFile.exists()) {
            Files.copy(logFile.toPath(), resp.getOutputStream());
        } else {
            resp.getWriter().write("Training not started yet...");
        }
//        //CHUYỂN TRANG
//        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/TrainModel/TrainProgress.jsp");
//        dispatcher.forward(req, resp);
    }
}
