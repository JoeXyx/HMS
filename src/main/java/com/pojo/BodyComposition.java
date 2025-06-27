package com.pojo;

import java.util.Date;

public class BodyComposition {
    private int id;
    private int memberId;
    private Date recordDate;
    private float weight, height, totalWater, protein, fat, muscle, basalMetabolicRate;
    private int visceralFatLevel;
    private float bodyFatRate, bmi;
    private int bodyScore;

    @Override
    public String toString() {
        return "BodyComposition{" +
                "id=" + id +
                ", memberId=" + memberId +
                ", recordDate=" + recordDate +
                ", weight=" + weight +
                ", height=" + height +
                ", totalWater=" + totalWater +
                ", protein=" + protein +
                ", fat=" + fat +
                ", muscle=" + muscle +
                ", basalMetabolicRate=" + basalMetabolicRate +
                ", visceralFatLevel=" + visceralFatLevel +
                ", bodyFatRate=" + bodyFatRate +
                ", bmi=" + bmi +
                ", bodyScore=" + bodyScore +
                '}';
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public void setWeight(float weight) {
        this.weight = weight;
    }

    public void setRecordDate(Date recordDate) {
        this.recordDate = recordDate;
    }

    public void setHeight(float height) {
        this.height = height;
    }

    public void setTotalWater(float totalWater) {
        this.totalWater = totalWater;
    }

    public void setProtein(float protein) {
        this.protein = protein;
    }

    public void setFat(float fat) {
        this.fat = fat;
    }

    public void setMuscle(float muscle) {
        this.muscle = muscle;
    }

    public void setBasalMetabolicRate(float basalMetabolicRate) {
        this.basalMetabolicRate = basalMetabolicRate;
    }

    public void setVisceralFatLevel(int visceralFatLevel) {
        this.visceralFatLevel = visceralFatLevel;
    }

    public void setBodyFatRate(float bodyFatRate) {
        this.bodyFatRate = bodyFatRate;
    }

    public void setBmi(float bmi) {
        this.bmi = bmi;
    }

    public void setBodyScore(int bodyScore) {
        this.bodyScore = bodyScore;
    }

    public int getId() {
        return id;
    }

    public int getMemberId() {
        return memberId;
    }

    public Date getRecordDate() {
        return recordDate;
    }

    public float getWeight() {
        return weight;
    }

    public float getHeight() {
        return height;
    }

    public float getTotalWater() {
        return totalWater;
    }

    public float getProtein() {
        return protein;
    }

    public float getFat() {
        return fat;
    }

    public float getMuscle() {
        return muscle;
    }

    public float getBasalMetabolicRate() {
        return basalMetabolicRate;
    }

    public int getVisceralFatLevel() {
        return visceralFatLevel;
    }

    public float getBodyFatRate() {
        return bodyFatRate;
    }

    public float getBmi() {
        return bmi;
    }

    public int getBodyScore() {
        return bodyScore;
    }
}
