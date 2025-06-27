package com.web;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pojo.BodyComposition;
import com.pojo.FamilyMember;
import com.service.BodyCompositionService;
import com.service.FamilyMemberService;
import com.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/addFamilyMemberCompositionServlet")
public class addFamilyMemberCompositionServlet extends HttpServlet {
    BodyCompositionService bcs = new BodyCompositionService();
    FamilyMemberService fms = new FamilyMemberService();
    UserService us = new UserService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");
        String username =(String) req.getSession().getAttribute("username");
        int i = us.selectByUsername(username);
        BufferedReader reader = req.getReader();
        StringBuilder json = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            json.append(line);
        }
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(json.toString());

        FamilyMember member = mapper.treeToValue(root.get("member"), FamilyMember.class);
        member.setUserId(i);
        fms.addFamilyMember(member);

// 解析体成分对象
        FamilyMember member1 = fms.selectByByname(member.getName());
        BodyComposition composition = mapper.treeToValue(root.get("composition"), BodyComposition.class);
        composition.setMemberId(member1.getId()); // 设置关联外键
        bcs.insertBodyComposition(composition);


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
