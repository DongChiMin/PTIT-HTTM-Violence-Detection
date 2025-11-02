/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.ModelDAO;
import dao.ModelMetricDAO;
import java.io.File;
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
import model.ModelMetric;
import util.PathUtil;

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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int modelId = Integer.parseInt(req.getParameter("modelId"));
        ModelDAO modelDao = new ModelDAO();
        Model model = modelDao.getModelById(modelId);
        ModelMetricDAO modelMetricDao = new ModelMetricDAO();
        
        String action = req.getParameter("action");
        switch (action) {
            case "activate_model":
                modelDao.SetActiveById(modelId);
                
                System.out.println("Set active model: " + model.getName());
                doGet(req, resp);
                break;
            case "retrain_model":
                
                break;
            case "delete_model":
                String modelPath = PathUtil.getProjectPath() + "/" + model.getPath();
                
                //Xóa file
                File file = new File(modelPath);
                if (file.exists()) {
                    file.delete();
                } else {
                    System.out.println("file không tồn tại");
                }
                
                //Xóa DB ModelMetric
                modelMetricDao.deleteModelMetricByModelId(modelId);
                
                //Xóa DB Model
                modelDao.deleteModelById(modelId);
  
                System.out.println("Deleted model: " + model.getName() + " at direction" + modelPath);
                doGet(req, resp);
                break;    
            default:
                throw new AssertionError();
        }
    }
}
