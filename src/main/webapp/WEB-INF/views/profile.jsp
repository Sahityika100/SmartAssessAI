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
}

.glass-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
	border-color: var(--primary);
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
	border: none;
	cursor: pointer;
}

.btn-modern:hover {
	background: var(--primary);
	transform: scale(1.02);
}

/* ========================================
   PROFILE CARD — NEW ANIMATED STYLES
   ======================================== */
.profile-wrapper {
	animation: profileReveal 0.7s cubic-bezier(0.22, 1, 0.36, 1) both;
}

@
keyframes profileReveal {from { opacity:0;
	transform: translateY(36px) scale(0.97);
}

to {
	opacity: 1;
	transform: translateY(0) scale(1);
}

}
.profile-card {
	flex-direction: row;
	align-items: center;
	gap: 2.5rem;
	position: relative;
	overflow: hidden;
}

/* Subtle animated gradient shimmer in background */
.profile-card::before {
	content: '';
	position: absolute;
	inset: 0;
	background: linear-gradient(120deg, rgba(99, 102, 241, 0.04) 0%,
		rgba(168, 85, 247, 0.06) 50%, rgba(16, 185, 129, 0.04) 100%);
	background-size: 200% 200%;
	animation: shimmerBg 6s ease infinite;
	border-radius: var(--radius);
	pointer-events: none;
}

@
keyframes shimmerBg { 0% {
	background-position: 0% 50%;
}

50




%
{
background-position




:




100


%
50


%;
}
100




%
{
background-position




:




0


%
50


%;
}
}

/* Avatar container with ring animation */
.avatar-container {
	flex-shrink: 0;
	position: relative;
	animation: avatarPop 0.6s cubic-bezier(0.34, 1.56, 0.64, 1) 0.2s both;
}

@
keyframes avatarPop {from { opacity:0;
	transform: scale(0.6) rotate(-6deg);
}

to {
	opacity: 1;
	transform: scale(1) rotate(0deg);
}

}
.avatar-ring {
	width: 130px;
	height: 130px;
	border-radius: 22px;
	padding: 3px;
	background: linear-gradient(135deg, var(--primary), var(--secondary),
		var(--accent));
	background-size: 300% 300%;
	animation: ringRotate 4s linear infinite;
}

@
keyframes ringRotate { 0% {
	background-position: 0% 50%;
}

50




%
{
background-position




:




100


%
50


%;
}
100




%
{
background-position




:




0


%
50


%;
}
}
.avatar-ring img {
	width: 100%;
	height: 100%;
	border-radius: 20px;
	object-fit: cover;
	display: block;
	background: white;
}

/* Online indicator dot */
.online-dot {
	position: absolute;
	bottom: 6px;
	right: 6px;
	width: 14px;
	height: 14px;
	background: var(--accent);
	border-radius: 50%;
	border: 2px solid white;
	animation: pulse 2s ease-in-out infinite;
}

@
keyframes pulse { 0%, 100% {
	box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.5);
}

50




%
{
box-shadow




:




0




0




0




6px




rgba


(




16
,
185
,
129
,
0




)


;
}
}

/* Profile info with staggered reveal */
.profile-info {
	flex-grow: 1;
	animation: slideRight 0.6s cubic-bezier(0.22, 1, 0.36, 1) 0.15s both;
}

@
keyframes slideRight {from { opacity:0;
	transform: translateX(-20px);
}

to {
	opacity: 1;
	transform: translateX(0);
}

}
.profile-name {
	font-size: 1.75rem;
	font-weight: 800;
	color: var(--text-heading);
	margin-bottom: 6px;
	letter-spacing: -0.5px;
}

.profile-role-badge {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	background: linear-gradient(135deg, rgba(99, 102, 241, 0.12),
		rgba(168, 85, 247, 0.12));
	color: var(--primary);
	font-size: 0.78rem;
	font-weight: 700;
	padding: 4px 12px;
	border-radius: 20px;
	border: 1px solid rgba(99, 102, 241, 0.2);
	margin-bottom: 1.2rem;
	text-transform: uppercase;
	letter-spacing: 0.8px;
}

.profile-detail-row {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 8px 0;
	border-bottom: 1px solid rgba(100, 116, 139, 0.08);
	color: var(--text-body);
	font-size: 0.92rem;
}

.profile-detail-row:last-child {
	border-bottom: none;
}

