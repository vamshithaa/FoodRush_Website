<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.Cart, com.tap.model.CartItem"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Your Cart | FoodRush</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

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
    --danger:#ff4d6d;
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

/*==============================
      PAGE HEADER
===============================*/

.cart-page-header{

    margin-top:135px;
    padding:0 7%;

    display:flex;
    justify-content:space-between;
    align-items:flex-end;
    flex-wrap:wrap;
    gap:20px;

    position:relative;
}

.cart-page-header::before{

    content:"";

    position:absolute;

    width:400px;
    height:400px;

    background:radial-gradient(var(--primary),transparent 70%);

    opacity:.10;

    top:-160px;
    left:-120px;

    filter:blur(30px);

    pointer-events:none;
}

.cart-heading h5{

    color:var(--primary);
    font-size:15px;
    font-weight:600;
    letter-spacing:1px;
    text-transform:uppercase;
    margin-bottom:12px;
}

.cart-heading h1{

    font-size:46px;
    font-weight:800;
    line-height:1.15;
}

.cart-heading p{

    color:var(--text2);
    margin-top:10px;
    font-size:16px;
}

.cart-count-pill{

    display:flex;
    align-items:center;
    gap:10px;

    padding:12px 22px;

    border-radius:50px;

    background:var(--glass);
    border:1px solid var(--border);
    backdrop-filter:blur(18px);

    color:var(--text2);
    font-weight:600;
    font-size:15px;
}

.cart-count-pill i{
    color:var(--primary);
}

/*==============================
        MAIN LAYOUT
===============================*/

.main-wrapper{

    margin-top:45px;
    padding:0 7% 80px;

    display:grid;
    grid-template-columns:1fr 400px;
    gap:40px;
    align-items:start;
}

/*==============================
        CART LIST BOX
===============================*/

.cart-box{

    background:var(--card);
    border:1px solid var(--border);
    border-radius:26px;
    overflow:hidden;
    box-shadow:var(--shadow);
}

.cart-header{

    display:grid;
    grid-template-columns:2.2fr 1fr 1fr 1.4fr .9fr;
    gap:15px;

    padding:22px 32px;

    font-weight:600;
    font-size:14px;
    letter-spacing:.4px;
    text-transform:uppercase;
    color:var(--text2);

    border-bottom:1px solid var(--border);

    background:var(--card2);
}

.cart-item{

    display:grid;
    grid-template-columns:2.2fr 1fr 1fr 1.4fr .9fr;
    gap:15px;
    align-items:center;

    padding:26px 32px;

    border-bottom:1px solid var(--border);

    transition:.35s;

    opacity:0;
    transform:translateY(25px);
    animation:itemIn .6s ease forwards;
}

@keyframes itemIn{
    to{
        opacity:1;
        transform:translateY(0);
    }
}

.cart-item:hover{

    background:linear-gradient(90deg,rgba(117,214,29,.06),transparent);
}

.cart-item:last-child{
    border-bottom:none;
}

.item-info{

    display:flex;
    align-items:center;
    gap:16px;
}

.item-thumb{

    width:58px;
    height:58px;
    flex-shrink:0;

    border-radius:16px;

    background:linear-gradient(135deg,var(--primary),var(--primary2));

    display:flex;
    align-items:center;
    justify-content:center;

    color:white;
    font-size:22px;

    box-shadow:0 10px 25px rgba(117,214,29,.25);
}

.item-name{
    font-size:17px;
    font-weight:600;
    line-height:1.3;
}

.item-price{

    color:var(--text2);
    font-size:16px;
    font-weight:500;
}

.item-price::before{
    content:"\20B9";
}

.item-total{

    color:var(--primary);
    font-size:18px;
    font-weight:700;
}

.item-total::before{
    content:"\20B9";
}

/*==============================
        QUANTITY
===============================*/

.quantity-box{

    display:flex;
    align-items:center;
    gap:14px;

    background:var(--card2);
    border:1px solid var(--border);
    border-radius:50px;

    padding:6px;

    width:fit-content;
}

.quantity-box form{
    display:flex;
}

.qty-btn{

    width:32px;
    height:32px;

    border:none;
    border-radius:50%;

    background:transparent;
    color:var(--text);

    cursor:pointer;
    font-size:15px;
    font-weight:700;

    display:flex;
    align-items:center;
    justify-content:center;

    transition:.3s;
}

.qty-btn:hover{

    background:linear-gradient(135deg,var(--primary),var(--primary2));
    color:white;
    transform:scale(1.1);
}

.quantity{

    font-size:15px;
    font-weight:700;
    min-width:18px;
    text-align:center;
}

/*==============================
        REMOVE
===============================*/

.remove-btn{

    width:42px;
    height:42px;

    border:1px solid var(--border);
    border-radius:50%;

    background:var(--glass);
    color:var(--text2);

    cursor:pointer;
    font-size:15px;

    display:flex;
    align-items:center;
    justify-content:center;

    transition:.3s;
}

