<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"/>
    <title>健康+ 管理系统 - 设置</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="css/main_page.css">
    <style>
        .modal {
            display: none; /* 默认隐藏 */
            position: fixed; /* 固定在视口中 */
            z-index: 999; /* 确保在最上层 */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4); /* 半透明黑色背景 */
        }

        /* 模态框内容样式 */
        .modal-content {
            background-color: #fff;
            margin: 10% auto; /* 距离顶部10%，水平居中 */
            padding: 20px;
            border-radius: 10px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        /* 关闭按钮 */
        .close {
            float: right;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }

        /* 设置页面特定样式 */
        .settings-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .settings-section {
            margin-bottom: 30px;
            border-bottom: 1px solid #eee;
            padding-bottom: 20px;
        }

        .settings-section:last-child {
            border-bottom: none;
        }

        .settings-title {
            font-size: 1.5rem;
            color: #2c7be5;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .settings-title i {
            margin-right: 10px;
            font-size: 1.3rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            border-color: #2c7be5;
            outline: none;
            box-shadow: 0 0 0 3px rgba(44, 123, 229, 0.1);
        }

        .form-row {
            display: flex;
            gap: 20px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-primary {
            background-color: #2c7be5;
            color: white;
        }

        .btn-primary:hover {
            background-color: #1c6bd5;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 24px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 16px;
            width: 16px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: #2c7be5;
        }

        input:checked + .slider:before {
            transform: translateX(26px);
        }

        .toggle-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 0;
        }

        .toggle-label {
            font-size: 1rem;
        }

        .avatar-container {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 20px;
        }

        .avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: #6c757d;
            overflow: hidden;
        }

        .avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .btn-change-avatar {
            background: none;
            border: 1px solid #2c7be5;
            color: #2c7be5;
        }

        .btn-change-avatar:hover {
            background-color: #e9f0fb;
        }

        .security-alert {
            background-color: #fff8e1;
            border-left: 4px solid #ffc107;
            padding: 15px;
            margin: 20px 0;
            border-radius: 0 5px 5px 0;
        }

        .password-strength {
            height: 5px;
            background: #e9ecef;
            margin-top: 5px;
            border-radius: 3px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0;
            background: #dc3545;
            transition: width 0.3s;
        }

        .password-strength-text {
            font-size: 0.8rem;
            color: #6c757d;
            margin-top: 5px;
        }

        .theme-color {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            cursor: pointer;
            margin-right: 10px;
            border: 2px solid transparent;
        }

        .theme-color.active {
            border-color: #495057;
        }

        .theme-colors {
            display: flex;
            gap: 15px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<header>
    <div class="logo">健康+ 管理系统</div>
    <div class="user-info">
        欢迎，<span><%= session.getAttribute("username") != null ? session.getAttribute("username") : "访客" %></span>
        <form method="post" action="/HMS/home_page.jsp" style="display:inline;">
            <button class="logout-btn" type="submit">退出</button>
        </form>
    </div>
</header>

<aside>
    <nav>
        <a href="home_page.jsp">🏠 首页</a>
        <a href="#" id="healthLink">🏥 健康档案</a>
        <a href="sportLink.jsp" id="sportLink">🏃‍♂️ 运动记录</a>
        <a href="healthDiet.jsp">🍱 营养饮食</a>
        <a href="reportLink.jsp">📊 体检报告</a>
        <a href="settingLink.jsp" class="active">⚙️ 设置</a>
    </nav>
</aside>

<main>
    <div class="settings-container">
        <h1 style="text-align: center; margin-bottom: 30px; color: #2c7be5;">系统设置</h1>

        <!-- 个人信息部分 -->
        <div class="settings-section">
            <h2 class="settings-title">👤 个人信息</h2>

            <div class="avatar-container">
                <div class="avatar">
                    <span><%= session.getAttribute("username") != null ? ((String) session.getAttribute("username")).charAt(0) : "U" %></span>
                </div>
                <button class="btn btn-change-avatar">更换头像</button>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>用户名</label>
                    <input type="text" class="form-control"
                           value="<%= session.getAttribute("username") != null ? session.getAttribute("username") : "用户" %>">
                </div>
                <div class="form-group">
                    <label>用户ID</label>
                    <input type="text" class="form-control" value="U123456789" disabled>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>电子邮箱</label>
                    <input type="email" class="form-control" value="user@example.com">
                </div>
                <div class="form-group">
                    <label>手机号码</label>
                    <input type="tel" class="form-control" value="13800138000">
                </div>
            </div>

            <div class="form-group">
                <label>个人简介</label>
                <textarea class="form-control" rows="3"
                          placeholder="介绍一下自己...">健康生活倡导者，热爱运动与健康饮食</textarea>
            </div>

            <div style="text-align: right;">
                <button class="btn btn-primary">更新个人信息</button>
            </div>
        </div>

        <!-- 账户安全部分 -->
        <div class="settings-section">
            <h2 class="settings-title">🔒 账户安全</h2>

            <div class="security-alert">
                <strong>安全提示：</strong> 上次登录时间：2023-06-15 14:30:22，IP地址：192.168.1.100
            </div>

            <div class="form-group">
                <label>当前密码</label>
                <input type="password" id="currentPassword" class="form-control" placeholder="输入当前密码">
            </div>

            <div class="form-group">
                <label>新密码</label>
                <input type="password" id="newPassword" class="form-control" placeholder="输入新密码">                <div class="password-strength">
                    <div class="password-strength-bar" id="passwordStrengthBar"></div>
                </div>
                <div class="password-strength-text" id="passwordStrengthText">密码强度：弱</div>
            </div>

            <div class="form-group">
                <label>确认新密码</label>
                <input type="password" id="confirmPassword" class="form-control" placeholder="再次输入新密码">            </div>

            <div class="toggle-container">
                <div class="toggle-label">启用双重验证</div>
                <label class="switch">
                    <input type="checkbox">
                    <span class="slider"></span>
                </label>
            </div>

            <div style="text-align: right; margin-top: 20px;">
                <button class="btn btn-primary" onclick="updatePassword()">更新密码</button>
            </div>
        </div>

        <!-- 系统偏好设置 -->
        <div class="settings-section">
            <h2 class="settings-title">⚙️ 系统偏好</h2>

            <div class="toggle-container">
                <div class="toggle-label">深色模式</div>
                <label class="switch">
                    <input type="checkbox">
                    <span class="slider"></span>
                </label>
            </div>

            <div class="toggle-container">
                <div class="toggle-label">数据自动同步</div>
                <label class="switch">
                    <input type="checkbox" checked>
                    <span class="slider"></span>
                </label>
            </div>

            <div class="toggle-container">
                <div class="toggle-label">接收健康周报</div>
                <label class="switch">
                    <input type="checkbox" checked>
                    <span class="slider"></span>
                </label>
            </div>

            <div class="form-group">
                <label>系统主题色</label>
                <div class="theme-colors">
                    <div class="theme-color active" style="background-color: #2c7be5;" data-color="#2c7be5"></div>
                    <div class="theme-color" style="background-color: #00a65a;" data-color="#00a65a"></div>
                    <div class="theme-color" style="background-color: #f39c12;" data-color="#f39c12"></div>
                    <div class="theme-color" style="background-color: #dd4b39;" data-color="#dd4b39"></div>
                    <div class="theme-color" style="background-color: #605ca8;" data-color="#605ca8"></div>
                </div>
            </div>

            <div class="form-group">
                <label>数据备份频率</label>
                <select class="form-control">
                    <option>每天</option>
                    <option selected>每周</option>
                    <option>每月</option>
                    <option>手动备份</option>
                </select>
            </div>

            <div style="text-align: right;">
                <button class="btn btn-primary">保存偏好设置</button>
            </div>
        </div>
        <%--        添加foodItem部分--%>
        <%
            String username = (String) session.getAttribute("username");
            if (username != null && username.equals("admin")) {
        %>
        <div class="settings-section">
            <h2 class="settings-title">🍎 食物管理</h2>
            <div class="form-group">
                <label>数据库操作</label>
                <button class="btn btn-secondary" onclick="openAddFoodModal()">➕ 添加食物到数据库</button>
                <p style="font-size: 0.9rem; color: #6c757d; margin-top: 8px;">此功能仅管理员可见，用于维护食物信息库</p>
            </div>
        </div>
        <% } %>

        <!-- 高级设置 -->
        <div class="settings-section">
            <h2 class="settings-title"><i>🔧</i> 高级设置</h2>

            <div class="form-group">
                <label>数据导出</label>
                <button class="btn btn-secondary">导出健康数据</button>
                <p style="font-size: 0.9rem; color: #6c757d; margin-top: 8px;">导出所有健康记录和报告数据</p>
            </div>

            <div class="form-group">
                <label>数据清除</label>
                <button class="btn btn-secondary">清除缓存数据</button>
                <p style="font-size: 0.9rem; color: #6c757d; margin-top: 8px;">清除本地缓存，不影响云端数据</p>
            </div>

            <div class="form-group">
                <label>账户管理</label>
                <button class="btn btn-secondary" style="background-color: #e74a3b; border-color: #e74a3b;">注销账户
                </button>
                <p style="font-size: 0.9rem; color: #6c757d; margin-top: 8px;">永久删除账户及相关数据</p>
            </div>
        </div>
    </div>
    <!-- 添加食物模态框 -->
    <div id="addFoodModal" class="modal" style="display: none;">
        <div class="modal-content" style="max-width: 500px;">
            <span class="close" onclick="document.getElementById('addFoodModal').style.display='none'">&times;</span>
            <h3>添加食物</h3>
            <div class="form-group">
                <label>食物名称</label>
                <input type="text" class="form-control" id="foodNameInput" placeholder="如：苹果">
            </div>
            <div class="form-group">
                <label>单位</label>
                <input type="text" class="form-control" id="foodUnitInput" placeholder="如：100g">
            </div>
            <div class="form-group">
                <label>图片URL</label>
                <input type="text" class="form-control" id="foodImageInput" placeholder="http://...">
            </div>
            <div class="form-group">
                <label>热量 (千卡)</label>
                <input type="number" class="form-control" id="foodCaloriesInput">
            </div>
            <div class="form-group">
                <label>蛋白质 (g)</label>
                <input type="number" class="form-control" id="foodProteinInput">
            </div>
            <div class="form-group">
                <label>碳水化合物 (g)</label>
                <input type="number" class="form-control" id="foodCarbsInput">
            </div>
            <div class="form-group">
                <label>脂肪 (g)</label>
                <input type="number" class="form-control" id="foodFatInput">
            </div>
            <div class="form-group">
                <label>膳食纤维 (g)</label>
                <input type="number" class="form-control" id="foodFiberInput">
            </div>
            <div class="form-group">
                <label>糖分 (g)</label>
                <input type="number" class="form-control" id="foodSugarInput">
            </div>
            <div class="form-group">
                <label>钠 (mg)</label>
                <input type="number" class="form-control" id="foodSodiumInput">
            </div>
            <div style="text-align: right;">
                <button class="btn btn-primary" onclick="submitNewFood()">提交</button>
            </div>
        </div>
    </div>

</main>

<script>
    // 密码强度检测
    document.getElementById('newPassword').addEventListener('input', function () {
        const password = this.value;
        const strengthBar = document.getElementById('passwordStrengthBar');
        const strengthText = document.getElementById('passwordStrengthText');

        let strength = 0;
        let text = '';
        let width = 0;
        let color = '';

        if (password.length > 0) {
            if (password.length < 6) {
                strength = 1;
                text = '非常弱';
                width = 25;
                color = '#dc3545';
            } else if (password.length < 8) {
                strength = 2;
                text = '弱';
                width = 35;
                color = '#fd7e14';
            } else if (/[a-z]/.test(password) && /[A-Z]/.test(password) && /[0-9]/.test(password)) {
                strength = 4;
                text = '非常强';
                width = 100;
                color = '#28a745';
            } else if (/[a-zA-Z]/.test(password) && /[0-9]/.test(password)) {
                strength = 3;
                text = '强';
                width = 70;
                color = '#28a745';
            } else {
                strength = 2;
                text = '中等';
                width = 50;
                color = '#ffc107';
            }
        } else {
            text = '';
            width = 0;
        }

        strengthBar.style.width = width + '%';
        strengthBar.style.backgroundColor = color;
        strengthText.textContent = text ? '密码强度：' + text : '';
        strengthText.style.color = color;
    });

    // 主题颜色选择
    document.querySelectorAll('.theme-color').forEach(color => {
        color.addEventListener('click', function () {
            // 移除所有active类
            document.querySelectorAll('.theme-color').forEach(c => {
                c.classList.remove('active');
            });

            // 为当前点击的元素添加active类
            this.classList.add('active');

            // 这里可以添加改变主题色的代码
            const selectedColor = this.getAttribute('data-color');
            console.log('主题色已更改为: ' + selectedColor);
        });
    });

    // 切换开关效果
    document.querySelectorAll('.switch input').forEach(switchEl => {
        switchEl.addEventListener('change', function () {
            console.log('开关状态: ' + (this.checked ? '开启' : '关闭'));
        });
    });

    // 更新按钮事件
    document.querySelectorAll('.btn-primary').forEach(btn => {
        btn.addEventListener('click', function () {
            const section = this.closest('.settings-section');
            const title = section.querySelector('.settings-title').textContent;
            alert(title + '已更新！');
        });
    });


    function openAddFoodModal() {
        document.getElementById("addFoodModal").style.display = "block";
    }


    function submitNewFood() {
        const data = {
            name: document.getElementById("foodNameInput").value,
            unit: document.getElementById("foodUnitInput").value,
            imageUrl: document.getElementById("foodImageInput").value,
            calories: document.getElementById("foodCaloriesInput").value,
            protein: document.getElementById("foodProteinInput").value,
            carbs: document.getElementById("foodCarbsInput").value,
            fat: document.getElementById("foodFatInput").value,
            fiber: document.getElementById("foodFiberInput").value,
            sugar: document.getElementById("foodSugarInput").value,
            sodium: document.getElementById("foodSodiumInput").value
        };
        console.log(data)
        fetch("/HMS/addFoodServlet", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: new URLSearchParams(data).toString()
        })
            .then(res => res.text())
            .then(msg => {
                alert("添加成功！");
                document.getElementById('addFoodModal').style.display = 'none';
            })
            .catch(err => {
                console.error("添加失败：", err);
                alert("添加失败，请检查输入");
            });
    }

    function updatePassword() {
        const current = document.getElementById('currentPassword').value;
        const newPwd = document.getElementById('newPassword').value;
        const confirm = document.getElementById('confirmPassword').value;

        if (!current || !newPwd || !confirm) {
            alert("请填写所有字段！");
            return;
        }

        if (newPwd !== confirm) {
            alert("两次输入的新密码不一致！");
            return;
        }

        // 简单强度校验（可根据需要替换）
        if (newPwd.length < 6) {
            alert("新密码长度不能少于6位！");
            return;
        }

        // 发起 AJAX 请求
        fetch('/HMS/updatePasswordServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({
                currentPassword: current,
                newPassword: newPwd
            })
        })
            .then(res => res.text())
            .then(msg => {
                alert(msg);
            })
            .catch(err => {
                console.error('密码修改失败：', err);
                alert('修改失败，请稍后重试');
            });
    }
    window.onclick = function(event) {
        const modal = document.getElementById("addFoodModal");
        if (event.target === modal) {
            modal.style.display = "none";
        }
    }

</script>
</body>
</html>