<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List,com.tap.model.Menu,com.tap.model.Restuarant" %>

<%!
	// Escapes a value so it's safe to place inside a double-quoted HTML attribute.
	private String escAttr(String value) {
		if (value == null) return "";
		return value.replace("&", "&amp;")
				.replace("\"", "&quot;")
				.replace("<", "&lt;")
				.replace(">", "&gt;");
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Menu - FoodRush Owner</title>

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
.main{padding:32px 40px;}

.back-link{
  color:var(--text-light);
  text-decoration:none;
  font-size:13px;
  display:inline-flex;
  align-items:center;
  gap:6px;
  margin-bottom:16px;
}
.back-link:hover{color:var(--primary);}

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

table{width:100%;border-collapse:collapse;min-width:480px;}

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

.item-name{font-weight:600;}
.item-img{width:44px;height:44px;border-radius:8px;object-fit:cover;background:var(--secondary);margin-right:12px;}
.item-cell{display:flex;align-items:center;}
.item-desc{color:var(--text-light);font-size:12px;margin-top:2px;max-width:220px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;}

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
.form-group input[type=number],
.form-group textarea{
  width:100%;
  background:var(--secondary);
  border:1px solid var(--secondary);
  color:var(--text);
  padding:11px 12px;
  border-radius:8px;
  font-size:14px;
  font-family:'Poppins',sans-serif;
  resize:vertical;
}

.form-group input:focus, .form-group textarea:focus{outline:none;border-color:var(--primary);}

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

</style>
</head>
<body>

<%
  Restuarant restuarant = (Restuarant) request.getAttribute("restuarant");
  int restuarantId = restuarant != null ? restuarant.getRestuarantId() : 0;
  String restuarantName = restuarant != null ? restuarant.getResName() : "";
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

  <div class="top-row">
    <div>
      <h1>Menu &ndash; <%=restuarantName%></h1>
      <div class="sub">Manage your restaurant's menu items</div>
    </div>
    <button class="btn btn-primary" onclick="openAddModal()"><i class="fa-solid fa-plus"></i> Add Menu Item</button>
  </div>

  <div class="table-card">
    <div class="table-scroll">
    <table>
      <thead>
        <tr>
          <th>Item</th>
          <th>Price</th>
          <th>Status</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
<%
  List<Menu> allMenu = (List<Menu>) request.getAttribute("allMenu");

  if (allMenu != null && !allMenu.isEmpty()) {
    for (Menu m : allMenu) {
    	String rawImgPath = m.getImagePath() == null ? "" : m.getImagePath();
    	String imgPath = rawImgPath.isEmpty() ? ""
    	        : (rawImgPath.startsWith("http://") || rawImgPath.startsWith("https://")
    	                ? rawImgPath
    	                : request.getContextPath() + "/" + rawImgPath);
      String desc = m.getDescription() == null ? "" : m.getDescription();
      String statusClass = m.getisAvailable() ? "active" : "inactive";
      String statusLabel = m.getisAvailable() ? "Available" : "Unavailable";
%>
          <tr>
            <td>
              <div class="item-cell">
                <img class="item-img" src="<%=imgPath%>" onerror="this.style.visibility='hidden'">
                <div>
                  <div class="item-name"><%=m.getItemName()%></div>
                  <div class="item-desc"><%=desc%></div>
                </div>
              </div>
            </td>
            <td>&#8377;<%=m.getPrice()%></td>
            <td>
              <span class="badge <%=statusClass%>"><%=statusLabel%></span>
            </td>
            <td>
              <div class="actions-cell">
                <a href="#" class="btn-icon edit-menu-btn" title="Edit"
                   data-id="<%=m.getMenuId()%>"
                   data-item-name="<%=escAttr(m.getItemName())%>"
                   data-description="<%=escAttr(desc)%>"
                   data-image-path="<%=escAttr(imgPath)%>"
                   data-price="<%=m.getPrice()%>"
                   data-available="<%=m.getisAvailable()%>">
                  <i class="fa-solid fa-pen"></i>
                </a>
                <a href="<%=request.getContextPath()%>/owner/menu?action=delete&id=<%=m.getMenuId()%>"
                   class="btn-icon danger" title="Delete"
                   onclick="return confirm('Delete this menu item? This cannot be undone.');">
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
            <td colspan="4">No menu items yet. Click "Add Menu Item" to create one.</td>
          </tr>
<%
  }
%>
      </tbody>
    </table>
    </div>
  </div>
</div>

<!-- Add / Edit Modal -->
<div class="modal-overlay" id="menuModal">
  <div class="modal">
    <h3 id="modalTitle">Add Menu Item</h3>
    <form id="menuForm" method="post" action="${pageContext.request.contextPath}/owner/menu" enctype="multipart/form-data">
  <input type="hidden" name="action" id="formAction" value="add">
  <input type="hidden" name="menuId" id="menuId" value="">
  <input type="hidden" name="existingImagePath" id="existingImagePath" value="">

      <div class="form-group">
        <label>Item Name</label>
        <input type="text" name="itemName" id="itemName" required>
      </div>

      <div class="form-group">
        <label>Description</label>
        <textarea name="description" id="description" rows="3"></textarea>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Price (&#8377;)</label>
          <input type="number" name="price" id="price" step="0.01" min="0" required>
        </div>
      </div>

      <div class="form-group">
  <label>Item Image</label>
  <input type="file" name="imageFile" id="imageFile" accept="image/png,image/jpeg,image/gif,image/webp" onchange="previewImage(this)">
  <img id="imagePreview" src="" alt="" style="display:none;margin-top:10px;max-width:160px;border-radius:8px;">
</div>

      <div class="checkbox-row">
        <input type="checkbox" name="isAvailable" id="isAvailable" checked>
        <label for="isAvailable">Available (visible to customers)</label>
      </div>

      <div class="modal-actions">
        <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
        <button type="submit" class="btn btn-primary">Save Item</button>
      </div>
    </form>
  </div>
</div>

<script>
var menuContextPath = "${pageContext.request.contextPath}";

function resolveImageUrl(imagePath){
  if(!imagePath) return '';
  if(imagePath.indexOf('http://') === 0 || imagePath.indexOf('https://') === 0) return imagePath;
  return menuContextPath + '/' + imagePath;
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
  document.getElementById('modalTitle').innerText = 'Add Menu Item';
  document.getElementById('formAction').value = 'add';
  document.getElementById('menuForm').reset();
  document.getElementById('menuId').value = '';
  document.getElementById('existingImagePath').value = '';
  showPreview('');
  document.getElementById('menuModal').classList.add('open');
}

function openEditModal(id, itemName, description, imagePath, price, isAvailable){
  document.getElementById('modalTitle').innerText = 'Edit Menu Item';
  document.getElementById('formAction').value = 'update';
  document.getElementById('menuId').value = id;
  document.getElementById('itemName').value = itemName;
  document.getElementById('description').value = description;
  document.getElementById('existingImagePath').value = imagePath;
  document.getElementById('imageFile').value = '';
  showPreview(resolveImageUrl(imagePath));
  document.getElementById('price').value = price;
  document.getElementById('isAvailable').checked = isAvailable;
  document.getElementById('menuModal').classList.add('open');
}

function closeModal(){
  document.getElementById('menuModal').classList.remove('open');
}

document.querySelectorAll('.edit-menu-btn').forEach(function(btn){
  btn.addEventListener('click', function(e){
    e.preventDefault();
    openEditModal(
      btn.dataset.id,
      btn.dataset.itemName,
      btn.dataset.description,
      btn.dataset.imagePath,
      btn.dataset.price,
      btn.dataset.available === 'true'
    );
  });
});

<%
  Menu editMenu = (Menu) request.getAttribute("editMenu");
  if (editMenu != null) {
%>
openEditModal(
  <%=editMenu.getMenuId()%>,
  "<%=escAttr(editMenu.getItemName())%>",
  "<%=escAttr(editMenu.getDescription())%>",
  "<%=escAttr(editMenu.getImagePath())%>",
  <%=editMenu.getPrice()%>,
  <%=editMenu.getisAvailable()%>
);
<%
  }
%>
</script>

</body>
</html>