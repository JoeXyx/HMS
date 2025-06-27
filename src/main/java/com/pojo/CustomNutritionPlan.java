package com.pojo;

import java.util.Date;

public class CustomNutritionPlan {
    private int id;
    private int memberId;
    private Date date;
    private String goal;
    private String planDetails;

    @Override
    public String toString() {
        return "CustomNutritionPlan{" +
                "id=" + id +
                ", memberId=" + memberId +
                ", date=" + date +
                ", goal='" + goal + '\'' +
                ", planDetails='" + planDetails + '\'' +
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

    public String getGoal() {
        return goal;
    }

    public void setGoal(String goal) {
        this.goal = goal;
    }

    public String getPlanDetails() {
        return planDetails;
    }

    public void setPlanDetails(String planDetails) {
        this.planDetails = planDetails;
    }
}