.detail-icon {
	width: 32px;
	height: 32px;
	border-radius: 8px;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-shrink: 0;
}

.detail-label {
	font-weight: 600;
	color: var(--text-heading);
	min-width: 55px;
}

.detail-value {
	color: var(--text-body);
}

/* Edit button area */
.edit-area {
	animation: slideLeft 0.6s cubic-bezier(0.22, 1, 0.36, 1) 0.3s both;
}

@
keyframes slideLeft {from { opacity:0;
	transform: translateX(20px);
}

to {
	opacity: 1;
	transform: translateX(0);
}

}
.btn-edit {
	padding: 13px 26px;
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	color: white;
	border: none;
	border-radius: 14px;
	font-weight: 700;
	font-size: 0.9rem;
	display: flex;
	align-items: center;
	gap: 8px;
	cursor: pointer;
	box-shadow: 0 8px 20px var(--primary-glow);
	font-family: 'Plus Jakarta Sans', sans-serif;
}

.btn-edit:hover {
	transform: translateY(-3px) scale(1.04);
	box-shadow: 0 14px 30px var(--primary-glow);
}

.btn-edit:active {
	transform: scale(0.97);
}

/* ========================================
   MODAL — ANIMATED POPUP
   ======================================== */
.modal-overlay {
	position: fixed;
	inset: 0;
	background: rgba(15, 23, 42, 0.6);
	backdrop-filter: blur(6px);
	-webkit-backdrop-filter: blur(6px);
	z-index: 2000;
	display: flex;
	align-items: center;
	justify-content: center;
	opacity: 0;
	pointer-events: none;
	transition: opacity 0.3s ease;
}

.modal-overlay.open {
	opacity: 1;
	pointer-events: all;
}

.modal-box {
	background: white;
	border-radius: 24px;
	padding: 2.5rem;
	width: 100%;
	max-width: 460px;
	box-shadow: 0 40px 80px rgba(0, 0, 0, 0.2);
	transform: translateY(30px) scale(0.95);
	transition: transform 0.4s cubic-bezier(0.34, 1.56, 0.64, 1), opacity
		0.3s ease;
	opacity: 0;
	position: relative;
}

.modal-overlay.open .modal-box {
	transform: translateY(0) scale(1);
	opacity: 1;
}

.modal-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 2rem;
}

.modal-title {
	font-size: 1.4rem;
	font-weight: 800;
	color: var(--text-heading);
	letter-spacing: -0.4px;
}

.modal-close {
	width: 36px;
	height: 36px;
	border-radius: 10px;
	border: none;
	background: #f1f5f9;
	color: var(--text-body);
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	font-size: 1rem;
}

.modal-close:hover {
	background: #fee2e2;
	color: #ef4444;
	transform: rotate(90deg);
}

/* Form fields */
.form-group {
	margin-bottom: 1.2rem;
}

.form-label {
	display: block;
	font-size: 0.8rem;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 0.7px;
	color: var(--text-body);
	margin-bottom: 6px;
}

.form-input {
	width: 100%;
	padding: 12px 16px;
	border: 2px solid #e2e8f0;
	border-radius: 12px;
	font-family: 'Plus Jakarta Sans', sans-serif;
	font-size: 0.95rem;
	color: var(--text-heading);
	outline: none;
	background: #f8fafc;
	transition: border-color 0.2s, box-shadow 0.2s, background 0.2s;
}

.form-input:focus {
	border-color: var(--primary);
	box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.12);
	background: white;
}

/* Input icon wrapper */
.input-icon-wrap {
	position: relative;
}

.input-icon-wrap .input-icon {
	position: absolute;
	left: 14px;
	top: 50%;
	transform: translateY(-50%);
	color: #94a3b8;
	pointer-events: none;
}

.input-icon-wrap .form-input {
	padding-left: 42px;
}

/* Form buttons */
.form-actions {
	display: flex;
	gap: 12px;
	margin-top: 1.8rem;
}

.btn-save {
	flex: 1;
	padding: 13px;
	background: linear-gradient(135deg, var(--primary), var(--secondary));
	color: white;
	border: none;
	border-radius: 12px;
	font-weight: 700;
	font-size: 0.95rem;
	cursor: pointer;
	font-family: 'Plus Jakarta Sans', sans-serif;
	box-shadow: 0 8px 20px var(--primary-glow);
}

.btn-save:hover {
	transform: translateY(-2px);
	box-shadow: 0 12px 28px var(--primary-glow);
}

