/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.VideoSampleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Lấy các thông tin cần thiết cho trang
        VideoSampleDAO videoSampleDAO = new VideoSampleDAO();
        List<VideoSample> videoSampleList = videoSampleDAO.getvideoSampleList();
        req.setAttribute("videoSampleList", videoSampleList);
        
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/TrainModel/SelectSamples.jsp");
        dispatcher.forward(req, resp);
    }
    
}
