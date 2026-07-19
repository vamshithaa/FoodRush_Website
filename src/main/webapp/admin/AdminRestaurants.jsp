<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List,com.tap.model.Restuarant" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Restaurants - FoodRush Admin</title>

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

.top-row{display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:28px;flex-wrap:wrap;gap:16px;}

.main h1{font-size:26px;margin-bottom:6px;}
.main .sub{color:var(--text-light);font-size:14px;}

.btn{
  border:none;
  border-radius:8px;
  padding:11px 20px;
  font-size:14px;
  font-weight:600;
  cursor:pointer;
  display:inline-flex;
  align-items:center;
  gap:8px;
  transition:0.2s;
}

.btn-primary{background:var(--primary);color:#0b0d12;}
.btn-primary:hover{background:var(--primary-dark);}

.btn-icon{
  background:transparent;
  border:1px solid var(--secondary);
  color:var(--text-light);
  width:34px;height:34px;
  border-radius:8px;
  display:inline-flex;align-items:center;justify-content:center;
  cursor:pointer;
  text-decoration:none;
}
.btn-icon:hover{border-color:var(--primary);color:var(--primary);}
.btn-icon.danger:hover{border-color:var(--danger);color:var(--danger);}

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

.res-name{font-weight:600;}
.res-img{width:44px;height:44px;border-radius:8px;object-fit:cover;background:var(--secondary);margin-right:12px;}
.res-cell{display:flex;align-items:center;}

.badge{
  padding:4px 10px;
  border-radius:20px;
  font-size:12px;
  font-weight:600;
}
.badge.active{background:rgba(105,241,31,0.12);color:var(--primary);}
.badge.inactive{background:rgba(241,91,91,0.12);color:var(--danger);}

.actions-cell{display:flex;gap:8px;}

.empty-row td{text-align:center;color:var(--text-light);padding:40px;}

/* Modal */
.modal-overlay{
  display:none;
  position:fixed;inset:0;
  background:rgba(0,0,0,0.6);
  align-items:center;justify-content:center;
  z-index:100;
}
.modal-overlay.open{display:flex;}

.modal{
  background:var(--card);
  border:1px solid var(--secondary);
  border-radius:14px;
  padding:28px;
  width:100%;
  max-width:460px;
  max-height:90vh;
  overflow-y:auto;
}

.modal h3{font-size:19px;margin-bottom:20px;}

.form-group{margin-bottom:16px;}
.form-group label{display:block;font-size:13px;color:var(--text-light);margin-bottom:6px;}

.form-group input[type=text],
.form-group input[type=number]{
  width:100%;
  background:var(--secondary);
  border:1px solid var(--secondary);
  color:var(--text);
  padding:11px 12px;
  border-radius:8px;
  font-size:14px;
}

.form-group input:focus{outline:none;border-color:var(--primary);}

.form-row{display:flex;gap:12px;}
.form-row .form-group{flex:1;}

.checkbox-row{display:flex;align-items:center;gap:10px;margin-bottom:20px;}
.checkbox-row input{width:16px;height:16px;accent-color:var(--primary);}
.checkbox-row label{font-size:13px;color:var(--text-light);}

.modal-actions{display:flex;justify-content:flex-end;gap:10px;margin-top:8px;}

.btn-secondary{background:transparent;border:1px solid var(--secondary);color:var(--text-light);}
.btn-secondary:hover{color:var(--text);}


@media (max-width:600px){
  .modal-overlay{padding:16px;}
  .modal{padding:20px;max-height:85vh;}
  .form-row{flex-direction:column;gap:0;}
}

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
    <a href="${pageContext.request.contextPath}/admin/restaurants" class="active"><i class="fa-solid fa-store"></i> Restaurants</a>
    <a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-receipt"></i> Orders</a>
    <a href="${pageContext.request.contextPath}/admin/users"><i class="fa-solid fa-users"></i> Users</a>
    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
  </div>

  <div class="main">
    <div class="top-row">
      <div>
        <h1>Restaurants</h1>
        <div class="sub">Manage all restaurants on the platform</div>
      </div>
      <button class="btn btn-primary" onclick="openAddModal()"><i class="fa-solid fa-plus"></i> Add Restaurant</button>
    </div>

   <div class="table-card">
      <div class="table-scroll">
      <table>
        <thead>
          <tr>
            <th>Restaurant</th>
            <th>Cuisine</th>
            <th>Delivery Time</th>
            <th>Address</th>
            <th>Rating</th>
            <th>Status</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
<%
  List<Restuarant> allRestuarants = (List<Restuarant>) request.getAttribute("allRestuarants");

  if (allRestuarants != null && !allRestuarants.isEmpty()) {
    for (Restuarant r : allRestuarants) {
    	String rawImgPath = r.getImagePath() == null ? "" : r.getImagePath();
    	String imgPath = rawImgPath.isEmpty() ? ""
    	        : (rawImgPath.startsWith("http://") || rawImgPath.startsWith("https://")
    	                ? rawImgPath
    	                : request.getContextPath() + "/" + rawImgPath);
      String statusClass = r.isActive() ? "active" : "inactive";
      String statusLabel = r.isActive() ? "Active" : "Inactive";
%>
            <tr>
              <td>
                <div class="res-cell">
                  <img class="res-img" src="<%=imgPath%>" onerror="this.style.visibility='hidden'">
                  <span class="res-name"><%=r.getResName()%></span>
                </div>
              </td>
              <td><%=r.getCuisineType()%></td>
              <td><%=r.getFormattedDeliveryTime()%></td>
              <td><%=r.getAddress()%></td>
              <td><i class="fa-solid fa-star" style="color:var(--primary);"></i> <%=r.getRating()%></td>
              <td>
                <span class="badge <%=statusClass%>"><%=statusLabel%></span>
              </td>
              <td>
                <div class="actions-cell">
                  <a href="<%=request.getContextPath()%>/admin/menu?restuarantId=<%=r.getRestuarantId()%>"
                     class="btn-icon" title="Manage Menu">
                    <i class="fa-solid fa-utensils"></i>
                  </a>
                  <a href="#" class="btn-icon" title="Edit"
                     onclick='openEditModal(<%=r.getRestuarantId()%>, "<%=r.getResName()%>", "<%=r.getCuisineType()%>", "<%=r.getAddress()%>", "<%=imgPath%>", <%=r.getRating()%>, <%=r.isActive()%>, "<%=r.getFormattedDeliveryTime()%>"); return false;'>
                    <i class="fa-solid fa-pen"></i>
                  </a>
                  <a href="<%=request.getContextPath()%>/admin/restaurants?action=delete&id=<%=r.getRestuarantId()%>"
                     class="btn-icon danger" title="Delete"
                     onclick="return confirm('Delete this restaurant? This cannot be undone.');">
                    <i class="fa-solid fa-trash"></i>
                  </a>
                </div>
              </td>
            </tr>
<%
    }
  } else {
%>
            <tr class="empty-row">
              <td colspan="7">No restaurants yet. Click "Add Restaurant" to create one.</td>
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

<!-- Add / Edit Modal -->
<div class="modal-overlay" id="restaurantModal">
  <div class="modal">
    <h3 id="modalTitle">Add Restaurant</h3>
    <form id="restaurantForm" method="post" action="${pageContext.request.contextPath}/admin/restaurants" enctype="multipart/form-data">
  <input type="hidden" name="action" id="formAction" value="add">
  <input type="hidden" name="restuarantId" id="restuarantId" value="">
  <input type="hidden" name="existingImagePath" id="existingImagePath" value="">

      <div class="form-group">
        <label>Restaurant Name</label>
        <input type="text" name="resName" id="resName" required>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Cuisine Type</label>
          <input type="text" name="cuisineType" id="cuisineType" required>
        </div>
        <div class="form-group">
          <label>Delivery Time (mins)</label>
          <input type="number" name="deliveryMinutes" id="deliveryMinutes" min="0" required>
        </div>
      </div>

      <div class="form-group">
        <label>Address</label>
        <input type="text" name="address" id="address" required>
      </div>

      <div class="form-group">
  <label>Restaurant Image</label>
  <input type="file" name="imageFile" id="imageFile" accept="image/png,image/jpeg,image/gif,image/webp" onchange="previewImage(this)">
  <img id="imagePreview" src="" alt="" style="display:none;margin-top:10px;max-width:160px;border-radius:8px;">
</div>

      <div class="form-row">
        <div class="form-group">
          <label>Rating</label>
          <input type="number" name="rating" id="rating" step="0.1" min="0" max="5" value="0">
        </div>
      </div>

      <div class="checkbox-row">
        <input type="checkbox" name="isActive" id="isActive" checked>
        <label for="isActive">Active (visible to customers)</label>
      </div>

      <div class="modal-actions">
        <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
        <button type="submit" class="btn btn-primary">Save Restaurant</button>
      </div>
    </form>
  </div>
</div>

<script>
var contextPath = "${pageContext.request.contextPath}";

function resolveImageUrl(imagePath){
  if(!imagePath) return '';
  if(imagePath.indexOf('http://') === 0 || imagePath.indexOf('https://') === 0) return imagePath;
  return contextPath + '/' + imagePath;
}

function showPreview(url){
  var preview = document.getElementById('imagePreview');
  if(url){
    preview.src = url;
    preview.style.display = 'block';
  } else {
    preview.src = '';
    preview.style.display = 'none';
  }
}

function previewImage(input){
  if(input.files && input.files[0]){
    var reader = new FileReader();
    reader.onload = function(e){ showPreview(e.target.result); };
    reader.readAsDataURL(input.files[0]);
  }
}

function openAddModal(){
  document.getElementById('modalTitle').innerText = 'Add Restaurant';
  document.getElementById('formAction').value = 'add';
  document.getElementById('restaurantForm').reset();
  document.getElementById('restuarantId').value = '';
  document.getElementById('existingImagePath').value = '';
  showPreview('');
  document.getElementById('restaurantModal').classList.add('open');
}

function parseMinutes(formatted){
  // formatted looks like "1h 20m" or "20 mins"
  if(!formatted) return 0;
  var h = 0, m = 0;
  var hMatch = formatted.match(/(\d+)h/);
  var mMatch = formatted.match(/(\d+)m/);
  if(hMatch) h = parseInt(hMatch[1], 10);
  if(mMatch) m = parseInt(mMatch[1], 10);
  return (h * 60) + m;
}

function openEditModal(id, resName, cuisineType, address, imagePath, rating, isActive, formattedDeliveryTime){
  document.getElementById('modalTitle').innerText = 'Edit Restaurant';
  document.getElementById('formAction').value = 'update';
  document.getElementById('restuarantId').value = id;
  document.getElementById('resName').value = resName;
  document.getElementById('cuisineType').value = cuisineType;
  document.getElementById('address').value = address;
  document.getElementById('existingImagePath').value = imagePath;
  document.getElementById('imageFile').value = '';
  showPreview(resolveImageUrl(imagePath));
  document.getElementById('rating').value = rating;
  document.getElementById('isActive').checked = isActive;
  document.getElementById('deliveryMinutes').value = parseMinutes(formattedDeliveryTime);
  document.getElementById('restaurantModal').classList.add('open');
}

function closeModal(){
  document.getElementById('restaurantModal').classList.remove('open');
}

<%
  Restuarant editRestuarant = (Restuarant) request.getAttribute("editRestuarant");
  if (editRestuarant != null) {
    String editImg = editRestuarant.getImagePath() == null ? "" : editRestuarant.getImagePath();
%>
openEditModal(
  <%=editRestuarant.getRestuarantId()%>,
  "<%=editRestuarant.getResName()%>",
  "<%=editRestuarant.getCuisineType()%>",
  "<%=editRestuarant.getAddress()%>",
  "<%=editImg%>",
  <%=editRestuarant.getRating()%>,
  <%=editRestuarant.isActive()%>,
  "<%=editRestuarant.getFormattedDeliveryTime()%>"
);
<%
  }
%>
</script>
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
