<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>




<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8" />
  <title>健康+ 管理系统 - 首页</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="css/main_page.css">
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

  <!-- 健康档案视图 -->
  <div id="healthRecordsView" style="display:none;">
    <button class="back-btn" onclick="showDashboard()">← 返回首页</button>
    <h2>家庭成员健康档案</h2>
    <button class="add-member-btn" onclick="function addMember() {
          document.getElementById('dashboardView').style.display = 'none';
    document.getElementById('memberDetailView').style.display = 'none';
    document.getElementById('healthRecordsView').style.display = 'none';
    document.getElementById('addMemberModal').style.display='block';
    }
    addMember()">
      <span>+</span> 添加家庭成员
    </button>

    <div id="memberList" class="dashboard">
      <!-- 成员卡片将通过JS动态添加 -->
    </div>
  </div>

  <!-- 成员详情视图 -->
  <div id="memberDetailView" style="display:none;">
    <button class="back-btn" onclick="showHealthRecords()">← 返回成员列表</button>
    <div class="member-details">
      <h3 id="detailName">成员详情</h3>
      <div class="detail-row">
        <div class="detail-item">
          <label>年龄</label>
          <div id="detailAge">--</div>
        </div>
        <div class="detail-item">
          <label>性别</label>
          <div id="detailGender">--</div>
        </div>
      </div>
      <div class="detail-row">
        <div class="detail-item">
          <label>生日</label>
          <div id="detailBirthday">--</div>
        </div>
        <div class="detail-item">
          <label>身高</label>
          <div id="detailHeight">--</div>
        </div>
        <div class="detail-item">
          <label>体重</label>
          <div id="detailWeight">--</div>
        </div>
        <div class="detail-item">
          <label>记录时间</label>
          <div id="detailRecordDate">--</div>
        </div>
      </div>
      <div class="detail-row">
        <div class="detail-item">
          <label>身体总水分</label>
          <div id="detailTotalWater">无</div>
        </div>
      </div>
      <div class="detail-row">
        <div class="detail-item">
          <label>蛋白质</label>
          <div id="detailProtein">无</div>
        </div>
      </div>
      <div class="detail-row">
        <div class="detail-item">
          <label>脂肪</label>
          <div id="detailFat">--</div>
        </div>
        <div class="detail-item">
          <label>肌肉</label>
          <div id="detailMuscle">--</div>
        </div>
        <div class="detail-item">
          <label>基础代谢率</label>
          <div id="detailBasalMetabolicRate">--</div>
        </div>
        <div class="detail-item">
          <label>内脏脂肪等级</label>
          <div id="detailVisceralFatLevel">--</div>
        </div>
        <div class="detail-item">
          <label>体脂率</label>
          <div id="detailBodyFatRate">--</div>
        </div>
        <div class="detail-item">
          <label>BMI</label>
          <div id="detailBmi">--</div>
        </div>
        <div class="detail-item">
          <label>身体分数</label>
          <div id="detailBodyScore">--</div>
        </div>
      </div>
    </div>
  </div>
  <!-- 隐藏弹窗，点击“添加成员”时弹出 -->
  <div id="addMemberModal" style="display:none;">
    <h3>添加新成员</h3>
    <label>姓名：<input type="text" id="inputName"></label><br>
    <label>性别：<select id="inputGender"><option>男</option><option>女</option></select></label><br>
    <label>出生日期：<input type="date" id="inputBirthday"></label><br>
    <label>身高：<input type="number" id="inputHeight"></label><br>
    <label>体重：<input type="number" id="inputWeight"></label><br>
    <label>记录时间：<input type="date" id="inputRecordDate"></label><br>
    <label>身体总水分：<input type="number" id="inputTotalWater"></label><br>
    <label>蛋白质：<input type="number" id="inputProtein"></label><br>
    <label>脂肪：<input type="number" id="inputFat"></label><br>
    <label>肌肉：<input type="number" id="inputMuscle"></label><br>
    <label>基础代谢率：<input type="number" id="inputBasalMetabolicRate"></label><br>
    <label>内脏脂肪等级：<input type="number" id="inputVisceralFatLevel"></label><br>
    <label>体脂率：<input type="number" id="inputBodyFatRate"></label><br>
    <button onclick="submitMember()">提交</button>
  </div>

</main>

