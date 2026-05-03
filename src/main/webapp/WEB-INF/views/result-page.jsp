<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Test Result | Smart Assess AI</title>

<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
:root {
    --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    --accent-color: #00ffae;
    --accent-warm: #ff6b6b;
    --accent-gold: #ffd700;
    --glass: rgba(255,255,255,0.08);
    --glass-border: rgba(255,255,255,0.15);
    --glass-hover: rgba(255,255,255,0.14);
    --text-dim: rgba(255,255,255,0.55);
}

* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    min-height: 100vh;
    font-family: 'DM Sans', sans-serif;
    background: #0d0d1a;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 24px 16px;
    overflow-x: hidden;
    position: relative;
}

/* ── Animated mesh background ── */
body::before {
    content: '';
    position: fixed;
    inset: 0;
    background:
        radial-gradient(ellipse 80% 60% at 20% 10%, rgba(102,126,234,0.45) 0%, transparent 60%),
        radial-gradient(ellipse 60% 50% at 80% 80%, rgba(118,75,162,0.4) 0%, transparent 60%),
        radial-gradient(ellipse 50% 40% at 50% 50%, rgba(0,255,174,0.06) 0%, transparent 70%);
    z-index: 0;
    animation: meshShift 12s ease-in-out infinite alternate;
}

@keyframes meshShift {
    0%   { opacity: 1; transform: scale(1) rotate(0deg); }
    100% { opacity: 0.85; transform: scale(1.06) rotate(2deg); }
}

