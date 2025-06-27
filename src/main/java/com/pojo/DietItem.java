package com.pojo;

public class DietItem {
    private int id;
    private int dietLogId;
    private int foodId;
    private float quantity;

    @Override
    public String toString() {
        return "DietItem{" +
                "id=" + id +
                ", dietLogId=" + dietLogId +
                ", foodId=" + foodId +
                ", quantity=" + quantity +
                '}';
    }

    public int getDietLogId() {
        return dietLogId;
    }

    public void setDietLogId(int dietLogId) {
        this.dietLogId = dietLogId;
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

    public float getQuantity() {
        return quantity;
    }

    public void setQuantity(float quantity) {
        this.quantity = quantity;
    }
}
