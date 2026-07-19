<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Reset Password - FoodRush</title>

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

  .error-banner{
    background: rgba(241,31,31,0.12);
    color: #e33a3a;
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
        <img src="images/foodrush-logo1.png" alt="FoodRush Logo">
      </div>

      <h1>
        Set a new<br>
        <span>Password</span>
      </h1>

      <p>
        Choose a strong password you haven't used before.
      </p>
    </div>

    <div class="form-container">

      <h2>Reset Password</h2>

      <%
        boolean invalid = Boolean.TRUE.equals(request.getAttribute("invalid"));
        String error = (String) request.getAttribute("error");
        String token = (String) request.getAttribute("token");
      %>

      <% if (invalid) { %>

        <p class="subtitle">
          This reset link is invalid or has expired.
        </p>

        <div class="error-banner">
          <i class="fa-solid fa-circle-exclamation"></i>
          Please request a new reset link to continue.
        </div>

        <p class="login-text">
          <a href="ForgotPasswordServlet">Request a new link</a>
        </p>

      <% } else { %>

        <p class="subtitle">
          Enter a new password for your <span>FoodRush</span> account
        </p>

        <% if (error != null) { %>
          <div class="error-banner">
            <i class="fa-solid fa-circle-exclamation"></i>
            <%= error %>
          </div>
        <% } %>

        <form action="ResetPasswordServlet" method="post">

          <input type="hidden" name="token" value="<%= token %>">

          <div class="input-box">
            <i class="fa-solid fa-lock"></i>
            <input type="password" placeholder="New Password" name="newPassword" minlength="6" required>
          </div>

          <div class="input-box">
            <i class="fa-solid fa-lock"></i>
            <input type="password" placeholder="Confirm New Password" name="confirmPassword" minlength="6" required>
          </div>

          <button type="submit" class="register-btn">
            Reset Password
          </button>

        </form>

      <% } %>

      <p class="login-text">
        Remembered your password?
        <a href="Login.html">Sign In</a>
      </p>

    </div>

  </div>

</body>
</html>
