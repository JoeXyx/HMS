package com.pojo;

public class FoodItem{
    private int id;
    private String name;
    private String unit;
    private String imageUrl;
    private float calories;
    private float protein;
    private float carbs;
    private float fat;
    private float fiber;
    private float sugar;
    private float sodium;

    @Override
    public String toString() {
        return "FoodItem{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", unit='" + unit + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", calories=" + calories +
                ", protein=" + protein +
                ", carbs=" + carbs +
                ", fat=" + fat +
                ", fiber=" + fiber +
                ", sugar=" + sugar +
                ", sodium=" + sodium +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public float getCalories() {
        return calories;
    }

    public void setCalories(float calories) {
        this.calories = calories;
    }

    public float getProtein() {
        return protein;
    }

    public void setProtein(float protein) {
        this.protein = protein;
    }

    public float getCarbs() {
        return carbs;
    }

    public void setCarbs(float carbs) {
        this.carbs = carbs;
    }

    public float getFat() {
        return fat;
    }

    public void setFat(float fat) {
        this.fat = fat;
    }

    public float getFiber() {
        return fiber;
    }

    public void setFiber(float fiber) {
        this.fiber = fiber;
    }

    public float getSugar() {
        return sugar;
    }

    public void setSugar(float sugar) {
        this.sugar = sugar;
    }

    public float getSodium() {
        return sodium;
    }

    public void setSodium(float sodium) {
        this.sodium = sodium;
    }
}
