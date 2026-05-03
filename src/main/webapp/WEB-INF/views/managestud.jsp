<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
.extra-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
	margin-top: 20px;
}

.table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
}

.table th, .table td {
	padding: 10px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

.table th {
	background-color: #f5f5f5;
}

/* ================= RESPONSIVE DESIGN ================= */

/* Tablet View */
@media ( max-width : 992px) {
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
	.dashboard-grid {
		grid-template-columns: 1fr 1fr;
		gap: 15px;
	}
	.extra-grid {
		grid-template-columns: 1fr;
	}

	/* ADDED: top-nav wrap on tablet */
	.top-nav {
		flex-wrap: wrap;
		gap: 10px;
	}

	/* ADDED: table font slightly smaller on tablet */
	.table {
		font-size: 13px;
	}
	.table th, .table td {
		padding: 8px;
	}
}

/* Mobile View */
@media ( max-width : 600px) {
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

	/* Cards full width */
	.dashboard-grid {
		grid-template-columns: 1fr;
	}
	.extra-grid {
		grid-template-columns: 1fr;
	}

	/* Table responsive */
	.table {
		font-size: 12px;
		min-width: 550px; /* ADDED: keeps columns readable inside scroll wrapper */
	}
	.table th, .table td {
		padding: 6px;
	}

	/* Calendar fix */
	#calendar {
		overflow-x: auto;
	}

	/* ADDED: card overflow guard */
	.card {
		overflow: hidden;
		word-break: break-word;
	}

	/* ADDED: status badge compact */
	.status-badge {
		font-size: 12px;
		padding: 3px 8px;
	}
}

/* Small Devices */
@media ( max-width : 400px) {
	.card {
		padding: 10px;
	}
	.stat-number {
		font-size: 18px;
	}
	h3 {
		font-size: 14px;
	}

	/* ADDED: tighter table on very small screens */
	.table {
		font-size: 11px;
		min-width: 480px;
	}
	.table th, .table td {
		padding: 5px 4px;
	}

	/* ADDED: shrink inline status pill */
	.table td span {
		font-size: 0.7rem !important;
		padding: 3px 7px !important;
	}
}

/* Hamburger button */
.menu-toggle {
	display: none;
	font-size: 20px;
	background: none;
	border: none;
	cursor: pointer;
	margin-bottom: 10px;
}

/* Mobile Sidebar Fix */
@media ( max-width : 600px) {
	.menu-toggle {
		display: block;
		margin-bottom: 0;
		margin-right: 6px;
	}
	.container {
		flex-direction: column;
	}

	/* Sidebar hidden by default */
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
	.main-content {
		padding: 15px;
		width: 100%;           /* ADDED */
		box-sizing: border-box; /* ADDED */
	}

	/* Overlay effect */
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
}

/* ADDED: landscape phone fix */
@media ( max-width : 768px) and (orientation: landscape) {
	.sidebar {
		width: 220px;
	}
	.table {
		font-size: 12px;
	}
	.table th, .table td {
		padding: 6px 8px;
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
				<a href="/admin/adb"><i class="fas fa-home"></i>
					Dashboard</a> <a href="/admin/addCourses"><i
					class="fas fa-plus-square"></i> Add Courses</a> <a href="/admin/manageStud" class="active"><i
					class="fas fa-user-graduate"></i> Manage Students</a> <a href="/admin/analytics"><i
					class="fas fa-chart-pie"></i> Analytics</a>
			</nav>

			<div class="sidebar-footer">
				<button class="logout-btn">
					<a href="/smartai/logout"><i class="fas fa-sign-out-alt"></i>
						Logout</a>
				</button>
			</div>
		</aside>

		<main class="main-content">
			<header class="top-nav">
				<button class="menu-toggle" onclick="toggleSidebar()">
					<i class="fas fa-bars"></i>
				</button>
				<h1>Manage Students</h1>
				<div class="user-info">
					<span class="status-badge">${sessionScope.name}</span>
					<div class="profile-img"></div>
				</div>
			</header>

			<div class="card">
				<h3>Student Performance</h3>

				<div style="overflow-x: auto;">
					<table class="table">
						<thead>
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Phone</th>
								<th>Email</th>
								<th>No. of Tests</th>
								<th>Percentage</th>
								<th>Status</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach var="student" items="${students}">
								<tr>
									<td>${student.id}</td>
									<td>${student.name}</td>
									<td>${student.phone}</td>
									<td>${student.email}</td>
									<td>${student.ntest}</td>
									<td><fmt:formatNumber value="${student.percentage}"
											maxFractionDigits="2" />%</td>
									<td><span
										style="padding: 5px 10px; border-radius: 10px; font-size: 0.8rem; background: #dcfce7; color: #16a34a;">
											Active </span></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</main>
	</div>

	<!-- ADDED: overlay div for mobile sidebar -->
	<div id="overlay" class="overlay" onclick="toggleSidebar()"></div>

	<!-- ADDED: sidebar toggle script -->
	<script type="text/javascript">
		function toggleSidebar() {
			document.getElementById("sidebar").classList.toggle("active");
			document.getElementById("overlay").classList.toggle("active");
		}
	</script>
</body>
</html>
