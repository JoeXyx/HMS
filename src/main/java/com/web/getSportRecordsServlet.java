package com.web;

import com.google.gson.Gson;
import com.pojo.ExerciseLog;
import com.pojo.FamilyMember;
import com.service.ExerciseLogService;
import com.service.FamilyMemberService;
import com.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/getSportRecordsServlet")
public class getSportRecordsServlet extends HttpServlet {
    UserService us = new UserService();
    FamilyMemberService fms = new FamilyMemberService();
    ExerciseLogService els = new ExerciseLogService();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");

        String username = (String)req.getSession().getAttribute("username");
        int i = us.selectByUsername(username);
        List<FamilyMember> members = fms.getFamilyMembersByUserId(i);
        List< ExerciseLog> el=new ArrayList<>();
        for (FamilyMember member : members) {
            if(els.selectAll(member.getId())!=null&&!els.selectAll(member.getId()).isEmpty()){
                el.addAll(els.selectAll(member.getId()));
            }
        }
        String json = new Gson().toJson(el);
        System.out.println(json);
        resp.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
