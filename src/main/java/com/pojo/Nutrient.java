package com.pojo;

public class Nutrient {
    private int id;
    private String name;
    private String functions;
    private String healthTargets;

    @Override
    public String toString() {
        return "Nutrient{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", functions='" + functions + '\'' +
                ", healthTargets='" + healthTargets + '\'' +
                '}';
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setFunctions(String functions) {
        this.functions = functions;
    }

    public void setHealthTargets(String healthTargets) {
        this.healthTargets = healthTargets;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getFunctions() {
        return functions;
    }

    public String getHealthTargets() {
        return healthTargets;
    }
}
