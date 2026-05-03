<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

        /* --- Sidebar --- */
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
            flex-shrink: 0;
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

        /* --- Main Content --- */
        .content-wrapper {
            margin-left: 280px;
            padding: 3rem;
            width: 100%;
            min-height: 100vh;
        }

        /* --- Page Header --- */
        .header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .header-left h2 {
            font-weight: 800;
            font-size: 2rem;
            line-height: 1.2;
        }

        .header-left p {
            color: var(--text-body);
            margin-top: 4px;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 14px;
            flex-wrap: wrap;
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
            white-space: nowrap;
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
            flex-shrink: 0;
        }

        /* --- Timer Pill --- */
        .timer {
            display: flex;
            align-items: center;
            gap: 8px;
            background: white;
            padding: 10px 20px;
            border-radius: 50px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            font-size: 1rem;
            font-weight: 700;
            color: #ef4444;
            white-space: nowrap;
            border: 2px solid #fee2e2;
        }

        .timer svg {
            width: 16px;
            height: 16px;
            color: #ef4444;
            flex-shrink: 0;
        }

        /* --- Sticky Test Header --- */
        .test-header {
            position: sticky;
            top: 16px;
            z-index: 100;
            background: white;
            padding: 16px 24px;
            border-radius: 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
            margin-bottom: 2rem;
            border-left: 5px solid var(--primary);
            gap: 1rem;
            flex-wrap: wrap;
        }

        .test-header h2 {
            font-size: 1.05rem;
            font-weight: 700;
            color: var(--text-heading);
            margin: 0;
        }

        .test-header small {
            display: block;
            color: var(--text-body);
            font-size: 0.8rem;
            margin-top: 2px;
        }

        /* --- Question Cards --- */
        .question-card {
            background: white;
            padding: 28px 32px;
            border-radius: 16px;
            margin-bottom: 20px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.04);
            border: 1px solid #e2e8f0;
        }

        .question-card:hover {
            border-color: var(--primary);
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.08);
        }

        .question-text {
            font-size: 1rem;
            font-weight: 700;
            margin-bottom: 18px;
            color: #0f172a;
            line-height: 1.6;
        }

        /* --- Option Labels --- */
        .option-label {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            margin-bottom: 10px;
            background: #f8fafc;
            border: 2px solid #f1f5f9;
            border-radius: 12px;
            cursor: pointer;
            font-weight: 500;
            font-size: 0.92rem;
            color: var(--text-heading);
        }

        .option-label:last-of-type {
            margin-bottom: 0;
        }

        .option-label:hover {
            background: #f1f5f9;
            border-color: var(--primary);
            transform: translateX(4px);
        }

        .option-label:has(input:checked) {
            border-color: var(--primary);
            background: rgba(99,102,241,0.07);
            font-weight: 600;
        }

        .option-label input[type="radio"] {
            accent-color: var(--primary);
            width: 17px;
            height: 17px;
            flex-shrink: 0;
            cursor: pointer;
        }

        .option-label span {
            flex: 1;
        }

        /* --- Submit Section --- */
        .submit-container {
            text-align: center;
            padding: 2rem 0 1rem;
        }

        .submit-btn {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 14px 48px;
            border: none;
            border-radius: 14px;
            font-size: 1rem;
            font-weight: 700;
            font-family: 'Plus Jakarta Sans', sans-serif;
            cursor: pointer;
            box-shadow: 0 8px 24px rgba(99, 102, 241, 0.35);
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 14px 32px rgba(99, 102, 241, 0.45);
        }

        /* --- Animations --- */
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(40px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to   { opacity: 1; }
        }

        /* ============================================
           RESPONSIVE
        ============================================ */

        /* Tablet — icon-only sidebar */
        @media (max-width: 1024px) {
            .sidebar {
                width: 90px;
                padding: 1.5rem 0.5rem;
                align-items: center;
            }
            .logo-text, .nav-link span, .user-name-label { display: none; }
            .content-wrapper { margin-left: 90px; padding: 2rem; }
            .nav-link { justify-content: center; width: 50px; height: 50px; }
        }

        /* Mobile — bottom nav bar */
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: 64px;
                flex-direction: row;
                bottom: 0;
                top: auto;
                padding: 0 1rem;
                justify-content: space-around;
            }
            .logo-box, .logout-item { display: none; }
            .nav-link { margin-bottom: 0; width: 44px; height: 44px; justify-content: center; }

            .content-wrapper {
                margin-left: 0;
                padding: 1.5rem 1.2rem;
                padding-bottom: 90px;
            }

            .header-flex {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
                margin-bottom: 1.5rem;
            }

            .header-left h2 { font-size: 1.5rem; }

            .header-right {
                width: 100%;
                justify-content: space-between;
            }

            .user-profile-trigger {
                flex: 1;
            }

            .timer {
                flex-shrink: 0;
            }

            .test-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
                padding: 14px 16px;
                position: static;
            }

            .question-card {
                padding: 18px 16px;
                border-radius: 14px;
                margin-bottom: 14px;
            }

            .question-text {
                font-size: 0.95rem;
                margin-bottom: 14px;
            }

            .option-label {
                padding: 11px 13px;
                font-size: 0.87rem;
                border-radius: 10px;
            }

            .option-label:hover { transform: none; }

            .submit-btn {
                width: 100%;
                justify-content: center;
                padding: 13px 24px;
                font-size: 0.95rem;
            }
        }

        /* Small phones */
        @media (max-width: 480px) {
            .content-wrapper { padding: 1rem 0.9rem 90px; }

            .header-left h2 { font-size: 1.3rem; }

            .timer { font-size: 0.88rem; padding: 8px 14px; }

            .question-card { padding: 14px 13px; }

            .question-text { font-size: 0.9rem; }

            .option-label { font-size: 0.83rem; padding: 10px 11px; }

            .submit-btn { font-size: 0.9rem; border-radius: 12px; }
        }

        /* Very small / Galaxy Fold */
        @media (max-width: 360px) {
            .header-left h2 { font-size: 1.1rem; }

            .user-name-label { display: none; }

            .question-text { font-size: 0.85rem; }

            .option-label { font-size: 0.8rem; }
        }

        /* Landscape phones */
        @media (max-width: 768px) and (orientation: landscape) {
            .sidebar { height: 56px; }
            .content-wrapper { padding-bottom: 76px; }
        }

        /* Touch — no hover side-effects */
        @media (hover: none) {
            .option-label:hover { transform: none; border-color: #f1f5f9; background: #f8fafc; }
            .submit-btn:hover   { transform: none; }
            .nav-link:hover     { transform: none; }
        }

        /* Notched iPhones */
        @supports (padding-bottom: env(safe-area-inset-bottom)) {
            @media (max-width: 768px) {
                .sidebar {
                    height: calc(64px + env(safe-area-inset-bottom));
                    padding-bottom: env(safe-area-inset-bottom);
                }
                .content-wrapper {
                    padding-bottom: calc(90px + env(safe-area-inset-bottom));
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
            <a href="/smartai/sdb" class="nav-link active"><i data-lucide="layout-grid"></i> <span>Dashboard</span></a>
            <a href="/courses/getCourses"  class="nav-link"><i data-lucide="zap"></i> <span>AI Test</span></a>
            <a href="/courses/getCourses" class="nav-link"><i data-lucide="book-open"></i> <span>My Courses</span></a>
            <a href="/test/results"    class="nav-link"><i data-lucide="line-chart"></i> <span>Results</span></a>
            <a href="/smartai/recommendations" class="nav-link"><i data-lucide="sparkles"></i> <span>AI Feedback</span></a>
            <a href="/smartai/profile" class="nav-link"><i data-lucide="user-circle"></i> <span>Profile</span></a>
        </div>

        <div class="logout-item">
            <a href="/smartai/logout" class="nav-link" style="color: #fb7185;"><i data-lucide="log-out"></i> <span>Logout</span></a>
        </div>
    </nav>

    <main class="content-wrapper">

        <!-- Page Header -->
        <header class="header-flex">
            <div class="header-left">
                <h2>Test Page</h2>
                <p>Welcome back, ready to master something new?</p>
            </div>

            <div class="header-right">
                <div class="user-profile-trigger">
                    <div class="avatar">${sessionScope.name.substring(0,1)}</div>
                    <span class="user-name-label" style="font-weight: 600;">${sessionScope.name}</span>
                </div>

                <div class="timer">
                    <i data-lucide="clock"></i>
                    <span id="time-display">30:00</span>
                </div>
            </div>
        </header>

        <!-- Sticky Test Header -->
        <div class="test-header">
            <div>
                <h2>Final Assessment: AI Basics</h2>
                <small>Candidate: ${stud}</small>
            </div>
        </div>

        <!-- Questions Form -->
        <form action="/test/submit-test" method="post">
            <input type="hidden" name="testId" value="${testId}"/>

            <c:forEach items="${questions}" var="q" varStatus="i">
                <div class="question-card">
                    <div class="question-text">
                        <span style="color:var(--primary); margin-right:8px;">Q${i.index + 1}.</span>${q.question}
                    </div>

                    <label class="option-label">
                        <input type="radio" name="q${q.id}" value="A" required/>
                        <span>${q.optionA}</span>
                    </label>
                    <label class="option-label">
                        <input type="radio" name="q${q.id}" value="B"/>
                        <span>${q.optionB}</span>
                    </label>
                    <label class="option-label">
                        <input type="radio" name="q${q.id}" value="C"/>
                        <span>${q.optionC}</span>
                    </label>
                    <label class="option-label">
                        <input type="radio" name="q${q.id}" value="D"/>
                        <span>${q.optionD}</span>
                    </label>
                </div>
            </c:forEach>

            <div class="submit-container">
                <button type="submit" class="submit-btn"
                        onclick="return confirm('Are you sure you want to submit your test?')">
                    Complete &amp; Submit Test
                </button>
            </div>
        </form>

    </main>

    <script>
        lucide.createIcons();

        // Timer countdown
        let time = 1800;
        const display = document.getElementById('time-display');

        const countdown = setInterval(() => {
            if (time <= 0) {
                clearInterval(countdown);
                display.innerText = "00:00";
                document.querySelector('form').submit();
                return;
            }
            time--;
            const m = Math.floor(time / 60);
            const s = time % 60;
            display.innerText = (m < 10 ? '0' : '') + m + ':' + (s < 10 ? '0' : '') + s;

            // Red warning in last 5 minutes
            if (time <= 300) {
                document.querySelector('.timer').style.borderColor = '#fca5a5';
                document.querySelector('.timer').style.background  = '#fff1f2';
            }
        }, 1000);
    </script>
</body>
</html>
