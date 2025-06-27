package com.web;


import com.service.BodyCompositionService;
import com.service.FamilyMemberService;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/deleteFamilyMemberServlet")
public class deleteFamilyMemberServlet extends HttpServlet {
    FamilyMemberService fms = new FamilyMemberService();
    BodyCompositionService bcs = new BodyCompositionService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String idStr = req.getParameter("memberId");
        BufferedReader reader = req.getReader();
        String jsonData = reader.readLine();
        JSONObject json = new JSONObject(jsonData);

        String method = json.optString("_method");
        int memberId = json.getInt("memberId");

        if ("DELETE".equalsIgnoreCase(method)) {
            // 模拟 DELETE 操作
            // TODO: 执行删除逻辑
            int id = Integer.parseInt(String.valueOf(memberId));
            System.out.println(id);
            boolean flag = false;
            if(id!=0){
                fms.deleteFamilyMember(id);
                bcs.deleteBodyComposition(id);
                flag = true;
            }
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":" + flag + "}");
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "不支持的操作");
        }




    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
