/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author namv2
 */
public class ModelMetric {
     private int id;
    private String labelName;
    private float precisionScore;
    private float recall;
    private float f1score;
    private int support;
    private Model model;

    public ModelMetric() {
    }

    public ModelMetric(int id, String labelName, float precisionScore, float recall, float f1score, int support, Model model) {
        this.id = id;
        this.labelName = labelName;
        this.precisionScore = precisionScore;
        this.recall = recall;
        this.f1score = f1score;
        this.support = support;
        this.model = model;
    }

    public int getId() {
        return id;
    }

    public String getLabelName() {
        return labelName;
    }

    public float getPrecisionScore() {
        return precisionScore;
    }

    public float getRecall() {
        return recall;
    }

    public float getF1score() {
        return f1score;
    }

    public int getSupport() {
        return support;
    }

    public Model getModel() {
        return model;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setLabelName(String labelName) {
        this.labelName = labelName;
    }

    public void setPrecisionScore(float precisionScore) {
        this.precisionScore = precisionScore;
    }

    public void setRecall(float recall) {
        this.recall = recall;
    }

    public void setF1score(float f1score) {
        this.f1score = f1score;
    }

    public void setSupport(int support) {
        this.support = support;
    }

    public void setModel(Model model) {
        this.model = model;
    }
    
    
}
