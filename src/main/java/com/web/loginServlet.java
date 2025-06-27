package com.web;

import com.mapper.UserMapper;
import com.pojo.User;
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
import java.io.PrintWriter;

@WebServlet(urlPatterns = "/loginServlet",loadOnStartup = 1)
public class loginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        SqlSessionFactory sqlSessionFactory = SqlSessionFactoryUtils.getSqlSessionFactory();
        SqlSession sqlSession = sqlSessionFactory.openSession();
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
        User select = userMapper.select(username, password);
        sqlSession.close();

        resp.setContentType("text/html;charset=utf-8");
        PrintWriter writer = resp.getWriter();
        if (select != null) {
//登陆成功
//            writer.write("登陆成功");
        req.getSession().setAttribute("username", username);
        resp.sendRedirect(req.getContextPath() + "/main_page.jsp");
        }else{
//            登陆失败
//            writer.write("登录失败");
            // 登录失败，返回登录失败信息或重定向回登录页
            writer.write("<script>alert('用户名或密码错误');window.location.href='home_page.jsp';</script>");
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
