<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page isELIgnored="false" %>
<%
    // 可以在这里添加登录状态检测等 JSP 逻辑
    String username = (String) session.getAttribute("username");

%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>健康+ 管理系统</title>
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

<section id="hero" class="hero">
    <h1>你的健康，尽在掌握</h1>
    <p>通过健康+ 管理系统，全面掌控健康信息，精准记录每日身体变化，开启智能健康新生活。</p>
    <a href="main_page.jsp">立即体验</a>
</section>

<section id="features" class="features">
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
        <p>定制你的每日餐单，记录热量、营养比例，吃得更科学。</p>
    </div>
    <div class="feature-card">
        <h3>体检报告</h3>
        <p>上传并分析体检数据，自动生成趋势图，及时掌握健康状况。</p>
    </div>
</section>

<footer>
    &copy; 2025 健康+ 管理系统 | 健康从数据开始
</footer>

<!-- 登录弹窗 -->
<div class="modal-overlay" id="modalOverlay">
    <div class="modal" id="authModal">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <h2 id="modalTitle">登录</h2>
        <form action="/HMS/loginServlet" method="post" onsubmit="return validateForm()">
            <input type="text" name="username" id="username" placeholder="用户名或邮箱">
            <input type="password" name="password" id="password" placeholder="密码">
            <button type="submit">确认</button>
            <div class="toggle" onclick="toggleAuth()">还没有账户？点击注册</div>
        </form>
    </div>
</div>

<script>

    window.addEventListener('scroll', () => {
        const header = document.getElementById('main-header');
        if (window.scrollY > 50) {
            header.style.background = 'rgba(255, 255, 255, 0.85)';
        } else {
            header.style.background = 'rgba(255, 255, 255, 0.95)';
        }
    });

    const modalOverlay = document.getElementById('modalOverlay');
    const modalTitle = document.getElementById('modalTitle');
    let isLogin = true;

    function openModal() {
        modalOverlay.style.display = 'flex';
        isLogin = true;
        modalTitle.textContent = '登录';
    }

    function closeModal() {
        modalOverlay.style.display = 'none';
    }

    function toggleAuth() {
        isLogin = !isLogin;
        modalTitle.textContent = isLogin ? '登录' : '注册';
        document.querySelector('.toggle').textContent = isLogin
            ? '还没有账户？点击注册'
            : '已有账户？点击登录';

        const form = document.querySelector('#authModal form');
        form.action = isLogin ? '/HMS/loginServlet' : '/HMS/registerServlet';
    }

    window.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') {
            closeModal();
        }
    });

    function validateForm() {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();

        if (!username || !password) {
            alert("请输入用户名和密码！");
            return false;
        }

        return true;
    }
</script>

</body>
</html>
