package com.web;

import com.mapper.FamilyMemberMapper;
import com.pojo.BodyComposition;
import com.pojo.FamilyMember;
import com.service.BodyCompositionService;
import com.service.FamilyMemberService;
import com.service.UserService;
import com.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/selectFamilyMembersByUserIdServlet")
public class selectFamilyMembersByUserIdServlet extends HttpServlet {
    public static class MemberWithBody {
        FamilyMember member;
        BodyComposition composition;
        private Integer age;
        MemberWithBody(FamilyMember member, BodyComposition composition) {
            this.member = member;
            this.composition = composition;
            this.age = member.getAge();
        }
    }
    FamilyMemberService familyMemberService = new FamilyMemberService();
    UserService userService = new UserService();
    BodyCompositionService bodyCompositionService = new BodyCompositionService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String username = (String) session.getAttribute("username");
        int i = userService.selectByUsername(username);

        List<FamilyMember> members = familyMemberService.getFamilyMembersByUserId(i);
        List<BodyComposition> bodyCompositionByFamily = bodyCompositionService.getBodyCompositionByFamily(i);
        List<MemberWithBody> membersWithBody = new ArrayList<>();
        for (FamilyMember member : members) {
            for (BodyComposition Body : bodyCompositionByFamily) {
                    if(member.getId()==(Body.getMemberId())){
                        membersWithBody.add(new MemberWithBody(member,Body));
                    }
            }
        }
        // 设置响应类型为 JSON
        resp.setContentType("application/json; charset=UTF-8");
        // 使用 Gson 输出 JSON 数据
        com.google.gson.Gson gson = new com.google.gson.Gson();
        String json = gson.toJson(membersWithBody);
        System.out.println(json);
        resp.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
