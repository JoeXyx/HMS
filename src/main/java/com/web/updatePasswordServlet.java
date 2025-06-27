package com.web;

import com.pojo.User;
import com.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/updatePasswordServlet")
public class updatePasswordServlet extends HttpServlet {
    UserService us =new UserService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/plain;charset=UTF-8");

        String currentPwd = req.getParameter("currentPassword");
        String newPwd = req.getParameter("newPassword");

        HttpSession session = req.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            resp.getWriter().write("用户未登录！");
            return;
        }
        User user = us.select(username, currentPwd);
        if (user != null) {
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(newPwd);
            us.update(newUser);
            resp.getWriter().write("密码修改成功！");
        }else{
            resp.getWriter().write("当前密码错误！");
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
