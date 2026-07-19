<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.Cart, com.tap.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodRush | Checkout</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        html {
            scroll-behavior: smooth;
        }

        :root {
            --primary: #75d61d;
            --primary-dark: #4caf13;
            --bg: #090b10;
            --card: #171d27;
            --card2: #1f2633;
            --border: rgba(255, 255, 255, 0.08);
            --text: #ffffff;
            --text-light: #bfc8d5;
            --shadow: 0 20px 50px rgba(0, 0, 0, 0.45);
            --glass: rgba(255, 255, 255, 0.05);
            --radius: 24px;
        }

        body.light {
            --bg: #f5f7fb;
            --card: #ffffff;
            --card2: #f8fafc;
            --border: #dfe6ee;
            --text: #111827;
            --text-light: #6b7280;
            --glass: rgba(255, 255, 255, 0.75);
            --shadow: 0 15px 40px rgba(0, 0, 0, 0.08);
        }

        body {
            background: radial-gradient(circle at top left, #173e10 0%, transparent 28%), 
                        radial-gradient(circle at bottom right, #164c18 0%, transparent 22%), 
                        var(--bg);
            color: var(--text);
            transition: .4s;
            overflow-x: hidden;
            position: relative;
            min-height: 100vh;
            padding-top: 96px;
        }

        /* Ambient Blobs */
        body::before {
            content: "";
            position: fixed;
            width: 500px;
            height: 500px;
            background: #69f11f18;
            border-radius: 50%;
            filter: blur(120px);
            top: -180px;
            left: -150px;
            animation: blob1 12s ease-in-out infinite;
            z-index: -2;
        }

        body::after {
            content: "";
            position: fixed;
            width: 450px;
            height: 450px;
            background: #00d4ff15;
            border-radius: 50%;
            filter: blur(120px);
            bottom: -150px;
            right: -100px;
            animation: blob2 14s ease-in-out infinite;
            z-index: -2;
        }

        @keyframes blob1 {
            0% { transform: translate(0, 0); }
            50% { transform: translate(120px, 80px); }
            100% { transform: translate(0, 0); }
        }

        @keyframes blob2 {
            0% { transform: translate(0, 0); }
            50% { transform: translate(-100px, -70px); }
            100% { transform: translate(0, 0); }
        }

        /* NAVBAR */
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 7%;
            background: rgba(12, 15, 20, 0.72);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            transition: 0.35s;
        }

        body.light .navbar {
            background: rgba(255, 255, 255, 0.85);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 14px;
            text-decoration: none;
            color: var(--text);
        }

        .logo img {
            width: 75px;
            transition: 0.35s;
        }

        .logo:hover img {
            transform: scale(1.08);
        }

        .logo-text {
            font-size: 30px;
            font-weight: 800;
            color: var(--text);
        }

        .logo-text span {
            color: var(--primary);
        }

        .nav-links {
            list-style: none;
            display: flex;
            gap: 38px;
            align-items: center;
        }

        .nav-links li {
            position: relative;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--text-light);
            font-size: 16px;
            font-weight: 500;
            transition: 0.35s;
        }

        .nav-links a:hover,
        .nav-links .active {
            color: var(--primary);
        }

        .nav-links a::after {
            content: "";
            position: absolute;
            left: 0;
            bottom: -8px;
            width: 0;
            height: 3px;
            border-radius: 20px;
            background: var(--primary);
            transition: 0.35s;
        }

        .nav-links a:hover::after,
        .nav-links .active::after {
            width: 100%;
        }

        .right-nav {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .theme-btn {
            width: 72px;
            height: 38px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            background: linear-gradient(135deg, #222, #111);
            display: flex;
            align-items: center;
            justify-content: flex-start;
            padding: 5px;
            transition: 0.35s;
            position: relative;
        }

        body.light .theme-btn {
            background: #d9dee6;
        }

        .theme-btn::before {
            content: "";
            position: absolute;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            background: white;
            left: 5px;
            transition: 0.35s;
        }

        body.light .theme-btn::before {
            left: 39px;
        }

        .theme-btn i {
            position: absolute;
            font-size: 14px;
        }

        .theme-btn .fa-sun {
            left: 12px;
            color: #f5b000;
        }

        .theme-btn .fa-moon {
            right: 12px;
            color: white;
        }

        .icon-btn {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            text-decoration: none;
            color: var(--text);
            border: 1px solid var(--border);
            background: var(--glass);
            backdrop-filter: blur(18px);
            transition: 0.35s;
            position: relative;
        }

        .icon-btn:hover {
            transform: translateY(-5px);
            color: white;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            border-color: transparent;
        }

        .cart-count {
            position: absolute;
            top: -5px;
            right: -3px;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background: var(--primary);
            color: white;
            font-size: 11px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: 700;
        }

        .mobile-toggle {
            display: none;
        }

        /* Checkout Layout */
        .checkout-container {
            width: min(1180px, 92%);
            margin: 24px auto 60px;
            animation: fadeUp .9s ease;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(50px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .checkout-heading {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            gap: 24px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }

        .eyebrow {
            display: inline-block;
            margin-bottom: 8px;
            padding: 7px 12px;
            border-radius: 999px;
            background: rgba(117, 214, 29, 0.16);
            color: var(--primary);
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        .checkout-heading h1 {
            font-size: 40px;
            font-weight: 800;
            margin-bottom: 6px;
        }

        .checkout-heading p {
            color: var(--text-light);
            max-width: 560px;
        }

        .delivery-highlight {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 16px 18px;
            border-radius: 18px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            min-width: 280px;
        }

        body.light .delivery-highlight {
            background: rgba(255, 255, 255, 0.8);
        }

        .delivery-icon {
            width: 46px;
            height: 46px;
            border-radius: 14px;
            display: grid;
            place-items: center;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            font-size: 18px;
        }

        .checkout-wrapper {
            display: grid;
            grid-template-columns: 1.1fr 0.9fr;
            gap: 24px;
            align-items: start;
        }

        /* Box Layouts */
        .checkout-box, .summary-box {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 24px;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
            transition: .35s;
        }

        body.light .checkout-box, body.light .summary-box {
            background: rgba(255, 255, 255, 0.82);
        }

        .checkout-box:hover, .summary-box:hover {
            transform: translateY(-8px);
            box-shadow: 0 25px 60px rgba(0,0,0,.35), 0 0 35px rgba(105, 241, 31, .08);
        }

        .checkout-box::before, .summary-box::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), #00d4ff, var(--primary));
            background-size: 300%;
            animation: borderMove 6s linear infinite;
        }

        @keyframes borderMove {
            0% { background-position: 0%; }
            100% { background-position: 300%; }
        }

        .section-title {
            font-size: 22px;
            margin-bottom: 20px;
            font-weight: 700;
        }

        /* Form Controls */
        .form-group {
            position: relative;
            margin-bottom: 28px;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            font-size: 15px;
            color: var(--text-light);
            transition: .3s;
        }

        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 14px 15px;
            background: linear-gradient(145deg, var(--card2), var(--card));
            border: 1px solid var(--border);
            border-radius: 14px;
            color: var(--text);
            font-size: 15px;
            transition: .35s;
            outline: none;
        }

        .form-group textarea {
            resize: none;
            height: 120px;
            line-height: 1.7;
        }

        .form-group select {
            cursor: pointer;
        }

        .form-group select option {
            background: #151923;
            color: white;
        }

        body.light .form-group select option {
            background: white;
            color: #222;
        }

        .form-group input:hover, .form-group textarea:hover, .form-group select:hover {
            transform: translateY(-3px);
        }

        .form-group input:focus, .form-group textarea:focus, .form-group select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 5px rgba(105, 241, 31, .08), 0 15px 35px rgba(105, 241, 31, .15);
        }

        /* Summary & Invoice Components */
        .summary-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            padding: 18px;
            margin-bottom: 18px;
            border-radius: 18px;
            background: linear-gradient(145deg, rgba(255, 255, 255, .04), rgba(255, 255, 255, .02));
            border: 1px solid var(--border);
            transition: .35s;
        }

        body.light .summary-item {
            background: #f9fbfd;
        }

        .summary-item:hover {
            transform: translateX(12px);
            border-color: var(--primary);
            box-shadow: 0 15px 30px rgba(105, 241, 31, .15);
        }

        .item-name {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .item-qty {
            font-size: 14px;
            color: var(--text-light);
        }

        .item-total {
            font-size: 22px;
            font-weight: 700;
            color: var(--primary);
        }

        .bill-details {
            margin-top: 35px;
            padding-top: 20px;
            border-top: 1px dashed var(--border);
        }

        .bill-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 0;
            font-size: 17px;
            transition: .3s;
        }

        .bill-row:hover {
            color: var(--primary);
            padding-left: 8px;
            letter-spacing: .4px;
        }

        .bill-row span:last-child {
            font-weight: 600;
        }

        .grand-total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 18px;
            padding-top: 22px;
            border-top: 2px solid var(--primary);
            font-size: 28px;
            font-weight: 700;
        }

        .grand-total-row span:last-child {
            font-size: 36px;
            color: var(--primary);
            text-shadow: 0 0 25px rgba(105, 241, 31, .45);
            animation: glowPrice 2s infinite;
        }

        @keyframes glowPrice {
            0% { transform: scale(1); }
            50% { transform: scale(1.06); }
            100% { transform: scale(1); }
        }

        /* Buttons & Interactions */
        .place-order-btn, .back-cart-btn, .browse-btn {
            display: inline-block;
            width: 100%;
            text-align: center;
            padding: 18px;
            border-radius: 18px;
            font-weight: 700;
            border: none;
            text-decoration: none;
            transition: .35s;
            margin-top: 16px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .place-order-btn {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            font-size: 18px;
        }

        .place-order-btn::before {
            content: "";
            position: absolute;
            left: -120%;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, .18);
            transform: skewX(-30deg);
            transition: .6s;
        }

        .place-order-btn:hover::before {
            left: 120%;
        }

        .place-order-btn:hover, .browse-btn:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 45px rgba(105, 241, 31, .35);
        }

        .place-order-btn:active {
            transform: scale(.97);
        }

        .back-cart-btn {
            background: transparent;
            color: var(--primary);
            border: 2px solid var(--primary);
        }

        .back-cart-btn:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-5px);
        }

        .empty-checkout {
            text-align: center;
            padding: 60px 24px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--border);
            border-radius: 24px;
            box-shadow: var(--shadow);
        }

        .empty-checkout h2 {
            margin-bottom: 12px;
        }

        .empty-checkout p {
            margin-bottom: 20px;
            color: var(--text-light);
        }

        .browse-btn {
            width: auto;
            padding: 16px 28px;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            border-radius: 14px;
        }

        /* Utilities */
        ::-webkit-scrollbar { width: 10px; }
        ::-webkit-scrollbar-track { background: var(--bg); }
        ::-webkit-scrollbar-thumb { 
            background: linear-gradient(var(--primary), var(--primary-dark)); 
            border-radius: 20px; 
        }

        ::selection { background: var(--primary); color: white; }
        input::placeholder, textarea::placeholder { color: var(--text-light); }

        /* Responsive Layout styles */
        @media (max-width: 960px) {
            .checkout-wrapper {
                grid-template-columns: 1fr;
            }

            .nav-links {
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                flex-direction: column;
                align-items: stretch;
                gap: 0;
                padding: 0.6rem 7%;
                background: rgba(12, 15, 20, 0.97);
                border: none;
                border-radius: 0;
                box-shadow: 0 12px 30px rgba(0, 0, 0, 0.35);
                display: none;
            }

            body.light .nav-links {
                background: rgba(255, 255, 255, 0.97);
            }

            .nav-links li {
                width: 100%;
            }

            .nav-links a {
                display: block;
                width: 100%;
                padding: 0.9rem 0;
            }

            .nav-links.open {
                display: flex;
            }

            .mobile-toggle {
    display: flex;
    background: none;
    border: none;
    color: var(--text);
    font-size: 1.6rem;
    cursor: pointer;
    padding: 4px;
}
        }

        @media (max-width: 700px) {
            body {
                padding-top: 84px;
            }

            .navbar {
                padding: 14px 5%;
            }

            .logo-text {
                font-size: 22px;
            }

            .checkout-heading {
                align-items: flex-start;
            }

            .checkout-heading h1 {
                font-size: 32px;
            }

            .delivery-highlight {
                min-width: 100%;
            }

            .checkout-box, .summary-box {
                padding: 20px;
                border-radius: 20px;
            }
            
            .grand-total-row {
    font-size: 20px;
}

.grand-total-row span:last-child {
    font-size: 26px;
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

        <li><a href="Checkout.jsp"  class="active">Checkout</a></li>

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
    <button class="mobile-toggle" onclick="toggleMobileMenu()" aria-label="Toggle menu">☰</button>

</nav>

    <div class="checkout-container">
        <div class="checkout-heading">
            <div>
                <p class="eyebrow">Fast & secure checkout</p>
                <h1>Checkout</h1>
                <p>Almost there! Complete your delivery details and enjoy your meal.</p>
            </div>
            <div class="delivery-highlight">
                <div class="delivery-icon"><i class="fa-solid fa-motorcycle"></i></div>
                <div>
                    <h3>Live delivery tracking</h3>
                    <p>Your order is prepared fresh and tracked until it reaches you.</p>
                </div>
            </div>
        </div>

        <%
            Cart cart = (Cart) session.getAttribute("cart");
            Integer restaurantId = (Integer) session.getAttribute("restaurantId");
            
            double grandTotal = 0;
            double deliveryFee = 40;
            double platformFee = 5;
            
            if (cart != null && !cart.getItems().isEmpty()) {
                for (CartItem item : cart.getItems().values()) {
                    grandTotal = grandTotal + item.getTotalPrice();
                }
                double finalAmount = grandTotal + deliveryFee + platformFee;
        %>

        <form action="checkout" method="post">
            <div class="checkout-wrapper">
                <!-- Left Column: Delivery Details -->
                <div class="checkout-box">
                    <h2 class="section-title">🚚 Delivery Details</h2>

                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" name="customerName" placeholder="John Doe" required>
                    </div>

                    <div class="form-group">
                        <label>Mobile Number</label>
                        <input type="text" name="mobileNumber" placeholder="+91 9876543210" required>
                    </div>

                    <div class="form-group">
                        <label>Delivery Address</label>
                        <textarea name="address" placeholder="House No, Street, Area, Landmark..." required></textarea>
                    </div>

                    <div class="form-group">
                        <label>Select Payment Method</label>
                        <select name="paymentMode" required>
                            <option value="">Choose Payment Method</option>
                            <option value="Cash On Delivery">💵 Cash On Delivery</option>
                            <option value="UPI">📱 UPI</option>
                            <option value="Debit Card">💳 Debit Card</option>
                            <option value="Credit Card">💳 Credit Card</option>
                            <option value="Net Banking">🏦 Net Banking</option>
                        </select>
                    </div>
                </div>

                <!-- Right Column: Order Summary & Bill Details -->
                <div class="summary-box">
                    <h2 class="section-title">🧾 Order Summary</h2>

                    <% for (CartItem item : cart.getItems().values()) { %>
                        <div class="summary-item">
                            <div>
                                <div class="item-name">🍔 <%= item.getName() %></div>
                                <div class="item-qty">Quantity : <%= item.getQuantity() %></div>
                            </div>
                            <div class="item-total">₹<%= item.getTotalPrice() %></div>
                        </div>
                    <% } %>

                    <div class="bill-details">
                        <div class="bill-row">
                            <span>Items Total</span>
                            <span>₹<%= grandTotal %></span>
                        </div>
                        <div class="bill-row">
                            <span>Delivery Fee</span>
                            <span>₹<%= deliveryFee %></span>
                        </div>
                        <div class="bill-row">
                            <span>Platform Fee</span>
                            <span>₹<%= platformFee %></span>
                        </div>
                        <div class="grand-total-row">
                            <span>Grand Total</span>
                            <span>₹<%= finalAmount %></span>
                        </div>
                    </div>

                    <% session.setAttribute("finalAmount", finalAmount); %>
                    <input type="hidden" name="restaurantId" value="<%= restaurantId %>">
                    <input type="hidden" name="totalAmount" value="<%= finalAmount %>">

                    <button class="place-order-btn" type="submit">🚀 Place Order</button>
                    <a href="Cart.jsp" class="back-cart-btn">← Back to Cart</a>
                </div>
            </div>
        </form>

        <% } else { %>
            <div class="empty-checkout">
                <h2>Your cart is empty</h2>
                <p>Please add food items before checkout.</p>
                <a class="browse-btn" href="callRestuarantServlet">Browse Restaurants</a>
            </div>
        <% } %>
    </div>

    <script>
        // ===================== THEME ======================
        function updateThemeIcon() {
            const btn = document.querySelector('.theme-btn');
            if (!btn) return;
            btn.classList.toggle('active', document.body.classList.contains('light'));
        }

        function toggleTheme() {
            document.body.classList.toggle('light');
            const isLight = document.body.classList.contains('light');
            localStorage.setItem('theme', isLight ? 'light' : 'dark');
            updateThemeIcon();
        }

        function toggleMobileMenu() {
            const links = document.getElementById('navLinks');
            const btn = document.querySelector('.mobile-toggle');
            if (links) {
                const isOpen = links.classList.toggle('open');
                if (btn) btn.textContent = isOpen ? '✕' : '☰';
            }
        }

        if (localStorage.getItem('theme') === 'light') {
            document.body.classList.add('light');
        }
        updateThemeIcon();

        document.querySelectorAll('.nav-links a').forEach(link => {
            link.addEventListener('click', () => {
                const nav = document.getElementById('navLinks');
                const btn = document.querySelector('.mobile-toggle');
                if (nav) nav.classList.remove('open');
                if (btn) btn.textContent = '☰';
            });
        });

        // ================= BUTTON LOADING =================
        const orderBtn = document.querySelector(".place-order-btn");
        if (orderBtn) {
            orderBtn.addEventListener("click", function() {
                this.innerHTML = "⏳ Placing Order...";
                this.style.pointerEvents = "none";
            });
        }

        // ================= CARD ANIMATION =================
        const cards = document.querySelectorAll(".summary-item");
        cards.forEach((card, index) => {
            card.style.opacity = "0";
            card.style.transform = "translateX(60px)";
            setTimeout(() => {
                card.style.transition = ".6s";
                card.style.opacity = "1";
                card.style.transform = "translateX(0)";
            }, index * 120);
        });

        // ================= FORM ANIMATION =================
        const inputs = document.querySelectorAll(".form-group");
        inputs.forEach((box, index) => {
            box.style.opacity = "0";
            box.style.transform = "translateY(30px)";
            setTimeout(() => {
                box.style.transition = ".6s";
                box.style.opacity = "1";
                box.style.transform = "translateY(0)";
            }, 150 + (index * 120));
        });
    </script>
    <script src="chatbot.js"></script>
</body>
</html>