.remove-btn:hover{

    background:var(--danger);
    border-color:transparent;
    color:white;
    transform:rotate(8deg) scale(1.08);
}

/*==============================
        ADD MORE STRIP
===============================*/

.add-more-strip{

    display:flex;
    align-items:center;
    justify-content:center;
    gap:10px;

    padding:22px;

    color:var(--primary);
    text-decoration:none;
    font-weight:600;
    font-size:15px;

    border-top:1px dashed var(--border);

    transition:.3s;
}

.add-more-strip:hover{

    background:rgba(117,214,29,.06);
    letter-spacing:.5px;
}

/*==============================
        SUMMARY CARD
===============================*/

.summary-card{

    background:var(--card);
    border:1px solid var(--border);
    border-radius:26px;

    padding:32px;

    box-shadow:var(--shadow);

    position:sticky;
    top:135px;
}

.summary-card h3{

    font-size:20px;
    font-weight:700;
    margin-bottom:26px;

    display:flex;
    align-items:center;
    gap:10px;
}

.summary-card h3 i{
    color:var(--primary);
}

.summary-row{

    display:flex;
    justify-content:space-between;
    align-items:center;

    margin-bottom:16px;

    font-size:15px;
    color:var(--text2);
}

.summary-row span:last-child{
    color:var(--text);
    font-weight:600;
}

.summary-row.free span:last-child{
    color:var(--success);
}

.summary-divider{

    height:1px;

    background:var(--border);

    margin:22px 0;
}

.summary-total{

    display:flex;
    justify-content:space-between;
    align-items:center;

    margin-bottom:30px;
}

.summary-total .label{

    font-size:17px;
    font-weight:600;
}

.summary-total .amount{

    font-size:30px;
    font-weight:800;
    color:var(--primary);
}

.summary-total .amount::before{
    content:"\20B9";
    font-size:22px;
}

.checkout-btn{

    display:flex;
    align-items:center;
    justify-content:center;
    gap:10px;

    width:100%;

    padding:18px;

    border:none;
    border-radius:16px;

    text-decoration:none;

    font-size:16px;
    font-weight:700;
    color:white;

    background:linear-gradient(135deg,var(--primary),var(--primary2));

    box-shadow:0 15px 35px rgba(117,214,29,.25);

    transition:.35s;
}

.checkout-btn:hover{

    transform:translateY(-4px);
    box-shadow:0 20px 45px rgba(117,214,29,.4);
}

.secure-note{

    display:flex;
    align-items:center;
    justify-content:center;
    gap:8px;

    margin-top:18px;

    font-size:13px;
    color:var(--text2);
}

.secure-note i{
    color:var(--primary);
}

/*==============================
        EMPTY CART
===============================*/

.empty-cart{

    grid-column:1/-1;

    background:var(--card);
    border:1px solid var(--border);
    border-radius:26px;

    padding:90px 40px;

    text-align:center;

    box-shadow:var(--shadow);

    position:relative;
    overflow:hidden;
}

.empty-cart::before{

    content:"";

    position:absolute;

    width:400px;
    height:400px;

    background:radial-gradient(var(--primary),transparent 70%);

    opacity:.08;

    top:-150px;
    left:50%;
    transform:translateX(-50%);

    filter:blur(30px);
}

.empty-icon{

    width:110px;
    height:110px;

    margin:0 auto 30px;

    border-radius:50%;

    display:flex;
    align-items:center;
    justify-content:center;

    background:var(--card2);
    border:1px solid var(--border);

    font-size:42px;
    color:var(--primary);

    animation:floatIcon 3s ease-in-out infinite;
}

@keyframes floatIcon{
    0%,100%{ transform:translateY(0); }
    50%{ transform:translateY(-14px); }
}

.empty-cart h2{

    font-size:30px;
    font-weight:700;
    margin-bottom:12px;
}

.empty-cart p{

    color:var(--text2);
    margin-bottom:35px;
}

.browse-btn{

    display:inline-flex;
    align-items:center;
    gap:10px;

    padding:16px 36px;

    border-radius:16px;

    text-decoration:none;

    font-weight:700;
    color:white;

    background:linear-gradient(135deg,var(--primary),var(--primary2));

    box-shadow:0 15px 35px rgba(117,214,29,.25);

    transition:.35s;
}

.browse-btn:hover{

    transform:translateY(-4px);
    box-shadow:0 20px 45px rgba(117,214,29,.4);
}

/*==============================
        RESPONSIVE
===============================*/

@media(max-width:1000px){

    .main-wrapper{
        grid-template-columns:1fr;
    }

    .summary-card{
        position:static;
    }
}

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

    .cart-page-header{
        margin-top:110px;
    }
}

