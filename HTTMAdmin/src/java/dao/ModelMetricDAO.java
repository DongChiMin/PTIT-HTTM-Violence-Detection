/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import model.ModelMetric;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DBUtil;

/**
 *
 * @author namv2
 */
public class ModelMetricDAO {

    public ModelMetricDAO() {
    }

    public void insertModelMetric(Connection conn, ModelMetric violenceMetric, ModelMetric nonViolenceMetric) {
        String sql = """
        INSERT INTO tblModelMetric (labelName, precisionScore, recall, f1score, support, tblModelid)
        VALUES (?, ?, ?, ?, ?, ?)
    """;

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, violenceMetric.getLabelName());
            ps.setFloat(2, violenceMetric.getPrecisionScore());
            ps.setFloat(3, violenceMetric.getRecall());
            ps.setFloat(4, violenceMetric.getF1score());
            ps.setInt(5, violenceMetric.getSupport());
            ps.setInt(6, violenceMetric.getModel().getId());

            ps.executeUpdate();
            
            ps.setString(1, nonViolenceMetric.getLabelName());
            ps.setFloat(2, nonViolenceMetric.getPrecisionScore());
            ps.setFloat(3, nonViolenceMetric.getRecall());
            ps.setFloat(4, nonViolenceMetric.getF1score());
            ps.setInt(5, nonViolenceMetric.getSupport());
            ps.setInt(6, nonViolenceMetric.getModel().getId());

            ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(ModelMetricDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean deleteModelMetricByModelId(int modelId){
        String sql = "DELETE FROM tblModelMetric WHERE tblModelid = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, modelId);
            ps.executeUpdate();  // trả về số dòng bị ảnh hưởng nếu muốn
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