.btn-cancel {
	padding: 13px 20px;
	background: #f1f5f9;
	color: var(--text-body);
	border: none;
	border-radius: 12px;
	font-weight: 600;
	font-size: 0.95rem;
	cursor: pointer;
	font-family: 'Plus Jakarta Sans', sans-serif;
}

.btn-cancel:hover {
	background: #fee2e2;
	color: #ef4444;
}

/* Divider line in modal */
.modal-divider {
	height: 1px;
	background: #f1f5f9;
	margin-bottom: 1.5rem;
}

/* ========================================
   RESPONSIVENESS (unchanged from original)
   ======================================== */
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
	.profile-card {
		flex-direction: column;
		text-align: center;
	}
	.profile-detail-row {
		justify-content: center;
	}
	.edit-area {
		width: 100%;
	}
	.btn-edit {
		width: 100%;
		justify-content: center;
	}
}

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
/* --- Delete Button --- */
.btn-delete {
	padding: 12px 24px;
	background: linear-gradient(135deg, #ef4444, #dc2626);
	color: white;
	border: none;
	border-radius: 12px;
	font-weight: 700;
	font-size: 0.9rem;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	cursor: pointer;
	box-shadow: 0 8px 20px rgba(239, 68, 68, 0.4);
}

.btn-delete:hover {
	transform: translateY(-2px) scale(1.03);
	box-shadow: 0 12px 28px rgba(239, 68, 68, 0.5);
}

/* --- Delete Button --- */
.btn-delete {
	padding: 12px 24px;
	background: linear-gradient(135deg, #ef4444, #dc2626);
	color: white;
	border: none;
	border-radius: 12px;
	font-weight: 700;
	font-size: 0.9rem;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	cursor: pointer;
	box-shadow: 0 8px 20px rgba(239, 68, 68, 0.4);
}

.btn-delete:hover {
	transform: translateY(-2px) scale(1.03);
	box-shadow: 0 12px 28px rgba(239, 68, 68, 0.5);
}
/* Improve modal text */
.modal-box p {
	margin-top: 10px;
}

/* Make buttons same height */
.form-actions button {
	height: 45px;
}

/* Better cancel button */
.btn-cancel {
	padding: 12px 20px;
	background: #f1f5f9;
	color: var(--text-body);
	border: none;
	border-radius: 12px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s ease;
}

.btn-cancel:hover {
	background: #fee2e2;
	color: #ef4444;
	transform: translateY(-1px);
}
</style>
</head>

<body>

	<!-- ================= SIDEBAR ================= -->
	<nav class="sidebar">
		<div class="logo-box">
			<div class="logo-icon">
				<i data-lucide="cpu" color="white" size="24"></i>
			</div>
			<span class="logo-text"
				style="color: white; font-weight: 800; font-size: 1.5rem;">
				Smart Assess AI </span>
		</div>

		<div style="flex-grow: 1;">
			<a href="/smartai/sdb" class="nav-link"><i
				data-lucide="layout-grid"></i> <span>Dashboard</span></a> <a
				href="/courses/getCourses" class="nav-link"><i data-lucide="zap"></i>
				<span>AI Test</span></a> <a href="/courses/getCourses" class="nav-link"><i
				data-lucide="book-open"></i> <span>My Courses</span></a> <a
				href="/test/results" class="nav-link"><i
				data-lucide="line-chart"></i> <span>Results</span></a> <a
				href="/smartai/recommendations" class="nav-link"><i
				data-lucide="sparkles"></i> <span>AI Feedback</span></a> <a
				href="/smartai/profile" class="nav-link active"><i
				data-lucide="user-circle"></i> <span>Profile</span></a>
		</div>

		<div class="logout-item">
			<a href="/smartai/logout" class="nav-link" style="color: #fb7185;">
				<i data-lucide="log-out"></i> <span>Logout</span>
			</a>
		</div>
	</nav>

	<!-- ================= MAIN ================= -->
	<main class="content-wrapper">
		<div class="profile-wrapper">
			<div class="glass-card profile-card">

				<div class="avatar-container">
					<div class="avatar-ring">
						<img src="/images/img.webp" alt="Profile">
					</div>
					<span class="online-dot"></span>
				</div>

				<div class="profile-info">
					<h2 class="profile-name">${student.name}</h2>

					<span class="profile-role-badge"> <i
						data-lucide="shield-check" size="12"></i> Student
					</span>

					<div class="profile-detail-row">
						<span class="detail-label">Phone</span> <span class="detail-value">${student.phone}</span>
					</div>

					<div class="profile-detail-row">
						<span class="detail-label">Email</span> <span class="detail-value">${student.email}</span>
					</div>

					<div class="profile-detail-row">
						<span class="detail-label">ID</span> <span class="detail-value">#${student.id}</span>
					</div>
				</div>

				<!-- ✅ FIXED BUTTON AREA -->
				<div class="edit-area"
					style="display: flex; flex-direction: column; gap: 12px;">
					<button class="btn-edit" onclick="openModal()">
						<i data-lucide="edit-3"></i> Edit Profile
					</button>

					<button class="btn-delete" onclick="openDeleteModal()">
						<i data-lucide="trash-2"></i> Delete Account
					</button>
				</div>

			</div>
		</div>
	</main>

	<!-- ================= EDIT MODAL ================= -->
	<div id="editModal" class="modal-overlay"
		onclick="handleOverlayClick(event)">
		<div class="modal-box">

			<div class="modal-header">
				<h2 class="modal-title">Edit Profile</h2>
				<button class="modal-close" onclick="closeModal()">
					<i data-lucide="x"></i>
				</button>
			</div>

			<div class="modal-divider"></div>

			<form action="/smartai/update" method="post">
				<input type="hidden" name="id" value="${student.id}">

				<div class="form-group">
					<label class="form-label">Full Name</label>
					<div class="input-icon-wrap">
						<i data-lucide="user" size="15" class="input-icon"></i> <input
							class="form-input" type="text" name="name"
							value="${student.name}" placeholder="Your full name" required>
					</div>
				</div>

				<div class="form-group">
					<label class="form-label">Phone Number</label>
					<div class="input-icon-wrap">
						<i data-lucide="phone" size="15" class="input-icon"></i> <input
							class="form-input" type="text" name="phone"
							value="${student.phone}" placeholder="Your phone number" required>
					</div>
				</div>

				<div class="form-group">
					<label class="form-label">Email Address</label>
					<div class="input-icon-wrap">
						<i data-lucide="mail" size="15" class="input-icon"></i> <input
							class="form-input" type="email" name="email"
							value="${student.email}" placeholder="Your email" required>
					</div>
				</div>
				<div class="form-actions">
					<button type="submit" class="btn-save">Save Changes</button>
					<button type="button" class="btn-cancel" onclick="closeModal()">Cancel</button>
				</div>
			</form>

		</div>

		</div>
	</div>

	<!-- ================= DELETE MODAL ================= -->
	<div id="deleteModal" class="modal-overlay"
		onclick="handleDeleteOverlay(event)">
		<div class="modal-box">

			<div class="modal-header">
				<h2 class="modal-title" style="color: #ef4444;">Delete Account</h2>
				<button class="modal-close" onclick="closeDeleteModal()">
					<i data-lucide="x"></i>
				</button>
			</div>

			<div class="modal-divider"></div>

			<p
				style="color: var(--text-body); font-size: 0.95rem; line-height: 1.5;">
				Are you sure you want to delete your account?<br> <b
					style="color: #ef4444;">This action cannot be undone.You will lose your data.</b>
			</p>

			<form action="/smartai/delete" method="post">
				<input type="hidden" name="id" value="${student.id}">

				<div class="form-actions" style="margin-top: 1.8rem;">

					<button type="submit" class="btn-delete" style="flex: 1;">
						<i data-lucide="trash-2"></i> Delete Permanently
					</button>

					<button type="button" class="btn-cancel"
						onclick="closeDeleteModal()">Cancel</button>

				</div>
			</form>

		</div>
	</div>

	<script>
		lucide.createIcons();

		function openModal() {
			document.getElementById("editModal").classList.add("open");
		}
		function closeModal() {
			document.getElementById("editModal").classList.remove("open");
		}

		function openDeleteModal() {
			document.getElementById("deleteModal").classList.add("open");
		}
		function closeDeleteModal() {
			document.getElementById("deleteModal").classList.remove("open");
		}

		function handleOverlayClick(e) {
			if (e.target.id === "editModal")
				closeModal();
		}

		function handleDeleteOverlay(e) {
			if (e.target.id === "deleteModal")
				closeDeleteModal();
		}
	</script>

</body>
</html>