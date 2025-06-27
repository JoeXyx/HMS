package com.web;

import com.google.gson.Gson;
import com.pojo.DietLog;
import com.service.DietLogService;
import com.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/dietServlet")
public class dietServlet extends HttpServlet {
    UserService us=new UserService();
    DietLogService dls=new DietLogService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = (String)req.getSession().getAttribute("username");
        System.out.println(username);
        int i = us.selectByUsername(username);
        List<DietLog> dietLogs = dls.selectByMemberId(i);
        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write(new Gson().toJson(dietLogs));
        System.out.println(dietLogs);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
