<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.Restuarant" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Offers - FoodRush Owner</title>

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

body{background:var(--bg);color:var(--text);min-height:100vh;}

.topbar{
  display:flex;
  justify-content:space-between;
  align-items:center;
  padding:20px 32px;
  background:var(--card);
}
.topbar h2{ color:var(--primary); font-size:20px; }
.topbar-right{display:flex;align-items:center;gap:16px;}

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
.main{
  padding:40px 20px;
  display:flex;
  flex-direction:column;
  align-items:center;
}

.back-link{
  color:var(--text-light);
  text-decoration:none;
  font-size:13px;
  display:inline-flex;
  align-items:center;
  gap:6px;
  margin-bottom:24px;
  align-self:flex-start;
  max-width:480px;
  width:100%;
}
.back-link:hover{color:var(--primary);}

.offer-card{
  background:var(--card);
  border-radius:20px;
  padding:36px;
  width:100%;
  max-width:480px;
}

.offer-card h1{font-size:22px;margin-bottom:6px;}
.offer-card .sub{color:var(--text-light);font-size:13px;margin-bottom:26px;}

.toggle-row{
  display:flex;
  align-items:center;
  justify-content:space-between;
  background:var(--secondary);
  padding:16px 18px;
  border-radius:12px;
  margin-bottom:20px;
}
.toggle-row .label{font-size:14px;font-weight:600;}
.toggle-row .label-sub{font-size:12px;color:var(--text-light);margin-top:2px;}

/* simple switch */
.switch{position:relative;display:inline-block;width:46px;height:26px;flex-shrink:0;}
.switch input{opacity:0;width:0;height:0;}
.slider{
  position:absolute;cursor:pointer;inset:0;
  background:#3a4150;border-radius:26px;transition:0.2s;
}
.slider:before{
  position:absolute;content:"";height:20px;width:20px;left:3px;bottom:3px;
  background:white;border-radius:50%;transition:0.2s;
}
.switch input:checked + .slider{background:var(--primary);}
.switch input:checked + .slider:before{transform:translateX(20px);}

.form-group{margin-bottom:22px;}
.form-group label{display:block;font-size:13px;color:var(--text-light);margin-bottom:8px;}

.percent-input-wrap{display:flex;align-items:center;gap:10px;}
.form-group input[type=number]{
  flex:1;
  padding:12px;
  border-radius:8px;
  border:1px solid var(--secondary);
  background:var(--bg);
  color:var(--text);
  font-size:16px;
}
.form-group input:focus{outline:none;border-color:var(--primary);}
.percent-sign{font-size:16px;color:var(--text-light);}

.submit-btn{
  width:100%;
  padding:13px;
  border:none;
  border-radius:10px;
  background:var(--primary);
  color:#08210a;
  font-weight:600;
  font-size:14px;
  cursor:pointer;
}
.submit-btn:hover{background:var(--primary-dark);}

.saved-banner{
  background:rgba(105,241,31,0.12);
  color:var(--primary);
  padding:10px 14px;
  border-radius:8px;
  font-size:13px;
  margin-bottom:20px;
  display:flex;
  align-items:center;
  gap:8px;
}

.current-preview{
  margin-top:22px;
  padding-top:22px;
  border-top:1px solid var(--secondary);
  font-size:13px;
  color:var(--text-light);
}
.current-preview .badge{
  display:inline-block;
  background:rgba(105,241,31,0.12);
  color:var(--primary);
  padding:3px 10px;
  border-radius:20px;
  font-weight:600;
  font-size:12px;
  margin-left:6px;
}
</style>
</head>
<body>

<%
  Restuarant restuarant = (Restuarant) request.getAttribute("restuarant");
  boolean saved = "true".equals(request.getParameter("saved"));
%>

<div class="topbar">
  <h2><i class="fa-solid fa-utensils"></i> FoodRush — Owner Panel</h2>
  <div class="topbar-right">
    <a href="${pageContext.request.contextPath}/owner/dashboard" class="logout-btn"><i class="fa-solid fa-gauge"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
  </div>
</div>

<div class="main">
  <a class="back-link" href="${pageContext.request.contextPath}/owner/dashboard"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>

  <div class="offer-card">
    <h1><i class="fa-solid fa-tags"></i> Manage Offers</h1>
    <div class="sub">Set a discount for <%=restuarant.getResName()%>. Customers will see it on your restaurant card and menu.</div>

    <% if (saved) { %>
    <div class="saved-banner"><i class="fa-solid fa-circle-check"></i> Offer settings saved.</div>
    <% } %>

    <form method="post" action="${pageContext.request.contextPath}/owner/offers">

      <div class="toggle-row">
        <div>
          <div class="label">Run an offer</div>
          <div class="label-sub">Turn this off anytime to remove the discount</div>
        </div>
        <label class="switch">
          <input type="checkbox" name="offerActive" <%= restuarant.isOfferActive() ? "checked" : "" %>>
          <span class="slider"></span>
        </label>
      </div>

      <div class="form-group">
        <label>Discount Percentage</label>
        <div class="percent-input-wrap">
          <input type="number" name="offerPercent" min="0" max="90" value="<%=restuarant.getOfferPercent()%>">
          <span class="percent-sign">%</span>
        </div>
      </div>

      <button type="submit" class="submit-btn">Save Offer</button>
    </form>

    <div class="current-preview">
      Currently showing to customers:
      <% if (restuarant.hasActiveOffer()) { %>
        <span class="badge"><%=restuarant.getOfferPercent()%>% OFF</span>
      <% } else { %>
        <span class="badge" style="background:var(--secondary);color:var(--text-light);">No offer</span>
      <% } %>
    </div>
  </div>
</div>

</body>
</html>