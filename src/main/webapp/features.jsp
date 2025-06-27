<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String username = (String) session.getAttribute("username");

%>
<!DOCTYPE html>
<html lang="zh-CN">
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

<section class="hero" style="padding: 100px 20px;">
    <h1>系统功能介绍</h1>
    <p>下面是健康+ 管理系统提供的各项功能模块，帮助您科学管理健康生活：</p>
</section>

<section class="features" style="padding-bottom: 80px;">
    <div class="feature-card">
        <h3>健康档案</h3>
        <p>集中记录病历、药物与诊断信息，长期追踪个人健康轨迹。</p>
    </div>
    <div class="feature-card">
        <h3>运动追踪</h3>
        <p>记录步数、跑步、锻炼时间，让每一份努力都有数据支持。</p>
    </div>
    <div class="feature-card">
        <h3>营养饮食</h3>
        <p>定制每日餐单，记录热量、营养比例，吃得更科学。</p>
    </div>
    <div class="feature-card">
        <h3>体检报告</h3>
        <p>上传体检数据，生成趋势图，及时掌握健康状况。</p>
    </div>
</section>

<footer>
    &copy; 2025 健康+ 管理系统 | 健康从数据开始
</footer>

<!-- 复用登录弹窗和 JS 逻辑 -->
<script>
    function openModal() {
        alert("请跳转回首页进行登录操作！");
    }
</script>

</body>
</html>
