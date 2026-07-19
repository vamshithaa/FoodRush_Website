<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List,com.tap.model.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Users - FoodRush Admin</title>

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
.you-tag{
  display:inline-block;
  margin-left:8px;
  font-size:11px;
  color:var(--primary);
  border:1px solid var(--primary);
  border-radius:20px;
  padding:1px 8px;
}

.role-badge{
  display:inline-block;
  padding:4px 12px;
  border-radius:20px;
  font-size:12px;
  text-transform:capitalize;
}
.role-admin{background:rgba(105,241,31,0.15);color:var(--primary);}
.role-customer{background:rgba(176,183,195,0.15);color:var(--text-light);}
.role-restuarantOwner{background:rgba(255,193,7,0.15);color:#ffc107;}

.actions{display:flex;gap:8px;}

.btn{
  border:none;
  border-radius:8px;
  padding:8px 14px;
  font-size:12px;
  cursor:pointer;
  font-family:'Poppins',sans-serif;
  font-weight:500;
}

.btn-promote{background:var(--secondary);color:var(--primary);}
.btn-demote{background:var(--secondary);color:var(--text-light);}
.btn-delete{background:rgba(241,91,91,0.15);color:var(--danger);}
.btn:disabled{opacity:0.35;cursor:not-allowed;}

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
    <a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-receipt"></i> Orders</a>
    <a href="${pageContext.request.contextPath}/admin/users" class="active"><i class="fa-solid fa-users"></i> Users</a>
    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
  </div>

  <div class="main">
    <h1>Users</h1>
    <div class="sub">View all users, manage admin access, or remove accounts</div>

    <div class="table-card">
      <div class="table-scroll">
      <table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Address</th>
            <th>Role</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
<%
  List<User> allUsers = (List<User>) request.getAttribute("allUsers");
  User currentAdmin = (User) session.getAttribute("user");
  int currentAdminId = currentAdmin != null ? currentAdmin.getUserId() : -1;

  if (allUsers != null && !allUsers.isEmpty()) {
    for (User u : allUsers) {
      boolean isSelf = (u.getUserId() == currentAdminId);
      boolean isAdmin = "admin".equalsIgnoreCase(u.getRole());
      String roleClass = isAdmin ? "role-admin" : ("customer".equalsIgnoreCase(u.getRole()) ? "role-customer" : "role-restuarantOwner");
%>
            <tr>
              <td>
                <span class="cust-name"><%=u.getUserName()%></span>
<% if (isSelf) { %>
                <span class="you-tag">You</span>
<% } %>
              </td>
              <td><%=u.getUserEmail()%></td>
              <td><%=u.getUserAddress()%></td>
              <td><span class="role-badge <%=roleClass%>"><%=u.getRole()%></span></td>
              <td>
                <div class="actions">
                  <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                    <input type="hidden" name="userId" value="<%=u.getUserId()%>">
<% if (isAdmin) { %>
                    <input type="hidden" name="action" value="demote">
                    <button type="submit" class="btn btn-demote" <%=isSelf ? "disabled" : ""%>>Remove Admin</button>
<% } else { %>
                    <input type="hidden" name="action" value="promote">
                    <button type="submit" class="btn btn-promote" <%=isSelf ? "disabled" : ""%>>Make Admin</button>
<% } %>
                  </form>
                  <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;"
                        onsubmit="return confirm('Delete this user? This cannot be undone.');">
                    <input type="hidden" name="userId" value="<%=u.getUserId()%>">
                    <input type="hidden" name="action" value="delete">
                    <button type="submit" class="btn btn-delete" <%=isSelf ? "disabled" : ""%>>Delete</button>
                  </form>
                </div>
              </td>
            </tr>
<%
    }
  } else {
%>
            <tr class="empty-row">
              <td colspan="5">No users yet.</td>
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