/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.ModelDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Model;

/**
 *
 * @author namv2
 */
@WebServlet(name = "ManageModelsServlet", urlPatterns = {"/ManageModelsServlet"})
public class ManageModelsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Lấy các thông tin cần thiết cho trang
        ModelDAO modelDAO = new ModelDAO();
        List<Model> modelList = modelDAO.getModelList();
        req.setAttribute("modelList", modelList);
        
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/ManageModels.jsp");
        dispatcher.forward(req, resp);
    }
    
}
