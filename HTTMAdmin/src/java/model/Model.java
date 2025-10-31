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
public class Model {
    private int id;
    private String name;
    private String path;
    private float accuracy;
    private float recallViolence;
    private LocalDateTime trainStartTime;
    private LocalDateTime trainEndTime;
    private int trainSamples;
    private int testSamples;
    private String note;
    private boolean isActive;
    private Admin trainedBy;

    public Model() {
    }

    public Model(int id, String name, String path, float accuracy, float recallViolence, LocalDateTime trainStartTime, LocalDateTime trainEndTime, int trainSamples, int testSamples, String note, boolean isActive, Admin trainedBy) {
        this.id = id;
        this.name = name;
        this.path = path;
        this.accuracy = accuracy;
        this.recallViolence = recallViolence;
        this.trainStartTime = trainStartTime;
        this.trainEndTime = trainEndTime;
        this.trainSamples = trainSamples;
        this.testSamples = testSamples;
        this.note = note;
        this.isActive = isActive;
        this.trainedBy = trainedBy;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getPath() {
        return path;
    }

    public float getAccuracy() {
        return accuracy;
    }

    public float getRecallViolence() {
        return recallViolence;
    }

    public LocalDateTime getTrainStartTime() {
        return trainStartTime;
    }

    public LocalDateTime getTrainEndTime() {
        return trainEndTime;
    }

    public int getTrainSamples() {
        return trainSamples;
    }

    public int getTestSamples() {
        return testSamples;
    }

    public String getNote() {
        return note;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public Admin getTrainedBy() {
        return trainedBy;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public void setAccuracy(float accuracy) {
        this.accuracy = accuracy;
    }

    public void setRecallViolence(float recallViolence) {
        this.recallViolence = recallViolence;
    }

    public void setTrainStartTime(LocalDateTime trainStartTime) {
        this.trainStartTime = trainStartTime;
    }

    public void setTrainEndTime(LocalDateTime trainEndTime) {
        this.trainEndTime = trainEndTime;
    }

    public void setTrainSamples(int trainSamples) {
        this.trainSamples = trainSamples;
    }

    public void setTestSamples(int testSamples) {
        this.testSamples = testSamples;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public void setTrainedBy(Admin trainedBy) {
        this.trainedBy = trainedBy;
    }
    
    
}
