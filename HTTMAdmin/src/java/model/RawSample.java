/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author namv2
 */
public class RawSample {
    private int id;
    private String fileName;
    private String path;
    private int duration;
    private String status;
    private LocalDateTime uploadAt;
    private Admin uploadBy;

    public RawSample() {
    }

    public RawSample(int id, String fileName, String path, int duration, String status, LocalDateTime uploadAt, Admin uploadBy) {
        this.id = id;
        this.fileName = fileName;
        this.path = path;
        this.duration = duration;
        this.status = status;
        this.uploadAt = uploadAt;
        this.uploadBy = uploadBy;
    }

    public int getId() {
        return id;
    }

    public String getFileName() {
        return fileName;
    }

    public String getPath() {
        return path;
    }

    public int getDuration() {
        return duration;
    }

    public String getStatus() {
        return status;
    }

    public LocalDateTime getUploadAt() {
        return uploadAt;
    }

    public Admin getUploadBy() {
        return uploadBy;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setUploadAt(LocalDateTime uploadAt) {
        this.uploadAt = uploadAt;
    }

    public void setUploadBy(Admin uploadBy) {
        this.uploadBy = uploadBy;
    }
    
    
}
