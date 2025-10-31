/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Model;
import model.VideoSample;
import util.DBUtil;

/**
 *
 * @author namv2
 */
public class VideoSampleDAO {
    private Connection conn;

    public VideoSampleDAO() {
        this.conn = DBUtil.getConnection();
    }
    
    public List<VideoSample> getvideoSampleList(){
        String sql = "SELECT * FROM tblVideoSample";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            List<VideoSample> videoSampleList = new ArrayList<>();
            while (rs.next()) {
                VideoSample videoSample = new VideoSample();
                videoSample.setId(rs.getInt("id"));
                videoSample.setFileName(rs.getString("fileName"));
                videoSample.setPath(rs.getString("path"));
                videoSample.setStartSecond(rs.getInt("startSecond"));
                videoSample.setEndSecond(rs.getInt("endSecond"));
                videoSample.setLabel(rs.getString("label"));

                int tblRawSampleid = rs.getInt("tblRawSampleid");
                RawSampleDAO rawSampleDAO = new RawSampleDAO();
                videoSample.setRawSample(rawSampleDAO.getRawSampleById(tblRawSampleid));

                videoSampleList.add(videoSample);
            }

            return videoSampleList;
        } catch (SQLException ex) {
            Logger.getLogger(ModelDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
}
