/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author namv2
 */
@WebServlet(name = "TrainProgressServlet", urlPatterns = {"/TrainProgressServlet"})
public class TrainProgressServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String modelName = req.getParameter("modelName");
        String modelNote = req.getParameter("modelNote");
        String[] violenceSampleIds = req.getParameterValues("violenceSampleIds");
        String[] nonViolenceSampleIds = req.getParameterValues("nonViolenceSampleIds");

        System.out.println(modelName + " " + modelNote);
        System.out.println(violenceSampleIds.length + " " + nonViolenceSampleIds.length);
        if (modelNote.isEmpty()) {
            modelNote = null;
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/TrainModel/TrainProgress.jsp");
        dispatcher.forward(req, resp);
    }
}
