package com.pojo;

import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.Date;

public class FamilyMember {
    private int id;
    private int userId;
    private String name;
    private Date birthday;
    private String gender;

    private Integer age;

    public Integer getAge() {
        if (birthday == null) return null;
        LocalDate birth = birthday.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate now = LocalDate.now();
        return Period.between(birth, now).getYears();
    }

    @Override
    public String toString() {
        return "FamilyMember{" +
                "id=" + id +
                ", userId=" + userId +
                ", name='" + name + '\'' +
                ", birthday=" + birthday +
                ", gender='" + gender + '\'' +
                ", age=" + age +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setAge(Integer age) {
        this.age = age;
    }
}
