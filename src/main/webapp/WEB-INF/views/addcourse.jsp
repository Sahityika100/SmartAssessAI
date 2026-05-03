<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart Assess AI - Admin Dashboard</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/Style.css' />">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
</head>
<style>
.add-btn {
	padding: 10px 15px;
	background: #4CAF50;
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 5px;
}

.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
}

.modal-content {
	background: #fff;
	margin: 10% auto;
	padding: 20px;
	width: 400px;
	border-radius: 10px;
}

.close {
	float: right;
	font-size: 22px;
	cursor: pointer;
}

.modal input, .modal textarea {
	width: 100%;
	padding: 8px;
	margin: 10px 0;
}
/* Add Course Button */
.add-btn {
    padding: 10px 18px;
    background: linear-gradient(135deg, #4CAF50, #2ecc71);
    color: #fff;
    border: none;
    cursor: pointer;
    border-radius: 8px;
    font-weight: bold;
    transition: 0.3s;
}

.add-btn:hover {
    transform: scale(1.05);
    background: linear-gradient(135deg, #43a047, #27ae60);
}

/* Modal Background */
.modal {
    display: none;
    position: fixed;
    z-index: 999;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.6);
    backdrop-filter: blur(4px);
}

/* Modal Box */
.modal-content {
    background: #ffffff;
    margin: 8% auto;
    padding: 25px;
    width: 400px;
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    animation: fadeIn 0.4s ease;
}

/* Animation */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Close Button */
.close {
    float: right;
    font-size: 24px;
    font-weight: bold;
    cursor: pointer;
    color: #888;
}

.close:hover {
    color: #000;
}

/* Form Styling */
.modal-content h2 {
    margin-bottom: 15px;
    color: #333;
}

.modal-content label {
    font-weight: 600;
    color: #555;
    display: block;
    margin-top: 10px;
}

/* Input Fields */
.modal-content input,
.modal-content textarea {
    width: 100%;
    padding: 10px;
    margin-top: 6px;
    border-radius: 6px;
    border: 1px solid #ccc;
    transition: 0.3s;
    font-size: 14px;
}

/* Focus Effect */
.modal-content input:focus,
.modal-content textarea:focus {
    border-color: #4CAF50;
    outline: none;
    box-shadow: 0 0 5px rgba(76, 175, 80, 0.3);
}

/* Submit Button */
.modal-content button {
    width: 100%;
    margin-top: 15px;
    padding: 10px;
    background: linear-gradient(135deg, #4CAF50, #2ecc71);
    border: none;
    color: white;
    font-size: 16px;
    border-radius: 6px;
    cursor: pointer;
    transition: 0.3s;
}

.modal-content button:hover {
    background: linear-gradient(135deg, #43a047, #27ae60);
    transform: scale(1.02);
}
.delete{
  height : 40px;
  width : 100px;
  background: linear-gradient(135deg, #4CAF50, #2ecc71);
  border : none;
  font-size : 15px;
  border-radius:5px;
  cursor : pointer;
}
.delete:hover{
 background: linear-gradient(135deg, #43a047, #27ae60);
    transform: scale(1.02);
}

/* ================= RESPONSIVE DESIGN ================= */

/* Hamburger button - hidden on desktop */
.menu-toggle {
    display: none;
    font-size: 20px;
    background: none;
    border: none;
    cursor: pointer;
    margin-right: 10px;
}

/* Tablet View */
@media (max-width: 992px) {
    .container {
        display: flex;
        flex-direction: column;
    }
    .sidebar {
        width: 100%;
        height: auto;
        position: relative;
    }
    .menu {
        display: flex;
        flex-direction: column;
        padding: 10px 0;
    }
    .menu a {
        padding: 12px 20px;
        display: block;
        color: white;
        text-decoration: none;
    }
    .menu a:hover {
        background: rgba(255, 255, 255, 0.1);
    }
    .main-content {
        padding: 15px;
    }

    /* Modal slightly narrower on tablet */
    .modal-content {
        width: 85%;
        margin: 10% auto;
    }

    /* Table wrapper for horizontal scroll */
    .table-wrapper {
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
    }

    .top-nav {
        flex-wrap: wrap;
        gap: 10px;
    }
}

/* Mobile View */
@media (max-width: 600px) {
    /* Show hamburger */
    .menu-toggle {
        display: inline-block;
    }

    /* top-nav layout */
    .top-nav {
        flex-direction: row;
        align-items: center;
        flex-wrap: wrap;
        gap: 8px;
    }

    .top-nav h1 {
        font-size: 18px;
        flex: 1;
    }

    .user-info {
        margin-top: 0;
    }

    /* Sidebar slide-in */
    .sidebar {
        position: fixed;
        left: -250px;
        top: 0;
        width: 250px;
        height: 100vh;
        overflow-y: auto;
        background: #1e1e2f;
        transition: 0.3s;
        z-index: 1000;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }
    .sidebar.active {
        left: 0;
    }

    /* Overlay */
    .overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.4);
        z-index: 999;
    }
    .overlay.active {
        display: block;
    }

    .main-content {
        width: 100%;
        box-sizing: border-box;
        padding: 15px;
    }

    /* Modal full-width on mobile */
    .modal-content {
        width: 92%;
        margin: 15% auto;
        padding: 18px;
    }

    /* Table responsive */
    .table-wrapper {
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
    }

    .table {
        font-size: 12px;
        min-width: 400px; /* prevents columns collapsing too much */
    }

    .table th, .table td {
        padding: 7px 6px;
    }

    /* Delete button smaller */
    .delete {
        height: 34px;
        width: 80px;
        font-size: 13px;
    }

    /* Add button full width */
    .add-btn {
        width: 100%;
        text-align: center;
    }

    /* Card padding */
    .card {
        overflow: hidden;
        word-break: break-word;
    }
}

/* Very small devices */
@media (max-width: 400px) {
    .top-nav h1 {
        font-size: 15px;
    }

    .modal-content {
        width: 95%;
        padding: 14px;
    }

    .modal-content h2 {
        font-size: 16px;
    }

    .modal-content input,
    .modal-content textarea {
        font-size: 13px;
        padding: 8px;
    }

    .modal-content button {
        font-size: 14px;
        padding: 9px;
    }

    .table {
        font-size: 11px;
    }

    .table th, .table td {
        padding: 5px 4px;
    }

    .delete {
        height: 30px;
        width: 70px;
        font-size: 12px;
    }

    .status-badge {
        font-size: 12px;
        padding: 3px 8px;
    }
}

/* Landscape phone fix */
@media (max-width: 768px) and (orientation: landscape) {
    .modal-content {
        margin: 4% auto;
        width: 70%;
    }

    .sidebar {
        width: 220px;
    }
}

.sidebar-footer {
    padding: 15px;
}
</style>
<body>

	<div class="container">
		<aside class="sidebar" id="sidebar">
			<div class="logo">
				<h2>
					Smart<span>Assess</span>
				</h2>
			</div>

			<nav class="menu">
				<a href="/admin/adb"><i class="fas fa-home"></i> Dashboard</a> <a
					href="/admin/addCourses" class="active"><i
					class="fas fa-plus-square"></i> Add Courses</a> <a href="/admin/manageStud"><i
					class="fas fa-user-graduate"></i> Manage Students</a> <a href="/admin/analytics"><i
					class="fas fa-chart-pie"></i> Analytics</a>
			</nav>

			<div class="sidebar-footer">
				<button class="logout-btn">
					<a href="/smartai/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
				</button>
			</div>
		</aside>

		<main class="main-content">
			<header class="top-nav">
				<!-- ADDED: hamburger toggle for mobile -->
				<button class="menu-toggle" onclick="toggleSidebar()">
					<i class="fas fa-bars"></i>
				</button>
				<h1>Add Courses</h1>
				<div class="user-info">
					<span class="status-badge">${sessionScope.name}</span>
					<div class="profile-img"></div>
				</div>
			</header>

			<div style="margin-top: 20px;">
				<button class="add-btn" onclick="openModal()">
					<i class="fas fa-plus"></i> Add Course
				</button>
			</div><br>
			<!-- Modal -->
			<div id="courseModal" class="modal">
				<div class="modal-content">
					<span class="close" onclick="closeModal()">&times;</span>
					<h2>Add Course</h2>

					<form action="/admin/saveCourse" method="post">
						<label>Course Name</label> <input type="text" name="courseName"
							required> <label>Description</label>
						<textarea name="description" required></textarea>

						<button type="submit">Save</button>
					</form>
				</div>
			</div>
			<div class="card">
				<h3>All Courses</h3>
				<!-- ADDED: table-wrapper for horizontal scroll on small screens -->
				<div class="table-wrapper">
					<table class="table">
						<tr>
							<th>ID  </th>
							<th>Name</th>
							<th>Description</th>
							<th>Action</th>
						</tr>

						<c:forEach var="c" items="${courses}">
							<tr>
								<td>${c.id}</td>
								<td>${c.courseName}</td>
								<td>${c.description}</td>
								<td>
								  <button class="delete"><a href="/admin/delCourse/${c.id}">Delete<a></button>
								</td>
							</tr>
						</c:forEach>

					</table>
				</div>
			</div>
		</main>
	</div>
	<!-- ADDED: overlay for sidebar close on mobile -->
	<div id="overlay" class="overlay" onclick="toggleSidebar()"></div>

	<script type="text/javascript">
		function openModal() {
			document.getElementById("courseModal").style.display = "block";
		}

		function closeModal() {
			document.getElementById("courseModal").style.display = "none";
		}

		// close when clicking outside
		window.onclick = function(event) {
			let modal = document.getElementById("courseModal");
			if (event.target == modal) {
				modal.style.display = "none";
			}
		}

		// ADDED: sidebar toggle for mobile
		function toggleSidebar() {
			document.getElementById("sidebar").classList.toggle("active");
			document.getElementById("overlay").classList.toggle("active");
		}
	</script>
</body>
</html>
