package com.web;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.pojo.ExerciseLog;
import com.pojo.FamilyMember;
import com.service.ExerciseLogService;
import com.service.UserService;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/addSportRecordServlet")
public class addSportRecordServlet extends HttpServlet {
    UserService us=new UserService();
    ExerciseLogService els=new ExerciseLogService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置响应格式
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");
        String username =(String) req.getSession().getAttribute("username");
        int i = us.selectByUsername(username);
        // 读取 JSON 数据
        BufferedReader reader = req.getReader();
        StringBuilder jsonBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuilder.append(line);
        }

        String jsonString = jsonBuilder.toString();
        JSONObject json = new JSONObject(jsonString);
        System.out.println(jsonString);
        // 解析 JSON
        Gson gson = new Gson(); // 或用 Jackson ObjectMapper
        ExerciseLog sport = gson.fromJson(jsonString, ExerciseLog.class);
        sport.setMemberId(i);
        sport.setStepCount(json.getInt("distance"));
        sport.setActivityType(json.getString("type"));
        sport.setCaloriesBurned(json.getFloat("calories"));
        // TODO: 存入数据库
        els.insert(sport);
        resp.getWriter().write("{\"message\":\"success\"}");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
