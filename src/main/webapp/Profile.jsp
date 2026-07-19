<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.User" %>

<%
	// Protect this page - only logged in users can view their profile
	User loggedInUser = (User) session.getAttribute("user");
	if (loggedInUser == null) {
		response.sendRedirect("Login.html");
		return;
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Profile | FoodRush</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

html{
scroll-behavior:smooth;
max-width:100%;
overflow-x:hidden;
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
    --danger:#ff4d4d;

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

    width:100%;
    overflow-x:hidden;

    transition:.4s;

}

::-webkit-scrollbar{ width:10px; }
::-webkit-scrollbar-track{ background:var(--dark); }
::-webkit-scrollbar-thumb{ background:linear-gradient(var(--primary),#3ca812); border-radius:30px; }

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
}

.logo img{
    width:75px;
    transition:.35s;
}

.logo:hover img{
    transform:scale(1.08);
}

.nav-links{

    display:flex;
    list-style:none;
    gap:35px;
    align-items:center;

}

.nav-links li{ position:relative; }

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
    align-items:center;
    justify-content:center;
    width:40px;
    height:40px;
    margin-left:8px;
    background:none;
    border:none;
    border-radius:10px;
    font-size:1.5rem;
    cursor:pointer;
    color:var(--text);
    line-height:1;
    padding:0;
    flex-shrink:0;
}

/* Premium toggle */

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

body.light .theme-btn{ background:#d9dee6; }

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

body.light .theme-btn::before{ left:39px; }

.theme-btn i{ position:absolute; font-size:14px; }
.theme-btn .fa-sun{ left:12px; color:#f5b000; }
.theme-btn .fa-moon{ right:12px; color:white; }

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

.icon-btn:hover,
.icon-btn.active{

    transform:translateY(-5px);
    color:white;
    background:linear-gradient(135deg,var(--primary),var(--primary2));
    border-color:transparent;

}

/* ---------- PROFILE SECTION ---------- */

.profile-wrap{

    max-width:760px;
    margin:0 auto;
    padding:150px 20px 100px;
    position:relative;

}

.profile-wrap::before{

    content:"";
    position:absolute;
    width:500px;
    height:500px;
    background:radial-gradient(var(--primary),transparent 70%);
    opacity:.10;
    top:-60px;
    left:50%;
    transform:translateX(-50%);
    filter:blur(30px);
    z-index:0;

}

.profile-header{

    text-align:center;
    margin-bottom:40px;
    position:relative;
    z-index:1;

}

.profile-header .avatar{

    width:100px;
    height:100px;
    border-radius:50%;

    background:linear-gradient(135deg,var(--primary),var(--primary2));
    color:white;

    display:flex;
    align-items:center;
    justify-content:center;

    font-size:38px;
    font-weight:700;

    margin:0 auto 18px;

    box-shadow:0 15px 40px rgba(117,214,29,.35);
    border:4px solid var(--card);

}

.profile-header h5{

    color:var(--primary);
    font-size:14px;
    letter-spacing:1px;
    text-transform:uppercase;
    margin-bottom:10px;

}

.profile-header h1{
    font-size:32px;
    font-weight:800;
    margin-bottom:8px;
}

.profile-header p{
    color:var(--text2);
    font-size:15px;
}

.profile-card{

    background:var(--card);
    border:1px solid var(--border);
    border-radius:25px;

    padding:40px 45px;

    box-shadow:var(--shadow);

    position:relative;
    z-index:1;

}

.alert{

    display:flex;
    align-items:center;
    gap:10px;

    padding:14px 18px;
    border-radius:12px;

    margin-bottom:24px;

    font-size:14px;
    font-weight:500;

}

.alert-success{
    background:rgba(46,204,113,.12);
    color:var(--success);
    border:1px solid rgba(46,204,113,.35);
}

.alert-error{
    background:rgba(255,77,77,.12);
    color:var(--danger);
    border:1px solid rgba(255,77,77,.35);
}

.form-group{ margin-bottom:22px; }

.form-group label{

    display:block;
    margin-bottom:8px;

    font-size:13px;
    font-weight:600;
    letter-spacing:.3px;

    color:var(--text2);

}

.form-group label i{
    color:var(--primary);
    margin-right:6px;
    width:16px;
}

.form-group input,
.form-group textarea{

    width:100%;

    padding:14px 16px;

    border-radius:12px;
    border:1px solid var(--border);

    background:var(--card2);
    color:var(--text);

    font-size:16px;
    font-family:inherit;

    outline:none;

    transition:.25s;

}

.form-group input:focus,
.form-group textarea:focus{
    border-color:var(--primary);
    box-shadow:0 0 0 3px rgba(117,214,29,.15);
}

.form-group input:disabled{
    opacity:.6;
    cursor:not-allowed;
}

.form-group input,
.form-group textarea{
    max-width:100%;
    word-break:break-word;
}

.profile-header h1{
    word-break:break-word;
}

.form-group small{
    display:block;
    margin-top:6px;
    color:var(--text2);
    font-size:12px;
}

textarea{
    resize:vertical;
    min-height:80px;
}

.form-row{
    display:flex;
    gap:20px;
}

.form-row .form-group{ flex:1; }

.divider{
    border:none;
    border-top:1px solid var(--border);
    margin:32px 0;
}

.section-label{

    display:flex;
    align-items:center;
    gap:10px;

    font-size:13px;
    font-weight:700;
    letter-spacing:.5px;
    text-transform:uppercase;
    color:var(--primary);

    margin-bottom:20px;

}

.section-label::after{

    content:"";
    flex:1;
    height:1px;
    background:var(--border);

}

.save-btn{

    width:100%;

    padding:16px;

    border:none;
    border-radius:12px;

    background:linear-gradient(135deg,var(--primary),var(--primary2));
    color:white;

    font-size:16px;
    font-weight:700;

    cursor:pointer;

    display:flex;
    align-items:center;
    justify-content:center;
    gap:8px;

    transition:.3s;

}

.save-btn:hover{
    transform:scale(1.015);
    box-shadow:0 15px 35px rgba(117,214,29,.3);
}

/* ---------- RESPONSIVE ---------- */

@media(max-width:900px){

    .hamburger{
        display:flex;
    }

    .navbar{
        padding:16px 5%;
    }

    .nav-links{
        display:none;
        position:absolute;
        top:100%;
        left:0;
        right:0;
        flex-direction:column;
        align-items:flex-start;
        gap:0;
        background:rgba(12,15,20,.97);
        padding:0.6rem 7%;
        box-shadow:0 12px 30px rgba(0,0,0,.35);
    }

    body.light .nav-links{
        background:rgba(255,255,255,.97);
    }

    .nav-links.open{
        display:flex;
    }

    .nav-links li{
        width:100%;
    }

    .nav-links a{
        display:block;
        width:100%;
        padding:0.9rem 0;
    }

    .profile-header h1{
        font-size:28px;
    }

}

@media(max-width:600px){

    .profile-card{ padding:28px 24px; }

    .form-row{
        flex-direction:column;
        gap:0;
    }

    .profile-wrap{ padding:140px 16px 80px; }

    .right-nav{
        gap:10px;
    }

    .theme-btn{
        width:60px;
        height:34px;
    }

    .theme-btn::before{
        width:24px;
        height:24px;
    }

    body.light .theme-btn::before{ left:31px; }

    .icon-btn{
        width:42px;
        height:42px;
    }

}

@media(max-width:480px){

    .navbar{
        padding:14px 4%;
    }

    .logo img{
        width:55px;
    }

    .right-nav{
        gap:8px;
    }

    .theme-btn{
        width:54px;
        height:30px;
    }

    .theme-btn::before{
        width:22px;
        height:22px;
        left:4px;
    }

    body.light .theme-btn::before{ left:28px; }

    .icon-btn{
        width:36px;
        height:36px;
        font-size:14px;
    }

    .hamburger{
        width:34px;
        height:34px;
        font-size:1.3rem;
        margin-left:4px;
    }

}

@media(max-width:420px){

    .profile-header .avatar{
        width:84px;
        height:84px;
        font-size:32px;
    }

    .profile-header h1{
        font-size:24px;
    }

    .save-btn{
        font-size:15px;
        padding:14px;
    }

}

@media(max-width:380px){

    .navbar{
        padding:12px 4%;
    }

    .logo img{
        width:46px;
    }

    .right-nav{
        gap:6px;
    }

    .theme-btn{
        width:46px;
        height:26px;
    }

    .theme-btn::before{
        width:18px;
        height:18px;
        left:4px;
    }

    body.light .theme-btn::before{ left:24px; }

    .theme-btn i{ font-size:10px; }
    .theme-btn .fa-sun{ left:6px; }
    .theme-btn .fa-moon{ right:6px; }

    .icon-btn{
        width:32px;
        height:32px;
        font-size:12px;
    }

    .hamburger{
        width:30px;
        height:30px;
        font-size:1.15rem;
        margin-left:2px;
    }

    .profile-header h1{
        font-size:21px;
    }

    .profile-card{
        padding:22px 16px;
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
        <li><a href="Checkout.jsp">Checkout</a></li>
        <li><a href="MyFavoritesServlet">Favorites</a></li>
        <li><a href="MyOrdersServlet">My Orders</a></li>

    </ul>

    <div class="right-nav">

        <button class="theme-btn" onclick="toggleTheme()">
            <i class="fa-solid fa-sun"></i>
            <i class="fa-solid fa-moon"></i>
        </button>

        <a href="ProfileServlet" class="icon-btn active" title="My Profile">
            <i class="fa-solid fa-user"></i>
        </a>

        <a href="LogoutServlet" class="icon-btn" title="Logout" onclick="return confirm('Are you sure you want to logout?');">
            <i class="fa-solid fa-right-from-bracket"></i>
        </a>

    </div>

    <button class="hamburger" id="hamburgerBtn" aria-label="Toggle menu" aria-expanded="false">☰</button>

</nav>

<div class="profile-wrap">

    <div class="profile-header">
        <div class="avatar">
            <%= loggedInUser.getUserName() != null && loggedInUser.getUserName().length() > 0
                    ? String.valueOf(loggedInUser.getUserName().charAt(0)).toUpperCase()
                    : "?" %>
        </div>
        <h5>ACCOUNT SETTINGS</h5>
        <h1>My Profile</h1>
        <p>Manage your account information and preferences</p>
    </div>

    <div class="profile-card">

        <%
        	String success = request.getParameter("success");
        	String error = request.getParameter("error");

        	if ("true".equals(success)) {
        %>
        	<div class="alert alert-success">
        		<i class="fa-solid fa-circle-check"></i> Profile updated successfully!
        	</div>
        <%
        	} else if ("true".equals(error)) {
        %>
        	<div class="alert alert-error">
        		<i class="fa-solid fa-circle-exclamation"></i> Something went wrong. Please try again.
        	</div>
        <%
        	}
        %>

        <form action="ProfileServlet" method="post">

            <div class="section-label">Account Details</div>

            <div class="form-group">
                <label><i class="fa-solid fa-user"></i>Full Name</label>
                <input type="text" name="userName" value="<%= loggedInUser.getUserName() %>" required>
            </div>

            <div class="form-group">
                <label><i class="fa-solid fa-envelope"></i>Email Address</label>
                <input type="email" name="userEmail" value="<%= loggedInUser.getUserEmail() %>" required>
            </div>

            <div class="form-group">
                <label><i class="fa-solid fa-location-dot"></i>Delivery Address</label>
                <textarea name="userAddress" required><%= loggedInUser.getUserAddress() != null ? loggedInUser.getUserAddress() : "" %></textarea>
            </div>

            <hr class="divider">

            <div class="section-label">Change Password</div>

            <div class="form-row">

                <div class="form-group">
                    <label><i class="fa-solid fa-lock"></i>New Password</label>
                    <input type="password" name="newPassword" placeholder="Leave blank to keep current password">
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-lock"></i>Confirm Password</label>
                    <input type="password" name="confirmPassword" placeholder="Re-enter new password">
                </div>

            </div>

            <small style="display:block;margin:-10px 0 22px;">
                Only fill this in if you want to change your password.
            </small>

            <button type="submit" class="save-btn">
                <i class="fa-solid fa-floppy-disk"></i> Save Changes
            </button>

        </form>

    </div>

</div>

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
