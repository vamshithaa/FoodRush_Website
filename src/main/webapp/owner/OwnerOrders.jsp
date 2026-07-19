<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List,java.util.Map,com.tap.model.Order,com.tap.model.User,com.tap.model.Restuarant" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Orders - FoodRush Owner</title>

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

.topbar{
  display:flex;
  justify-content:space-between;
  align-items:center;
  padding:20px 32px;
  background:var(--card);
}
.topbar h2{ color:var(--primary); font-size:20px; }
.topbar-right{display:flex;align-items:center;gap:16px;}

.logout-btn{
  color:var(--text-light);
  text-decoration:none;
  font-size:14px;
  padding:8px 16px;
  border:1px solid var(--secondary);
  border-radius:8px;
  transition:0.2s;
}
.logout-btn:hover{ color:var(--text); border-color:var(--primary); }
@media (max-width:600px){
  .topbar{padding:14px 16px;flex-wrap:wrap;gap:10px;}
  .topbar h2{font-size:16px;}
  .topbar-right{gap:8px;flex-wrap:wrap;}
  .logout-btn{padding:6px 10px;font-size:12px;}
  .main{padding:20px 16px;}
}
.main{padding:40px 32px;}

.back-link{
  color:var(--text-light);
  text-decoration:none;
  font-size:13px;
  display:inline-flex;
  align-items:center;
  gap:6px;
  margin-bottom:20px;
}
.back-link:hover{color:var(--primary);}

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

table{width:100%;border-collapse:collapse;min-width:700px;}

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
</style>
</head>
<body>

<%
  Restuarant restuarant = (Restuarant) request.getAttribute("restuarant");
%>

<div class="topbar">
  <h2><i class="fa-solid fa-utensils"></i> FoodRush — Owner Panel</h2>
  <div class="topbar-right">
    <a href="${pageContext.request.contextPath}/owner/dashboard" class="logout-btn"><i class="fa-solid fa-gauge"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
  </div>
</div>

<div class="main">
  <a class="back-link" href="${pageContext.request.contextPath}/owner/dashboard"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>

  <h1>Orders<% if (restuarant != null) { %> — <%=restuarant.getResName()%><% } %></h1>
  <div class="sub">View incoming orders and update their delivery status</div>

  <div class="table-card">
    <div class="table-scroll">
    <table>
      <thead>
        <tr>
          <th>Order</th>
          <th>Customer</th>
          <th>Date</th>
          <th>Amount</th>
          <th>Payment</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
<%
  List<Order> myOrders = (List<Order>) request.getAttribute("myOrders");
  Map<Integer, User> userMap = (Map<Integer, User>) request.getAttribute("userMap");

  // must match the `status` ENUM('delivered','Not delivered','packed') column exactly
  String[] statusOptions = { "Not delivered", "packed", "delivered", "Cancelled" };

  if (myOrders != null && !myOrders.isEmpty()) {
    for (Order o : myOrders) {
      User cust = userMap != null ? userMap.get(o.getUserId()) : null;
      String custName = cust != null ? cust.getUserName() : ("User #" + o.getUserId());
      String custEmail = cust != null ? cust.getUserEmail() : "";
%>
        <tr>
          <td>#<%=o.getOrderId()%></td>
          <td>
            <div class="cust-name"><%=custName%></div>
            <div class="cust-email"><%=custEmail%></div>
          </td>
          <td><%=o.getOrderDate()%></td>
          <td>&#8377;<%=String.format("%.2f", o.getTotalAmount())%></td>
          <td><%=o.getPaymentMethod()%></td>
          <td>
            <form method="post" action="${pageContext.request.contextPath}/owner/orders">
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
          <td colspan="6">No orders yet.</td>
        </tr>
<%
  }
%>
      </tbody>
    </table>
  </div>
  </div>
</div>

</body>
</html>
