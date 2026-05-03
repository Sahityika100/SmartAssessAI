<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
#calendar {
	max-width: 100%;
	margin-top: 10px;
}

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

	/* --- ADDED: top-nav layout fix for tablet --- */
	.top-nav {
		flex-wrap: wrap;
		gap: 10px;
	}
}

/* Mobile View */
@media ( max-width : 600px) {
	/* Optional: show top menu */
	.top-nav {
		flex-direction: column;
		align-items: flex-start;
	}

	.top-nav h1 {
		font-size: 20px;
	}

	.user-info {
		margin-top: 10px;
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
	}

	.table th, .table td {
		padding: 6px;
	}

	/* Calendar fix */
	#calendar {
		overflow-x: auto;
	}

	/* --- ADDED: table horizontal scroll on small screens --- */
	.table-wrapper {
		overflow-x: auto;
		-webkit-overflow-scrolling: touch;
	}

	/* --- ADDED: prevent card content overflow --- */
	.card {
		overflow: hidden;
		word-break: break-word;
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

	/* --- ADDED: shrink table text further on very small screens --- */
	.table {
		font-size: 11px;
	}

	.table th, .table td {
		padding: 5px 4px;
	}

	/* --- ADDED: compact status badge --- */
	.status-badge {
		font-size: 12px;
		padding: 3px 8px;
	}

	/* --- ADDED: shrink calendar controls --- */
	.fc .fc-toolbar-title {
		font-size: 14px !important;
	}

	.fc .fc-button {
		padding: 2px 6px !important;
		font-size: 11px !important;
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

	/* --- ADDED: ensure main content not hidden behind fixed sidebar --- */
	.main-content {
		width: 100%;
		box-sizing: border-box;
	}
}

/* --- ADDED: landscape phone fix --- */
@media ( max-width : 768px) and (orientation: landscape) {
	.sidebar {
		width: 220px;
	}

	.dashboard-grid {
		grid-template-columns: 1fr 1fr;
		gap: 10px;
	}

	.extra-grid {
		grid-template-columns: 1fr 1fr;
	}

	.stat-number {
		font-size: 20px;
	}
}

/* --- ADDED: FullCalendar responsive overrides for small screens --- */
@media ( max-width : 600px) {
	.fc .fc-toolbar {
		flex-direction: column;
		gap: 6px;
		align-items: flex-start;
	}

	.fc .fc-toolbar-title {
		font-size: 15px;
	}

	.fc .fc-daygrid-day-number {
		font-size: 11px;
	}

	.fc .fc-col-header-cell-cushion {
		font-size: 11px;
		padding: 2px;
	}

	.fc .fc-button {
		font-size: 12px;
		padding: 3px 7px;
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
				<a href="/admin/adb" class="active"><i class="fas fa-home"></i>
					Dashboard</a> <a href="/admin/addCourses"><i
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
				<button class="menu-toggle" onclick="toggleSidebar()">
					<i class="fas fa-bars"></i>
				</button>
				<h1>Admin Overview</h1>
				<div class="user-info">
					<span class="status-badge">${sessionScope.name}</span>
					<div class="profile-img"></div>
				</div>
			</header>

			<section class="dashboard-grid">
				<div class="card">
					<h3>Total Students</h3>
					<p class="stat-number">${nostuds}</p>
				</div>
				<div class="card">
					<h3>Courses</h3>
					<p class="stat-number">${nocourses}</p>
				</div>
				<div class="card">
					<h3>AI Tests Taken</h3>
					<p class="stat-number">${notest}</p>
				</div>
				<div class="card">
					<h3>Avg. Accuracy</h3>
					<p class="stat-number"><fmt:formatNumber value="${accuracy}" pattern="0.00"/>%</p>
				</div>
			</section>
			<section class="extra-grid">

				<!-- Top 3 Students -->
				<div class="card">
					<h3>Top Performers</h3>
					<!-- ADDED: table-wrapper div for horizontal scroll on small screens -->
					<div class="table-wrapper">
						<table class="table">
							<tr>
								<th>Name</th>
								<th>Percentage</th>
							</tr>

							<c:forEach var="s" items="${topStudents}">
								<tr>
									<td>${s[0]}</td>
									<td><fmt:formatNumber value="${s[1]}" pattern="0.00"/>%</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>

				<!-- Calendar -->
				<div class="card">
					<h3>Test Activity Calendar</h3>
					<div id="calendar"></div>
				</div>

			</section>
		</main>
	</div>
	<div id="overlay" class="overlay" onclick="toggleSidebar()"></div>
	<script>
document.addEventListener('DOMContentLoaded', function () {

    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',

        events: [
            <c:forEach var="t" items="${testPerDay}">
            {
                title: '${t.count} Tests',
                start: '${t.date}'
            },
            </c:forEach>
        ]
    });

    calendar.render();
});
function toggleSidebar() {
    document.getElementById("sidebar").classList.toggle("active");
    document.getElementById("overlay").classList.toggle("active");
}
</script>
</body>
</html>
