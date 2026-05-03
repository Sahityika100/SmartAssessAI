<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard | Smart Assess AI</title>

<link
	href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">
<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
:root {
	--primary: #6366f1;
	--primary-glow: rgba(99, 102, 241, 0.4);
	--secondary: #a855f7;
	--accent: #10b981;
	--background: #f8fafc;
	--sidebar: #0f172a;
	--card-bg: rgba(255, 255, 255, 0.8);
	--text-heading: #1e293b;
	--text-body: #64748b;
	--radius: 20px;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

body {
	font-family: 'Plus Jakarta Sans', sans-serif;
	background-color: var(--background);
	color: var(--text-heading);
	display: flex;
	min-height: 100vh;
}

/* --- Animated Sidebar --- */
.sidebar {
	width: 280px;
	background: var(--sidebar);
	height: 100vh;
	position: fixed;
	padding: 2rem 1.5rem;
	display: flex;
	flex-direction: column;
	z-index: 1000;
}

.logo-box {
	display: flex;
	align-items: center;
	gap: 12px;
	padding-bottom: 3rem;
}

.logo-icon {
	width: 42px;
	height: 42px;
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	border-radius: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	box-shadow: 0 10px 20px var(--primary-glow);
}

.nav-link {
	display: flex;
	align-items: center;
	gap: 14px;
	padding: 12px 16px;
	color: #94a3b8;
	text-decoration: none;
	border-radius: 14px;
	font-weight: 500;
	margin-bottom: 8px;
}

.nav-link:hover {
	background: rgba(255, 255, 255, 0.05);
	color: white;
	transform: translateX(5px);
}

.nav-link.active {
	background: var(--primary);
	color: white;
	box-shadow: 0 15px 30px -5px var(--primary-glow);
}

/* --- Main Content Area --- */
.content-wrapper {
	margin-left: 280px;
	padding: 3rem;
	width: 100%;
}

.header-flex {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 2.5rem;
}

.user-profile-trigger {
	display: flex;
	align-items: center;
	gap: 12px;
	background: white;
	padding: 8px 16px 8px 8px;
	border-radius: 50px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
	cursor: pointer;
}

.avatar {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	background: var(--primary);
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 800;
}

/* --- Stats/Info Section --- */
.overview-banner {
	background: linear-gradient(110deg, #1e293b 0%, #334155 100%);
	border-radius: var(--radius);
	padding: 2.5rem;
	color: white;
	margin-bottom: 2rem;
	display: flex;
	justify-content: space-between;
	align-items: center;
	position: relative;
	overflow: hidden;
	animation: slideUp 0.8s ease;
}

/* --- Grid System --- */
.grid-container {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
	gap: 1.5rem;
}

.glass-card {
	background: var(--card-bg);
	backdrop-filter: blur(12px);
	-webkit-backdrop-filter: blur(12px);
	border: 1px solid rgba(255, 255, 255, 0.6);
	padding: 2rem;
	border-radius: var(--radius);
	display: flex;
	flex-direction: column;
	gap: 1.5rem;
	animation: fadeIn 0.5s ease backwards;
}

.glass-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
	border-color: var(--primary);
}

.icon-circle {
	width: 54px;
	height: 54px;
	border-radius: 16px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.btn-modern {
	padding: 12px 24px;
	background: var(--text-heading);
	color: white;
	text-decoration: none;
	border-radius: 12px;
	font-weight: 600;
	font-size: 0.9rem;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
}

.btn-modern:hover {
	background: var(--primary);
	transform: scale(1.02);
}

/* --- Animations --- */
@
keyframes slideUp {from { opacity:0;
	transform: translateY(40px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}

/* --- Responsiveness --- */
@media ( max-width : 1024px) {
	.sidebar {
		width: 90px;
		padding: 1.5rem 0.5rem;
		align-items: center;
	}
	.logo-text, .nav-link span, .user-name-label {
		display: none;
	}
	.content-wrapper {
		margin-left: 90px;
		padding: 2rem;
	}
	.nav-link {
		justify-content: center;
		width: 50px;
		height: 50px;
	}
}

@media ( max-width : 768px) {
	.sidebar {
		width: 100%;
		height: 70px;
		flex-direction: row;
		bottom: 0;
		top: auto;
		padding: 0 1rem;
		justify-content: space-around;
	}
	.logo-box, .logout-item {
		display: none;
	}
	.content-wrapper {
		margin-left: 0;
		padding-bottom: 100px;
	}
	.nav-link {
		margin-bottom: 0;
	}
	.overview-banner {
		flex-direction: column;
		text-align: center;
		gap: 1rem;
	}
}
/* --- Table Styling (Professional + Responsive) --- */
.table-container {
    width: 100%;
    overflow-x: auto;
    animation: fadeIn 0.8s ease;
}

table {
    width: 100%;
    border-collapse: collapse;
    background: var(--card-bg);
    backdrop-filter: blur(10px);
    border-radius: var(--radius);
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
}

thead {
    background: linear-gradient(135deg, var(--primary), var(--secondary));
    color: white;
}

th {
    padding: 16px;
    text-align: left;
    font-size: 0.95rem;
    letter-spacing: 0.5px;
}

td {
    padding: 14px 16px;
    color: var(--text-body);
    font-weight: 500;
}

tr {
    border-bottom: 1px solid rgba(0,0,0,0.05);
    transition: all 0.3s ease;
}

/* Hover Effect */
tbody tr:hover {
    background: rgba(99, 102, 241, 0.08);
    transform: scale(1.01);
}

/* Alternate Row Color */
tbody tr:nth-child(even) {
    background: rgba(0,0,0,0.02);
}

/* Responsive Table */
@media (max-width: 768px) {
    table, thead, tbody, th, td, tr {
        display: block;
    }

    thead {
        display: none;
    }

    tr {
        margin-bottom: 15px;
        border-radius: var(--radius);
        background: white;
        padding: 10px;
    }

    td {
        display: flex;
        justify-content: space-between;
        padding: 10px;
        font-size: 0.9rem;
    }

    td::before {
        content: attr(data-label);
        font-weight: 700;
        color: var(--text-heading);
    }
}
</style>
</head>
<body>

	<nav class="sidebar">
		<div class="logo-box">
			<div class="logo-icon">
				<i data-lucide="cpu" color="white" size="24"></i>
			</div>
			<span class="logo-text"
				style="color: white; font-weight: 800; font-size: 1.5rem;">Smart
				Assess AI</span>
		</div>

		<div style="flex-grow: 1;">
			<a href="/smartai/sdb" class="nav-link"><i
				data-lucide="layout-grid"></i> <span>Dashboard</span></a> <a
				href="/courses/getCourses" class="nav-link"><i data-lucide="zap"></i>
				<span>AI Test</span></a> <a href="/courses/getCourses" class="nav-link"><i
				data-lucide="book-open"></i> <span>My Courses</span></a> <a
				href="/test/results" class="nav-link"><i
				data-lucide="line-chart"></i> <span>Results</span></a> <a
				href="/student/recommendations" class="nav-link active"><i
				data-lucide="sparkles"></i> <span>AI Feedback</span></a> <a
				href="/smartai/profile" class="nav-link"><i
				data-lucide="user-circle"></i> <span>Profile</span></a>
		</div>

		<div class="logout-item">
			<a href="/smartai/logout" class="nav-link" style="color: #fb7185;"><i
				data-lucide="log-out"></i> <span>Logout</span></a>
		</div>
	</nav>

	<main class="content-wrapper">
		<header class="header-flex">
			<div>
				<h2 style="font-weight: 800; font-size: 2rem;">	Your AI Feedback</h2>
				<p style="color: var(--text-body);">Welcome back, ready to
					master something new?</p>
			</div>

			<div class="user-profile-trigger">
				<div class="avatar">${sessionScope.name.substring(0,1)}</div>
				<span class="user-name-label" style="font-weight: 600;">${sessionScope.name}</span>
			</div>
		</header>
        <main>
  <div class="table-container">
    <table>
      <thead>
        <tr>
          <th>Course</th>
          <th>Feedback</th>
        </tr>
      </thead>

      <tbody>
        <c:forEach var="s" items="${feedback}">
          <tr>
            <td data-label="Course">${s.course}</td>
            <td data-label="Feedback">${s.feedback}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</main>
	<script>
		// Initialize Lucide Icons
		lucide.createIcons();
	</script>
</body>
</html>