<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8" />
    <title>健康+ 管理系统 - 运动记录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/main_page.css">
    <style>
        /* 运动记录特有样式 */
        .sport-card {
            background: linear-gradient(135deg, #4a90e2 0%, #63b3ed 100%);
            color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            position: relative;
            transition: transform 0.3s ease;
        }

        .sport-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }

        .sport-card h3 {
            margin-top: 0;
            font-size: 1.4rem;
            border-bottom: 1px solid rgba(255,255,255,0.3);
            padding-bottom: 10px;
        }

        .sport-card .sport-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .sport-stats {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }

        .stat-item {
            text-align: center;
            flex: 1;
        }

        .stat-value {
            font-size: 1.4rem;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 0.85rem;
            opacity: 0.9;
        }

        .sport-type-tag {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255,255,255,0.2);
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
        }

        /* 运动类型颜色 */
        .cardio { background: linear-gradient(135deg, #4a90e2 0%, #63b3ed 100%); }
        .strength { background: linear-gradient(135deg, #e74c3c 0%, #e67e22 100%); }
        .flexibility { background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%); }
        .balance { background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%); }

        /* 添加按钮 */
        .add-sport-btn {
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 50px;
            padding: 12px 25px;
            font-size: 1rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            margin: 20px 0;
            transition: all 0.3s ease;
        }

        .add-sport-btn:hover {
            background-color: #2980b9;
            transform: scale(1.05);
        }

        .add-sport-btn span {
            font-size: 1.5rem;
            margin-right: 8px;
        }

        /* 模态框样式 */
        #addSportModal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.2);
            z-index: 1000;
            width: 90%;
            max-width: 500px;
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

        .form-group {
            margin-bottom: 20px;
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
            border-radius: 5px;
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
            border-radius: 5px;
            padding: 12px 20px;
            font-size: 1rem;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background-color: #2980b9;
        }

        /* 运动详情样式 */
        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .detail-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .detail-card h4 {
            margin-top: 0;
            color: #3498db;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }

        /* 进度条样式 */
        .progress-container {
            background-color: #ecf0f1;
            border-radius: 10px;
            height: 10px;
            margin: 15px 0;
        }

        .progress-bar {
            height: 100%;
            border-radius: 10px;
            background-color: #3498db;
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
        <a href="#" id="sportLink" class="active">🏃‍♂️ 运动记录</a>
        <a href="healthDiet.jsp">🍱 营养饮食</a>
        <a href="reportLink.jsp">📊 体检报告</a>
        <a href="settingLink.jsp">⚙️ 设置</a>    </nav>
</aside>

<main>
    <!-- 默认首页 -->
    <div id="dashboardView">
        <h2>欢迎使用健康+ 管理系统</h2>
        <p>请选择左侧菜单功能查看相关信息。</p>
    </div>

    <!-- 运动记录视图 -->
    <div id="sportRecordsView" style="display:none;">
        <button class="back-btn" onclick="showDashboard()">← 返回首页</button>
        <h2>我的运动记录</h2>
        <button class="add-sport-btn" onclick="showAddSportModal()">
            <span>+</span> 添加运动记录
        </button>

        <div id="sportList" class="dashboard">
            <!-- 运动记录卡片将通过JS动态添加 -->
            <div class="sport-card cardio">
                <div class="sport-type-tag">有氧运动</div>
                <h3>晨跑</h3>
                <div class="sport-icon">🏃‍♂️</div>
                <div class="sport-stats">
                    <div class="stat-item">
                        <div class="stat-value">45</div>
                        <div class="stat-label">分钟</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">5.2</div>
                        <div class="stat-label">公里</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">320</div>
                        <div class="stat-label">卡路里</div>
                    </div>
                </div>
            </div>

            <div class="sport-card strength">
                <div class="sport-type-tag">力量训练</div>
                <h3>健身房训练</h3>
                <div class="sport-icon">💪</div>
                <div class="sport-stats">
                    <div class="stat-item">
                        <div class="stat-value">60</div>
                        <div class="stat-label">分钟</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">12</div>
                        <div class="stat-label">组数</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">420</div>
                        <div class="stat-label">卡路里</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 运动记录详情视图 -->
    <div id="sportDetailView" style="display:none;">
        <button class="back-btn" onclick="showSportRecords()">← 返回记录列表</button>
        <div class="member-details">
            <h3 id="sportDetailName">运动详情</h3>

            <div class="detail-grid">
                <div class="detail-card">
                    <h4>基本信息</h4>
                    <div class="detail-row">
                        <div class="detail-item">
                            <label>运动类型</label>
                            <div id="detailSportType">--</div>
                        </div>
                        <div class="detail-item">
                            <label>运动日期</label>
                            <div id="detailSportDate">--</div>
                        </div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-item">
                            <label>持续时间</label>
                            <div id="detailDuration">--</div>
                        </div>
                        <div class="detail-item">
                            <label>运动强度</label>
                            <div id="detailIntensity">--</div>
                        </div>
                    </div>
                </div>

                <div class="detail-card">
                    <h4>运动数据</h4>
                    <div class="detail-item">
                        <label>消耗卡路里</label>
                        <div id="detailCalories">--</div>
                    </div>
                    <div class="detail-item">
                        <label>距离</label>
                        <div id="detailDistance">--</div>
                    </div>
                    <div class="detail-item">
                        <label>平均心率</label>
                        <div id="detailHeartRate">--</div>
                    </div>
                </div>

                <div class="detail-card">
                    <h4>个人感受</h4>
                    <div class="detail-item">
                        <label>努力程度</label>
                        <div class="progress-container">
                            <div class="progress-bar" style="width: 70%"></div>
                        </div>
                        <div>7/10</div>
                    </div>
                    <div class="detail-item">
                        <label>备注</label>
                        <div id="detailNotes">--</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 添加运动记录模态框 -->
    <div id="addSportModal" style="display:none;">
        <div class="modal-header">
            <h3>添加运动记录</h3>
            <button class="close-btn" onclick="closeAddSportModal()">&times;</button>
        </div>
        <div class="form-group">
            <label>运动类型</label>
            <select class="form-control" id="inputSportType">
                <option value="跑步">跑步</option>
                <option value="走路">走路</option>
                <option value="骑行">骑行</option>
                <option value="瑜伽">瑜伽</option>
                <option value="跳绳">跳绳</option>
                <option value="游泳">游泳</option>
            </select>
        </div>
        <div class="form-group">
            <label>运动名称</label>
            <input type="text" class="form-control" id="inputSportName" placeholder="例如：晨跑、瑜伽等">
        </div>
        <div class="form-group">
            <label>运动日期</label>
            <input type="date" class="form-control" id="inputSportDate">
        </div>
        <div class="form-group">
            <label>持续时间 (分钟)</label>
            <input type="number" class="form-control" id="inputDuration" min="1" max="300">
        </div>
        <div class="form-group">
            <label>消耗卡路里</label>
            <input type="number" class="form-control" id="inputCalories" min="1">
        </div>
        <div class="form-group">
            <label>距离 (公里，可选)</label>
            <input type="number" class="form-control" id="inputDistance" step="0.1">
        </div>
        <div class="form-group">
            <label>平均心率 (可选)</label>
            <input type="number" class="form-control" id="inputHeartRate" min="40" max="200">
        </div>
        <div class="form-group">
            <label>运动强度</label>
            <select class="form-control" id="inputIntensity">
                <option value="low">低强度</option>
                <option value="medium" selected>中等强度</option>
                <option value="high">高强度</option>
            </select>
        </div>
        <div class="form-group">
            <label>个人感受 (1-10)</label>
            <input type="range" class="form-control" id="inputEffort" min="1" max="10" value="5">
            <div style="text-align: center; margin-top: 5px;"><span id="effortValue">5</span>/10</div>
        </div>
        <div class="form-group">
            <label>备注</label>
            <textarea class="form-control" id="inputNotes" rows="3" placeholder="记录本次运动的感受..."></textarea>
        </div>
        <button class="submit-btn" onclick="addNewSport()">添加记录</button>
    </div>

    <!-- 模态框覆盖层 -->
    <div class="overlay" id="modalOverlay" onclick="closeAddSportModal()"></div>
</main>

<script>
    // 运动类型映射
    const iconMap = {
        "跑步": "🏃‍♂️",
        "走路": "🚶‍♀️",
        "骑行": "🚴‍♂️",
        "瑜伽": "🧘‍♀️",
        "跳绳": "🤸‍♂️",
        "游泳": "🏊‍♂️"
    };

    // 初始化运动记录数据
    let sportRecords = [];

    // 渲染运动记录列表 - 使用DOM操作代替模板字符串
    function renderSportList(sportRecords) {
        const sportList = document.getElementById('sportList');
        sportList.innerHTML = '';

        sportRecords.forEach(sport => {
            const card = document.createElement('div');
            card.className = `sport-card`;  // 不再拼接类型 class，避免中文报错

            // 类型标签
            const typeTag = document.createElement('div');
            typeTag.className = 'sport-type-tag';
            typeTag.textContent = sport.activityType;

            // 名称（也用 activityType）
            const title = document.createElement('h3');
            title.textContent = sport.activityType;

            // 图标
            const icon = document.createElement('div');
            icon.className = 'sport-icon';
            icon.textContent = iconMap[sport.activityType] || '🏅';

            // 统计容器
            const stats = document.createElement('div');
            stats.className = 'sport-stats';

            // 时长
            const durationStat = createStatItem(sport.duration, '分钟');

            // 步数（如果 >0）
            let stepStat = null;
            if (sport.stepCount && sport.stepCount > 0) {
                stepStat = createStatItem(sport.stepCount, '步');
            }

            // 卡路里
            const caloriesStat = createStatItem(sport.caloriesBurned, '卡路里');

            // 组装
            stats.appendChild(durationStat);
            if (stepStat) stats.appendChild(stepStat);
            stats.appendChild(caloriesStat);

            card.appendChild(typeTag);
            card.appendChild(title);
            card.appendChild(icon);
            card.appendChild(stats);

            // 点击查看详情
            // card.addEventListener('click', () => viewSportDetails(sport.id));
            card.addEventListener('click', () => {
                console.log("点击了卡片 id:", sport.id);
                viewSportDetails(sport.id);
            });


            sportList.appendChild(card);
        });
    }

    // 创建统计项
    function createStatItem(value, label) {
        const statItem = document.createElement('div');
        statItem.className = 'stat-item';

        const statValue = document.createElement('div');
        statValue.className = 'stat-value';
        statValue.textContent = value;

        const statLabel = document.createElement('div');
        statLabel.className = 'stat-label';
        statLabel.textContent = label;

        statItem.appendChild(statValue);
        statItem.appendChild(statLabel);

        return statItem;
    }

    // 查看运动详情
    function viewSportDetails(sportId) {
        const sport = sportRecords.find(r => r.id === sportId);
        if (!sport) return;

        const activity = (sport.activityType || '').trim();

        // 填充详情数据
        document.getElementById('sportDetailName').textContent = activity + ' 的详细信息';
        document.getElementById('detailSportType').textContent = activity;
        document.getElementById('detailSportDate').textContent = new Date(sport.date).toLocaleDateString();
        document.getElementById('detailDuration').textContent = (sport.duration || 0) + ' 分钟';

        // 运动强度
        // let intensityText = '--';
        // switch(sport.intensity) {
        //     case 'low': intensityText = '低强度'; break;
        //     case 'medium': intensityText = '中等强度'; break;
        //     case 'high': intensityText = '高强度'; break;
        // }
        // document.getElementById('detailIntensity').textContent = intensityText;

        document.getElementById('detailCalories').textContent = (sport.caloriesBurned || 0) + ' 卡路里';
        document.getElementById('detailDistance').textContent = sport.stepCount ? sport.stepCount + ' 步' : '--';
        document.getElementById('detailHeartRate').textContent = sport.heartRate ? sport.heartRate + ' bpm' : '--';
        document.getElementById('detailNotes').textContent = sport.notes || '无备注';

        // 更新进度条
        // if (sport.effort) {
        //     const progressBar = document.querySelector('.progress-bar');
        //     if (progressBar) {
        //         progressBar.style.width = (sport.effort * 10) + '%';
        //     }
        //     const effortValue = document.querySelector('#sportDetailView .progress-container + div');
        //     if (effortValue) {
        //         effortValue.textContent = sport.effort + '/10';
        //     }
        // }

        // 切换到详情视图
        document.getElementById('sportRecordsView').style.display = 'none';
        document.getElementById('sportDetailView').style.display = 'block';
    }

    // 显示添加运动模态框
    function showAddSportModal() {
        document.getElementById('addSportModal').style.display = 'block';
        document.getElementById('modalOverlay').style.display = 'block';
    }

    // 关闭添加运动模态框
    function closeAddSportModal() {
        document.getElementById('addSportModal').style.display = 'none';
        document.getElementById('modalOverlay').style.display = 'none';
    }

    function showSportRecords() {
        document.getElementById('dashboardView').style.display = 'none';
        document.getElementById('sportDetailView').style.display = 'none';
        document.getElementById('sportRecordsView').style.display = 'block';
    }

    // 添加新运动记录
    function addNewSport() {
        const newSport = {
            name: document.getElementById('inputSportName').value,
            type: document.getElementById('inputSportType').value,
            date: document.getElementById('inputSportDate').value,
            duration: parseInt(document.getElementById('inputDuration').value),
            calories: parseInt(document.getElementById('inputCalories').value),
            distance: parseFloat(document.getElementById('inputDistance').value) || null,
            // heartRate: parseInt(document.getElementById('inputHeartRate').value) || null,
            intensity: document.getElementById('inputIntensity').value,
            effort: parseInt(document.getElementById('inputEffort').value),
            notes: document.getElementById('inputNotes').value
        };

        fetch('/HMS/addSportRecordServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(newSport)
        })
            .then(response => {
                if (!response.ok) throw new Error('服务器响应失败');
                return response.json(); // 如果返回的是 JSON 格式的响应
            })
            .then(data => {
                alert('添加成功！');
                closeAddSportModal();
                loadSportRecordsFromServer(); // 从服务端重新加载最新记录
            })
            .catch(err => {
                console.error('添加失败：', err);
                alert('添加失败：' + err.message);
            });
    }

    // loadSportRecordsFromServer函数，向后端请求最新运动列表并调用renderSportList(data)
    function loadSportRecordsFromServer() {
        fetch('/HMS/getSportRecordsServlet')
            .then(res => res.json())
            .then(data => {
                sportRecords = data;
                renderSportList(sportRecords);
            })
            .catch(err => {
                console.error('加载运动记录失败', err);
            });
    }

    // 获取数据
    document.getElementById("sportLink").addEventListener("click", function (e) {
        e.preventDefault(); // 阻止默认跳转

        fetch("/HMS/getSportRecordsServlet")
            .then(response => response.json())
            .then(data => {
                console.log("exerciselog：", data);
                if (Array.isArray(data)) {
                    sportRecords=data;
                    showSportRecords();
                    renderSportList(data);
                } else {
                    console.error("数据格式错误：应为一维数组");
                }
            })
            .catch(error => {
                console.error("获取数据失败:", error);
                alert("获取 exerciselog 数据失败");
            });
    });

</script>
</body>
</html>