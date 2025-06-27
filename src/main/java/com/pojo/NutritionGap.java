package com.pojo;

import java.util.Date;

public class NutritionGap {
    private int id;
    private int memberId;
    private Date date;
    private int nutritionId;
    private float intakeAmount;
    private float recommendationAmount;
    private enum status{
        DEFICIENT, // 缺乏
        NORMAL,    // 正常
        EXCESS     // 过量
        };

    @Override
    public String toString() {
        return "NutritionGap{" +
                "id=" + id +
                ", memberId=" + memberId +
                ", date=" + date +
                ", nutritionId=" + nutritionId +
                ", intakeAmount=" + intakeAmount +
                ", recommendationAmount=" + recommendationAmount +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getNutritionId() {
        return nutritionId;
    }

    public void setNutritionId(int nutritionId) {
        this.nutritionId = nutritionId;
    }

    public float getIntakeAmount() {
        return intakeAmount;
    }

    public void setIntakeAmount(float intakeAmount) {
        this.intakeAmount = intakeAmount;
    }

    public float getRecommendationAmount() {
        return recommendationAmount;
    }

    public void setRecommendationAmount(float recommendationAmount) {
        this.recommendationAmount = recommendationAmount;
    }
}