@media(max-width:700px){

    .cart-header{
        display:none;
    }

    .cart-item{
    grid-template-columns:1fr auto;
    grid-template-areas:
        "info   remove"
        "price  total"
        "qty    qty";
    gap:10px 14px;
    padding:18px 20px;
}

.item-info{
    grid-area:info;
}

.item-price{
    grid-area:price;
    justify-self:start;
}

.item-total{
    grid-area:total;
    justify-self:end;
    align-self:center;
}

.quantity-box{
    grid-area:qty;
}

.remove-form{
    grid-area:remove;
    align-self:start;
    justify-self:end;
}

.remove-btn{
    width:34px;
    height:34px;
    font-size:13px;
}

    .cart-heading h1{
        font-size:32px;
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
        <li><a href="Cart.jsp" class="active">🛒 Cart</a></li>
        <li><a href="MyFavoritesServlet">Favorites</a></li>
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

<%
    Cart cart = (Cart) session.getAttribute("cart");
    Integer restuarantId = (Integer) session.getAttribute("restuarantId");

    double grandTotal = 0;
    int totalItems = 0;

    if (cart != null && !cart.getItems().isEmpty()) {
        for (CartItem ci : cart.getItems().values()) {
            totalItems += ci.getQuantity();
        }
%>

<section class="cart-page-header">
    <div class="cart-heading">
        <h5>Review &amp; Order</h5>
        <h1>Your Cart</h1>
        <p>Review your selected food items before checkout</p>
    </div>

    <div class="cart-count-pill">
        <i class="fa-solid fa-bag-shopping"></i>
        <span><%= totalItems %> item<%= totalItems == 1 ? "" : "s" %> in cart</span>
    </div>
</section>

<div class="main-wrapper">

	<div class="cart-box">

		<div class="cart-header">
			<div>Item</div>
			<div>Price</div>
			<div>Total</div>
			<div>Quantity</div>
			<div>Action</div>
		</div>
		<%
		    int idx = 0;
		    for (CartItem item : cart.getItems().values()) {

		    grandTotal = grandTotal + item.getTotalPrice();
		    idx++;
		%>

		<div class="cart-item" style="animation-delay: <%= idx * 0.08 %>s">

			<div class="item-info">
				<div class="item-thumb"><i class="fa-solid fa-utensils"></i></div>
				<div class="item-name"><%= item.getName() %></div>
			</div>

			<div class="item-price"><%= item.getPrice() %></div>

			<div class="item-total"><%= item.getTotalPrice() %></div>

			<div class="quantity-box">
				<form action="cartServlet" method="post">
					<input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
					<input type="hidden" name="restuarantId" value="<%= restuarantId %>">

					<% if (item.getQuantity()-1 <= 0) { %>
						<input type="hidden" name="action" value="delete">
					<% } else { %>
						<input type="hidden" name="action" value="update">
						<input type="hidden" name="quantity" value="<%= item.getQuantity() - 1 %>">
					<% } %>

					<button class="qty-btn" type="submit">-</button>
				</form>

				<span class="quantity"><%= item.getQuantity() %></span>

				<form action="cartServlet" method="post">
					<input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
					<input type="hidden" name="restuarantId" value="<%= restuarantId %>">
					<input type="hidden" name="action" value="update">
					<input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
					<button class="qty-btn" type="submit">+</button>
				</form>
			</div>

			<form action="cartServlet" class="remove-form" method="post">
				<input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
				<input type="hidden" name="restuarantId" value="<%= restuarantId %>">
				<input type="hidden" name="action" value="delete">
				<button class="remove-btn" type="submit" title="Remove item"><i class="fa-solid fa-trash"></i></button>
			</form>

		</div>

		<%
    		}
		%>

		<a class="add-more-strip" href="menu?restuarantId=<%= restuarantId %>">
			<i class="fa-solid fa-plus"></i> Add More Items
		</a>

	</div>

	<div class="summary-card">

		<h3><i class="fa-solid fa-receipt"></i> Order Summary</h3>

		<div class="summary-row">
			<span>Subtotal</span>
			<span>&#8377;<%= grandTotal %></span>
		</div>

		<div class="summary-row free">
			<span>Delivery Fee</span>
			<span>Free</span>
		</div>

		<div class="summary-divider"></div>

		<div class="summary-total">
			<div class="label">Grand Total</div>
			<div class="amount"><%= grandTotal %></div>
		</div>

		<a class="checkout-btn" href="Checkout.jsp">
			<i class="fa-solid fa-lock"></i> Proceed to Checkout
		</a>

		<div class="secure-note">
			<i class="fa-solid fa-shield-halved"></i> Safe &amp; secure checkout
		</div>

	</div>

</div>

<%
    } else {
%>

<div class="main-wrapper" style="margin-top:150px;">
	<div class="empty-cart">
		<div class="empty-icon"><i class="fa-solid fa-cart-shopping"></i></div>
		<h2>Your cart is empty</h2>
		<p>Please add some food items from the menu to get started.</p>
		<a class="browse-btn" href="callRestuarantServlet">
			<i class="fa-solid fa-utensils"></i> Browse Restaurants
		</a>
	</div>
</div>

<%
    }
%>

<script>

/* ---------------- THEME ---------------- */

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
