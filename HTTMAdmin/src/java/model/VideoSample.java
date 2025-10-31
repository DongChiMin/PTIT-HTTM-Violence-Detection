/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author namv2
 */
public class VideoSample {
    private int id;
    private String fileName;
    private String path;
    private int startSecond;
    private int endSecond;
    private String label;
    private RawSample rawSample;

    public VideoSample() {
    }

    public VideoSample(int id, String fileName, String path, int startSecond, int endSecond, String label, RawSample rawSample) {
        this.id = id;
        this.fileName = fileName;
        this.path = path;
        this.startSecond = startSecond;
        this.endSecond = endSecond;
        this.label = label;
        this.rawSample = rawSample;
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

    public int getStartSecond() {
        return startSecond;
    }

    public int getEndSecond() {
        return endSecond;
    }

    public String getLabel() {
        return label;
    }

    public RawSample getRawSample() {
        return rawSample;
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

    public void setStartSecond(int startSecond) {
        this.startSecond = startSecond;
    }

    public void setEndSecond(int endSecond) {
        this.endSecond = endSecond;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public void setRawSample(RawSample rawSample) {
        this.rawSample = rawSample;
    }
    
    
}