<script>

  // 以下时健康模块初始化示例成员数据

  let familyMembers = [];

  // 渲染成员列表
  function renderMemberList() {
    console.log("familyMembers", familyMembers);
    const memberList = document.getElementById('memberList');
    memberList.innerHTML = '';

    // 添加示例成员
    familyMembers.forEach(item => {
      const card = createMemberCard(item.member,item.composition);
      memberList.appendChild(card);
    });
    // 更新全局 sampleMembers，如果你还要用它做删除/查看

  }

  // 创建成员卡片
  function createMemberCard(member, composition) {
    console.log("name:", member.name, "gender:", member.gender, "bodyScore:", (composition && composition.bodyScore) || '--', "member.id:", member.id);

    const card = document.createElement('div');
    card.className = 'card';
    card.dataset.id = member.id;

    // 点击查看详情
    card.addEventListener('click', () => {
      console.log("点击了成员卡片 id:", member.id);
      viewMemberDetails(composition.memberId);
    });

    // 姓名标题
    const title = document.createElement('h3');
    title.textContent = member.name;

    // 性别
    const genderP = document.createElement('p');
    genderP.textContent = 'gender：' + (member.gender || '--');

    // 体质评分
    const scoreP = document.createElement('p');
    scoreP.textContent = 'body_score：' + ((composition && composition.bodyScore) || '--');

    // 删除按钮
    const deleteBtn = document.createElement('button');
    deleteBtn.className = 'delete-btn';
    deleteBtn.textContent = '×';
    deleteBtn.addEventListener('click', (event) => {
      event.stopPropagation(); // 阻止冒泡，避免触发查看详情
      console.log("删除的 memberId 是：", member.id);
      removeMember(member.id);
    });

    // 组装卡片
    card.appendChild(title);
    card.appendChild(genderP);
    card.appendChild(scoreP);
    card.appendChild(deleteBtn);

    return card;
  }


  // 添加新成员
  function submitMember() {
    const newMember = {
      member:{
      name: document.getElementById('inputName').value,
      gender: document.getElementById('inputGender').value,
      birthday: document.getElementById('inputBirthday').value,
      },
      composition:{
        height: document.getElementById('inputHeight').value,
        weight: document.getElementById('inputWeight').value,
        recordDate:document.getElementById("inputRecordDate").value,
        totalWater:document.getElementById("inputTotalWater").value,
        protein:document.getElementById("inputProtein").value,
        fat:document.getElementById("inputFat").value,
        muscle:document.getElementById("inputMuscle").value,
        basalMetabolicRate:document.getElementById("inputBasalMetabolicRate").value,
        visceralFatLevel:document.getElementById("inputVisceralFatLevel").value,
        bodyFatRate:document.getElementById("inputBodyFatRate").value,
      }
    };

    fetch('/HMS/addFamilyMemberCompositionServlet', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json;charset=UTF-8'
      },
      body: JSON.stringify(newMember)
    })
            .then(res => {
              if (res.ok) {
                alert('添加成功');
                return res.json();
              } else {
                throw new Error("添加失败");
              }
            })
            .then(data => {
              // 成功后更新列表（可选）
              familyMembers.push(data);
              renderMemberList();
            })
    document.getElementById('addMemberModal').style.display = 'none';

  }

  // 删除成员
  function removeMember(memberId) {
    memberId = parseInt(memberId);
    if (!confirm('确定要删除该成员吗？')) return;

    fetch('/HMS/deleteFamilyMemberServlet', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        memberId: memberId,
        _method: 'DELETE' // 用于模拟DELETE方法
      })
    });


  }

  // 查看成员详情 member.id,member,composition
  function viewMemberDetails(memberId) {
    const data = familyMembers.find(item => item.member.id === memberId);
    if (!data) return;

    const member = data.member;
    const composition = data.composition;
    const age=data.age

    // 填充详情数据
    document.getElementById('detailName').textContent = member.name + ' 的健康档案';
    document.getElementById('detailAge').textContent = age + (member.age === '--' ? '' : '岁');
    document.getElementById('detailGender').textContent = member.gender;
    document.getElementById('detailBirthday').textContent = new Date(member.birthday).toLocaleDateString();
    document.getElementById('detailRecordDate').textContent = new Date(composition.recordDate).toLocaleDateString();
    document.getElementById('detailHeight').textContent = composition.height;
    document.getElementById('detailWeight').textContent = composition.weight;
    document.getElementById('detailTotalWater').textContent = composition.totalWater;
    document.getElementById('detailProtein').textContent = composition.protein;
    document.getElementById('detailFat').textContent = composition.fat;
    document.getElementById('detailMuscle').textContent = composition.muscle;
    document.getElementById('detailBasalMetabolicRate').textContent = composition.basalMetabolicRate;
    document.getElementById('detailVisceralFatLevel').textContent = composition.visceralFatLevel;
    document.getElementById('detailBodyFatRate').textContent = composition.bodyFatRate;
    document.getElementById('detailBmi').textContent = composition.bmi;
    document.getElementById('detailBodyScore').textContent = composition.bodyScore;


    // 切换到详情视图
    document.getElementById('healthRecordsView').style.display = 'none';
    document.getElementById('memberDetailView').style.display = 'block';
  }

  // 视图切换函数
  function showHealthRecords() {
    document.getElementById('dashboardView').style.display = 'none';
    document.getElementById('memberDetailView').style.display = 'none';
    document.getElementById('healthRecordsView').style.display = 'block';
    document.getElementById('addMemberModal').style.display = 'none';

  }

  function showDashboard() {
    document.getElementById('healthRecordsView').style.display = 'none';
    document.getElementById('memberDetailView').style.display = 'none';
    document.getElementById('dashboardView').style.display = 'block';
    document.getElementById('addMemberModal').style.display = 'none';

  }

  // 绑定健康档案链接
  document.getElementById("healthLink").addEventListener("click", function (e) {
    e.preventDefault(); // 阻止跳转

    fetch("/HMS/selectFamilyMembersByUserIdServlet")
            .then(response => response.json())
            .then(data => {
              console.log("成员+体测数据：", data);
              familyMembers=data
              renderMemberList();  // 替代原 sampleMembers
              showHealthRecords();
            }).catch(error => {
      console.error("获取数据失败:", error);
      alert("获取家庭成员数据失败");
    });

  });
</script>
</body>
</html>