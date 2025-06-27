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
  <h1>营养饮食 —— 吃得健康，活得轻松！</h1>
  <p>记录每日饮食，精准追踪营养摄入，让每一餐都为健康加分。</p>
</section>

<section class="features module-section">
  <div class="feature-card">
    <h3>食物摄入轻松记录</h3>
    <p>支持上传图片，选择餐次（早餐/午餐/晚餐/加餐）</p>
  </div>
  <div class="feature-card">
    <h3>营养素自动分析</h3>
    <p>热量、蛋白质、脂肪、碳水、维生素一目了然</p>
  </div>
  <div class="feature-card">
    <h3>营养摄入对比推荐值</h3>
    <p>一键判断是否缺乏或过量</p>
  </div>
  <div class="feature-card">
    <h3>家庭成员饮食独立管理</h3>
    <p>贴心关怀每位成员健康</p>
  </div>
  <div class="feature-card">
    <h3>饮食备注和膳食建议</h3>
    <p>吃得更科学、更安心</p>
  </div>
</section>

</body>
</html>
