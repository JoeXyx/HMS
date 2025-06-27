package com.pojo;

import java.util.Date;

public class ExerciseLog {
    private int id;
    private int memberId;
    private Date date;
    private int stepCount;
    private String activityType;
    private int duration;
    private float caloriesBurned;

    @Override
    public String toString() {
        return "ExerciseLog{" +
                "id=" + id +
                ", memberId=" + memberId +
                ", date=" + date +
                ", stepCount=" + stepCount +
                ", activityType='" + activityType + '\'' +
                ", duration=" + duration +
                ", caloriesBurned=" + caloriesBurned +
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

    public int getStepCount() {
        return stepCount;
    }

    public void setStepCount(int stepCount) {
        this.stepCount = stepCount;
    }

    public String getActivityType() {
        return activityType;
    }

    public void setActivityType(String activityType) {
        this.activityType = activityType;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public float getCaloriesBurned() {
        return caloriesBurned;
    }

    public void setCaloriesBurned(float caloriesBurned) {
        this.caloriesBurned = caloriesBurned;
    }
}
