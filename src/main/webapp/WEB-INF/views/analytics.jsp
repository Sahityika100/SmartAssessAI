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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

	/* ADDED: top-nav wrap on tablet */
	.top-nav {
		flex-wrap: wrap;
		gap: 10px;
	}

	/* ADDED: charts slightly shorter on tablet */
	canvas {
		height: 220px !important;
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
	}
	.table th, .table td {
		padding: 6px;
	}

	/* Calendar fix */
	#calendar {
		overflow-x: auto;
	}

	/* ADDED: charts compact on mobile */
	canvas {
		height: 200px !important;
	}

	/* ADDED: card overflow guard */
	.card {
		overflow: hidden;
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

	/* ADDED: charts even shorter on very small screens */
	canvas {
		height: 180px !important;
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
		width: 100%;            /* ADDED */
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
	.dashboard-grid {
		grid-template-columns: 1fr 1fr;
		gap: 10px;
	}
	.extra-grid {
		grid-template-columns: 1fr 1fr;
	}
	canvas {
		height: 190px !important;
	}
}

.sidebar-footer {
	padding: 15px;
}

canvas {
	width: 100% !important;
	height: 250px !important;
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
					class="fas fa-plus-square"></i> Add Courses</a> <a href="/admin/manageStud"><i
					class="fas fa-user-graduate"></i> Manage Students</a> <a href="/admin/analytics" class="active"><i
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
				<h1>Analytics</h1>
				<div class="user-info">
					<span class="status-badge">${sessionScope.name}</span>
					<div class="profile-img"></div>
				</div>
			</header>

			<!-- ================= ANALYTICS CARDS ================= -->
			<section class="dashboard-grid">
				<div class="card">
					<h3>Total Tests</h3>
					<p class="stat-number">${notest}</p>
				</div>
				<div class="card">
					<h3>Pass Rate</h3>
					<p class="stat-number"><fmt:formatNumber value="${passRate}"
											maxFractionDigits="2" />%</p>
				</div>
				<div class="card">
					<h3>Avg Score</h3>
					<p class="stat-number">
						<fmt:formatNumber value="${accuracy}" pattern="0.00" />
						%
					</p>
				</div>
				<div class="card">
					<h3>Certificates Issued</h3>
					<p class="stat-number">${certCount}</p>
				</div>
			</section>

			<!-- ================= CHARTS ================= -->
			<section class="extra-grid">

				<div class="card">
					<h3>Score Distribution</h3>
					<!-- ADDED: chart-wrapper for overflow safety -->
					<div style="position: relative; width: 100%;">
						<canvas id="scoreChart"></canvas>
					</div>
				</div>

				<div class="card">
					<h3>Pass vs Fail</h3>
					<!-- ADDED: chart-wrapper for overflow safety -->
					<div style="position: relative; width: 100%;">
						<canvas id="passChart"></canvas>
					</div>
				</div>

			</section>

			<section class="extra-grid">

				<div class="card">
					<h3>Top Subjects</h3>
					<!-- ADDED: chart-wrapper for overflow safety -->
					<div style="position: relative; width: 100%;">
						<canvas id="subjectChart"></canvas>
					</div>
				</div>

			</section>

		</main>
	</div>

	<!-- ADDED: overlay div for mobile sidebar -->
	<div id="overlay" class="overlay" onclick="toggleSidebar()"></div>

	<script>
// ================= SCORE DISTRIBUTION =================
new Chart(document.getElementById("scoreChart"), {
    type: "bar",
    data: {
        labels: ["0-40", "40-60", "60-80", "80-100"],
        datasets: [{
            label: "Students",
            data: [${r1}, ${r2}, ${r3}, ${r4}]
        }]
    }
});

// ================= PASS FAIL =================
new Chart(document.getElementById("passChart"), {
    type: "pie",
    data: {
        labels: ["Pass", "Fail"],
        datasets: [{
            data: [${passCount}, ${failCount}]
        }]
    }
});

// ================= SUBJECT =================
new Chart(document.getElementById("subjectChart"), {
    type: "doughnut",
    data: {
        labels: [
            <c:forEach var="sub" items="${subjects}">
                '${sub.name}',
            </c:forEach>
        ],
        datasets: [{
            data: [
                <c:forEach var="sub" items="${subjects}">
                    ${sub.count},
                </c:forEach>
            ]
        }]
    }
});

// ADDED: sidebar toggle for mobile
function toggleSidebar() {
    document.getElementById("sidebar").classList.toggle("active");
    document.getElementById("overlay").classList.toggle("active");
}
</script>
</body>
</html>
