<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List,java.util.Map,com.tap.model.Order,com.tap.model.User,com.tap.model.Restuarant" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Orders - FoodRush Admin</title>

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
  --danger:#f15b5b;
}

body{background:var(--bg);color:var(--text);min-height:100vh;}

.admin-shell{display:flex;min-height:100vh;}

.sidebar{
  width:220px;
  background:var(--card);
  padding:24px 16px;
  display:flex;
  flex-direction:column;
  gap:8px;
}

.sidebar h2{
  color:var(--primary);
  font-size:20px;
  margin-bottom:24px;
  padding:0 8px;
}

.sidebar a{
  color:var(--text-light);
  text-decoration:none;
  padding:12px 14px;
  border-radius:8px;
  display:flex;
  align-items:center;
  gap:10px;
  font-size:14px;
  transition:0.2s;
}

.sidebar a:hover, .sidebar a.active{
  background:var(--secondary);
  color:var(--primary);
}

.sidebar a.logout{margin-top:auto;color:var(--danger);}

.main{flex:1;padding:32px 40px;}

.main h1{font-size:26px;margin-bottom:6px;}
.main .sub{color:var(--text-light);margin-bottom:28px;font-size:14px;}

.table-card{
  background:var(--card);
  border-radius:14px;
  border:1px solid var(--secondary);
  overflow:hidden;
}

.table-scroll{
  overflow-x:auto;
  -webkit-overflow-scrolling:touch;
}

table{width:100%;border-collapse:collapse;min-width:XXXpx;}

thead th{
  text-align:left;
  font-size:12px;
  text-transform:uppercase;
  letter-spacing:0.04em;
  color:var(--text-light);
  padding:16px 18px;
  border-bottom:1px solid var(--secondary);
}

tbody td{
  padding:16px 18px;
  font-size:14px;
  border-bottom:1px solid var(--secondary);
  vertical-align:middle;
}

tbody tr:last-child td{border-bottom:none;}
tbody tr:hover{background:rgba(255,255,255,0.02);}

.cust-name{font-weight:600;}
.cust-email{color:var(--text-light);font-size:12px;margin-top:2px;}

.status-select{
  background:var(--secondary);
  border:1px solid var(--secondary);
  color:var(--text);
  padding:8px 10px;
  border-radius:8px;
  font-size:13px;
  font-family:'Poppins',sans-serif;
  cursor:pointer;
  text-transform:capitalize;
}
.status-select:focus{outline:none;border-color:var(--primary);}

.empty-row td{text-align:center;color:var(--text-light);padding:40px;}

.hamburger{
  display:none;
  position:fixed;
  top:16px; left:16px;
  z-index:1001;
  width:42px; height:42px;
  background:var(--card);
  border:1px solid var(--secondary);
  border-radius:8px;
  color:var(--text);
  font-size:18px;
  align-items:center; justify-content:center;
  cursor:pointer;
}


.hamburger.hide{display:none;}

.sidebar-overlay{
  display:none;
  position:fixed; inset:0;
  background:rgba(0,0,0,0.5);
  z-index:999;
}

@media (max-width:768px){
  .hamburger{display:flex;}
  .sidebar{
    position:fixed;
    top:0; left:0;
    height:100vh;
    width:240px;
    z-index:1000;
    transform:translateX(-100%);
    transition:transform 0.25s ease;
  }
  .sidebar.open{transform:translateX(0);}
  .sidebar-overlay.open{display:block;}
  .main{padding:80px 16px 32px;}
}
</style>
</head>
<body>

<div class="admin-shell">
<button class="hamburger" id="hamburgerBtn"><i class="fa-solid fa-bars"></i></button>
  <div class="sidebar-overlay" id="sidebarOverlay"></div>
  <div class="sidebar" id="sidebar">
    <h2>FoodRush Admin</h2>
    <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa-solid fa-gauge"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/restaurants"><i class="fa-solid fa-store"></i> Restaurants</a>
    <a href="${pageContext.request.contextPath}/admin/orders" class="active"><i class="fa-solid fa-receipt"></i> Orders</a>
    <a href="${pageContext.request.contextPath}/admin/users"><i class="fa-solid fa-users"></i> Users</a>
    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
  </div>

  <div class="main">
    <h1>Orders</h1>
    <div class="sub">View all orders and update their delivery status</div>

    <div class="table-card">
      <div class="table-scroll">
      <table>
        <thead>
          <tr>
            <th>Order</th>
            <th>Customer</th>
            <th>Restaurant</th>
            <th>Date</th>
            <th>Amount</th>
            <th>Payment</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
<%
  List<Order> allOrders = (List<Order>) request.getAttribute("allOrders");
  Map<Integer, User> userMap = (Map<Integer, User>) request.getAttribute("userMap");
  Map<Integer, Restuarant> restaurantMap = (Map<Integer, Restuarant>) request.getAttribute("restaurantMap");

//must match the `status` ENUM('delivered','Not delivered','packed') column exactly
String[] statusOptions = { "Not delivered", "packed", "delivered", "Cancelled" };

  if (allOrders != null && !allOrders.isEmpty()) {
    for (Order o : allOrders) {
      User cust = userMap != null ? userMap.get(o.getUserId()) : null;
      Restuarant rest = restaurantMap != null ? restaurantMap.get(o.getRestuarantId()) : null;
      String custName = cust != null ? cust.getUserName() : ("User #" + o.getUserId());
      String custEmail = cust != null ? cust.getUserEmail() : "";
      String restName = rest != null ? rest.getResName() : ("Restaurant #" + o.getRestuarantId());
%>
            <tr>
              <td>#<%=o.getOrderId()%></td>
              <td>
                <div class="cust-name"><%=custName%></div>
                <div class="cust-email"><%=custEmail%></div>
              </td>
              <td><%=restName%></td>
              <td><%=o.getOrderDate()%></td>
              <td>&#8377;<%=String.format("%.2f", o.getTotalAmount())%></td>
              <td><%=o.getPaymentMethod()%></td>
              <td>
                <form method="post" action="${pageContext.request.contextPath}/admin/orders">
                  <input type="hidden" name="action" value="updateStatus">
                  <input type="hidden" name="orderId" value="<%=o.getOrderId()%>">
                  <select class="status-select" name="status" onchange="this.form.submit()">
<%
        for (String option : statusOptions) {
          String selected = option.equalsIgnoreCase(o.getStatus()) ? "selected" : "";
%>
                    <option value="<%=option%>" <%=selected%>><%=option%></option>
<%
        }
%>
                  </select>
                </form>
              </td>
            </tr>
<%
    }
  } else {
%>
            <tr class="empty-row">
              <td colspan="7">No orders yet.</td>
            </tr>
<%
  }
%>
        </tbody>
      </table>
      </div>
    </div>
  </div>

</div>
<script>
document.getElementById('hamburgerBtn').addEventListener('click', function(){
	  document.getElementById('sidebar').classList.toggle('open');
	  document.getElementById('sidebarOverlay').classList.toggle('open');
	  this.classList.toggle('hide');
	});
	document.getElementById('sidebarOverlay').addEventListener('click', function(){
	  document.getElementById('sidebar').classList.remove('open');
	  document.getElementById('sidebarOverlay').classList.remove('open');
	  document.getElementById('hamburgerBtn').classList.remove('hide');
	});
</script>
</body>
</html>