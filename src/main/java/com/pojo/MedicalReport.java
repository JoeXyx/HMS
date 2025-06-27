package com.pojo;

import java.util.Date;

public class MedicalReport {
    private int id;
    private int userId;
    private String reportName;
    private Date reportDate;
    private String reportFilePath;
    private Date createdAt;
    private Date updatedAt;

    @Override
    public String toString() {
        return "MedicalReport{" +
                "id=" + id +
                ", userId=" + userId +
                ", reportName='" + reportName + '\'' +
                ", reportDate=" + reportDate +
                ", reportFilePath='" + reportFilePath + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setReportName(String reportName) {
        this.reportName = reportName;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public void setReportFilePath(String reportFilePath) {
        this.reportFilePath = reportFilePath;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getReportName() {
        return reportName;
    }

    public Date getReportDate() {
        return reportDate;
    }

    public String getReportFilePath() {
        return reportFilePath;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }
}
