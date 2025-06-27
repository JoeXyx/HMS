package com.web;

import com.pojo.FoodItem;
import com.service.FoodItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addFoodServlet")
public class addFoodServlet extends HttpServlet {
    FoodItemService fis = new FoodItemService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        FoodItem item = new FoodItem();
        item.setName(req.getParameter("name"));
        item.setUnit(req.getParameter("unit"));
        System.out.println(req.getParameter("unit"));
        item.setImageUrl(req.getParameter("imageUrl"));
        item.setCalories(Float.parseFloat(req.getParameter("calories")));
        item.setProtein(Float.parseFloat(req.getParameter("protein")));
        item.setCarbs(Float.parseFloat(req.getParameter("carbs")));
        item.setFat(Float.parseFloat(req.getParameter("fat")));
        item.setFiber(Float.parseFloat(req.getParameter("fiber")));
        item.setSugar(Float.parseFloat(req.getParameter("sugar")));
        item.setSodium(Float.parseFloat(req.getParameter("sodium")));
        fis.insert(item);
        resp.getWriter().write("success");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
