package com.pojo;

import java.util.Date;

public class DietLog {



    private int id;
    private int memberId;
    private MealType mealType;
    private Date date;
    private double calories;
    private double protein;
    private double Carbon;

    @Override
    public String toString() {
        return "DietLog{" +
                "id=" + id +
                ", memberId=" + memberId +
                ", mealType=" + mealType +
                ", date=" + date +
                ", calories=" + calories +
                ", protein=" + protein +
                ", Carbon=" + Carbon +
                ", imageUrl='" + imageUrl + '\'' +
                '}';
    }

    public double getCalories() {
        return calories;
    }

    public void setCalories(double calories) {
        this.calories = calories;
    }

    public double getProtein() {
        return protein;
    }

    public void setProtein(double protein) {
        this.protein = protein;
    }

    public double getCarbon() {
        return Carbon;
    }

    public void setCarbon(double carbon) {
        Carbon = carbon;
    }

    private String imageUrl;

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

    public MealType getMealType() {
        return mealType;
    }

    public void setMealType(MealType mealType) {
        this.mealType = mealType;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
