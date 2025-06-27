<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>功能介绍 - 健康+ 管理系统</title>
    <link href="https://fonts.googleapis.com/css2?family=SF+Pro+Display:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/external.css">
</head>
<body>
<header id="main-header">
    <div class="logo">健康+ 管理系统</div>
    <nav>
        <a href="home_page.jsp">首页</a>
        <a href="features.jsp">功能</a>
        <a href="healthIntro.jsp">健康档案</a>
        <a href="moveIntro.jsp">运动记录</a>
        <a href="nutritiousIntro.jsp">营养饮食</a>
        <% if (null!=username) { %>
        <span style="margin-left: 10px; font-weight: 500;"><%= username %></span>
        <a href="/HMS/logoutServlet" style="margin-left: 10px;">退出</a>
        <% } else { %>
        <a onclick="openModal()">登录</a>
        <% } %>


    </nav>
</header>
<section class="hero small-hero">
    <h1>运动记录模块</h1>
    <p>运动记录 —— 让每一次运动都更有价值！</p>
</section>

<section class="features module-section">
    <div class="feature-card">
        <h3>多种运动类型支持</h3>
        <p>跑步、骑行、游泳、健身应有尽有</p>
    </div>
    <div class="feature-card">
        <h3>一键记录时长与热量</h3>
        <p>轻松掌握每日消耗</p>
    </div>
    <div class="feature-card">
        <h3>图表分析趋势清晰</h3>
        <p>每周进步看得见</p>
    </div>
    <div class="feature-card">
        <h3>定制提醒功能</h3>
        <p>帮你坚持好习惯</p>
    </div>
    <div class="feature-card">
        <h3>家庭成员独立管理</h3>
        <p>全家人一起动起来！</p>
    </div>
</section>

</body>
</html>
