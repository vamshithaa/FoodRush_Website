<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - FoodRush</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>

<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}

:root{
  --primary:#69f11f;
  --primary-dark:#49c80c;
  --bg:#0b0d12;
  --card:#141821;
  --secondary:#1c2330;
  --text:#ffffff;
  --text-light:#b0b7c3;
}

body{background:var(--bg);color:var(--text);min-height:100vh;}

.admin-shell{display:flex;min-height:100vh;}

.sidebar{
  width:220px;
  background:var(--card);
  padding:24px 16px;
  display:flex;
  flex-direction:column;
  gap:8px;
}

.sidebar h2{
  color:var(--primary);
  font-size:20px;
  margin-bottom:24px;
  padding:0 8px;
}

.sidebar a{
  color:var(--text-light);
  text-decoration:none;
  padding:12px 14px;
  border-radius:8px;
  display:flex;
  align-items:center;
  gap:10px;
  font-size:14px;
  transition:0.2s;
}

.sidebar a:hover, .sidebar a.active{
  background:var(--secondary);
  color:var(--primary);
}

.sidebar a.logout{margin-top:auto;color:#f15b5b;}

.main{flex:1;padding:32px 40px;}

.main h1{font-size:26px;margin-bottom:6px;}
.main .sub{color:var(--text-light);margin-bottom:28px;font-size:14px;}

.stats-grid{
  display:grid;
  grid-template-columns:repeat(auto-fit, minmax(220px, 1fr));
  gap:20px;
  margin-bottom:32px;
}

.stat-card{
  background:var(--card);
  border-radius:14px;
  padding:22px;
  border:1px solid var(--secondary);
}

.stat-card .icon{
  width:44px;height:44px;
  border-radius:10px;
  background:rgba(105,241,31,0.12);
  color:var(--primary);
  display:flex;align-items:center;justify-content:center;
  font-size:18px;
  margin-bottom:14px;
}

.stat-card .value{font-size:28px;font-weight:700;}
.stat-card .label{color:var(--text-light);font-size:13px;margin-top:4px;}

.charts-grid{
  display:grid;
  grid-template-columns:2fr 1fr;
  gap:20px;
  margin-bottom:20px;
}

.chart-card{
  background:var(--card);
  border-radius:14px;
  padding:22px;
  border:1px solid var(--secondary);
}

.chart-card h3{font-size:15px;margin-bottom:16px;color:var(--text-light);font-weight:500;}

.chart-card canvas{max-height:280px;}

@media (max-width:900px){
  .charts-grid{grid-template-columns:1fr;}
}


.hamburger{
  display:none;
  position:fixed;
  top:16px; left:16px;
  z-index:1001;
  width:42px; height:42px;
  background:var(--card);
  border:1px solid var(--secondary);
  border-radius:8px;
  color:var(--text);
  font-size:18px;
  align-items:center; justify-content:center;
  cursor:pointer;
}

.hamburger.hide{display:none;}

.sidebar-overlay{
  display:none;
  position:fixed; inset:0;
  background:rgba(0,0,0,0.5);
  z-index:999;
}

@media (max-width:768px){
  .hamburger{display:flex;}
  .sidebar{
    position:fixed;
    top:0; left:0;
    height:100vh;
    width:240px;
    z-index:1000;
    transform:translateX(-100%);
    transition:transform 0.25s ease;
  }
  .sidebar.open{transform:translateX(0);}
  .sidebar-overlay.open{display:block;}
  .main{padding:80px 16px 32px;}
}
</style>
</head>
<body>

<div class="admin-shell">
<button class="hamburger" id="hamburgerBtn"><i class="fa-solid fa-bars"></i></button>
  <div class="sidebar-overlay" id="sidebarOverlay"></div>
  <div class="sidebar" id="sidebar">
    <h2>FoodRush Admin</h2>
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="active"><i class="fa-solid fa-gauge"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/restaurants"><i class="fa-solid fa-store"></i> Restaurants</a>
    <a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-receipt"></i> Orders</a>
    <a href="${pageContext.request.contextPath}/admin/users"><i class="fa-solid fa-users"></i> Users</a>
    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
  </div>

  <div class="main">
    <h1>Dashboard</h1>
    <div class="sub">Overview of your FoodRush platform</div>

    <div class="stats-grid">
      <div class="stat-card">
        <div class="icon"><i class="fa-solid fa-store"></i></div>
        <div class="value">${restaurantCount}</div>
        <div class="label">Total Restaurants</div>
      </div>

      <div class="stat-card">
        <div class="icon"><i class="fa-solid fa-receipt"></i></div>
        <div class="value">${orderCount}</div>
        <div class="label">Total Orders</div>
      </div>

      <div class="stat-card">
        <div class="icon"><i class="fa-solid fa-hourglass-half"></i></div>
        <div class="value">${pendingOrderCount}</div>
        <div class="label">Pending Orders</div>
      </div>

      <div class="stat-card">
        <div class="icon"><i class="fa-solid fa-users"></i></div>
        <div class="value">${userCount}</div>
        <div class="label">Registered Users</div>
      </div>
    </div>

    <div class="charts-grid">
      <div class="chart-card">
        <h3>Orders &amp; Revenue &mdash; Last 7 Days</h3>
        <canvas id="trendChart"></canvas>
      </div>

      <div class="chart-card">
        <h3>Order Status Breakdown</h3>
        <canvas id="statusChart"></canvas>
      </div>
    </div>

    <div class="charts-grid" style="grid-template-columns:1fr;">
      <div class="chart-card">
        <h3>Top 5 Restaurants by Orders</h3>
        <canvas id="topRestaurantsChart"></canvas>
      </div>
    </div>
  </div>

</div>

<script>
var statusData = ${statusChartJson};
var trendData = ${trendChartJson};
var topRestaurantsData = ${topRestaurantsChartJson};

var textLight = '#b0b7c3';
var gridColor = '#1c2330';

new Chart(document.getElementById('statusChart'), {
  type: 'doughnut',
  data: {
    labels: statusData.labels,
    datasets: [{
      data: statusData.values,
      backgroundColor: ['#ff9f43', '#3d9dfc', '#69f11f', '#f15b5b'],
      borderWidth: 0
    }]
  },
  options: {
    plugins: { legend: { position: 'bottom', labels: { color: textLight } } }
  }
});

new Chart(document.getElementById('trendChart'), {
  data: {
    labels: trendData.labels,
    datasets: [
      {
        type: 'bar',
        label: 'Orders',
        data: trendData.orderCounts,
        backgroundColor: '#69f11f',
        yAxisID: 'y'
      },
      {
        type: 'line',
        label: 'Revenue (₹)',
        data: trendData.revenue,
        borderColor: '#3d9dfc',
        backgroundColor: '#3d9dfc',
        tension: 0.3,
        yAxisID: 'y1'
      }
    ]
  },
  options: {
    plugins: { legend: { labels: { color: textLight } } },
    scales: {
      x: { ticks: { color: textLight }, grid: { color: gridColor } },
      y: { position: 'left', ticks: { color: textLight }, grid: { color: gridColor } },
      y1: { position: 'right', ticks: { color: textLight }, grid: { drawOnChartArea: false } }
    }
  }
});

new Chart(document.getElementById('topRestaurantsChart'), {
  type: 'bar',
  data: {
    labels: topRestaurantsData.labels,
    datasets: [{
      label: 'Orders',
      data: topRestaurantsData.values,
      backgroundColor: '#69f11f'
    }]
  },
  options: {
    indexAxis: 'y',
    plugins: { legend: { display: false } },
    scales: {
      x: { ticks: { color: textLight }, grid: { color: gridColor } },
      y: { ticks: { color: textLight }, grid: { display: false } }
    }
  }
});
</script>
<script>
document.getElementById('hamburgerBtn').addEventListener('click', function(){
	  document.getElementById('sidebar').classList.toggle('open');
	  document.getElementById('sidebarOverlay').classList.toggle('open');
	  this.classList.toggle('hide');
	});
	document.getElementById('sidebarOverlay').addEventListener('click', function(){
	  document.getElementById('sidebar').classList.remove('open');
	  document.getElementById('sidebarOverlay').classList.remove('open');
	  document.getElementById('hamburgerBtn').classList.remove('hide');
	});
</script>
</body>
</html>