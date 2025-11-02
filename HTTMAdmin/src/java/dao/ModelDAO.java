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

    public ModelDAO() {
    }

    public List<Model> getModelList() {
        String sql = "SELECT * FROM tblModel";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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

    public boolean isNameExists(String name) {
        String sql = """
                     SELECT * FROM tblModel t
                     WHERE t.name = ?
                     """;
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return true;
            }
            return false;
        } catch (SQLException ex) {
            Logger.getLogger(ModelDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public int insertModel(Connection conn, Model newModel) {
        String sql = """
        INSERT INTO tblModel (name, path, accuracy, recallViolence, trainStartTime, 
                              trainEndTime, trainSamples, testSamples, note, isActive, tblAdminid)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, newModel.getName());
            ps.setFloat(3, newModel.getAccuracy());
            ps.setFloat(4, newModel.getRecallViolence());
            ps.setTimestamp(5, Timestamp.valueOf(newModel.getTrainStartTime()));
            ps.setTimestamp(6, Timestamp.valueOf(newModel.getTrainEndTime()));
            ps.setInt(7, newModel.getTrainSamples());
            ps.setInt(8, newModel.getTestSamples());
            ps.setBoolean(10, newModel.getIsActive());
            ps.setInt(11, newModel.getTrainedBy().getId());

            //Kiểm tra note nếu rỗng thì set null vào CSDL
            String note = newModel.getNote();
            if (note != null && !note.isEmpty() && !note.equalsIgnoreCase("null")) {
                ps.setString(9, newModel.getNote());
            } else {
                ps.setNull(9, java.sql.Types.VARCHAR);
            }
            
            //path chỉ lưu từ data/model/...
            String pathStr = newModel.getPath();
            int index = pathStr.indexOf("data");
            ps.setString(2, pathStr.substring(index));

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1); // Trả về modelId vừa tạo
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ModelDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return -1;
    }
}
