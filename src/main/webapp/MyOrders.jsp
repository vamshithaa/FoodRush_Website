<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.Order,com.tap.model.OrderItem,com.tap.model.Menu,com.tap.model.Restuarant,com.tap.model.Review" %>
<%@ page import="java.util.List,java.util.Map" %>
<%@ page import="com.tap.model.Order,com.tap.model.OrderItem,com.tap.model.Menu,com.tap.model.Restuarant" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Orders - FoodRush</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>

/*==============================
        GOOGLE FONT
===============================*/
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

html{
    scroll-behavior:smooth;
}

:root{

    --primary:#75d61d;
    --primary2:#4caf13;
    --dark:#090b10;
    --dark2:#11151c;
    --card:#171d27;
    --card2:#1f2633;
    --border:rgba(255,255,255,.08);

    --text:#ffffff;
    --text2:#bfc8d5;

    --shadow:0 20px 50px rgba(0,0,0,.45);

    --glass:rgba(255,255,255,.05);

    --success:#2ecc71;
    --warning:#ff9f43;
    --danger:#e74c3c;
}

body.light{

    --dark:#f5f7fb;
    --dark2:#eef2f7;
    --card:#ffffff;
    --card2:#f8fafc;

    --border:#dfe6ee;

    --text:#111827;
    --text2:#6b7280;

    --glass:rgba(255,255,255,.75);

    --shadow:0 15px 40px rgba(0,0,0,.08);

}

