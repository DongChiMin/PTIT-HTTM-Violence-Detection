/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Model;
import java.sql.*;
import java.time.LocalDateTime;
import util.DBUtil;

public class ModelDAO {

    private Connection conn;

    public ModelDAO() {
        this.conn = DBUtil.getConnection();
    }

    public List<Model> getModelList() {
        String sql = "SELECT * FROM tblModel";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            List<Model> modelList = new ArrayList<>();
            while (rs.next()) {
                Model model = new Model();
                model.setId(rs.getInt("id"));
                model.setName(rs.getString("name"));
                model.setPath(rs.getString("path"));
                model.setAccuracy(rs.getFloat("accuracy"));
                model.setRecallViolence(rs.getFloat("recallViolence"));
                model.setTrainStartTime(rs.getTimestamp("trainStartTime").toLocalDateTime());
                model.setTrainEndTime(rs.getTimestamp("trainEndTime").toLocalDateTime());
                model.setTrainSamples(rs.getInt("trainSamples"));
                model.setTestSamples(rs.getInt("testSamples"));
                model.setIsActive(rs.getBoolean("isActive"));

                String note = rs.getString("note");
                if (note == null) {
                    note = "";
                }
                model.setNote(note);

                int tblAdminid = rs.getInt("tblAdminid");
                AdminDAO adminDAO = new AdminDAO();
                model.setTrainedBy(adminDAO.getAdminById(tblAdminid));

                modelList.add(model);
            }

            return modelList;
        } catch (SQLException ex) {
            Logger.getLogger(ModelDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
}
