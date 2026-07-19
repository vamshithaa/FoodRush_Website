<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.User" %>
<%
    User owner = (User) request.getAttribute("owner");
    String ownerName = (owner != null) ? owner.getUserName() : "Owner";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Owner Dashboard - FoodRush</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

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

body{
  background:var(--bg);
  color:var(--text);
  min-height:100vh;
  display:flex;
  flex-direction:column;
}

.topbar{
  display:flex;
  justify-content:space-between;
  align-items:center;
  padding:20px 32px;
  background:var(--card);
}

.topbar h2{ color:var(--primary); font-size:20px; }

.logout-btn{
  color:var(--text-light);
  text-decoration:none;
  font-size:14px;
  padding:8px 16px;
  border:1px solid var(--secondary);
  border-radius:8px;
  transition:0.2s;
}
.logout-btn:hover{ color:var(--text); border-color:var(--primary); }

@media (max-width:600px){
  .topbar{padding:14px 16px;flex-wrap:wrap;gap:10px;}
  .topbar h2{font-size:16px;}
  .topbar-right{gap:8px;flex-wrap:wrap;}
  .logout-btn{padding:6px 10px;font-size:12px;}
  .main{padding:20px 16px;}
}

.content{
  flex:1;
  display:flex;
  flex-direction:column;
  align-items:center;
  justify-content:center;
  padding:40px 20px;
  text-align:center;
}

.content h1{ font-size:28px; margin-bottom:10px; }
.content p{ color:var(--text-light); margin-bottom:30px; max-width:420px; }

.card-grid{
  display:flex;
  gap:20px;
  flex-wrap:wrap;
  justify-content:center;
  max-width:700px;
}

.dash-card{
  background:var(--card);
  border-radius:16px;
  padding:24px;
  width:200px;
  text-align:left;
}

.dash-card i{ color:var(--primary); font-size:22px; margin-bottom:12px; }
.dash-card h3{ font-size:16px; margin-bottom:6px; }
.dash-card p{ color:var(--text-light); font-size:13px; margin:0; }

.coming-soon{ opacity:0.5; }
.coming-soon span{
  display:inline-block;
  margin-top:8px;
  font-size:11px;
  background:var(--secondary);
  padding:3px 8px;
  border-radius:6px;
  color:var(--primary);
}
</style>
</head>
<body>

<div class="topbar">
  <h2><i class="fa-solid fa-utensils"></i> FoodRush — Owner Panel</h2>
  <a href="<%=request.getContextPath()%>/LogoutServlet" class="logout-btn">
    <i class="fa-solid fa-right-from-bracket"></i> Logout
  </a>
</div>

<div class="content">
  <h1>Welcome, <%=ownerName%> 👋</h1>
  <p>This is your restaurant owner dashboard. From here you'll soon be able to manage your restaurant's menu and offers.</p>

  <a href="<%=request.getContextPath()%>/owner/offers" style="text-decoration:none;color:inherit;">
	<div class="dash-card" style="cursor:pointer;transition:0.2s;" onmouseover="this.style.background='var(--secondary)'" onmouseout="this.style.background='var(--card)'">
	  <i class="fa-solid fa-tags"></i>
	  <h3>Manage Offers</h3>
	  <p>Set discounts for your restaurant.</p>
	</div>
   </a>
    
    <a href="<%=request.getContextPath()%>/owner/restaurant" style="text-decoration:none;color:inherit;">
		<div class="dash-card" style="cursor:pointer;transition:0.2s;" onmouseover="this.style.background='var(--secondary)'" onmouseout="this.style.background='var(--card)'">
		  <i class="fa-solid fa-book-open"></i>
		  <h3>Manage Menu</h3>
		  <p>Edit your menu items.</p>
		</div>
	</a>

   <a href="<%=request.getContextPath()%>/owner/orders" style="text-decoration:none;color:inherit;">
	<div class="dash-card" style="cursor:pointer;transition:0.2s;" onmouseover="this.style.background='var(--secondary)'" onmouseout="this.style.background='var(--card)'">
	  <i class="fa-solid fa-receipt"></i>
	  <h3>View Orders</h3>
	  <p>Track incoming orders.</p>
	</div>
</a>
  </div>
</div>

</body>
</html>