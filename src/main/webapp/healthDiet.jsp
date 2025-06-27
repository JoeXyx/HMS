<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8" />
  <title>健康+ 管理系统 - 营养饮食</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="css/main_page.css">
  <style>
    /* 背景条容器 */
    .progress-bar-bg {
      width: 100%;
      height: 10px;
      background-color: #eee;
      border-radius: 5px;
      overflow: hidden;
      margin-top: 4px;
    }

    /* 内部进度条 */
    .progress-bar {
      height: 100%;
      width: 0%;
      transition: width 0.4s ease;
      border-radius: 5px;
    }

    /* 不同营养素不同颜色 */
    .progress-bar.carbs {
      background-color: #42a5f5; /* 蓝色 */
    }

    .progress-bar.protein {
      background-color: #66bb6a; /* 绿色 */
    }

    .progress-bar.fat {
      background-color: #ffa726; /* 橙色 */
    }


    #editFoodModal {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      background: #fff;
      padding: 20px;
      z-index: 1001;
      box-shadow: 0 4px 20px rgba(0,0,0,0.3);
      border-radius: 10px;
      width: 300px;
    }

    #editFoodModal input {
      width: 100%;
      margin: 5px 0 10px;
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .food-card {
      border: 1px solid #ccc;
      border-radius: 12px;
      padding: 10px;
      margin: 10px;
      width: 160px;
      text-align: center;
      cursor: pointer;
      position: relative;
      box-shadow: 0 0 5px rgba(0,0,0,0.1);
      transition: transform 0.2s ease;
    }

    .food-card:hover {
      transform: scale(1.02);
    }

    .food-img {
      width: 100%;
      height: 100px;
      object-fit: cover;
      border-radius: 8px;
    }

    .food-header {
      margin-top: 8px;
      font-weight: bold;
    }

    .delete-food {
      position: absolute;
      top: 5px;
      right: 8px;
      background: transparent;
      border: none;
      font-size: 18px;
      cursor: pointer;
      color: #f00;
    }

    /* 饮食模块特有样式 */
    .diet-container {
      display: grid;
      grid-template-columns: 1fr 350px;
      gap: 25px;
      margin-top: 20px;
    }

    .meals-container {
      background: white;
      border-radius: 15px;
      padding: 20px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    }

    .meal-section {
      margin-bottom: 30px;
    }

    .meal-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
      padding-bottom: 10px;
      border-bottom: 2px solid #f0f5ff;
    }

    .meal-title {
      font-size: 1.4rem;
      color: #3498db;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .meal-icon {
      font-size: 1.6rem;
    }

    .add-food-btn {
      background: #3498db;
      color: white;
      border: none;
      border-radius: 30px;
      padding: 8px 20px;
      font-size: 0.9rem;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 5px;
      transition: all 0.3s;
    }

    .add-food-btn:hover {
      background: #2980b9;
      transform: translateY(-2px);
    }

    .food-items {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
      gap: 15px;
    }

    .food-card {
      background: white;
      border-radius: 10px;
      padding: 15px;
      box-shadow: 0 3px 10px rgba(0,0,0,0.08);
      border: 1px solid #eaeaea;
      transition: all 0.3s;
      display: flex;
      flex-direction: column;
      position: relative;
    }

    .food-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      border-color: #d6e4ff;
    }

    .food-header {
      display: flex;
      justify-content: space-between;
      margin-bottom: 10px;
    }

    .food-name {
      font-weight: 600;
      font-size: 1.1rem;
      color: #2c3e50;
    }

    .food-quantity {
      color: #7f8c8d;
      font-size: 0.9rem;
    }

    .nutrients {
      display: flex;
      gap: 15px;
      margin-top: 10px;
      padding-top: 10px;
      border-top: 1px solid #f5f5f5;
    }

    .nutrient {
      text-align: center;
      flex: 1;
    }

    .nutrient-value {
      font-weight: bold;
      color: #3498db;
    }

    .nutrient-label {
      font-size: 0.8rem;
      color: #95a5a6;
    }

    .delete-food {
      position: absolute;
      top: 10px;
      right: 10px;
      background: #e74c3c;
      color: white;
      border: none;
      border-radius: 50%;
      width: 24px;
      height: 24px;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      font-size: 1rem;
      padding: 0;
      line-height: 1;
    }

    /* 营养分析面板 */
    .nutrition-panel {
      background: white;
      border-radius: 15px;
      padding: 25px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.08);
      position: sticky;
      top: 20px;
    }

    .panel-title {
      text-align: center;
      font-size: 1.3rem;
      color: #2c3e50;
      margin-bottom: 20px;
      padding-bottom: 15px;
      border-bottom: 2px solid #f0f5ff;
    }

    .calories-display {
      text-align: center;
      margin-bottom: 25px;
    }

    .calories-value {
      font-size: 3rem;
      font-weight: 700;
      color: #3498db;
      line-height: 1;
    }

    .calories-label {
      font-size: 1rem;
      color: #7f8c8d;
    }

    .progress-container {
      margin-bottom: 20px;
    }

    .progress-label {
      display: flex;
      justify-content: space-between;
      margin-bottom: 5px;
      font-size: 0.9rem;
    }

    .progress-bar-bg {
      height: 10px;
      background: #ecf0f1;
      border-radius: 5px;
      overflow: hidden;
    }

    .progress-bar {
      height: 100%;
      border-radius: 5px;
    }

    .carbs .progress-bar { background: #3498db; }
    .protein .progress-bar { background: #2ecc71; }
    .fat .progress-bar { background: #e67e22; }

    .nutrient-targets {
      background: #f9fbfd;
      border-radius: 10px;
      padding: 15px;
      margin-top: 20px;
      border: 1px solid #eaeaea;
    }

    .target-item {
      display: flex;
      justify-content: space-between;
      margin-bottom: 10px;
      padding-bottom: 10px;
      border-bottom: 1px solid #f0f5ff;
    }

    .target-item:last-child {
      margin-bottom: 0;
      padding-bottom: 0;
      border-bottom: none;
    }

    .target-value {
      font-weight: 600;
    }

    /* 食谱推荐 */
    .recipes-section {
      margin-top: 30px;
    }

    .recipe-card {
      background: white;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 4px 10px rgba(0,0,0,0.08);
      transition: all 0.3s;
      margin-bottom: 20px;
    }

    .recipe-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    }

    .recipe-image {
      height: 150px;
      background-size: cover;
      background-position: center;
    }

    .recipe-content {
      padding: 15px;
    }

    .recipe-title {
      font-size: 1.1rem;
      font-weight: 600;
      margin-bottom: 10px;
      color: #2c3e50;
    }

    .recipe-meta {
      display: flex;
      gap: 15px;
      font-size: 0.85rem;
      color: #7f8c8d;
    }

    .recipe-meta span {
      display: flex;
      align-items: center;
      gap: 5px;
    }

    /* 添加食物模态框 */
    #addFoodModal {
      display: none;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      background-color: white;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 5px 30px rgba(0,0,0,0.2);
      z-index: 1000;
      width: 90%;
      max-width: 600px;
      max-height: 90vh;
      overflow-y: auto;
    }

    .modal-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .close-btn {
      background: none;
      border: none;
      font-size: 1.5rem;
      cursor: pointer;
      color: #7f8c8d;
    }

    .search-container {
      position: relative;
      margin-bottom: 20px;
    }

    .search-input {
      width: 100%;
      padding: 12px 15px 12px 45px;
      border: 1px solid #ddd;
      border-radius: 30px;
      font-size: 1rem;
      transition: all 0.3s;
    }

    .search-input:focus {
      border-color: #3498db;
      outline: none;
      box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
    }

    .search-icon {
      position: absolute;
      left: 15px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 1.2rem;
      color: #95a5a6;
    }

    .food-results {
      max-height: 300px;
      overflow-y: auto;
      margin-bottom: 20px;
      border: 1px solid #eee;
      border-radius: 10px;
    }

    .food-result-item {
      padding: 12px 15px;
      border-bottom: 1px solid #f5f5f5;
      cursor: pointer;
      display: flex;
      justify-content: space-between;
      align-items: center;
      transition: background 0.2s;
    }

    .food-result-item:hover {
      background: #f9fbfd;
    }

    .food-result-name {
      font-weight: 500;
    }

    .food-result-calories {
      color: #7f8c8d;
      font-size: 0.9rem;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-row {
      display: flex;
      gap: 15px;
    }

    .form-group.half {
      flex: 1;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      font-weight: 500;
      color: #2c3e50;
    }

    .form-control {
      width: 100%;
      padding: 12px;
      border: 1px solid #ddd;
      border-radius: 8px;
      font-size: 1rem;
      transition: border-color 0.3s;
    }

    .form-control:focus {
      border-color: #3498db;
      outline: none;
      box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
    }

    .submit-btn {
      background-color: #3498db;
      color: white;
      border: none;
      border-radius: 8px;
      padding: 12px 20px;
      font-size: 1rem;
      cursor: pointer;
      width: 100%;
      transition: background-color 0.3s;
    }

    .submit-btn:hover {
      background-color: #2980b9;
    }

    /* 覆盖层 */
    .overlay {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0,0,0,0.5);
      z-index: 999;
    }

    /* 响应式调整 */
    @media (max-width: 900px) {
      .diet-container {
        grid-template-columns: 1fr;
      }

      .nutrition-panel {
        position: static;
      }
    }

    /* 空状态样式 */
    .empty-message {
      text-align: center;
      padding: 20px;
      color: #7f8c8d;
      font-style: italic;
      border: 1px dashed #e0e0e0;
      border-radius: 8px;
      background-color: #f9f9f9;
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
    <a href="main_page.jsp">🏥 健康档案</a>
    <a href="sportLink.jsp">🏃‍♂️ 运动记录</a>
    <a href="#" id="dietLink" class="active">🍱 营养饮食</a>
    <a href="reportLink.jsp">📊 体检报告</a>
    <a href="settingLink.jsp">⚙️ 设置</a>
  </nav>
</aside>

<main>
  <!-- 默认首页 -->
  <div id="dashboardView">
    <h2>欢迎使用健康+ 管理系统</h2>
    <p>请选择左侧菜单功能查看相关信息。</p>
  </div>

  <!-- 饮食记录视图 -->
  <div id="dietView" style="display:none;">
    <button class="back-btn" onclick="showDashboard()">← 返回首页</button>

    <div class="diet-container">
      <div class="meals-container">
        <h2>今日饮食记录</h2>
        <p class="subtitle"><span id="todayDate"></span> | 已摄入 <span id="totalCalories">0</span> 卡路里</p>

        <div class="meal-section">
          <div class="meal-header">
            <div class="meal-title">
              <span class="meal-icon">🌅</span> 早餐
            </div>
            <button class="add-food-btn" data-meal="breakfast">
              <span>+</span> 添加食物
            </button>
          </div>
          <div class="food-items" id="breakfastItems">
            <!-- 早餐食物卡片 -->
            <div class="empty-message">暂无记录，请添加食物</div>
          </div>
        </div>

        <div class="meal-section">
          <div class="meal-header">
            <div class="meal-title">
              <span class="meal-icon">☀️</span> 午餐
            </div>
            <button class="add-food-btn" data-meal="lunch">
              <span>+</span> 添加食物
            </button>
          </div>
          <div class="food-items" id="lunchItems">
            <!-- 午餐食物卡片 -->
            <div class="empty-message">暂无记录，请添加食物</div>
          </div>
        </div>

        <div class="meal-section">
          <div class="meal-header">
            <div class="meal-title">
              <span class="meal-icon">🌙</span> 晚餐
            </div>
            <button class="add-food-btn" data-meal="dinner">
              <span>+</span> 添加食物
            </button>
          </div>
          <div class="food-items" id="dinnerItems">
            <!-- 晚餐食物卡片 -->
            <div class="empty-message">暂无记录，请添加食物</div>
          </div>
        </div>

        <div class="meal-section">
          <div class="meal-header">
            <div class="meal-title">
              <span class="meal-icon">🍎</span> 加餐
            </div>
            <button class="add-food-btn" data-meal="snacks">
              <span>+</span> 添加食物
            </button>
          </div>
          <div class="food-items" id="snacksItems">
            <!-- 加餐食物卡片 -->
            <div class="empty-message">暂无记录，请添加食物</div>
          </div>
        </div>
      </div>

      <div class="nutrition-panel">
        <div class="panel-title">今日营养分析</div>

        <div class="calories-display">
          <div class="calories-value" id="caloriesValue">0</div>
          <div class="calories-label">卡路里</div>
        </div>

        <div class="progress-container">
          <div class="progress-label">
            <span>碳水化合物</span>
            <span><span id="carbsValue">0</span>g / 300g</span>
          </div>
          <div class="progress-bar-bg">
            <div class="progress-bar carbs" id="carbsBar" style="width: 0%"></div>
          </div>
        </div>

        <div class="progress-container">
          <div class="progress-label">
            <span>蛋白质</span>
            <span><span id="proteinValue">0</span>g / 120g</span>
          </div>
          <div class="progress-bar-bg">
            <div class="progress-bar protein" id="proteinBar" style="width: 0%"></div>
          </div>
        </div>

        <div class="progress-container">
          <div class="progress-label">
            <span>脂肪</span>
            <span><span id="fatValue">0</span>g / 70g</span>
          </div>
          <div class="progress-bar-bg">
            <div class="progress-bar fat" id="fatBar" style="width: 0%"></div>
          </div>
        </div>

        <div class="nutrient-targets">
          <div class="target-item">
            <span>膳食纤维</span>
            <span class="target-value"><span id="fiberValue">0</span>g / 25g</span>
          </div>
          <div class="target-item">
            <span>糖分</span>
            <span class="target-value"><span id="sugarValue">0</span>g / 50g</span>
          </div>
          <div class="target-item">
            <span>钠</span>
            <span class="target-value"><span id="sodiumValue">0</span>mg / 2300mg</span>
          </div>
        </div>

        <div class="recipes-section">
          <h3>健康食谱推荐</h3>
          <div class="recipe-card">
            <div class="recipe-image" style="background-image: url('https://images.unsplash.com/photo-1490818387583-1baba5e638af?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80')"></div>
            <div class="recipe-content">
              <div class="recipe-title">地中海烤鸡沙拉</div>
              <div class="recipe-meta">
                <span>⏱️ 25分钟</span>
                <span>🔥 320卡路里</span>
                <span>🥗 简单</span>
              </div>
            </div>
          </div>

          <div class="recipe-card">
            <div class="recipe-image" style="background-image: url('https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80')"></div>
            <div class="recipe-content">
              <div class="recipe-title">藜麦蔬菜碗</div>
              <div class="recipe-meta">
                <span>⏱️ 20分钟</span>
                <span>🔥 280卡路里</span>
                <span>🥗 简单</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 添加食物模态框 -->
  <div id="addFoodModal" style="display:none;">
    <div class="modal-header">
      <h3>添加食物记录</h3>
      <button class="close-btn" onclick="closeAddFoodModal()">&times;</button>
    </div>

    <div class="search-container">
      <span class="search-icon">🔍</span>
      <input type="text" class="search-input" id="foodSearch" placeholder="搜索食物...">

    </div>

    <div class="food-results" id="foodResults">
      <div class="food-result-item" data-food='{"name":"水煮鸡胸肉","calories":165,"protein":31,"carbs":0,"fat":3.6,"fiber":0,"sugar":0,"sodium":70}'>
        <div class="food-result-name">水煮鸡胸肉 (100g)</div>
        <div class="food-result-calories">165卡</div>
      </div>
      <div class="food-result-item" data-food='{"name":"白米饭","calories":130,"protein":2.7,"carbs":28,"fat":0.3,"fiber":0.4,"sugar":0.1,"sodium":1}'>
        <div class="food-result-name">白米饭 (100g)</div>
        <div class="food-result-calories">130卡</div>
      </div>
      <div class="food-result-item" data-food='{"name":"西兰花","calories":34,"protein":2.8,"carbs":7,"fat":0.4,"fiber":2.6,"sugar":1.7,"sodium":33}'>
        <div class="food-result-name">西兰花 (100g)</div>
        <div class="food-result-calories">34卡</div>
      </div>
      <div class="food-result-item" data-food='{"name":"苹果","calories":95,"protein":0.5,"carbs":25,"fat":0.3,"fiber":4.4,"sugar":19,"sodium":2}'>
        <div class="food-result-name">苹果 (中等大小)</div>
        <div class="food-result-calories">95卡</div>
      </div>
      <div class="food-result-item" data-food='{"name":"全麦面包","calories":70,"protein":3,"carbs":12,"fat":1,"fiber":2,"sugar":1,"sodium":150}'>
        <div class="food-result-name">全麦面包 (1片)</div>
        <div class="food-result-calories">70卡</div>
      </div>
    </div>

    <div class="form-row">
      <div class="form-group half">
        <label>食物名称</label>
        <input type="text" class="form-control" id="inputFoodName" placeholder="例如：鸡胸肉">
      </div>
      <div class="form-group half">
        <label>份量 (g)</label>
        <input type="number" class="form-control" id="inputQuantity" min="1" value="100">
      </div>
    </div>

    <div class="form-row">
      <div class="form-group half">
        <label>卡路里 (kcal)</label>
        <input type="number" class="form-control" id="inputCalories" min="0" value="0">
      </div>
      <div class="form-group half">
        <label>蛋白质 (g)</label>
        <input type="number" class="form-control" id="inputProtein" min="0" step="0.1" value="0">
      </div>
    </div>

    <div class="form-row">
      <div class="form-group half">
        <label>碳水化合物 (g)</label>
        <input type="number" class="form-control" id="inputCarbs" min="0" step="0.1" value="0">
      </div>
      <div class="form-group half">
        <label>脂肪 (g)</label>
        <input type="number" class="form-control" id="inputFat" min="0" step="0.1" value="0">
      </div>
      <input type="hidden" id="inputImageUrl" />
    </div>

    <button class="submit-btn" onclick="addFoodItem()">添加食物</button>
  </div>

  <!-- 模态框覆盖层 -->
  <div class="overlay" id="modalOverlay" onclick="closeAddFoodModal()"></div>

<%--  点击图片添加相关数据--%>
  <!-- 编辑食物信息模态框 -->
  <div id="editFoodModal" style="display:none;">
    <div class="modal-header">
      <h3>编辑食物信息</h3>
      <button class="close-btn" onclick="closeEditFoodModal()">&times;</button>
    </div>

    <div class="form-row">
      <div class="form-group half">
        <label>卡路里 (kcal)</label>
        <input type="number" class="form-control" id="editCalories" min="0">
      </div>
      <div class="form-group half">
        <label>蛋白质 (g)</label>
        <input type="number" class="form-control" id="editProtein" min="0" step="0.1">
      </div>
    </div>

    <div class="form-row">
      <div class="form-group half">
        <label>碳水化合物 (g)</label>
        <input type="number" class="form-control" id="editCarbs" min="0" step="0.1">
      </div>
      <div class="form-group half">
        <label>脂肪 (g)</label>
        <input type="number" class="form-control" id="editFat" min="0" step="0.1">
      </div>
    </div>

    <button class="submit-btn" onclick="confirmEditFood()">确认修改</button>
  </div>
</main>

<script>
  // 初始化今日饮食数据
  let todayDiet = {
    breakfast: [],
    lunch: [],
    dinner: [],
    snacks: []
  };
  let foodItems = []; // 全局变量

  // 当前选择的餐次
  let currentMeal = "";

  // 设置今日日期
  function setTodayDate() {
    const now = new Date();
    const options = { year: 'numeric', month: 'long', day: 'numeric', weekday: 'long' };
    document.getElementById('todayDate').textContent = now.toLocaleDateString('zh-CN', options);
  }

  // 渲染食物列表
  function renderFoodItems(meal) {
    console.log("正在渲染餐次：", meal);

    const container = document.getElementById(meal + "Items");
    if (!container) {
      console.warn(`容器 ${meal}Items 未找到`);
      return;
    }

    container.innerHTML = '';
    const foods = todayDiet[meal];

    if (!foods || foods.length === 0) {
      const emptyMessage = document.createElement('div');
      emptyMessage.className = 'empty-message';
      emptyMessage.textContent = '暂无记录，请添加食物';
      container.appendChild(emptyMessage);
      return;
    }

    foods.forEach(food => {
      const foodCard = createFoodCard(food, meal);
      container.appendChild(foodCard);
    });
  }

  // createFoodCard(food, meal) 函数（创建单个卡片）
  function createFoodCard(food, meal) {
    const card = document.createElement('div');
    card.className = 'food-card';

    // 点击卡片进入编辑
    card.addEventListener('click', () => {
      console.log("点击卡片准备编辑", food.id);
      showEditFoodModal(food, meal);
    });

    // 图片区域
    const img = document.createElement('img');
    img.src = food.imageUrl || 'default.jpg';
    img.alt = food.name;
    img.className = 'food-img';

    // 名称 + 卡路里
    const header = document.createElement('div');
    header.className = 'food-header';

    const nameDiv = document.createElement('div');
    nameDiv.className = 'food-name';
    nameDiv.textContent = food.name || '未知食物';

    const calorieDiv = document.createElement('div');
    calorieDiv.className = 'food-quantity';
    calorieDiv.textContent = (food.calories || 0) + " kcal";


    header.appendChild(nameDiv);
    header.appendChild(calorieDiv);

    // 删除按钮
    const deleteBtn = document.createElement('button');
    deleteBtn.className = 'delete-food';
    deleteBtn.textContent = '×';
    deleteBtn.addEventListener('click', (event) => {
      event.stopPropagation(); // 防止触发卡片点击
      removeFood(meal, food.id);
    });

    // 组装卡片
    card.appendChild(img);
    card.appendChild(header);
    card.appendChild(deleteBtn);
    return card;
  }


  // 更新营养分析面板
  function updateNutritionPanel() {
    let totalCalories = 0;
    let totalProtein = 0;
    let totalCarbs = 0;
    let totalFat = 0;
    let totalFiber = 0;
    let totalSugar = 0;
    let totalSodium = 0;

    Object.values(todayDiet).forEach(meal => {
      meal.forEach(food => {
        totalCalories += Number(food.calories) || 0;
        totalProtein += Number(food.protein) || 0;
        totalCarbs += Number(food.carbs) || 0;
        totalFat += Number(food.fat) || 0;
        totalFiber += Number(food.fiber) || 0;
        totalSugar += Number(food.sugar) || 0;
        totalSodium += Number(food.sodium) || 0;
      });
    });

    // 更新UI
    document.getElementById('totalCalories').textContent = totalCalories;
    document.getElementById('caloriesValue').textContent = totalCalories;

    document.getElementById('proteinValue').textContent = totalProtein.toFixed(1);
    document.getElementById('carbsValue').textContent = totalCarbs.toFixed(1);
    document.getElementById('fatValue').textContent = totalFat.toFixed(1);
    document.getElementById('fiberValue').textContent = totalFiber.toFixed(1);
    document.getElementById('sugarValue').textContent = totalSugar.toFixed(1);
    document.getElementById('sodiumValue').textContent = totalSodium.toFixed(0);

    // 更新进度条
    console.log("蛋白质条宽度：", Math.min(totalProtein / 120 * 100, 100) + '%');

    document.getElementById('proteinBar').style.width = Math.min(totalProtein / 120 * 100, 100) + '%';
    document.getElementById('carbsBar').style.width = Math.min(totalCarbs / 300 * 100, 100) + '%';
    document.getElementById('fatBar').style.width = Math.min(totalFat / 70 * 100, 100) + '%';
  }


  // 添加食物
  function addFoodItem() {
    const name = document.getElementById('inputFoodName').value;
    const quantity = parseInt(document.getElementById('inputQuantity').value);
    const calories = parseInt(document.getElementById('inputCalories').value);
    const protein = parseFloat(document.getElementById('inputProtein').value);
    const carbs = parseFloat(document.getElementById('inputCarbs').value);
    const fat = parseFloat(document.getElementById('inputFat').value);
    const imageUrl = document.getElementById('inputImageUrl').value;


    if (!name || quantity <= 0) {
      alert('请填写完整的食物信息');
      return;
    }

    // 创建食物对象
    const newFood = {
      id: Date.now(), // 使用时间戳作为唯一ID
      name: name,
      quantity: quantity,
      calories: calories,
      protein: protein,
      carbs: carbs,
      fat: fat,
      fiber: 0, // 简化处理
      sugar: 0, // 简化处理
      sodium: 0, // 简化处理
      imageUrl:imageUrl
    }

    // 添加到当前餐次
    todayDiet[currentMeal].push(newFood);

    // 更新UI
    renderFoodItems(currentMeal);
    updateNutritionPanel();

    // 关闭模态框
    closeAddFoodModal();

    // 重置表单
    document.getElementById('inputFoodName').value = '';
    document.getElementById('inputQuantity').value = '100';
    document.getElementById('inputCalories').value = '0';
    document.getElementById('inputProtein').value = '0';
    document.getElementById('inputCarbs').value = '0';
    document.getElementById('inputFat').value = '0';
    document.getElementById('inputImageUrl').value = ''; // 清空图片

  }

  // 删除食物
  function removeFood(meal, foodId) {
    todayDiet[meal] = todayDiet[meal].filter(food => food.id !== foodId);
    renderFoodItems(meal);
    updateNutritionPanel();
  }

  // 显示添加食物模态框
  function showAddFoodModal(meal) {
    currentMeal = meal;
    document.getElementById('addFoodModal').style.display = 'block';
    document.getElementById('modalOverlay').style.display = 'block';

    renderFoodResults();
  }

  // 关闭添加食物模态框
  function closeAddFoodModal() {
    document.getElementById('addFoodModal').style.display = 'none';
    document.getElementById('modalOverlay').style.display = 'none';
  }

  // 初始化饮食页面
  function initDietPage() {
    setTodayDate();

    fetch("/HMS/dietServlet ")
            .then(res => res.json())
            .then(data => {
              // 清空原始 todayDiet
              todayDiet = {
                breakfast: [],
                lunch: [],
                dinner: [],
                snacks: []
              };

              // 枚举映射
              const mealMap = {
                BREAKFAST: 'breakfast',
                LUNCH: 'lunch',
                DINNER: 'dinner',
                SNACK: 'snacks'
              };

              // 分类数据
              data.forEach(item => {
                const mealKey = mealMap[item.mealType];
                if (mealKey && todayDiet[mealKey]) {
                  todayDiet[mealKey].push(item);
                }
              });

              renderFoodItems('breakfast');
              renderFoodItems('lunch');
              renderFoodItems('dinner');
              renderFoodItems('snacks');
              updateNutritionPanel();
            })

            .catch(err => {
              console.error("获取饮食记录失败", err);
            });
    //读取数据库所有食物
    preloadFoodItems();

    // 渲染所有餐次
    renderFoodItems('breakfast');
    renderFoodItems('lunch');
    renderFoodItems('dinner');
    renderFoodItems('snacks');

    // 更新营养面板
    updateNutritionPanel();

    // 添加食物按钮事件 - 使用事件委托确保动态元素绑定
    document.getElementById('dietView').addEventListener('click', function (e) {
      const btn = e.target.closest('.add-food-btn');
      if (btn) {
        console.log("点击添加按钮", btn.dataset.meal);
        showAddFoodModal(btn.dataset.meal);
      }
    });

    document.getElementById('foodSearch').addEventListener('input', function () {
      const searchTerm = this.value.trim().toLowerCase();
      if (!searchTerm) {
        renderFoodResults(); // 输入为空时显示全部
        return;
      }

      const filtered = foodItems.filter(food => {
        const name = (food.name ?? '').toLowerCase();
        return name.includes(searchTerm);
      });

      renderFoodResults(filtered);
    });



    // 食物结果点击事件
    document.getElementById('foodResults').addEventListener('click', function(e) {
      const item = e.target.closest('.food-result-item');
      if (item) {
        const foodData = JSON.parse(item.dataset.food);
        document.getElementById('inputFoodName').value = foodData.name;
        document.getElementById('inputCalories').value = foodData.calories;
        document.getElementById('inputProtein').value = foodData.protein;
        document.getElementById('inputCarbs').value = foodData.carbs;
        document.getElementById('inputFat').value = foodData.fat;

        document.getElementById('inputImageUrl').value = foodData.imageUrl || '';
      }
    });
  }

  // 视图切换函数
  function showDietView() {
    document.getElementById('dashboardView').style.display = 'none';
    document.getElementById('dietView').style.display = 'block';
    initDietPage();
  }

  function showDashboard() {
    document.getElementById('dietView').style.display = 'none';
    document.getElementById('dashboardView').style.display = 'block';
  }

  // 绑定饮食链接
  document.getElementById("dietLink").addEventListener("click", function (e) {
    e.preventDefault();
    showDietView();
  });

  // 页面加载时设置默认日期
  window.onload = function() {
    setTodayDate();

    // // 绑定模态框关闭事件
    // document.querySelectorAll('.close-btn').forEach(btn => {
    //   btn.addEventListener('click', closeAddFoodModal);
    // });
  };
  let editingFood = null;
  let editingMeal = null;

  function showEditFoodModal(food, meal) {
    editingFood = food;
    editingMeal = meal;

    // 填充表单
    document.getElementById('editCalories').value = food.calories || 0;
    document.getElementById('editProtein').value = food.protein || 0;
    document.getElementById('editCarbs').value = food.carbs || 0;
    document.getElementById('editFat').value = food.fat || 0;

    // 显示模态框
    document.getElementById('editFoodModal').style.display = 'block';
    document.getElementById('modalOverlay').style.display = 'block';
  }

  function closeEditFoodModal() {
    document.getElementById('editFoodModal').style.display = 'none';
    document.getElementById('modalOverlay').style.display = 'none';
  }

  function confirmEditFood() {
    if (!editingFood || !editingMeal) return;

    // 更新对象
    editingFood.calories = parseInt(document.getElementById('editCalories').value) || 0;
    editingFood.protein = parseFloat(document.getElementById('editProtein').value) || 0;
    editingFood.carbs = parseFloat(document.getElementById('editCarbs').value) || 0;
    editingFood.fat = parseFloat(document.getElementById('editFat').value) || 0;

    // 重新渲染和更新面板
    renderFoodItems(editingMeal);
    updateNutritionPanel();

    closeEditFoodModal();
  }

  function preloadFoodItems() {
    if (foodItems.length > 0) return; // 已加载则跳过

    fetch('/HMS/getFoodItemsServlet')
            .then(res => res.json())
            .then(data => {
              foodItems = data;
              console.log("已预加载食物数据：", foodItems);
            });
  }
  // 显示数据库食物数据
  function renderFoodResults(filteredList = foodItems) {
    const container = document.getElementById('foodResults');
    container.innerHTML = ''; // 先清空

      if (filteredList.length === 0) {
        container.innerHTML = '<div class="no-results">没有找到匹配的食物</div>';
        return;
      }

    filteredList.forEach(food => {
      const item = document.createElement('div');
      item.className = 'food-result-item';
      item.dataset.food = JSON.stringify(food);
      // 名称和卡路里
      const nameDiv = document.createElement('div');
      nameDiv.className = 'food-result-name';
      nameDiv.textContent = food.name+`(`+food.unit+`g)`;

      const calorieDiv = document.createElement('div');
      calorieDiv.className = 'food-result-calories';
      calorieDiv.textContent = `${food.calories}卡`;

      const carbsDiv = document.createElement('div');
      carbsDiv.className = 'food-result-carbs';
      carbsDiv.textContent = `${food.carbs}g`;

      const fatDiv = document.createElement('div');
      fatDiv.className = 'food-result-fat';
      fatDiv.textContent = `${food.fat}g`;

      const fiberDiv = document.createElement('div');
      fiberDiv.className = 'food-result-fiber';
      fiberDiv.textContent = `${food.fiber}g`;

      const sugarDiv = document.createElement('div');
      sugarDiv.className = 'food-result-sugar';
      sugarDiv.textContent = `${food.sugar}g`;

      const sodiumDiv = document.createElement('div');
      sodiumDiv.className = 'food-result-sodium';
      sodiumDiv.textContent = `${food.sodium}mg`;


      item.appendChild(nameDiv);
      item.appendChild(calorieDiv);

      container.appendChild(item);
      });
  }

</script>
</body>
</html>