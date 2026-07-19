<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List,com.tap.model.Menu,com.tap.model.Restuarant" %>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodRush Menu</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
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
    --primary-dark:#4cc80d;

    --bg:#0b0d12;
    --card:#141821;
    --secondary:#1a202c;
    --text:#ffffff;
    --text-light:#b0b7c3;
    --border:#252c38;
    --shadow:rgba(0,0,0,.45);
    --glass:rgba(255,255,255,.05);
}

body.light{
    --bg:#f5f7fb;
    --card:#ffffff;
    --secondary:#eef2f7;
    --text:#1b1f28;
    --text-light:#6b7280;
    --border:#dce3eb;
    --shadow:rgba(0,0,0,.08);
}

body{
    background:var(--bg);
    color:var(--text);
    transition:.35s;
}

/* NAVBAR */

.navbar{
    position:sticky;
    top:0;
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
    font-size:34px;
    font-weight:800;
}

.logo span{
    color:var(--primary);
}

.nav-links{
    display:flex;
    list-style:none;
    gap:35px;
    align-items:center;
}

.nav-links a{
    text-decoration:none;
    color:var(--text-light);
    font-weight:500;
    transition:.3s;
}

.nav-links a{
    position:relative;
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
.nav-links a:hover::after,
.nav-links .active::after{
    width:100%;
}

.right-nav{
    display:flex;
    align-items:center;
    gap:20px;
}

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
}

.icon-btn:hover{
    transform:translateY(-5px);
    color:white;
    background:linear-gradient(135deg,var(--primary),var(--primary-dark));
    border-color:transparent;
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
/* LAYOUT */

.container{
    width:100%;
    padding:35px 6%;
}


.offer-banner{
    margin-bottom:24px;
    background:linear-gradient(135deg,#6df11c,#3dbd00);
    color:#0b0d12;
    padding:16px 22px;
    border-radius:14px;
    font-weight:600;
    display:flex;
    align-items:center;
    gap:10px;
}

.original-price{
    font-size:14px;
    color:var(--text-light);
    text-decoration:line-through;
    margin-right:8px;
    font-weight:400;
}

.discounted-price{
    color:var(--primary);
}

/* MAIN */

.heading{
    display:flex;
    justify-content:space-between;
    flex-wrap:wrap;
    gap:20px;
    margin-bottom:30px;
}

.heading h1{
    font-size:42px;
}

.heading h1 span{
    color:var(--primary);
}

.filters{
    display:flex;
    gap:15px;
}

.filter-btn{
    padding:12px 25px;
    border:none;
    border-radius:12px;
    background:var(--card);
    color:var(--text-light);
    border:1px solid var(--border);
    cursor:pointer;
}

.filter-btn.active{
    background:var(--primary);
    color:white;
}

/* CARDS */

.food-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
    gap:30px;
}

.card{
    background:var(--card);
    border-radius:25px;
    overflow:hidden;
    border:1px solid var(--border);
    transition:.4s;
}

.card:hover{
    transform:translateY(-12px);
    box-shadow:0 20px 50px var(--shadow);
}

.card img{
    width:100%;
    height:220px;
    object-fit:cover;
}

.card-content{
    padding:20px;
}

.badge{
    display:inline-block;
    padding:6px 14px;
    border-radius:30px;
    background:rgba(105,241,31,.15);
    color:var(--primary);
    font-size:13px;
    margin-bottom:15px;
}

.card h3{
    margin-bottom:10px;
}

.card p{
    color:var(--text-light);
    font-size:14px;
    line-height:1.7;
}

.price-area{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-top:20px;
}

.price{
    font-size:24px;
    font-weight:700;
}

.add-btn{
    padding:12px 22px;
    border:none;
    border-radius:12px;
    background:linear-gradient(135deg,var(--primary),var(--primary-dark));
    color:white;
    font-weight:600;
    cursor:pointer;
    transition:.3s;
}

.add-btn:hover{
    transform:scale(1.05);
}

/* RESPONSIVE */

.menu-btn{
    display:none;
}

@media(max-width:1000px){

    .container{
        grid-template-columns:1fr;
    }

    .sidebar{
        position:relative;
        top:0;
    }
}

@media(max-width:800px){

    .hamburger{
        display:block;
    }

    .nav-links{
        display:none;
        position:absolute;
        top:100%;
        left:0;
        right:0;
        flex-direction:column;
        align-items:stretch;
        gap:0;
        background:var(--card);
        border-bottom:1px solid var(--border);
        padding:10px 6%;
    }

    .nav-links.open{
        display:flex;
    }

    .nav-links li{
        width:100%;
    }

    .nav-links a{
        display:block;
        padding:14px 0;
        border-bottom:1px solid var(--border);
    }

    .right-nav{
        gap:10px;
    }

    .icon-btn{
        width:40px;
        height:40px;
        font-size:14px;
    }

    .heading h1{
        font-size:30px;
    }

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
    <li><a href="MyOrdersServlet">My Orders</a></li>
    <li><a href="Menu.jsp" class="active">Menu</a></li>
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

<div class="container">

    
    <main>

        <div class="heading">

            <div>
                <h1>Our <span>Menu</span></h1>
                <p>Discover premium meals prepared by top chefs.</p>
            </div>

         <!--    <div class="filters">
                <button class="filter-btn active">All</button>
                <button class="filter-btn">Veg</button>
                <button class="filter-btn">Non Veg</button>
            </div>
             -->

        </div>

<%
Restuarant restuarant = (Restuarant) request.getAttribute("restuarant");
boolean hasOffer = restuarant != null && restuarant.hasActiveOffer();
int offerPercent = restuarant != null ? restuarant.getOfferPercent() : 0;

if (hasOffer) {
%>
        <div class="offer-banner">
            <i class="fa-solid fa-tags"></i> <%=offerPercent%>% OFF on everything from this restaurant!
        </div>
<%
}
%>

        <div class="food-grid">
<%
List<Menu> allMenusByRestaurant=(List<Menu>) request.getAttribute("allMenusByRestaurant");

for(Menu menu:allMenusByRestaurant){
	float originalPrice = menu.getPrice();
	float displayPrice = hasOffer ? originalPrice * (100 - offerPercent) / 100f : originalPrice;
	%>

            <div class="card">
                <img src="<%= menu.getImagePath()%>"  alt="">
                <div class="card-content">
                    <span class="badge">Bestseller</span>
                    <h3><%= menu.getItemName()%></h3>
                    <p><%= menu.getDescription()%></p>

                    <div class="price-area">
                        <div class="price">
<%
if (hasOffer) {
%>
                            <span class="original-price">&#8377;<%=String.format("%.0f", originalPrice)%></span>
                            <span class="discounted-price">&#8377;<%=String.format("%.0f", displayPrice)%></span>
<%
} else {
%>
                            &#8377;<%=String.format("%.0f", originalPrice)%>
<%
}
%>
                        </div>
                        <form action="cartServlet" method="post">
                        <input type="hidden" name="menuId" value="<%= menu.getMenuId() %>">
				        <input type="hidden" name="restuarantId" value="<%= menu.getRestuarantId() %>">
				        <input type="hidden" name="quantity" value="1">
				        <input type="hidden" name="action" value="add">
                        <button class="add-btn">Add +</button>
                        </form>
                    </div>
                </div>
            </div>


	<%
}
%>
        </div>
    </main>

</div>

<script>

function toggleTheme(){
    document.body.classList.toggle("light");
    localStorage.setItem("theme", document.body.classList.contains("light") ? "light" : "dark");
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
    
    
    
    








