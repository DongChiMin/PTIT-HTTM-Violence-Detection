/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.RawSample;
import model.VideoSample;
import util.DBUtil;

/**
 *
 * @author namv2
 */
public class RawSampleDAO {
    private Connection conn;

    public RawSampleDAO() {
        this.conn = DBUtil.getConnection();
    }
    
    public RawSample getRawSampleById(int id){
        String sql = """
                     SELECT * FROM tblRawSample t
                     WHERE t.id = ?
                     """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            RawSample rawSample = new RawSample();

            while (rs.next()) {
                rawSample.setId(rs.getInt("id"));
                rawSample.setFileName(rs.getString("fileName"));
                rawSample.setPath(rs.getString("path"));
                rawSample.setDuration(rs.getInt("duration"));
                rawSample.setStatus(rs.getString("status"));
                rawSample.setUploadAt(rs.getTimestamp("uploadAt").toLocalDateTime());   
                
                int tblAdminid = rs.getInt("tblAdminid");
                AdminDAO adminDAO = new AdminDAO();
                rawSample.setUploadBy(adminDAO.getAdminById(tblAdminid));
            }

            return rawSample;
        } catch (SQLException ex) {
            Logger.getLogger(ModelDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
}
