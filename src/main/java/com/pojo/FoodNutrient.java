package com.pojo;

public class FoodNutrient {
    private int id;
    private int foodId;
    private int nutrientId;
    private double amountPerUnit;

    @Override
    public String toString() {
        return "FoodNutrient{" +
                "id=" + id +
                ", foodId=" + foodId +
                ", nutrientId=" + nutrientId +
                ", amountPerUnit=" + amountPerUnit +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFoodId() {
        return foodId;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public int getNutrientId() {
        return nutrientId;
    }

    public void setNutrientId(int nutrientId) {
        this.nutrientId = nutrientId;
    }

    public double getAmountPerUnit() {
        return amountPerUnit;
    }

    public void setAmountPerUnit(double amountPerUnit) {
        this.amountPerUnit = amountPerUnit;
    }
}
