<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.List,com.tap.model.Restuarant" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodRush Restaurants</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>

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
--primary-dark:#4caf13;

--bg:#090b10;
--card:#171d27;
--secondary:#1f2633;

--text:#ffffff;
--text-light:#bfc8d5;

--border:rgba(255,255,255,.08);
--shadow:rgba(0,0,0,.45);

--glass:rgba(255,255,255,.05);

}

body.light{

--bg:#f5f7fb;
--card:#ffffff;
--secondary:#f8fafc;

--text:#111827;
--text-light:#6b7280;

--border:#dfe6ee;
--shadow:rgba(0,0,0,.08);

--glass:rgba(255,255,255,.75);

}

body{

background:
radial-gradient(circle at top left,#173e10 0%,transparent 28%),
radial-gradient(circle at bottom right,#164c18 0%,transparent 22%),
var(--bg);

color:var(--text);
transition:.35s;

}

/* Scrollbar */

::-webkit-scrollbar{
width:10px;
}

::-webkit-scrollbar-track{
background:var(--bg);
}

::-webkit-scrollbar-thumb{
background:linear-gradient(var(--primary),#3ca812);
border-radius:30px;
}

/* ---------- NAVBAR ---------- */

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

font-size:34px;
font-weight:800;
letter-spacing:.5px;

}

.logo img{

width:75px;
transition:.35s;

}

.logo:hover img{

transform:scale(1.08);

}

.logo span{

color:var(--primary);

}

.nav-links{

display:flex;
list-style:none;
gap:38px;
align-items:center;

}

.nav-links li{

position:relative;

}

.nav-links a{

text-decoration:none;
color:var(--text-light);

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

/* ---------- ICON BUTTONS (Profile / Logout) ---------- */

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

background:linear-gradient(135deg,var(--primary),var(--primary-dark));

border-color:transparent;

}

/* ---------- HERO ---------- */

.restaurant-hero{

margin-top:95px;

padding:70px 6% 40px;
text-align:center;

}

.restaurant-hero h1{

font-size:52px;
font-weight:700;
margin-bottom:15px;

}

.restaurant-hero h1 span{

color:var(--primary);

}

.restaurant-hero p{

color:var(--text-light);

font-size:17px;

margin-bottom:35px;

}

.restaurant-search{

width:650px;
max-width:100%;

margin:auto;

display:flex;
align-items:center;

background:var(--card);

padding:16px 22px;

border-radius:18px;

border:1px solid var(--border);

}

.restaurant-search i{

margin-right:15px;

color:var(--text-light);

}

.restaurant-search input{

flex:1;

border:none;
outline:none;

background:none;

color:var(--text);

font-size:16px;

}

/* ---------- FILTERS ---------- */

.filter-section{

padding:10px 6% 40px;

display:flex;
gap:15px;
flex-wrap:wrap;

}

.filter-btn{

padding:12px 22px;

border-radius:12px;

background:var(--card);

border:1px solid var(--border);

color:var(--text-light);

cursor:pointer;

transition:.3s;

}

.filter-btn:hover{

transform:translateY(-3px);

}

.active-filter{

background:linear-gradient(135deg,var(--primary),var(--primary-dark));

color:white;

}

/* ---------- GRID ---------- */

.restaurant-container{

padding:10px 6% 60px;

display:grid;

grid-template-columns:repeat(auto-fit,minmax(320px,1fr));

gap:30px;

}

.restaurant-container a{

text-decoration:none;
color:inherit;

}

/* ---------- CARD ---------- */

.restaurant-card{

background:var(--card);

border-radius:25px;

overflow:hidden;

border:1px solid var(--border);

transition:.35s;

position:relative;

}

.restaurant-card:hover{

transform:translateY(-10px);

box-shadow:0 20px 45px var(--shadow);

}

.restaurant-image{

position:relative;
overflow:hidden;

}

.restaurant-image img{

width:100%;
height:230px;
object-fit:cover;

transition:.5s;

}

.restaurant-card:hover img{

transform:scale(1.08);

}

.restaurant-badge{

position:absolute;

left:18px;
top:18px;

background:#ff4d4d;

padding:8px 14px;

border-radius:30px;

color:white;

font-size:13px;
font-weight:600;

}

.restaurant-content{

padding:22px;

}

.restaurant-top{

display:flex;
justify-content:space-between;
align-items:center;

margin-bottom:12px;

}

.restaurant-top h3{

font-size:24px;

}

.rating{

background:#19b34b;

color:white;

padding:6px 12px;

border-radius:10px;

font-size:14px;

font-weight:600;

}

.restaurant-content p{

color:var(--text-light);

margin-bottom:18px;

}

.restaurant-info{

display:flex;

justify-content:space-between;

font-size:14px;

color:var(--text-light);

}

/* ---------- HEART BUTTON ---------- */

.fav-btn{

position:absolute;

right:18px;
top:18px;

width:42px;
height:42px;

border-radius:50%;

display:flex;
justify-content:center;
align-items:center;

background:rgba(255,255,255,.95);

color:#ff4d6d;

font-size:18px;

box-shadow:0 5px 15px rgba(0,0,0,.25);

}

/* ---------- RESPONSIVE ---------- */

@media(max-width:900px){

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
padding:10px 7%;

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

.restaurant-hero h1{

font-size:38px;

}

}

@media(max-width:600px){

.restaurant-container{

grid-template-columns:1fr;

}

.filter-section{

justify-content:center;

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
		<li><a href="MyFavoritesServlet" class="active">Favorites</a></li>
        <li><a href="Checkout.jsp">Checkout</a></li>
        <li><a href="MyOrdersServlet">My Orders</a></li>

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


<section class="restaurant-hero">

   <h1>
    My <span>Favorite Restaurants</span>
</h1>

<p>
    The places you loved and saved for later
</p>

    <div class="restaurant-search">

        <i class="fa-solid fa-magnifying-glass"></i>

        <input
        id="searchRestaurant"
        type="text"
        placeholder="Search restaurants, cuisines or food...">

    </div>

</section>


<!--  
<section class="filter-section">

    <button class="filter-btn active-filter">All</button>

    <button class="filter-btn">🔥 Trending</button>

    <button class="filter-btn">🥗 Veg</button>

    <button class="filter-btn">🍗 Non Veg</button>

    <button class="filter-btn">🍕 Pizza</button>

    <button class="filter-btn">🍔 Burger</button>

    <button class="filter-btn">🍜 Chinese</button>

    <button class="filter-btn">🎁 Offers</button>

</section>
-->


<section class="restaurant-container">

<%
List<Restuarant> allrestuarants =
(List<Restuarant>)request.getAttribute("allrestuarants");

List<Integer> favoriteIds =
(List<Integer>)request.getAttribute("favoriteIds");

if(favoriteIds==null){
	favoriteIds = new java.util.ArrayList<Integer>();
}

if(allrestuarants!=null && !allrestuarants.isEmpty()){

for(Restuarant restuarant:allrestuarants){

boolean isFav = favoriteIds.contains(restuarant.getRestuarantId());

%>

<a href="menu?restuarantId=<%=restuarant.getRestuarantId()%>">

<div class="restaurant-card">

<div class="restaurant-image">

<img src="<%=restuarant.getImagePath()%>">

<% if (restuarant.hasActiveOffer()) { %>
<div class="restaurant-badge">
<%=restuarant.getOfferPercent()%>% OFF
</div>
<% } %>

<div class="fav-btn<%= isFav ? " favorited" : "" %>" data-restaurant-id="<%=restuarant.getRestuarantId()%>">

<i class="<%= isFav ? "fa-solid" : "fa-regular" %> fa-heart"></i>

</div>

</div>


<div class="restaurant-content">

<div class="restaurant-top">

<h3>

<%=restuarant.getResName()%>

</h3>

<div class="rating">

⭐ <%=restuarant.getRating()%>

</div>

</div>

<p>

🍽️ <%=restuarant.getCuisineType()%>

</p>

<div class="restaurant-info">

<span>

⏱️ <%=restuarant.getFormattedDeliveryTime()%>

</span>

<span>

📍 <%=restuarant.getAddress()%>

</span>

</div>

</div>

</div>

</a>
<%
    }
}
else{
%>

<div style="grid-column:1/-1;text-align:center;padding:80px 20px;color:var(--text-light);">
    <h2>No Favorites Yet</h2>
    <p>Tap the heart icon on any restaurant to save it here.</p>
</div>

<%
}
%>

</section>

<script>

/* ---------------- THEME ---------------- */

const themeBtn=document.querySelector(".theme-btn");

function toggleTheme(){

    document.body.classList.toggle("light");

    if(document.body.classList.contains("light")){

        themeBtn.innerHTML="☀️";
        localStorage.setItem("theme","light");

    }
    else{

        themeBtn.innerHTML="🌙";
        localStorage.setItem("theme","dark");

    }

}

if(localStorage.getItem("theme")==="light"){

    document.body.classList.add("light");
    themeBtn.innerHTML="☀️";

}


/* ---------------- SEARCH ---------------- */

const search=document.getElementById("searchRestaurant");

search.addEventListener("keyup",function(){

let value=this.value.toLowerCase();

let cards=document.querySelectorAll(".restaurant-card");

cards.forEach(card=>{

let text=card.innerText.toLowerCase();

if(text.indexOf(value)>-1){
    card.parentElement.style.display="";
}
else{
	card.parentElement.style.display="none";
}

});

});


/* ---------------- FILTER BUTTON ---------------- */

const filters=document.querySelectorAll(".filter-btn");

filters.forEach(button=>{

button.addEventListener("click",()=>{

filters.forEach(btn=>btn.classList.remove("active-filter"));

button.classList.add("active-filter");

});

});


/* ---------------- HEART BUTTON ---------------- */

document.querySelectorAll(".fav-btn").forEach(btn=>{

btn.addEventListener("click",function(e){

e.preventDefault();
e.stopPropagation();

const restaurantId=this.dataset.restaurantId;
const icon=this.querySelector("i");
const btnEl=this;

fetch("FavoriteServlet",{
	method:"POST",
	headers:{"Content-Type":"application/x-www-form-urlencoded"},
	body:"restaurantId="+encodeURIComponent(restaurantId)
})
.then(res=>{
	if(res.status===401){
		window.location.href="Login.html";
		return null;
	}
	return res.json();
})
.then(data=>{
	if(!data) return;

	if(data.status==="added"){
		icon.classList.remove("fa-regular");
		icon.classList.add("fa-solid");
		btnEl.classList.add("favorited");
	}
	else if(data.status==="removed"){
		icon.classList.remove("fa-solid");
		icon.classList.add("fa-regular");
		btnEl.classList.remove("favorited");
	}
})
.catch(err=>{
	console.error("Favorite request failed:",err);
});

});

});


/* ---------------- CARD ANIMATION ---------------- */

const cards=document.querySelectorAll(".restaurant-card");

cards.forEach((card,index)=>{

card.style.opacity="0";
card.style.transform="translateY(40px)";

setTimeout(()=>{

card.style.transition=".6s";

card.style.opacity="1";
card.style.transform="translateY(0px)";

},index*120);

});

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


