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
    <h1>健康档案模块</h1>
    <p>记录与管理您的全面健康信息，构建个人健康数据库</p>
</section>

<section class="features module-section">
    <div class="feature-card">
        <h3>基础健康信息</h3>
        <p>输入并管理姓名、性别、年龄、身高体重等基本数据</p>
    </div>
    <div class="feature-card">
        <h3>BMI 自动计算</h3>
        <p>系统根据身高体重自动计算身体质量指数（BMI）</p>
    </div>
    <div class="feature-card">
        <h3>体检记录展示</h3>
        <p>查看近期体检报告和系统自动评估结果</p>
    </div>
    <div class="feature-card">
        <h3>健康建议生成</h3>
        <p>根据档案内容自动提供饮食、运动、疾病预防建议</p>
    </div>
    <div class="feature-card">
        <h3>多模块联动</h3>
        <p>与运动和饮食模块互通，共同构建健康数据分析体系</p>
    </div>
</section>

</body>
</html>
