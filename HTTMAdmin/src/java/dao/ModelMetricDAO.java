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

    public int insertModelMetric(Connection conn, ModelMetric metric) {
        String sql = """
        INSERT INTO tblModelMetric (labelName, precisionScore, recall, f1score, support, tblModelid)
        VALUES (?, ?, ?, ?, ?, ?)
    """;

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, metric.getLabelName());
            ps.setFloat(2, metric.getPrecisionScore());
            ps.setFloat(3, metric.getRecall());
            ps.setFloat(4, metric.getF1score());
            ps.setInt(5, metric.getSupport());
            ps.setInt(6, metric.getModel().getId());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1); // Trả về id của ModelMetric vừa được thêm
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(ModelMetricDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return -1;
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
