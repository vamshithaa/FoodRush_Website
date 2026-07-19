<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Order Confirmed</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>

*{
  margin:0;
  padding:0;
  box-sizing:border-box;
  font-family:'Poppins',sans-serif;
}

:root{
  --primary:#69f11f;
  --primary-dark:#2e9e0a;
  --text:#1c2330;
  --text-light:#6b7280;
  --bg:#f6f8f7;
}

body{
  background:var(--bg);
  overflow-x:hidden;
  overflow-y:auto;
  padding:40px 20px;
  display:flex;
  justify-content:center;
  align-items:center;
  min-height:100vh;
  color:var(--text);
  position:relative;
}

/* Soft, static background accent — no motion */
body::before{
  content:"";
  position:absolute;
  width:600px;
  height:600px;
  background:radial-gradient(circle, rgba(105,241,31,0.08) 0%, transparent 70%);
  top:-200px;
  left:-200px;
  pointer-events:none;
}
body::after{
  content:"";
  position:absolute;
  width:500px;
  height:500px;
  background:radial-gradient(circle, rgba(105,241,31,0.06) 0%, transparent 70%);
  bottom:-180px;
  right:-180px;
  pointer-events:none;
}

/* Home Button */
.home-btn{
  position:fixed;
  top:24px;
  left:24px;
  display:inline-flex;
  align-items:center;
  gap:8px;
  text-decoration:none;
  padding:10px 18px;
  border-radius:10px;
  background:#ffffff;
  color:var(--text);
  font-weight:600;
  font-size:14px;
  border:1px solid #e5e8eb;
  box-shadow:0 2px 8px rgba(0,0,0,.05);
  transition:.2s ease;
  z-index:1000;
  opacity:0;
  animation:fadeIn .5s ease forwards .1s;
}
.home-btn i{ color:var(--primary-dark); font-size:13px; }
.home-btn:hover{
  border-color:var(--primary);
  color:var(--primary-dark);
  transform:translateY(-1px);
  box-shadow:0 4px 12px rgba(0,0,0,.08);
}

/* Card */
.card{
  width:460px;
  max-width:100%;
  padding:48px 44px;
  border-radius:20px;
  text-align:center;
  background:#ffffff;
  border:1px solid #edf0f2;
  box-shadow:0 12px 40px rgba(16,24,40,.08);
  opacity:0;
  animation:cardIn .5s ease forwards;
}

@keyframes cardIn{
  from{ opacity:0; transform:translateY(14px); }
  to{ opacity:1; transform:translateY(0); }
}

.brand-logo{
  height:56px;
  margin-bottom:24px;
  opacity:0;
  animation:fadeIn .5s ease forwards 0s;
}
/* Icon */
.icon-wrap{
  position:relative;
  width:88px;
  height:88px;
  margin:0 auto;
}

.icon-glow{
  position:absolute;
  inset:-14px;
  border-radius:50%;
  background:rgba(105,241,31,0.18);
  transform:scale(0.6);
  opacity:0;
  animation:glowPop .6s ease forwards .15s;
}

@keyframes glowPop{
  to{ transform:scale(1); opacity:1; }
}

.check-icon{
  position:relative;
  width:88px;
  height:88px;
}

.check-circle-bg{
  fill:#f1fdf0;
}

.check-circle{
  fill:none;
  stroke:var(--primary-dark);
  stroke-width:3;
  stroke-dasharray:226;
  stroke-dashoffset:226;
  animation:drawCircle .55s ease forwards .15s;
}

.check-mark{
  fill:none;
  stroke:var(--primary-dark);
  stroke-width:5;
  stroke-linecap:round;
  stroke-linejoin:round;
  stroke-dasharray:60;
  stroke-dashoffset:60;
  animation:drawCheck .35s ease forwards .65s;
}

@keyframes drawCircle{ to{ stroke-dashoffset:0; } }
@keyframes drawCheck{ to{ stroke-dashoffset:0; } }

/* Heading */
h1{
  margin-top:28px;
  font-size:26px;
  font-weight:700;
  color:var(--text);
  opacity:0;
  animation:fadeUp .5s ease forwards .5s;
}

.sub{
  margin-top:8px;
  font-size:14.5px;
  color:var(--text-light);
  line-height:1.6;
  opacity:0;
  animation:fadeUp .5s ease forwards .6s;
}

.sub b{ color:var(--text); font-weight:600; }

/* Divider */
.divider{
  height:1px;
  background:#eef1f3;
  margin:28px 0;
  opacity:0;
  animation:fadeUp .5s ease forwards .7s;
}

/* Delivery info row */
.info-row{
  display:flex;
  align-items:center;
  gap:14px;
  background:#f8faf8;
  border:1px solid #eef1f3;
  border-radius:14px;
  padding:16px 18px;
  text-align:left;
  opacity:0;
  animation:fadeUp .5s ease forwards .8s;
}

.info-icon{
  width:42px;
  height:42px;
  flex-shrink:0;
  border-radius:10px;
  background:rgba(105,241,31,0.14);
  color:var(--primary-dark);
  display:flex;
  align-items:center;
  justify-content:center;
  font-size:16px;
}

.info-text{ display:flex; flex-direction:column; gap:2px; }
.info-label{ font-size:12px; color:var(--text-light); text-transform:uppercase; letter-spacing:.03em; }
.info-value{ font-size:15px; font-weight:600; color:var(--text); }

@keyframes fadeUp{
  from{ opacity:0; transform:translateY(10px); }
  to{ opacity:1; transform:translateY(0); }
}

@keyframes fadeIn{
  to{ opacity:1; }
}

@media(max-width:600px){
  .card{
    padding:36px 26px;
  }
  h1{ font-size:22px; }
  .icon-wrap, .check-icon{ width:72px; height:72px; }
  .home-btn{
    top:14px;
    left:14px;
    padding:8px 14px;
    font-size:13px;
  }
}

@media(max-width:380px){
  .card{ padding:30px 20px; }
  h1{ font-size:20px; }
  .sub{ font-size:13.5px; }
  .info-row{ padding:14px; }
  .info-value{ font-size:14px; }
}

</style>

</head>

<body>

<a href="callRestuarantServlet" class="home-btn">
  <i class="fa-solid fa-house"></i> Home
</a>

<div class="card">

  <img src="images/foodrush-logo1.png" alt="FoodRush" class="brand-logo">

  <div class="icon-wrap">
    <div class="icon-glow"></div>
    <svg class="check-icon" viewBox="0 0 80 80">
      <circle class="check-circle-bg" cx="40" cy="40" r="36"></circle>
      <circle class="check-circle" cx="40" cy="40" r="36"></circle>
      <path class="check-mark" d="M23 41 L35 53 L59 27"></path>
    </svg>
  </div>

  <h1>Order Confirmed</h1>

  <p class="sub">
    Thank you for choosing <b>FoodRush</b>.<br>
    Your order has been placed and is being prepared.
  </p>

  <div class="divider"></div>

  <div class="info-row">
    <div class="info-icon"><i class="fa-solid fa-truck-fast"></i></div>
    <div class="info-text">
      <span class="info-label">Estimated Delivery</span>
      <span class="info-value">25 – 30 minutes</span>
    </div>
  </div>

</div>

</body>
</html>