body{

    background:
    radial-gradient(circle at top left,#173e10 0%,transparent 28%),
    radial-gradient(circle at bottom right,#164c18 0%,transparent 22%),
    var(--dark);

    color:var(--text);

    overflow-x:hidden;

    transition:.4s;
}

/* Scrollbar */

::-webkit-scrollbar{
    width:10px;
}

::-webkit-scrollbar-track{
    background:var(--dark);
}

::-webkit-scrollbar-thumb{
    background:linear-gradient(var(--primary),#3ca812);
    border-radius:30px;
}

/*==============================
        NAVBAR
===============================*/

.navbar{

    position:fixed;
    top:0;
    left:0;
    width:100%;
    z-index:1000;

    display:flex;
    justify-content:space-between;
    align-items:center;

    padding:18px 7%;

    background:rgba(12,15,20,.72);

    backdrop-filter:blur(20px);

    border-bottom:1px solid rgba(255,255,255,.08);

    transition:.35s;
}

body.light .navbar{

    background:rgba(255,255,255,.85);

}

.logo{

    display:flex;
    align-items:center;
    gap:14px;
}

.logo img{

    width:75px;
    transition:.35s;
}

.logo:hover img{

    transform:scale(1.08);
}

/*==============================
        NAV LINKS
===============================*/

.nav-links{

    list-style:none;

    display:flex;

    gap:38px;

    align-items:center;
}

.nav-links li{

    position:relative;
}

.nav-links a{

    text-decoration:none;

    color:var(--text2);

    font-size:16px;

    font-weight:500;

    transition:.35s;
}

.nav-links a:hover,
.nav-links .active{

    color:var(--primary);
}

.nav-links a::after{

    content:"";

    position:absolute;

    left:0;
    bottom:-8px;

    width:0;

    height:3px;

    border-radius:20px;

    background:var(--primary);

    transition:.35s;
}

.nav-links a:hover::after,
.nav-links .active::after{

    width:100%;
}

/*==============================
      RIGHT NAVIGATION
===============================*/

.right-nav{

    display:flex;

    align-items:center;

    gap:18px;
}

.hamburger{
    display:none;
    background:none;
    border:none;
    font-size:1.6rem;
    cursor:pointer;
    color:var(--text);
    line-height:1;
    padding:0.3rem;
}

/*==============================
        PREMIUM TOGGLE
===============================*/

.theme-btn{

    width:72px;
    height:38px;

    border:none;

    border-radius:50px;

    cursor:pointer;

    background:linear-gradient(135deg,#222,#111);

    display:flex;

    align-items:center;

    justify-content:flex-start;

    padding:5px;

    transition:.35s;

    position:relative;
}

body.light .theme-btn{

    background:#d9dee6;
}

.theme-btn::before{

    content:"";

    position:absolute;

    width:28px;
    height:28px;

    border-radius:50%;

    background:white;

    left:5px;

    transition:.35s;
}

body.light .theme-btn::before{

    left:39px;
}

.theme-btn i{

    position:absolute;

    font-size:14px;
}

.theme-btn .fa-sun{

    left:12px;

    color:#f5b000;
}

.theme-btn .fa-moon{

    right:12px;

    color:white;
}

/*==============================
      ICON BUTTONS
===============================*/

.icon-btn{

    width:48px;
    height:48px;

    border-radius:50%;

    display:flex;
    justify-content:center;
    align-items:center;

    text-decoration:none;

    color:var(--text);

    border:1px solid var(--border);

    background:var(--glass);

    backdrop-filter:blur(18px);

    transition:.35s;

    position:relative;
}

.icon-btn:hover{

    transform:translateY(-5px);

    color:white;

    background:linear-gradient(135deg,var(--primary),var(--primary2));

    border-color:transparent;
}

/*====================================
            PAGE HEADER
=====================================*/

.orders-hero{

    margin-top:95px;

    padding:70px 7% 30px;

    text-align:center;

    position:relative;

    overflow:hidden;
}

.orders-hero::before{

    content:"";

    position:absolute;

    width:550px;
    height:550px;

    background:radial-gradient(var(--primary),transparent 70%);

    opacity:.12;

    top:-260px;
    left:50%;

    transform:translateX(-50%);

    filter:blur(30px);
}

.orders-hero h5{

    color:var(--primary);

    font-size:16px;

    margin-bottom:14px;

    letter-spacing:1px;

    text-transform:uppercase;

    position:relative;
    z-index:2;
}

.orders-hero h1{

    font-size:48px;

    font-weight:800;

    margin-bottom:12px;

    position:relative;
    z-index:2;
}

.orders-hero h1 span{

    color:var(--primary);
}

.orders-hero p{

    color:var(--text2);

    font-size:16px;

    position:relative;
    z-index:2;
}

/* ---------- ORDERS LIST ---------- */

.orders-container{

    padding:30px 7% 80px;

    display:flex;

    flex-direction:column;

    gap:26px;

    max-width:920px;

    margin:auto;

    position:relative;
    z-index:2;
}

.order-card{

    background:var(--card);

    border:1px solid var(--border);

    border-radius:25px;

    padding:28px;

    box-shadow:var(--shadow);

    transition:.35s;
}

.order-card:hover{

    transform:translateY(-4px);

    border-color:rgba(117,214,29,.35);
}

.order-top{

    display:flex;

    justify-content:space-between;

    align-items:flex-start;

    flex-wrap:wrap;

    gap:12px;

    margin-bottom:18px;

    padding-bottom:18px;

    border-bottom:1px solid var(--border);
}

.order-restaurant{

    display:flex;

    align-items:center;

    gap:16px;
}

.order-restaurant .order-icon{

    width:52px;
    height:52px;

    border-radius:16px;

    display:flex;

    justify-content:center;
    align-items:center;

    background:linear-gradient(135deg,var(--primary),var(--primary2));

    color:white;

    font-size:20px;

    flex-shrink:0;
}

.order-restaurant h3{

    font-size:20px;

    margin-bottom:6px;
}

.order-meta{

    color:var(--text2);

    font-size:13px;
}

.order-status{

    padding:8px 16px;

    border-radius:30px;

    font-size:13px;

    font-weight:600;

    white-space:nowrap;
}

.status-delivered{
    background:rgba(46,204,113,.15);
    color:var(--success);
    border:1px solid rgba(46,204,113,.35);
}

.status-pending{
    background:rgba(255,159,67,.15);
    color:var(--warning);
    border:1px solid rgba(255,159,67,.35);
}

.status-cancelled{
    background:rgba(231,76,60,.15);
    color:var(--danger);
    border:1px solid rgba(231,76,60,.35);
}

/* ---------- TRACKER ---------- */

.tracker{

    display:flex;

    align-items:flex-start;

    margin:20px 0 22px;
}

.tracker-step{

    flex:1;

    text-align:center;

    position:relative;
}

.tracker-step .dot{

    width:32px;
    height:32px;

    border-radius:50%;

    background:var(--card2);

    color:var(--text2);

    display:flex;

    align-items:center;
    justify-content:center;

    margin:0 auto 8px;

    font-size:13px;

    border:2px solid var(--border);

    position:relative;

    z-index:2;

    transition:.25s;
}

.tracker-step .line{

    position:absolute;

    top:15px;
    left:-50%;

    width:100%;
    height:2px;

    background:var(--border);

    z-index:1;
}

.tracker-step:first-child .line{display:none;}

.tracker-step.completed .dot,
.tracker-step.active .dot{

    background:linear-gradient(135deg,var(--primary),var(--primary2));

    color:white;

    border-color:transparent;
}

.tracker-step.active .dot{

    box-shadow:0 0 0 5px rgba(117,214,29,.18);
}

.tracker-step.completed .line{background:linear-gradient(90deg,var(--primary),var(--primary2));}

.tracker-step .label{

    font-size:11px;

    color:var(--text2);
}

.tracker-step.completed .label,
.tracker-step.active .label{

    color:var(--text);

    font-weight:600;
}

.cancelled-banner{

    display:flex;

    align-items:center;

    gap:10px;

    background:rgba(231,76,60,.1);

    color:var(--danger);

    padding:12px 16px;

    border-radius:12px;

    font-size:13px;

    margin:20px 0 22px;

    font-weight:500;

    border:1px solid rgba(231,76,60,.25);
}

/* ---------- ITEMS ---------- */

.order-items{

    display:flex;

    flex-direction:column;

    gap:10px;

    margin-bottom:18px;

    padding:16px;

    background:var(--card2);

    border-radius:16px;
}

.order-item-row{

    display:flex;

    justify-content:space-between;

    color:var(--text2);

    font-size:15px;
}

.order-item-row span:first-child{

    color:var(--text);
}

.order-bottom{

    display:flex;

    justify-content:space-between;

    align-items:center;

    flex-wrap:wrap;

    gap:12px;

    padding-top:18px;

    border-top:1px solid var(--border);
}

.order-total{

    font-size:19px;

    font-weight:700;
}

.order-total span{
    color:var(--primary);
}

.order-payment{

    color:var(--text2);

    font-size:14px;
}

.cancel-btn{

    margin-left:auto;

    background:rgba(231,76,60,.12);

    color:var(--danger);

    border:1px solid rgba(231,76,60,.35);

    padding:10px 18px;

    border-radius:10px;

    cursor:pointer;

    font-family:inherit;

    font-weight:600;

    font-size:13px;

    transition:.3s;
}

.cancel-btn:hover{

    background:var(--danger);

    color:white;
}

/* ---------- REVIEW ---------- */

.review-box{

    margin-top:18px;

    padding-top:18px;

    border-top:1px dashed var(--border);
}

.review-box .review-heading{

    font-size:13px;

    color:var(--text2);

    margin-bottom:10px;

    font-weight:600;

    text-transform:uppercase;

    letter-spacing:.5px;
}

.star-rating{

    display:flex;

    flex-direction:row-reverse;

    justify-content:flex-end;

    gap:4px;

    margin-bottom:12px;
}

.star-rating input{display:none;}

.star-rating label{

    font-size:24px;

    color:var(--border);

    cursor:pointer;

    transition:.15s;
}

.star-rating input:checked ~ label,
.star-rating label:hover,
.star-rating label:hover ~ label{

    color:var(--warning);
}

.review-comment{

    width:100%;

    padding:12px 14px;

    border-radius:12px;

    border:1px solid var(--border);

    background:var(--card2);

    color:var(--text);

    font-family:'Poppins',sans-serif;

    font-size:13px;

    resize:vertical;

    min-height:60px;

    margin-bottom:12px;

    outline:none;

    transition:.3s;
}

.review-comment:focus{
    border-color:var(--primary);
}

.review-submit-btn{

    background:linear-gradient(135deg,var(--primary),var(--primary2));

    color:white;

    border:none;

    padding:10px 22px;

    border-radius:10px;

    font-weight:600;

    font-size:13px;

    cursor:pointer;

    transition:.3s;
}

.review-submit-btn:hover{

    transform:scale(1.04);
}

.existing-review{

    display:flex;

    flex-direction:column;

    gap:6px;
}

.existing-review .stars{color:var(--warning);font-size:16px;}
.existing-review .comment{font-size:13px;color:var(--text2);}

/* ---------- EMPTY STATE ---------- */

.empty-state{

    text-align:center;

    padding:100px 20px;

    color:var(--text2);
}

.empty-state i{

    font-size:50px;

    color:var(--primary);

    margin-bottom:20px;

    display:block;
}

.empty-state h2{

    color:var(--text);

    margin-bottom:10px;

    font-size:26px;
}

/* ---------- RESPONSIVE ---------- */

@media(max-width:900px){

.hamburger{ display:block; }

.nav-links{
    display:none;
    position:absolute;
    top:100%;
    left:0;
    right:0;
    flex-direction:column;
    align-items:stretch;
    gap:0;
    background:rgba(12,15,20,.97);
    padding:0.6rem 7%;
    box-shadow:0 12px 30px rgba(0,0,0,.35);
}

.nav-links.open{ display:flex; }

.nav-links li{ width:100%; }

.nav-links a{
    display:block;
    width:100%;
    padding:0.9rem 0;
}

.orders-hero h1{ font-size:34px; }

}

@media(max-width:600px){

.order-restaurant{ gap:10px; }

.order-restaurant .order-icon{ width:44px;height:44px;font-size:16px; }

.cancel-btn{ margin-left:0; width:100%; }

}

</style>

</head>
<body>

<nav class="navbar">

    <div class="logo">
        <img src="images/foodrush-logo1.png" alt="FoodRush">
    </div>

    <ul class="nav-links" id="navLinks">
        <li><a href="callRestuarantServlet">Restaurants</a></li>
        <li><a href="Cart.jsp">🛒 Cart</a></li>
        <li><a href="MyFavoritesServlet">Favorites</a></li>
        <li><a href="Checkout.jsp">Checkout</a></li>
        <li><a href="MyOrdersServlet" class="active">My Orders</a></li>
    </ul>

    <div class="right-nav">

        <button class="theme-btn" onclick="toggleTheme()">
            <i class="fa-solid fa-sun"></i>
            <i class="fa-solid fa-moon"></i>
        </button>

        <a href="ProfileServlet" class="icon-btn" title="Profile">
            <i class="fa-solid fa-user"></i>
        </a>

        <a href="LogoutServlet"
           class="icon-btn"
           title="Logout"
           onclick="return confirm('Are you sure you want to logout?');">
            <i class="fa-solid fa-right-from-bracket"></i>
        </a>

    </div>
    <button class="hamburger" id="hamburgerBtn" aria-label="Toggle menu" aria-expanded="false">☰</button>

</nav>

<section class="orders-hero">
    <h5>ORDER HISTORY</h5>
    <h1>My <span>Orders</span></h1>
    <p>Everything you've ordered so far, all in one place</p>
</section>

<section class="orders-container">

<%
List<Order> orders = (List<Order>) request.getAttribute("orders");
Map<Integer, List<OrderItem>> orderItemsMap = (Map<Integer, List<OrderItem>>) request.getAttribute("orderItemsMap");
Map<Integer, Restuarant> restaurantMap = (Map<Integer, Restuarant>) request.getAttribute("restaurantMap");
Map<Integer, Menu> menuMap = (Map<Integer, Menu>) request.getAttribute("menuMap");
Map<Integer, Review> reviewMap = (Map<Integer, Review>) request.getAttribute("reviewMap");

if(orders != null && !orders.isEmpty()){

for(Order order : orders){

Restuarant restuarant = restaurantMap.get(order.getRestuarantId());
List<OrderItem> items = orderItemsMap.get(order.getOrderId());

String statusClass = "delivered".equalsIgnoreCase(order.getStatus()) ? "status-delivered"
        : ("cancelled".equalsIgnoreCase(order.getStatus()) ? "status-cancelled" : "status-pending");
%>

<div class="order-card">

    <div class="order-top">
        <div class="order-restaurant">
            <div class="order-icon"><i class="fa-solid fa-utensils"></i></div>
            <div>
                <h3><%= restuarant != null ? restuarant.getResName() : "Restaurant" %></h3>
                <div class="order-meta">
                    Order #<%= order.getOrderId() %> &nbsp;•&nbsp; <%= order.getOrderDate() %>
                </div>
            </div>
        </div>
        <div class="order-status <%= statusClass %>">
            <%= order.getStatus() %>
        </div>
    </div>

<%
    boolean isCancelled = "Cancelled".equalsIgnoreCase(order.getStatus());
    int currentStep = 1; // 1 = Placed, 2 = Packed, 3 = Delivered
    if (!isCancelled) {
        if ("delivered".equalsIgnoreCase(order.getStatus())) {
            currentStep = 3;
        } else if ("packed".equalsIgnoreCase(order.getStatus())) {
            currentStep = 2;
        }
    }
    String step1Class = currentStep > 1 ? "completed" : "active";
    String step2Class = currentStep > 2 ? "completed" : (currentStep == 2 ? "active" : "");
    String step3Class = currentStep == 3 ? "active" : "";
%>

<% if (isCancelled) { %>
    <div class="cancelled-banner">
        <i class="fa-solid fa-circle-xmark"></i> This order was cancelled
    </div>
<% } else { %>
    <div class="tracker">
        <div class="tracker-step <%= step1Class %>">
            <div class="dot"><i class="fa-solid fa-receipt"></i></div>
            <div class="label">Placed</div>
        </div>
        <div class="tracker-step <%= step2Class %>">
            <div class="line"></div>
            <div class="dot"><i class="fa-solid fa-box"></i></div>
            <div class="label">Packed</div>
        </div>
        <div class="tracker-step <%= step3Class %>">
            <div class="line"></div>
            <div class="dot"><i class="fa-solid fa-circle-check"></i></div>
            <div class="label">Delivered</div>
        </div>
    </div>
<% } %>

    <div class="order-items">
    <%
    if(items != null){
        for(OrderItem item : items){
            Menu menu = menuMap.get(item.getMenuId());
            String itemName = menu != null ? menu.getItemName() : "Item";
    %>
        <div class="order-item-row">
            <span><%= itemName %> x <%= item.getQuantity() %></span>
            <span>₹<%= item.getItemTotal() %></span>
        </div>
    <%
        }
    }
    %>
    </div>

    <div class="order-bottom">
        <div class="order-total">Total: <span>₹<%= order.getTotalAmount() %></span></div>
        <div class="order-payment">Paid via <%= order.getPaymentMethod() %></div>
        <% if("Not delivered".equalsIgnoreCase(order.getStatus())){ %>
        <form method="post" action="MyOrdersServlet" onsubmit="return confirm('Cancel this order?');" style="margin-left:auto;">
            <input type="hidden" name="action" value="cancel">
            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
            <button type="submit" class="cancel-btn">Cancel Order</button>
        </form>
        <% } %>
    </div>

    <%
    if ("delivered".equalsIgnoreCase(order.getStatus())) {
        Review existingReview = reviewMap != null ? reviewMap.get(order.getOrderId()) : null;
%>
    <div class="review-box">
<%
        if (existingReview != null) {
            String filledStars = "";
            for (int i = 0; i < existingReview.getRating(); i++) filledStars += "★";
            for (int i = existingReview.getRating(); i < 5; i++) filledStars += "☆";
%>
        <div class="existing-review">
            <div class="review-heading">Your Review</div>
            <div class="stars"><%= filledStars %></div>
<% if (existingReview.getComment() != null && !existingReview.getComment().trim().isEmpty()) { %>
            <div class="comment"><%= existingReview.getComment() %></div>
<% } %>
        </div>
<%
        } else {
%>
        <div class="review-heading">Rate this order</div>
        <form method="post" action="review">
            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
            <div class="star-rating">
                <input type="radio" name="rating" value="5" id="star5-<%= order.getOrderId() %>" required><label for="star5-<%= order.getOrderId() %>">★</label>
                <input type="radio" name="rating" value="4" id="star4-<%= order.getOrderId() %>"><label for="star4-<%= order.getOrderId() %>">★</label>
                <input type="radio" name="rating" value="3" id="star3-<%= order.getOrderId() %>"><label for="star3-<%= order.getOrderId() %>">★</label>
                <input type="radio" name="rating" value="2" id="star2-<%= order.getOrderId() %>"><label for="star2-<%= order.getOrderId() %>">★</label>
                <input type="radio" name="rating" value="1" id="star1-<%= order.getOrderId() %>"><label for="star1-<%= order.getOrderId() %>">★</label>
            </div>
            <textarea class="review-comment" name="comment" placeholder="Share your experience (optional)"></textarea>
            <button type="submit" class="review-submit-btn">Submit Review</button>
        </form>
<%
        }
%>
    </div>
<%
    }
%>

</div>

<%
}
}
else{
%>

<div class="empty-state">
    <i class="fa-solid fa-receipt"></i>
    <h2>No Orders Yet</h2>
    <p>Your past orders will show up here once you place one.</p>
</div>

<%
}
%>

</section>

<script>

const themeBtn=document.querySelector(".theme-btn");

function toggleTheme(){

    document.body.classList.toggle("light");

    if(document.body.classList.contains("light")){
        localStorage.setItem("theme","light");
    }
    else{
        localStorage.setItem("theme","dark");
    }

}

if(localStorage.getItem("theme")==="light"){
    document.body.classList.add("light");
}

</script>
<script>
  const hamburgerBtn = document.getElementById('hamburgerBtn');
  const navLinks = document.getElementById('navLinks');

  hamburgerBtn.addEventListener('click', () => {
    const isOpen = navLinks.classList.toggle('open');
    hamburgerBtn.setAttribute('aria-expanded', isOpen);
    hamburgerBtn.textContent = isOpen ? '✕' : '☰';
  });

  navLinks.querySelectorAll('a').forEach((link) => {
    link.addEventListener('click', () => {
      navLinks.classList.remove('open');
      hamburgerBtn.setAttribute('aria-expanded', false);
      hamburgerBtn.textContent = '☰';
    });
  });
</script>
<script src="chatbot.js"></script>
</body>
</html>