/* Floating orbs */
.orb {
    position: fixed;
    border-radius: 50%;
    filter: blur(60px);
    opacity: 0.18;
    z-index: 0;
    animation: floatOrb 8s ease-in-out infinite;
}
.orb-1 { width: 300px; height: 300px; background: #667eea; top: -80px; left: -80px; animation-delay: 0s; }
.orb-2 { width: 200px; height: 200px; background: #00ffae; bottom: -60px; right: -60px; animation-delay: 3s; }
.orb-3 { width: 150px; height: 150px; background: #ff6b6b; top: 50%; right: 10%; animation-delay: 5s; }

@keyframes floatOrb {
    0%,100% { transform: translateY(0) scale(1); }
    50%      { transform: translateY(-30px) scale(1.1); }
}

/* Particle dots */
.particles {
    position: fixed;
    inset: 0;
    z-index: 0;
    pointer-events: none;
    overflow: hidden;
}
.particle {
    position: absolute;
    width: 3px;
    height: 3px;
    border-radius: 50%;
    background: rgba(255,255,255,0.4);
    animation: particleDrift linear infinite;
}

@keyframes particleDrift {
    0%   { transform: translateY(100vh) scale(0); opacity: 0; }
    10%  { opacity: 1; }
    90%  { opacity: 0.6; }
    100% { transform: translateY(-20px) scale(1.5); opacity: 0; }
}

/* ── Card ── */
.result-card {
    position: relative;
    z-index: 1;
    width: 100%;
    max-width: 520px;
    background: rgba(255,255,255,0.06);
    backdrop-filter: blur(28px);
    -webkit-backdrop-filter: blur(28px);
    border: 1px solid var(--glass-border);
    border-radius: 28px;
    padding: 40px 36px 36px;
    color: white;
    text-align: center;
    box-shadow:
        0 0 0 1px rgba(255,255,255,0.04) inset,
        0 40px 80px rgba(0,0,0,0.5),
        0 0 60px rgba(102,126,234,0.15);
    animation: cardReveal 0.8s cubic-bezier(0.16,1,0.3,1) both;
}

@keyframes cardReveal {
    from { opacity: 0; transform: translateY(50px) scale(0.95); }
    to   { opacity: 1; transform: translateY(0) scale(1); }
}

/* Shimmer line on top of card */
.result-card::before {
    content: '';
    position: absolute;
    top: 0; left: 10%; right: 10%;
    height: 2px;
    background: linear-gradient(90deg, transparent, var(--accent-color), #667eea, transparent);
    border-radius: 2px;
    animation: shimmerLine 3s ease-in-out infinite;
}

@keyframes shimmerLine {
    0%,100% { opacity: 0.5; transform: scaleX(0.6); }
    50%      { opacity: 1; transform: scaleX(1); }
}

/* ── Title ── */
.result-title {
    font-family: 'Syne', sans-serif;
    font-size: clamp(1.3rem, 4vw, 1.6rem);
    font-weight: 800;
    letter-spacing: -0.02em;
    margin-bottom: 6px;
    animation: fadeUp 0.6s 0.2s both;
}

.result-subtitle {
    font-size: 0.82rem;
    color: var(--text-dim);
    margin-bottom: 30px;
    animation: fadeUp 0.6s 0.3s both;
    letter-spacing: 0.06em;
    text-transform: uppercase;
}

/* ── Circle ── */
.progress-wrapper {
    width: 190px;
    height: 190px;
    margin: 0 auto 28px;
    position: relative;
    animation: fadeUp 0.6s 0.4s both;
}

.circle-canvas {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    background: conic-gradient(var(--accent-color) 0deg, rgba(255,255,255,0.08) 0deg);
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow:
        0 0 0 4px rgba(255,255,255,0.05),
        0 0 40px rgba(0,255,174,0.2);
    transition: box-shadow 0.4s ease;
}

.circle-inner {
    width: 138px;
    height: 138px;
    background: linear-gradient(145deg, #16163a, #1e1e48);
    border-radius: 50%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    box-shadow: inset 0 2px 8px rgba(0,0,0,0.4);
    gap: 2px;
}

.percent-num {
    font-family: 'Syne', sans-serif;
    font-size: 2.4rem;
    font-weight: 800;
    color: var(--accent-color);
    line-height: 1;
    text-shadow: 0 0 20px rgba(0,255,174,0.5);
}

.circle-label {
    font-size: 0.65rem;
    letter-spacing: 0.15em;
    color: var(--text-dim);
    text-transform: uppercase;
}

/* Pulsing ring when high score */
.pulse-ring {
    position: absolute;
    inset: -8px;
    border-radius: 50%;
    border: 2px solid rgba(0,255,174,0.25);
    animation: pulseRing 2.5s ease-out infinite;
    opacity: 0;
}

.pulse-ring:nth-child(2) { animation-delay: 0.8s; }

@keyframes pulseRing {
    0%   { transform: scale(0.92); opacity: 0.6; }
    100% { transform: scale(1.18); opacity: 0; }
}

/* ── Stats Grid ── */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 12px;
    margin: 0 0 24px;
    animation: fadeUp 0.6s 0.5s both;
}

.stat-item {
    background: var(--glass);
    border: 1px solid var(--glass-border);
    padding: 14px 10px;
    border-radius: 16px;
    position: relative;
    overflow: hidden;
    transition: transform 0.25s ease, background 0.25s ease;
}

.stat-item:hover {
    transform: translateY(-4px);
    background: var(--glass-hover);
}

.stat-item::after {
    content: '';
    position: absolute;
    bottom: 0; left: 0; right: 0;
    height: 2px;
    background: var(--accent-color);
    transform: scaleX(0);
    transform-origin: left;
    transition: transform 0.3s ease;
    border-radius: 0 0 16px 16px;
}

.stat-item:hover::after { transform: scaleX(1); }

.stat-item h3 {
    font-family: 'Syne', sans-serif;
    font-size: 1.7rem;
    font-weight: 800;
    color: white;
    line-height: 1;
    margin-bottom: 4px;
}

.stat-item p {
    font-size: 0.72rem;
    color: var(--text-dim);
    letter-spacing: 0.08em;
    text-transform: uppercase;
}

/* Stat accent colors */
.stat-correct h3 { color: var(--accent-color); text-shadow: 0 0 14px rgba(0,255,174,0.4); }
.stat-total h3   { color: #a78bfa; }
.stat-skipped h3 { color: #fb923c; }

/* ── Buttons ── */
.btn-group {
    display: flex;
    flex-direction: column;
    gap: 10px;
    margin-bottom: 24px;
    animation: fadeUp 0.6s 0.6s both;
}

.btn-main {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    padding: 14px 20px;
    border-radius: 14px;
    text-decoration: none;
    font-weight: 600;
    font-size: 0.92rem;
    letter-spacing: 0.01em;
    transition: all 0.25s ease;
    position: relative;
    overflow: hidden;
}

.btn-main::before {
    content: '';
    position: absolute;
    inset: 0;
    background: rgba(255,255,255,0.08);
    transform: translateX(-100%);
    transition: transform 0.35s ease;
}

.btn-main:hover::before { transform: translateX(0); }

.btn-certificate {
    background: linear-gradient(135deg, var(--accent-color) 0%, #00c9a7 100%);
    color: #0d0d1a;
    box-shadow: 0 8px 24px rgba(0,255,174,0.3);
}

.btn-certificate:hover {
    transform: translateY(-2px);
    box-shadow: 0 14px 32px rgba(0,255,174,0.4);
    color: #0d0d1a;
}

.btn-dashboard {
    background: var(--glass);
    color: white;
    border: 1px solid var(--glass-border);
}

.btn-dashboard:hover {
    transform: translateY(-2px);
    background: var(--glass-hover);
    border-color: rgba(255,255,255,0.28);
}

/* ── AI Feedback Card ── */
.ai-card {
    margin-top: 0;
    padding: 20px 22px;
    border-radius: 18px;
    background: rgba(0,0,0,0.28);
    border: 1px solid rgba(0,255,174,0.18);
    text-align: left;
    animation: fadeUp 0.6s 0.7s both;
    position: relative;
    overflow: hidden;
}

.ai-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 1px;
    background: linear-gradient(90deg, transparent, var(--accent-color), transparent);
    opacity: 0.6;
}

.ai-card-header {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 14px;
}

.ai-icon-wrap {
    width: 34px;
    height: 34px;
    border-radius: 10px;
    background: linear-gradient(135deg, rgba(0,255,174,0.2), rgba(102,126,234,0.2));
    border: 1px solid rgba(0,255,174,0.25);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1rem;
    flex-shrink: 0;
}

.ai-card h3 {
    font-family: 'Syne', sans-serif;
    font-size: 0.92rem;
    font-weight: 700;
    color: var(--accent-color);
    letter-spacing: 0.04em;
}

.ai-text {
    white-space: pre-wrap;
    font-size: 0.87rem;
    line-height: 1.7;
    color: rgba(255,255,255,0.78);
}

/* Typing cursor blink on ai-text */
.ai-text::after {
    content: '▌';
    color: var(--accent-color);
    animation: blink 1s step-end infinite;
    font-size: 0.8rem;
}

@keyframes blink { 0%,100% { opacity: 1; } 50% { opacity: 0; } }

/* ── Shared animation ── */
@keyframes fadeUp {
    from { opacity: 0; transform: translateY(22px); }
    to   { opacity: 1; transform: translateY(0); }
}

/* ── Confetti ── */
.confetti-wrap {
    position: fixed;
    inset: 0;
    pointer-events: none;
    z-index: 999;
    overflow: hidden;
}

.confetti-piece {
    position: absolute;
    top: -20px;
    width: 8px;
    height: 12px;
    opacity: 0;
    border-radius: 2px;
    animation: confettiFall linear forwards;
}

@keyframes confettiFall {
    0%   { transform: translateY(0) rotateZ(0deg); opacity: 1; }
    100% { transform: translateY(110vh) rotateZ(720deg); opacity: 0; }
}

/* ── Responsive ── */
@media (max-width: 520px) {
    .result-card { padding: 28px 20px 28px; border-radius: 22px; }
    .progress-wrapper { width: 160px; height: 160px; }
    .circle-inner { width: 116px; height: 116px; }
    .percent-num { font-size: 2rem; }
    .stats-grid { gap: 8px; }
    .stat-item h3 { font-size: 1.4rem; }
    .stat-item p { font-size: 0.68rem; }
    .btn-main { padding: 13px 16px; font-size: 0.88rem; }
    .ai-card { padding: 16px 16px; }
    .ai-text { font-size: 0.83rem; }
}

@media (max-width: 360px) {
    body { padding: 16px 10px; }
    .result-card { padding: 22px 14px 22px; border-radius: 18px; }
    .progress-wrapper { width: 140px; height: 140px; }
    .circle-inner { width: 100px; height: 100px; }
    .percent-num { font-size: 1.7rem; }
    .stats-grid { grid-template-columns: repeat(3,1fr); gap: 6px; }
    .stat-item { padding: 10px 6px; }
    .stat-item h3 { font-size: 1.2rem; }
}

@media (max-width: 768px) and (orientation: landscape) {
    body { padding: 12px; align-items: flex-start; }
    .result-card { max-width: 100%; padding: 20px 24px; }
    .progress-wrapper { width: 130px; height: 130px; }
    .circle-inner { width: 94px; height: 94px; }
    .percent-num { font-size: 1.5rem; }
}
</style>
</head>

<body>

<!-- Background orbs -->
<div class="orb orb-1"></div>
<div class="orb orb-2"></div>
<div class="orb orb-3"></div>

<!-- Floating particles -->
<div class="particles" id="particles"></div>

<!-- Confetti container -->
<div class="confetti-wrap" id="confettiWrap"></div>

<div class="result-card">

    <!-- Pulse rings (shown when high score) -->
    <div class="progress-wrapper">
        <div class="pulse-ring"></div>
        <div class="pulse-ring"></div>
        <div class="circle-canvas" id="circle">
            <div class="circle-inner">
                <span class="percent-num" id="percent">0%</span>
                <span class="circle-label">Accuracy</span>
            </div>
        </div>
    </div>

    <h2 class="result-title" id="feedback-text">🎉 Great Job!</h2>
    <p class="result-subtitle">Test Complete &nbsp;·&nbsp; Smart Assess AI</p>

    <!-- Stats — mappings unchanged: ${score}, ${total}, ${unattemted} -->
    <div class="stats-grid">
        <div class="stat-item stat-correct">
            <h3>${score}</h3>
            <p>Correct</p>
        </div>
        <div class="stat-item stat-total">
            <h3>${total}</h3>
            <p>Total</p>
        </div>
        <div class="stat-item stat-skipped">
            <h3>${unattemted}</h3>
            <p>Skipped</p>
        </div>
    </div>

    <!-- Buttons — hrefs unchanged -->
    <div class="btn-group">
        <a href="/test/getCertificate/${testid}" class="btn-main btn-certificate">
            <i class="fas fa-certificate"></i> Download Certificate
        </a>
        <a href="/smartai/sdb" class="btn-main btn-dashboard">
            <i class="fas fa-th-large"></i> Back to Dashboard
        </a>
    </div>

    <!-- AI Feedback — mapping unchanged: ${feedback} -->
    <div class="ai-card">
        <div class="ai-card-header">
            <div class="ai-icon-wrap">🤖</div>
            <h3>AI Feedback</h3>
        </div>
        <div class="ai-text">${feedback}</div>
    </div>

</div>

<script>
// ── Score & feedback label ──
const targetPercent = parseInt("${per}") || 0;
const feedbackEl = document.getElementById("feedback-text");

if      (targetPercent < 40) feedbackEl.innerText = "📚 Keep Learning!";
else if (targetPercent < 80) feedbackEl.innerText = "🚀 Well Done!";
else                         feedbackEl.innerText = "🏆 Mastery Achieved!";

// ── Animated progress circle ──
let current = 0;
const circle = document.getElementById("circle");
const percentText = document.getElementById("percent");

// Pick arc colour based on score
const arcColor = targetPercent < 40 ? "#ff6b6b" : targetPercent < 80 ? "#ffd700" : "#00ffae";

const interval = setInterval(() => {
    current++;
    percentText.innerText = current + "%";
    const deg = current * 3.6;
    circle.style.background =
        `conic-gradient(${arcColor} ${deg}deg, rgba(255,255,255,0.08) ${deg}deg)`;
    circle.style.boxShadow =
        `0 0 0 4px rgba(255,255,255,0.05), 0 0 ${20 + current * 0.4}px ${arcColor}55`;
    if (current >= targetPercent) clearInterval(interval);
}, 18);

// ── Confetti for high scores ──
if (targetPercent >= 80) {
    const wrap = document.getElementById("confettiWrap");
    const colors = ["#00ffae","#667eea","#ffd700","#ff6b6b","#a78bfa","#ffffff"];
    for (let i = 0; i < 90; i++) {
        const piece = document.createElement("div");
        piece.className = "confetti-piece";
        piece.style.left       = Math.random() * 100 + "vw";
        piece.style.background = colors[Math.floor(Math.random() * colors.length)];
        piece.style.width      = (Math.random() * 8 + 5) + "px";
        piece.style.height     = (Math.random() * 10 + 8) + "px";
        piece.style.borderRadius = Math.random() > 0.5 ? "50%" : "2px";
        piece.style.animationDuration  = (Math.random() * 2.5 + 2) + "s";
        piece.style.animationDelay     = (Math.random() * 1.5) + "s";
        wrap.appendChild(piece);
    }
}

// ── Floating particles ──
const pWrap = document.getElementById("particles");
for (let i = 0; i < 28; i++) {
    const p = document.createElement("div");
    p.className = "particle";
    p.style.left              = Math.random() * 100 + "vw";
    p.style.animationDuration = (Math.random() * 10 + 8) + "s";
    p.style.animationDelay    = (Math.random() * 8) + "s";
    p.style.width = p.style.height = (Math.random() * 3 + 1.5) + "px";
    pWrap.appendChild(p);
}
</script>

</body>
</html>
