<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Smart Assess AI</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    
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
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
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
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* --- Responsiveness --- */
        @media (max-width: 1024px) {
            .sidebar { width: 90px; padding: 1.5rem 0.5rem; align-items: center; }
            .logo-text, .nav-link span, .user-name-label { display: none; }
            .content-wrapper { margin-left: 90px; padding: 2rem; }
            .nav-link { justify-content: center; width: 50px; height: 50px; }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: 70px;
                flex-direction: row;
                bottom: 0;
                top: auto;
                padding: 0 1rem;
                justify-content: space-around;
            }
            .logo-box, .logout-item { display: none; }
            .content-wrapper { margin-left: 0; padding-bottom: 100px; }
            .nav-link { margin-bottom: 0; }
            .overview-banner { flex-direction: column; text-align: center; gap: 1rem; }
        }

        /* ---------- FINAL RESPONSIVE FIXES (NO STRUCTURE CHANGE) ---------- */

        /* Prevent text overflow */
        .glass-card h3 {
            word-break: break-word;
        }

        /* Make dropdown fully responsive */
        select {
            width: 100%;
            max-width: 100%;
        }

        /* Keep buttons flexible */
        .btn-modern {
            flex: 1;
            min-width: 120px;
        }

        /* Fix button layout */
        form div {
            display: flex;
            gap: 10px;
        }

        /* ---------- Mobile (Small Devices) ---------- */
        @media (max-width: 600px) {

            .grid-container {
                grid-template-columns: 1fr;
            }

            .glass-card {
                padding: 1.5rem;
            }

            .header-flex {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }

            .user-profile-trigger {
                width: 100%;
                justify-content: space-between;
            }

            /* Stack buttons */
            form div {
                flex-direction: column;
            }

            .btn-modern {
                width: 100%;
                font-size: 0.85rem;
                padding: 10px;
            }
        }

        /* ---------- Tablet ---------- */
        @media (max-width: 900px) {
            .grid-container {
                grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            }
        }

        /* ---------- Extra Small Devices ---------- */
        @media (max-width: 400px) {
            .content-wrapper {
                padding: 1.5rem;
            }

            .glass-card {
                padding: 1.2rem;
            }

            h2 {
                font-size: 1.5rem;
            }
        }

        /* ---------- NEW RESPONSIVE ADDITIONS ---------- */

        /* Large tablets / small laptops */
        @media (max-width: 1280px) and (min-width: 1025px) {
            .content-wrapper {
                padding: 2rem;
            }

            .grid-container {
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            }
        }

        /* Sidebar icon-only mode: center icons properly */
        @media (max-width: 1024px) and (min-width: 769px) {
            .nav-link {
                padding: 0;
                margin: 0 auto 8px auto;
                border-radius: 14px;
            }

            .logo-box {
                padding-bottom: 2rem;
                justify-content: center;
            }

            .logo-icon {
                flex-shrink: 0;
            }
        }

        /* Bottom nav bar: fix icon sizing and touch targets */
        @media (max-width: 768px) {
            .nav-link {
                width: 44px;
                height: 44px;
                padding: 0;
                justify-content: center;
                align-items: center;
                border-radius: 12px;
            }

            .nav-link svg {
                width: 22px;
                height: 22px;
            }

            .content-wrapper {
                padding: 1.5rem 1.5rem 100px 1.5rem;
            }

            .header-flex {
                margin-bottom: 1.5rem;
            }

            .header-flex h2 {
                font-size: 1.6rem;
            }
        }

        /* Very narrow phones (SE, Fold closed) */
        @media (max-width: 360px) {
            .content-wrapper {
                padding: 1rem 1rem 90px 1rem;
            }

            .glass-card {
                padding: 1rem;
                gap: 1rem;
                border-radius: 14px;
            }

            .glass-card h3 {
                font-size: 0.95rem;
            }

            select {
                font-size: 0.85rem;
                padding: 8px;
            }

            .btn-modern {
                font-size: 0.8rem;
                padding: 9px;
                border-radius: 10px;
            }

            .avatar {
                width: 34px;
                height: 34px;
                font-size: 0.85rem;
            }

            h2 {
                font-size: 1.3rem;
            }
        }

        /* Landscape mode on phones */
        @media (max-width: 768px) and (orientation: landscape) {
            .sidebar {
                height: 60px;
            }

            .content-wrapper {
                padding-bottom: 80px;
            }

            .grid-container {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        /* Touch: remove hover lift on cards to avoid sticky state */
        @media (hover: none) {
            .glass-card:hover {
                transform: none;
                box-shadow: none;
                border-color: rgba(255, 255, 255, 0.6);
            }

            .btn-modern:hover {
                transform: none;
            }

            .nav-link:hover {
                transform: none;
            }
        }

        /* Safe area insets for notched phones (iPhone X+) */
        @supports (padding-bottom: env(safe-area-inset-bottom)) {
            @media (max-width: 768px) {
                .sidebar {
                    padding-bottom: env(safe-area-inset-bottom);
                    height: calc(70px + env(safe-area-inset-bottom));
                }

                .content-wrapper {
                    padding-bottom: calc(100px + env(safe-area-inset-bottom));
                }
            }
        }
    </style>
</head>
<body>

    <nav class="sidebar">
        <div class="logo-box">
            <div class="logo-icon"><i data-lucide="cpu" color="white" size="24"></i></div>
            <span class="logo-text" style="color: white; font-weight: 800; font-size: 1.5rem;">Smart Assess AI</span>
        </div>

        <div style="flex-grow: 1;">
            <a href="/smartai/sdb" class="nav-link"><i data-lucide="layout-grid"></i> <span>Dashboard</span></a>
            <a href="/courses/getCourses" class="nav-link"><i data-lucide="zap"></i> <span>AI Test</span></a>
            <a href="/courses/getCourses" class="nav-link active"><i data-lucide="book-open"></i> <span>My Courses</span></a>
            <a href="/test/results" class="nav-link"><i data-lucide="line-chart"></i> <span>Results</span></a>
            <a href="/smartai/recommendations" class="nav-link"><i data-lucide="sparkles"></i> <span>AI Feedback</span></a>
            <a href="/smartai/profile" class="nav-link"><i data-lucide="user-circle"></i> <span>Profile</span></a>
        </div>

        <div class="logout-item">
            <a href="/smartai/logout" class="nav-link" style="color: #fb7185;"><i data-lucide="log-out"></i> <span>Logout</span></a>
        </div>
    </nav>

    <main class="content-wrapper">
    <header class="header-flex">
        <div>
            <h2 style="font-weight: 800; font-size: 2rem;">Select Courses</h2>
            <p style="color: var(--text-body);">Choose subject & generate your AI test</p>
        </div>

        <div class="user-profile-trigger">
            <div class="avatar">${sessionScope.name.substring(0,1)}</div>
            <span class="user-name-label" style="font-weight: 600;">
                ${sessionScope.name}
            </span>
        </div>
    </header>

    <!-- Courses Grid -->
    <div class="grid-container">

        <c:forEach var="course" items="${courses}">
            <div class="glass-card">

                <div style="display:flex; justify-content:space-between; align-items:center;">
                    <h3 style="font-weight:700;">${name}</h3>
                </div>
                <!-- Question Selection -->
                <form action="/test/generate-test" method="post">
                    <input type="hidden" name="courseId" value="${id}"/>

                    <label style="font-weight:600;">Select Questions:</label>
                    <select name="questionCount" 
                            style="padding:10px; border-radius:10px; width:100%; margin-top:8px;">
                        <option value="10">10 Questions</option>
                        <option value="20">20 Questions</option>
                        <option value="30">30 Questions</option>
                    </select>

                    <!-- Buttons -->
                    <div style="display:flex; gap:10px; margin-top:15px;">
                       
                        <!-- Generate Test -->
                        <button type="submit" class="btn-modern">
                            <i data-lucide="play-circle"></i> Start Test
                        </button>
                    </div>
                </form>

            </div>
        </c:forEach>

    </div>
</main>

    <script>
        // Initialize Lucide Icons
        lucide.createIcons();
    </script>
</body>
</html>
