<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Set Up Your Restaurant - FoodRush</title>

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

body{
  background:var(--bg);
  color:var(--text);
  min-height:100vh;
  display:flex;
  align-items:center;
  justify-content:center;
  padding:30px;
}

.setup-card{
  background:var(--card);
  border-radius:20px;
  padding:36px;
  width:100%;
  max-width:480px;
}

.setup-card h1{
  font-size:22px;
  margin-bottom:6px;
  color:var(--primary);
}

.setup-card p{
  color:var(--text-light);
  font-size:13px;
  margin-bottom:26px;
}

.form-group{margin-bottom:16px;}
.form-group label{display:block;font-size:13px;color:var(--text-light);margin-bottom:6px;}

.form-group input[type=text],
.form-group input[type=number]{
  width:100%;
  padding:10px 12px;
  border-radius:8px;
  border:1px solid var(--secondary);
  background:var(--bg);
  color:var(--text);
  font-size:14px;
}
.form-group input:focus{outline:none;border-color:var(--primary);}

.form-row{display:flex;gap:12px;}
.form-row .form-group{flex:1;}

@media (max-width:600px){
  .form-row{flex-direction:column;gap:0;}
  body{padding:16px;}
}

.form-group input[type=file]{
  color:var(--text-light);
  font-size:13px;
}

.submit-btn{
  width:100%;
  margin-top:10px;
  padding:12px;
  border:none;
  border-radius:10px;
  background:var(--primary);
  color:#08210a;
  font-weight:600;
  font-size:14px;
  cursor:pointer;
}
.submit-btn:hover{background:var(--primary-dark);}
</style>
</head>
<body>

<div class="setup-card">
  <h1><i class="fa-solid fa-store"></i> Set Up Your Restaurant</h1>
  <p>Tell us a bit about your restaurant so customers can find you and place orders.</p>

  <form method="post" action="${pageContext.request.contextPath}/owner/restaurant" enctype="multipart/form-data">

    <div class="form-group">
      <label>Restaurant Name</label>
      <input type="text" name="resName" required>
    </div>

    <div class="form-row">
      <div class="form-group">
        <label>Cuisine Type</label>
        <input type="text" name="cuisineType" placeholder="e.g. North Indian" required>
      </div>
      <div class="form-group">
        <label>Avg. Delivery Time (minutes)</label>
        <input type="number" name="deliveryMinutes" min="0" value="30" required>
      </div>
    </div>

    <div class="form-group">
      <label>Address</label>
      <input type="text" name="address" required>
    </div>

    <div class="form-group">
      <label>Restaurant Image</label>
      <input type="file" name="imageFile" accept="image/png,image/jpeg,image/gif,image/webp">
    </div>

    <button type="submit" class="submit-btn">Create Restaurant</button>
  </form>
</div>

</body>
</html>