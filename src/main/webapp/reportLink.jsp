<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"/>
    <title>健康+ 管理系统 - 体检报告</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="css/main_page.css">
    <style>
        /* 体检报告特有样式 */
        .report-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s;
            cursor: pointer;
        }

        .report-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .report-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }

        .report-title {
            font-size: 18px;
            color: #2c3e50;
            font-weight: 600;
        }

        .report-date {
            color: #7f8c8d;
            font-size: 14px;
        }

        .report-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            padding: 8px 0;
            border-bottom: 1px dashed #eee;
        }

        .report-item:last-child {
            border-bottom: none;
        }

        .item-name {
            color: #34495e;
            font-weight: 500;
        }

        .item-value {
            color: #2c3e50;
            font-weight: 600;
        }

        .normal {
            color: #27ae60;
        }

        .warning {
            color: #e74c3c;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }

        .detail-item {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .detail-item h4 {
            margin-top: 0;
            color: #3498db;
            border-bottom: 1px solid #eee;
            padding-bottom: 8px;
        }

        .detail-item p {
            margin: 8px 0;
        }

        .add-report-btn {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .add-report-btn:hover {
            background-color: #2980b9;
        }

        .modal-content {
            max-width: 600px;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
        }

        .form-group {
            flex: 1;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #2c3e50;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 15px;
        }

        .form-group textarea {
            min-height: 100px;
            resize: vertical;
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
        <a href="#" id="healthLink">🏥 健康档案</a>
        <a href="sportLink.jsp" id="sportLink">🏃‍♂️ 运动记录</a>
        <a href="healthDiet.jsp">🍱 营养饮食</a>
        <a href="#" id="reportLink">📊 体检报告</a>
        <a href="settingLink.jsp">⚙️ 设置</a>    </nav>
</aside>

<main>
    <!-- 默认首页 -->
    <div id="dashboardView">
        <h2>欢迎使用健康+ 管理系统</h2>
        <p>请选择左侧菜单功能查看相关信息。</p>
    </div>

    <!-- 体检报告列表视图 -->
    <div id="reportsView" style="display:none;">
        <button class="back-btn" onclick="showDashboard()">← 返回首页</button>
        <h2>体检报告管理</h2>
        <button class="add-report-btn" onclick="showAddReportModal()">
            <span>+</span> 添加新报告
        </button>
        <input type="file" id="importReportFile" accept=".json" style="display:none;"
               onchange="importReportFromFile(event)">
        <button class="add-report-btn" onclick="document.getElementById('importReportFile').click()">📂 导入报告</button>


        <div id="reportsList">
            <!-- 报告卡片将通过JS动态添加 -->
        </div>
    </div>

    <!-- 报告详情视图 -->
    <div id="reportDetailView" style="display:none;">
        <button class="back-btn" onclick="showReportsView()">← 返回报告列表</button>
        <div class="report-details">
            <div class="report-header">
                <h3 id="detailReportTitle">体检报告详情</h3>
                <div class="report-date" id="detailReportTitleDate">--</div>
            </div>

            <div class="detail-summary">
                <h4>总体评价</h4>
                <p id="detailSummary">--</p>
            </div>

            <div class="detail-grid">
                <div class="detail-item">
                    <h4>基本信息</h4>
                    <p><strong>体检机构：</strong> <span id="detailHospital">--</span></p>
                    <p><strong>体检日期：</strong> <span id="detailCheckDate">--</span></p>
                    <p><strong>报告日期：</strong> <span id="detailReportDate">--</span></p>
                    <p><strong>医生建议：</strong> <span id="detailDoctorAdvice">--</span></p>
                </div>

                <div class="detail-item">
                    <h4>血液检查</h4>
                    <p><strong>白细胞计数：</strong> <span id="detailWhiteBloodCell">--</span></p>
                    <p><strong>红细胞计数：</strong> <span id="detailRedBloodCell">--</span></p>
                    <p><strong>血红蛋白：</strong> <span id="detailHemoglobin">--</span></p>
                    <p><strong>血小板计数：</strong> <span id="detailPlatelet">--</span></p>
                </div>

                <div class="detail-item">
                    <h4>生化指标</h4>
                    <p><strong>血糖：</strong> <span id="detailBloodSugar">--</span></p>
                    <p><strong>总胆固醇：</strong> <span id="detailCholesterol">--</span></p>
                    <p><strong>甘油三酯：</strong> <span id="detailTriglyceride">--</span></p>
                    <p><strong>肝功能(ALT)：</strong> <span id="detailAlt">--</span></p>
                </div>

                <div class="detail-item">
                    <h4>其他检查</h4>
                    <p><strong>血压：</strong> <span id="detailBloodPressure">--</span></p>
                    <p><strong>心电图：</strong> <span id="detailEcg">--</span></p>
                    <p><strong>胸透结果：</strong> <span id="detailChestXray">--</span></p>
                    <p><strong>尿常规：</strong> <span id="detailUrineTest">--</span></p>
                </div>
            </div>

            <div class="detail-actions">
                <button class="print-btn" onclick="printReport()">打印报告</button>
                <button class="delete-btn" onclick="deleteReport()">删除报告</button>
            </div>
        </div>
    </div>

    <!-- 添加报告模态框 -->
    <div id="addReportModal" class="modal" style="display:none;">
        <div class="modal-content">
            <span class="close" onclick="closeAddReportModal()">&times;</span>
            <h3>添加新体检报告</h3>

            <div class="form-row">
                <div class="form-group">
                    <label>报告标题</label>
                    <input type="text" id="inputReportTitle" placeholder="如：2024年年度体检报告">
                </div>
                <div class="form-group">
                    <label>体检机构</label>
                    <input type="text" id="inputHospital" placeholder="医院名称">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>体检日期</label>
                    <input type="date" id="inputCheckDate">
                </div>
                <div class="form-group">
                    <label>报告日期</label>
                    <input type="date" id="inputReportDate">
                </div>
            </div>

            <div class="form-group">
                <label>总体评价</label>
                <textarea id="inputSummary" placeholder="请输入体检总体评价..."></textarea>
            </div>

            <div class="form-group">
                <label>医生建议</label>
                <textarea id="inputDoctorAdvice" placeholder="请输入医生建议..."></textarea>
            </div>

            <h4>检查数据</h4>
            <div class="form-row">
                <div class="form-group">
                    <label>白细胞计数 (10^9/L)</label>
                    <input type="number" step="0.01" id="inputWhiteBloodCell">
                </div>
                <div class="form-group">
                    <label>红细胞计数 (10^12/L)</label>
                    <input type="number" step="0.01" id="inputRedBloodCell">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>血红蛋白 (g/L)</label>
                    <input type="number" id="inputHemoglobin">
                </div>
                <div class="form-group">
                    <label>血小板计数 (10^9/L)</label>
                    <input type="number" id="inputPlatelet">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>血糖 (mmol/L)</label>
                    <input type="number" step="0.1" id="inputBloodSugar">
                </div>
                <div class="form-group">
                    <label>总胆固醇 (mmol/L)</label>
                    <input type="number" step="0.1" id="inputCholesterol">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>甘油三酯 (mmol/L)</label>
                    <input type="number" step="0.1" id="inputTriglyceride">
                </div>
                <div class="form-group">
                    <label>肝功能(ALT) (U/L)</label>
                    <input type="number" id="inputAlt">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>血压 (mmHg)</label>
                    <input type="text" id="inputBloodPressure" placeholder="如：120/80">
                </div>
                <div class="form-group">
                    <label>心电图结果</label>
                    <select id="inputEcg">
                        <option value="正常">正常</option>
                        <option value="异常">异常</option>
                        <option value="其他">其他</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label>胸透结果</label>
                <textarea id="inputChestXray" placeholder="请输入胸透结果描述..."></textarea>
            </div>

            <div class="form-group">
                <label>尿常规结果</label>
                <textarea id="inputUrineTest" placeholder="请输入尿常规结果描述..."></textarea>
            </div>

            <button class="submit-btn" onclick="submitReport()">提交报告</button>
        </div>
    </div>

</main>

<script>
    // 体检报告数据
    let medicalReports = [];
    let currentReportId = null;

    // 初始化
    document.addEventListener('DOMContentLoaded', function () {
        // 绑定体检报告链接
        document.getElementById("reportLink").addEventListener("click", function (e) {
            e.preventDefault();
            loadReports();
        });
    });

    // 加载体检报告
    function loadReports() {
        // 模拟从后端获取数据
        // fetch("/HMS/selectMedicalReportsServlet")
        //     .then(response => response.json())
        //     .then(data => {
        //         medicalReports = data;
        //         renderReportsList();
        //         showReportsView();
        //     })
        //     .catch(error => {
        //         console.error("获取体检报告失败:", error);
        //         // 模拟数据
        medicalReports = [
            {
                id: 1,
                title: "2024年年度体检报告",
                hospital: "市中心医院",
                checkDate: "2024-05-15",
                reportDate: "2024-05-20",
                summary: "总体健康状况良好，部分指标需要注意。",
                doctorAdvice: "建议加强锻炼，控制饮食中的油脂摄入，三个月后复查血脂。",
                whiteBloodCell: 6.2,
                redBloodCell: 4.8,
                hemoglobin: 145,
                platelet: 210,
                bloodSugar: 5.3,
                cholesterol: 5.2,
                triglyceride: 1.8,
                alt: 30,
                bloodPressure: "120/80",
                ecg: "正常",
                chestXray: "心肺未见明显异常",
                urineTest: "尿常规各项指标正常"
            },
            {
                id: 2,
                title: "入职体检报告",
                hospital: "仁爱医院",
                checkDate: "2023-11-10",
                reportDate: "2023-11-12",
                summary: "身体健康，符合入职要求。",
                doctorAdvice: "保持规律作息，注意用眼卫生。",
                whiteBloodCell: 5.8,
                redBloodCell: 4.7,
                hemoglobin: 142,
                platelet: 195,
                bloodSugar: 4.9,
                cholesterol: 4.8,
                triglyceride: 1.2,
                alt: 28,
                bloodPressure: "118/76",
                ecg: "正常",
                chestXray: "心肺膈未见明显异常",
                urineTest: "尿常规正常"
            }
        ];
        renderReportsList();
        showReportsView();
        // });
    }

    // 渲染报告列表
    function renderReportsList() {
        const reportsList = document.getElementById('reportsList');
        reportsList.innerHTML = '';

        medicalReports.forEach(report => {
            const card = document.createElement('div');
            card.className = 'report-card';
            card.dataset.id = report.id;

            // 创建 report-header
            const header = document.createElement('div');
            header.className = 'report-header';

            const titleDiv = document.createElement('div');
            titleDiv.className = 'report-title';
            titleDiv.textContent = report.title;

            const dateDiv = document.createElement('div');
            dateDiv.className = 'report-date';
            dateDiv.textContent = new Date(report.reportDate).toLocaleDateString();

            header.appendChild(titleDiv);
            header.appendChild(dateDiv);

            // 体检机构
            const hospitalItem = document.createElement('div');
            hospitalItem.className = 'report-item';

            const hospitalName = document.createElement('span');
            hospitalName.className = 'item-name';
            hospitalName.textContent = '体检机构';

            const hospitalValue = document.createElement('span');
            hospitalValue.className = 'item-value';
            hospitalValue.textContent = report.hospital;

            hospitalItem.appendChild(hospitalName);
            hospitalItem.appendChild(hospitalValue);

            // 体检日期
            const checkDateItem = document.createElement('div');
            checkDateItem.className = 'report-item';

            const checkDateName = document.createElement('span');
            checkDateName.className = 'item-name';
            checkDateName.textContent = '体检日期';

            const checkDateValue = document.createElement('span');
            checkDateValue.className = 'item-value';
            checkDateValue.textContent = new Date(report.checkDate).toLocaleDateString();

            checkDateItem.appendChild(checkDateName);
            checkDateItem.appendChild(checkDateValue);

            // 总体评价
            const summaryItem = document.createElement('div');
            summaryItem.className = 'report-item';

            const summaryName = document.createElement('span');
            summaryName.className = 'item-name';
            summaryName.textContent = '总体评价';

            const summaryValue = document.createElement('span');
            summaryValue.className = 'item-value';
            summaryValue.textContent = report.summary.length > 30
                ? report.summary.substring(0, 30) + '...'
                : report.summary;

            summaryItem.appendChild(summaryName);
            summaryItem.appendChild(summaryValue);

            // 组装卡片
            card.appendChild(header);
            card.appendChild(hospitalItem);
            card.appendChild(checkDateItem);
            card.appendChild(summaryItem);

            // 点击查看详情
            card.addEventListener('click', () => {
                viewReportDetails(report.id);
            });

            reportsList.appendChild(card);
        });
    }


    // 查看报告详情
    function viewReportDetails(reportId) {
        const report = medicalReports.find(r => r.id === reportId);
        if (!report) return;

        currentReportId = reportId;

        // 填充详情数据
        document.getElementById('detailReportTitle').textContent = report.title;
        document.getElementById('detailReportTitleDate').textContent = new Date(report.reportDate).toLocaleDateString();
        document.getElementById('detailSummary').textContent = report.summary;
        document.getElementById('detailHospital').textContent = report.hospital;
        document.getElementById('detailCheckDate').textContent = new Date(report.checkDate).toLocaleDateString();
        document.getElementById('detailReportDate').textContent = new Date(report.reportDate).toLocaleDateString();
        document.getElementById('detailDoctorAdvice').textContent = report.doctorAdvice;
        document.getElementById('detailWhiteBloodCell').textContent = report.whiteBloodCell;
        document.getElementById('detailRedBloodCell').textContent = report.redBloodCell;
        document.getElementById('detailHemoglobin').textContent = report.hemoglobin;
        document.getElementById('detailPlatelet').textContent = report.platelet;
        document.getElementById('detailBloodSugar').textContent = report.bloodSugar;
        document.getElementById('detailCholesterol').textContent = report.cholesterol;
        document.getElementById('detailTriglyceride').textContent = report.triglyceride;
        document.getElementById('detailAlt').textContent = report.alt;
        document.getElementById('detailBloodPressure').textContent = report.bloodPressure;
        document.getElementById('detailEcg').textContent = report.ecg;
        document.getElementById('detailChestXray').textContent = report.chestXray;
        document.getElementById('detailUrineTest').textContent = report.urineTest;

        // 切换到详情视图
        document.getElementById('reportsView').style.display = 'none';
        document.getElementById('reportDetailView').style.display = 'block';
    }

    // 添加新报告

    function submitReport() {
        // 获取表单内容
        const title = document.getElementById("inputReportTitle").value;
        const hospital = document.getElementById("inputHospital").value;
        const checkDate = document.getElementById("inputCheckDate").value;
        const reportDate = document.getElementById("inputReportDate").value;
        const summary = document.getElementById("inputSummary").value;

        // 简化展示，只展示标题和日期，你可以自行添加更多信息展示
        const reportCard = document.createElement("div");
        reportCard.className = "report-card";

// 1. header 部分
        const header = document.createElement("div");
        header.className = "report-header";

        const titleDiv = document.createElement("div");
        titleDiv.className = "report-title";
        titleDiv.textContent = title;

        const dateDiv = document.createElement("div");
        dateDiv.className = "report-date";
        dateDiv.textContent = reportDate;

        header.appendChild(titleDiv);
        header.appendChild(dateDiv);
        reportCard.appendChild(header);

// 2. 体检机构项
        const hospitalItem = document.createElement("div");
        hospitalItem.className = "report-item";
        hospitalItem.appendChild(createItem("体检机构", hospital));
        reportCard.appendChild(hospitalItem);

// 3. 体检日期项
        const checkDateItem = document.createElement("div");
        checkDateItem.className = "report-item";
        checkDateItem.appendChild(createItem("体检日期", checkDate));
        reportCard.appendChild(checkDateItem);

// 4. 总体评价项
        const summaryItem = document.createElement("div");
        summaryItem.className = "report-item";
        summaryItem.appendChild(createItem("总体评价", summary));
        reportCard.appendChild(summaryItem);

// 5. 添加点击事件显示详情（可选）
        reportCard.addEventListener("click", () => {
            showReportDetail({
                title,
                reportDate,
                hospital,
                checkDate,
                summary
            });
        });

// 6. 添加到页面中
        document.getElementById("reportsList").appendChild(reportCard);


        // 添加点击事件查看详情（可选）
        reportCard.addEventListener("click", () => {
            showReportDetail({
                title, reportDate, hospital, checkDate, summary
                // 你也可以传更多字段进去
            });
        });

        // 添加到列表中
        document.getElementById("reportsList").appendChild(reportCard);

        // 隐藏模态框 & 清空表单
        closeAddReportModal();
        clearReportForm();
    }
    function createItem(name, value) {
        const nameSpan = document.createElement("span");
        nameSpan.className = "item-name";
        nameSpan.textContent = name;

        const valueSpan = document.createElement("span");
        valueSpan.className = "item-value";
        valueSpan.textContent = value;

        const wrapper = document.createElement("div");
        wrapper.appendChild(nameSpan);
        wrapper.appendChild(valueSpan);
        return wrapper;
    }

    function clearReportForm() {
        document.querySelectorAll("#addReportModal input, #addReportModal textarea, #addReportModal select").forEach(el => el.value = '');
    }

    // 删除报告
    function deleteReport() {
        if (!currentReportId || !confirm('确定要删除该报告吗？')) return;

        fetch('/HMS/deleteMedicalReportServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                reportId: currentReportId,
                _method: 'DELETE'
            })
        })
            .then(() => {
                // 成功后更新列表
                medicalReports = medicalReports.filter(r => r.id !== currentReportId);
                showReportsView();
            });
    }

    // 打印报告
    function printReport() {
        window.print();
    }

    // 视图切换函数
    function showReportsView() {
        document.getElementById('dashboardView').style.display = 'none';
        document.getElementById('reportDetailView').style.display = 'none';
        document.getElementById('reportsView').style.display = 'block';
        document.getElementById('addReportModal').style.display = 'none';
    }

    function showDashboard() {
        document.getElementById('reportsView').style.display = 'none';
        document.getElementById('reportDetailView').style.display = 'none';
        document.getElementById('dashboardView').style.display = 'block';
        document.getElementById('addReportModal').style.display = 'none';
    }

    function showAddReportModal() {
        document.getElementById('addReportModal').style.display = 'block';
    }

    function closeAddReportModal() {
        document.getElementById('addReportModal').style.display = 'none';
    }

    function importReportFromFile(event) {
        const file = event.target.files[0];
        if (!file) return;

        const reader = new FileReader();
        reader.onload = function (e) {
            try {
                const data = JSON.parse(e.target.result);
                // 将数据填入表单
                document.getElementById("inputReportTitle").value = data.title || '';
                document.getElementById("inputHospital").value = data.hospital || '';
                document.getElementById("inputCheckDate").value = data.checkDate || '';
                document.getElementById("inputReportDate").value = data.reportDate || '';
                document.getElementById("inputSummary").value = data.summary || '';
                document.getElementById("inputDoctorAdvice").value = data.doctorAdvice || '';
                document.getElementById("inputWhiteBloodCell").value = data.whiteBloodCell || '';
                document.getElementById("inputRedBloodCell").value = data.redBloodCell || '';
                document.getElementById("inputHemoglobin").value = data.hemoglobin || '';
                document.getElementById("inputPlatelet").value = data.platelet || '';
                document.getElementById("inputBloodSugar").value = data.bloodSugar || '';
                document.getElementById("inputCholesterol").value = data.cholesterol || '';
                document.getElementById("inputTriglyceride").value = data.triglyceride || '';
                document.getElementById("inputAlt").value = data.alt || '';
                document.getElementById("inputBloodPressure").value = data.bloodPressure || '';
                document.getElementById("inputEcg").value = data.ecg || '正常';
                document.getElementById("inputChestXray").value = data.chestXray || '';
                document.getElementById("inputUrineTest").value = data.urineTest || '';

                // 显示模态框
                showAddReportModal();

            } catch (error) {
                alert("文件格式错误或无法解析！");
                console.error(error);
            }
        };
        reader.readAsText(file);
    }


</script>
</body>
</html>