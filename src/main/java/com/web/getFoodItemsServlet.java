package com.web;

import com.google.gson.Gson;
import com.pojo.FoodItem;
import com.service.FoodItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/getFoodItemsServlet")
public class getFoodItemsServlet extends HttpServlet {
    FoodItemService fis = new FoodItemService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");
        List<FoodItem> foodItems = fis.selectAll();
        String json = new Gson().toJson(foodItems);
        System.out.println(json);
        resp.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
