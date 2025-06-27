package com.pojo;

public class DailyRecommendation {
    private int id;
    private String gender;
    private int ageMin;
    private int ageMax;
    private int nutrientId;
    private double recommendedAmount;

    @Override
    public String toString() {
        return "DailyRecommendation{" +
                "id=" + id +
                ", gender='" + gender + '\'' +
                ", ageMin=" + ageMin +
                ", ageMax=" + ageMax +
                ", nutrientId=" + nutrientId +
                ", recommendedAmount=" + recommendedAmount +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public int getAgeMin() {
        return ageMin;
    }

    public void setAgeMin(int ageMin) {
        this.ageMin = ageMin;
    }

    public int getAgeMax() {
        return ageMax;
    }

    public void setAgeMax(int ageMax) {
        this.ageMax = ageMax;
    }

    public int getNutrientId() {
        return nutrientId;
    }

    public void setNutrientId(int nutrientId) {
        this.nutrientId = nutrientId;
    }

    public double getRecommendedAmount() {
        return recommendedAmount;
    }

    public void setRecommendedAmount(double recommendedAmount) {
        this.recommendedAmount = recommendedAmount;
    }
}
