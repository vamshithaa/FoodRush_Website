<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Forgot Password - FoodRush</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  <link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

  <link rel="stylesheet" href="style.css" />

  <style>
  .container{
    flex-direction: row-reverse;
  }

  @media(max-width:1100px){
    .container{
      flex-direction: column;
    }
  }

  .info-banner{
    background: rgba(105,241,31,0.12);
    color: #49c80c;
    padding: 12px 14px;
    border-radius: 8px;
    font-size: 13px;
    margin-bottom: 18px;
  }
</style>
</head>

<body>

  <video autoplay muted loop playsinline class="bg-video">
    <source src="images/food-video.mp4" type="video/mp4">
  </video>

  <div class="overlay"></div>

  <div class="container">

    <div class="left-section">
      <div class="logo-box">
        <img src="images/foodrush-logo.png" alt="FoodRush Logo">
      </div>

      <h1>
        Forgot your<br>
        <span>Password?</span>
      </h1>

      <p>
        No worries — enter your email and we'll send you
        a link to reset it.
      </p>
    </div>

    <div class="form-container">

      <h2>Reset Password</h2>

      <p class="subtitle">
        Enter the email linked to your <span>FoodRush</span> account
      </p>

      <%
        boolean sent = "true".equals(request.getParameter("sent"));
      %>
      <% if (sent) { %>
        <div class="info-banner">
          <i class="fa-solid fa-circle-check"></i>
          If that email is registered, a reset link has been sent. Check your inbox.
        </div>
      <% } %>

      <form action="ForgotPasswordServlet" method="post">

        <div class="input-box">
          <i class="fa-regular fa-envelope"></i>
          <input type="email" placeholder="Email" name="email" required>
        </div>

        <button type="submit" class="register-btn">
          Send Reset Link
        </button>

      </form>

      <p class="login-text">
        Remembered your password?
        <a href="Login.html">Sign In</a>
      </p>

    </div>

  </div>

</body>
</html>
