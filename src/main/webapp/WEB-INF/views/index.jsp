<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart Assess AI</title>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer"/>
<style>
:root{
  --ink:#0a0e1a; --surface:#f8f9ff; --accent:#3b5bfa; --accent-2:#00d4aa;
  --text:#0a0e1a; --text-muted:#5a6480; --border:rgba(59,91,250,0.13);
  --modal-bg:rgba(10,14,26,0.72); --success:#10b981; --error:#ef4444; --warning:#f59e0b;
}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth}
body{font-family:'DM Sans',sans-serif;background:var(--surface);color:var(--text);overflow-x:hidden}
::-webkit-scrollbar{width:6px}
::-webkit-scrollbar-track{background:var(--surface)}
::-webkit-scrollbar-thumb{background:var(--accent);border-radius:10px}

/* NAVBAR */
.navbar{position:fixed;top:0;left:0;right:0;z-index:100;display:flex;align-items:center;justify-content:space-between;padding:18px 56px;background:rgba(248,249,255,.88);backdrop-filter:blur(18px);border-bottom:1px solid var(--border);transition:box-shadow .3s}
.navbar.scrolled{box-shadow:0 4px 32px rgba(59,91,250,.08)}
.nav-logo{display:flex;align-items:center;gap:10px;font-family:'Syne',sans-serif;font-size:22px;font-weight:800;color:var(--accent);letter-spacing:-.5px;text-decoration:none}
.nav-logo span{color:var(--ink)}
.logo-dot{width:8px;height:8px;border-radius:50%;background:var(--accent-2);margin-bottom:2px}
.nav-links{display:flex;align-items:center;gap:8px}
.nav-btn{padding:9px 22px;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:500;cursor:pointer;border:none;transition:all .22s;text-decoration:none;display:inline-block}
.nav-btn-ghost{background:transparent;color:var(--text);border:1.5px solid var(--border)}
.nav-btn-ghost:hover{border-color:var(--accent);color:var(--accent)}
.nav-btn-primary{background:var(--accent);color:#fff;box-shadow:0 4px 16px rgba(59,91,250,.25)}
.nav-btn-primary:hover{background:#2a47e8;transform:translateY(-1px)}
.hamburger{display:none;flex-direction:column;gap:5px;cursor:pointer;padding:4px}
.hamburger span{display:block;width:24px;height:2px;background:var(--ink);border-radius:2px;transition:all .3s}
.hamburger.open span:nth-child(1){transform:translateY(7px) rotate(45deg)}
.hamburger.open span:nth-child(2){opacity:0}
.hamburger.open span:nth-child(3){transform:translateY(-7px) rotate(-45deg)}

/* HERO */
.hero{min-height:100vh;display:flex;flex-direction:column;align-items:center;justify-content:center;text-align:center;padding:120px 24px 80px;position:relative;overflow:hidden}
.hero-bg{position:absolute;inset:0;z-index:0;background:radial-gradient(ellipse 80% 60% at 50% 0%,rgba(59,91,250,.10) 0%,transparent 70%),radial-gradient(ellipse 40% 40% at 80% 80%,rgba(0,212,170,.08) 0%,transparent 60%),linear-gradient(170deg,#f8f9ff 60%,#eef1ff 100%)}
.blob{position:absolute;border-radius:50%;filter:blur(60px);opacity:.55;animation:blobFloat 8s ease-in-out infinite;pointer-events:none}
.blob-1{width:420px;height:420px;background:rgba(59,91,250,.12);top:-80px;left:-100px}
.blob-2{width:320px;height:320px;background:rgba(0,212,170,.10);bottom:10%;right:-60px;animation-delay:3s}
.blob-3{width:200px;height:200px;background:rgba(255,107,107,.08);top:40%;left:10%;animation-delay:5s}
@keyframes blobFloat{0%,100%{transform:translateY(0) scale(1)}50%{transform:translateY(-28px) scale(1.04)}}
.hero-grid{position:absolute;inset:0;z-index:0;background-image:linear-gradient(rgba(59,91,250,.04) 1px,transparent 1px),linear-gradient(90deg,rgba(59,91,250,.04) 1px,transparent 1px);background-size:48px 48px;mask-image:radial-gradient(ellipse 80% 80% at 50% 50%,black 30%,transparent 100%)}
.hero-content{position:relative;z-index:1;max-width:800px}
.hero-tag{display:inline-flex;align-items:center;gap:8px;background:rgba(59,91,250,.08);border:1px solid rgba(59,91,250,.18);border-radius:100px;padding:6px 16px;font-size:13px;font-weight:500;color:var(--accent);margin-bottom:28px;animation:fadeUp .6s .1s both}
.hero-tag-dot{width:6px;height:6px;border-radius:50%;background:var(--accent-2);animation:pulse 1.8s infinite}
@keyframes pulse{0%,100%{opacity:1;transform:scale(1)}50%{opacity:.5;transform:scale(1.4)}}
.hero h1{font-family:'Syne',sans-serif;font-size:clamp(40px,7vw,76px);font-weight:800;line-height:1.08;letter-spacing:-2px;color:var(--ink);animation:fadeUp .7s .2s both}
.hero h1 em{font-style:normal;color:var(--accent)}
.hero-sub{font-size:clamp(15px,2vw,19px);color:var(--text-muted);max-width:520px;margin:24px auto 40px;line-height:1.65;font-weight:300;animation:fadeUp .7s .35s both}
.hero-actions{display:flex;gap:14px;justify-content:center;flex-wrap:wrap;animation:fadeUp .7s .5s both}
.btn-hero-primary{padding:14px 32px;border-radius:10px;background:var(--accent);color:#fff;font-family:'DM Sans',sans-serif;font-size:15px;font-weight:500;border:none;cursor:pointer;box-shadow:0 6px 24px rgba(59,91,250,.3);transition:all .22s;display:inline-flex;align-items:center;gap:8px;position:relative;overflow:hidden}
.btn-hero-primary::before{content:'';position:absolute;inset:0;background:linear-gradient(120deg,transparent 40%,rgba(255,255,255,.18) 50%,transparent 60%);transform:translateX(-100%);transition:transform .5s}
.btn-hero-primary:hover::before{transform:translateX(100%)}
.btn-hero-primary:hover{transform:translateY(-2px);box-shadow:0 10px 32px rgba(59,91,250,.4)}
.btn-hero-secondary{padding:14px 32px;border-radius:10px;background:transparent;color:var(--ink);font-family:'DM Sans',sans-serif;font-size:15px;font-weight:500;border:1.5px solid var(--border);cursor:pointer;transition:all .22s}
.btn-hero-secondary:hover{border-color:var(--accent);color:var(--accent);background:rgba(59,91,250,.04)}
.hero-stats{display:flex;gap:40px;justify-content:center;margin-top:64px;animation:fadeUp .7s .65s both;flex-wrap:wrap}
.stat{text-align:center}
.stat-num{font-family:'Syne',sans-serif;font-size:30px;font-weight:800;color:var(--ink)}
.stat-label{font-size:13px;color:var(--text-muted);margin-top:4px}
@keyframes fadeUp{from{opacity:0;transform:translateY(28px)}to{opacity:1;transform:translateY(0)}}
.floating-card-wrap{position:absolute;z-index:1;pointer-events:none}
.floating-card{background:white;border-radius:14px;box-shadow:0 8px 32px rgba(0,0,0,.10);border:1px solid rgba(59,91,250,.08);padding:14px 18px;display:flex;align-items:center;gap:10px;animation:floatCard 4s ease-in-out infinite}
.fc-icon{width:34px;height:34px;border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:16px;flex-shrink:0}
.fc-title{font-weight:600;font-size:12px;color:var(--ink)}
.fc-sub{font-size:11px;color:var(--text-muted);margin-top:1px}
.fc-wrap-1{top:20%;left:-10px}
.fc-wrap-2{bottom:22%;right:-10px}
@keyframes floatCard{0%,100%{transform:translateY(0)}50%{transform:translateY(-10px)}}

/* SECTIONS */
section{padding:96px 24px}
.section-label{display:inline-block;font-size:12px;font-weight:600;letter-spacing:2px;text-transform:uppercase;color:var(--accent);margin-bottom:12px}
.section-title{font-family:'Syne',sans-serif;font-size:clamp(28px,4vw,44px);font-weight:800;line-height:1.15;letter-spacing:-1px;color:var(--ink)}
.section-sub{font-size:16px;color:var(--text-muted);max-width:520px;margin-top:14px;line-height:1.6;font-weight:300}
.centered{text-align:center}
.centered .section-sub{margin-left:auto;margin-right:auto}

/* FEATURES */
#features{background:var(--ink);position:relative;overflow:hidden}
#features::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse 60% 50% at 20% 50%,rgba(59,91,250,.18) 0%,transparent 70%),radial-gradient(ellipse 40% 50% at 80% 30%,rgba(0,212,170,.10) 0%,transparent 70%);pointer-events:none}
#features .section-label{color:var(--accent-2)}
#features .section-title{color:white}
#features .section-sub{color:rgba(255,255,255,.5)}
.features-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:24px;max-width:1100px;margin:56px auto 0}
.feature-card{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.08);border-radius:18px;padding:32px;transition:all .3s;position:relative;overflow:hidden}
.feature-card::before{content:'';position:absolute;inset:0;border-radius:18px;background:linear-gradient(135deg,rgba(59,91,250,.12),transparent);opacity:0;transition:opacity .3s}
.feature-card:hover{transform:translateY(-6px);border-color:rgba(59,91,250,.3)}
.feature-card:hover::before{opacity:1}
.fc-num{font-family:'Syne',sans-serif;font-size:11px;font-weight:700;color:rgba(255,255,255,.2);letter-spacing:2px;margin-bottom:20px}
.feature-icon{width:48px;height:48px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:20px;margin-bottom:20px}
.feature-card h3{font-family:'Syne',sans-serif;font-size:18px;font-weight:700;color:white;margin-bottom:10px}
.feature-card p{font-size:14px;color:rgba(255,255,255,.5);line-height:1.65;font-weight:300}

/* HOW IT WORKS */
#how{background:white}
.steps-track{max-width:900px;margin:64px auto 0;display:flex;flex-direction:column;position:relative}
.steps-track::before{content:'';position:absolute;left:28px;top:0;bottom:0;width:2px;background:linear-gradient(to bottom,var(--accent),var(--accent-2))}
.step-item{display:flex;gap:28px;align-items:flex-start;padding:28px 0;position:relative;opacity:0;transform:translateX(-20px);transition:all .5s}
.step-item.visible{opacity:1;transform:translateX(0)}
.step-circle{width:58px;height:58px;border-radius:50%;flex-shrink:0;display:flex;align-items:center;justify-content:center;font-family:'Syne',sans-serif;font-size:18px;font-weight:800;background:white;border:3px solid var(--accent);color:var(--accent);position:relative;z-index:1;transition:all .3s}
.step-item:hover .step-circle{background:var(--accent);color:white;box-shadow:0 4px 20px rgba(59,91,250,.3)}
.step-body{padding-top:10px}
.step-body h3{font-family:'Syne',sans-serif;font-size:20px;font-weight:700;color:var(--ink);margin-bottom:8px}
.step-body p{font-size:15px;color:var(--text-muted);line-height:1.6;font-weight:300}

/* CTA */
#cta{background:linear-gradient(135deg,var(--accent) 0%,#1a3bd4 100%);text-align:center;position:relative;overflow:hidden}
#cta::before{content:'';position:absolute;inset:0;background-image:linear-gradient(rgba(255,255,255,.04) 1px,transparent 1px),linear-gradient(90deg,rgba(255,255,255,.04) 1px,transparent 1px);background-size:40px 40px}
#cta .section-title{color:white;position:relative}
#cta .section-sub{color:rgba(255,255,255,.7);position:relative}
.btn-cta{padding:15px 36px;border-radius:10px;background:white;color:var(--accent);font-family:'DM Sans',sans-serif;font-size:15px;font-weight:600;border:none;cursor:pointer;transition:all .22s;margin-top:36px;position:relative;display:inline-block}
.btn-cta:hover{transform:translateY(-2px);box-shadow:0 8px 28px rgba(0,0,0,.2)}

/* FOOTER */
footer{background:var(--ink);padding:40px 56px;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:16px}
.footer-logo{font-family:'Syne',sans-serif;font-size:18px;font-weight:800;color:white}
.footer-logo span{color:var(--accent)}
footer p{color:rgba(255,255,255,.35);font-size:13px}
.footer-links{display:flex;gap:20px}
.footer-links a{color:rgba(255,255,255,.4);font-size:13px;text-decoration:none;transition:color .2s}
.footer-links a:hover{color:white}

/* MODAL */
.modal-overlay{position:fixed;inset:0;z-index:999;background:var(--modal-bg);backdrop-filter:blur(10px);display:flex;align-items:center;justify-content:center;padding:20px;opacity:0;pointer-events:none;transition:opacity .3s}
.modal-overlay.active{opacity:1;pointer-events:all}
.modal{background:white;border-radius:24px;width:100%;max-width:480px;box-shadow:0 32px 80px rgba(0,0,0,.22);transform:translateY(30px) scale(.97);transition:transform .35s cubic-bezier(.34,1.56,.64,1);max-height:92vh;overflow-y:auto}
.modal-overlay.active .modal{transform:translateY(0) scale(1)}
.modal-header{padding:28px 32px 0;display:flex;align-items:flex-start;justify-content:space-between}
.modal-title{font-family:'Syne',sans-serif;font-size:22px;font-weight:800;color:var(--ink)}
.modal-sub{font-size:13px;color:var(--text-muted);margin-top:4px;font-weight:300}
.modal-close{width:34px;height:34px;border-radius:8px;background:var(--surface);border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;color:var(--text-muted);transition:all .2s;flex-shrink:0;font-size:16px}
.modal-close:hover{background:#fee2e2;color:#ef4444}
.modal-tabs{display:flex;padding:20px 32px 0;border-bottom:1px solid var(--border);margin-top:4px}
.modal-tab{padding:10px 20px;border:none;background:none;cursor:pointer;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:500;color:var(--text-muted);border-bottom:2px solid transparent;margin-bottom:-1px;transition:all .2s}
.modal-tab.active{color:var(--accent);border-bottom-color:var(--accent)}
.modal-body{padding:24px 32px 28px}
.tab-pane{display:none}
.tab-pane.active{display:block}

/* FORM */
.form-group{margin-bottom:16px}
.form-label{display:block;font-size:13px;font-weight:500;color:var(--ink);margin-bottom:6px}
.form-input,.form-select{width:100%;padding:11px 14px;border-radius:10px;border:1.5px solid var(--border);font-family:'DM Sans',sans-serif;font-size:14px;color:var(--ink);background:white;outline:none;transition:border .2s,box-shadow .2s;appearance:none}
.form-input:focus,.form-select:focus{border-color:var(--accent);box-shadow:0 0 0 3px rgba(59,91,250,.10)}
.form-input.is-err,.form-select.is-err{border-color:var(--error)!important;box-shadow:0 0 0 3px rgba(239,68,68,.10)!important}
.form-input::placeholder{color:#b0b8cc}
.select-wrap{position:relative}
.select-wrap::after{content:'▾';position:absolute;right:14px;top:50%;transform:translateY(-50%);pointer-events:none;color:var(--text-muted);font-size:13px}
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:12px}
.input-wrap{position:relative}
.input-wrap .form-input{padding-right:44px}
.toggle-pw{position:absolute;right:12px;top:50%;transform:translateY(-50%);background:none;border:none;cursor:pointer;color:var(--text-muted);font-size:14px;padding:4px;transition:color .2s;line-height:1}
.toggle-pw:hover{color:var(--accent)}

/* field errors */
.field-err{font-size:11px;color:var(--error);margin-top:5px;display:none;align-items:center;gap:5px;line-height:1.4}
.field-err.show{display:flex}
.field-err i{font-size:11px;flex-shrink:0}

/* SUBMIT BUTTON */
.btn-submit{width:100%;padding:13px;border-radius:10px;background:var(--accent);color:white;font-family:'DM Sans',sans-serif;font-size:15px;font-weight:500;border:none;cursor:pointer;margin-top:8px;box-shadow:0 4px 16px rgba(59,91,250,.25);transition:all .22s;position:relative;overflow:hidden;display:flex;align-items:center;justify-content:center;gap:8px}
.btn-submit::before{content:'';position:absolute;inset:0;background:linear-gradient(90deg,transparent,rgba(255,255,255,.15),transparent);transform:translateX(-100%);transition:transform .5s}
.btn-submit:hover::before{transform:translateX(100%)}
.btn-submit:hover:not(:disabled){background:#2a47e8;transform:translateY(-1px)}
.btn-submit:disabled{opacity:.7;cursor:not-allowed;transform:none}
.spinner{width:16px;height:16px;border:2px solid rgba(255,255,255,.4);border-top-color:white;border-radius:50%;animation:spin .6s linear infinite;display:none;flex-shrink:0}
@keyframes spin{to{transform:rotate(360deg)}}
.form-footer{text-align:center;margin-top:16px;font-size:13px;color:var(--text-muted)}
.form-footer a{color:var(--accent);text-decoration:none;font-weight:500;cursor:pointer}
.form-footer a:hover{text-decoration:underline}

/* ── STATUS BANNER ──
   Icon is a <div class="sb-icon"> that holds a Font Awesome <i> tag.
   We set the icon class via JS — never textContent on the icon div itself.
*/
.status-banner{display:none;align-items:flex-start;gap:12px;padding:14px 16px;border-radius:12px;margin-bottom:20px;border:1.5px solid transparent}
.status-banner.show{display:flex;animation:slideDown .35s ease}
@keyframes slideDown{from{opacity:0;transform:translateY(-10px)}to{opacity:1;transform:translateY(0)}}
.status-banner.s-success{background:#f0fdf4;border-color:#86efac}
.status-banner.s-error  {background:#fef2f2;border-color:#fca5a5}
.status-banner.s-warning{background:#fffbeb;border-color:#fcd34d}

.sb-icon{width:34px;height:34px;border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;font-size:15px}
.s-success .sb-icon{background:#dcfce7;color:#15803d}
.s-error   .sb-icon{background:#fee2e2;color:#dc2626}
.s-warning .sb-icon{background:#fef3c7;color:#d97706}

.sb-body{flex:1}
.sb-title{font-size:13px;font-weight:600}
.s-success .sb-title{color:#065f46}
.s-error   .sb-title{color:#7f1d1d}
.s-warning .sb-title{color:#78350f}
.sb-msg{font-size:12px;margin-top:3px;font-weight:300;line-height:1.5}
.s-success .sb-msg{color:#166534}
.s-error   .sb-msg{color:#991b1b}
.s-warning .sb-msg{color:#92400e}

.toast{position:fixed;bottom:28px;right:28px;z-index:9999;border-radius:14px;box-shadow:0 8px 32px rgba(0,0,0,.14);display:flex;align-items:center;gap:12px;padding:14px 18px 14px 14px;transform:translateY(20px) scale(.96);opacity:0;transition:all .35s cubic-bezier(.34,1.56,.64,1);pointer-events:none;min-width:270px;max-width:360px;border:1.5px solid transparent}
.toast.show{transform:translateY(0) scale(1);opacity:1;pointer-events:all}
.toast.t-success{background:#f0fdf4;border-color:#86efac;color:#065f46}
.toast.t-error  {background:#fef2f2;border-color:#fca5a5;color:#7f1d1d}
.toast.t-warning{background:#fffbeb;border-color:#fcd34d;color:#78350f}

.t-icon{width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:14px;flex-shrink:0}
.t-success .t-icon{background:#dcfce7;color:#15803d}
.t-error   .t-icon{background:#fee2e2;color:#dc2626}
.t-warning .t-icon{background:#fef3c7;color:#d97706}

.t-body{flex:1}
.t-title{font-weight:600;font-size:13px}
.t-msg{font-size:12px;margin-top:2px;font-weight:300;opacity:.85}
.t-close{background:none;border:none;cursor:pointer;font-size:16px;opacity:.45;padding:0 0 0 8px;transition:opacity .2s;line-height:1;color:inherit}
.t-close:hover{opacity:1}

/* RESPONSIVE */
@media(max-width:900px){
  .navbar{padding:16px 24px}
  .nav-links{display:none}
  .nav-links.open{display:flex;flex-direction:column;position:absolute;top:68px;left:0;right:0;background:white;border-bottom:1px solid var(--border);padding:16px 24px;box-shadow:0 8px 24px rgba(0,0,0,.08);z-index:99}
  .hamburger{display:flex}
  .fc-wrap-1,.fc-wrap-2{display:none}
  section{padding:72px 24px}
  footer{padding:32px 24px;flex-direction:column;text-align:center}
  .footer-links{justify-content:center}
}
@media(max-width:600px){
  .hero{padding:110px 20px 70px}
  .hero-stats{gap:24px}
  .form-row{grid-template-columns:1fr}
  .modal-body,.modal-header{padding-left:20px;padding-right:20px}
  .modal-tabs{padding-left:20px;padding-right:20px}
}
.reveal{opacity:0;transform:translateY(28px);transition:opacity .6s,transform .6s}
.reveal.visible{opacity:1;transform:translateY(0)}
</style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar" id="navbar">
  <a href="#" class="nav-logo"><div class="logo-dot"></div>Smart<span>Assess</span>AI</a>
  <div class="nav-links" id="navLinks">
    <a href="#features" class="nav-btn nav-btn-ghost">Features</a>
    <a href="#how" class="nav-btn nav-btn-ghost">How It Works</a>
    <button type="button" class="nav-btn nav-btn-ghost" onclick="openModal('login')">Login</button>
    <button type="button" class="nav-btn nav-btn-primary" onclick="openModal('signup')">Get Started</button>
  </div>
  <div class="hamburger" id="hamburger" onclick="toggleNav()">
    <span></span><span></span><span></span>
  </div>
</nav>

<!-- HERO -->
<section class="hero" id="home">
  <div class="hero-bg">
    <div class="blob blob-1"></div><div class="blob blob-2"></div><div class="blob blob-3"></div>
  </div>
  <div class="hero-grid"></div>
  <div class="floating-card-wrap fc-wrap-1">
    <div class="floating-card" style="animation-delay:0s">
      <div class="fc-icon" style="background:#eef1ff">&#129302;</div>
      <div><div class="fc-title">AI Generated</div><div class="fc-sub">Test ready in 3s</div></div>
    </div>
  </div>
  <div class="floating-card-wrap fc-wrap-2">
    <div class="floating-card" style="animation-delay:1.8s">
      <div class="fc-icon" style="background:#f0fdf9">&#9989;</div>
      <div><div class="fc-title">Instant Results</div><div class="fc-sub">Score: 94/100</div></div>
    </div>
  </div>
  <div class="hero-content">
    <div class="hero-tag"><span class="hero-tag-dot"></span>Powered by Advanced AI</div>
    <h1>Assess Smarter,<br><em>Not Harder</em></h1>
    <p class="hero-sub">AI-powered platform to create, manage, and evaluate tests intelligently -- built for educators and learners of tomorrow.</p>
    <div class="hero-actions">
      <button type="button" class="btn-hero-primary" onclick="openModal('signup')">Start for Free &rarr;</button>
      <button type="button" class="btn-hero-secondary" onclick="openModal('login')">Sign In</button>
    </div>
    <div class="hero-stats">
      <div class="stat"><div class="stat-num">10K+</div><div class="stat-label">Tests Created</div></div>
      <div class="stat"><div class="stat-num">98%</div><div class="stat-label">Accuracy Rate</div></div>
      <div class="stat"><div class="stat-num">3x</div><div class="stat-label">Faster Grading</div></div>
    </div>
  </div>
</section>

<!-- FEATURES -->
<section id="features">
  <div style="max-width:1100px;margin:0 auto;position:relative">
    <div class="centered reveal">
      <div class="section-label">What We Offer</div>
      <h2 class="section-title">Everything you need<br>to assess brilliantly</h2>
      <p class="section-sub">Four powerful capabilities working in harmony to transform how you test and learn.</p>
    </div>
    <div class="features-grid">
      <div class="feature-card reveal"><div class="fc-num">01</div><div class="feature-icon" style="background:rgba(59,91,250,.15)"><i class="fa-solid fa-brain" style="color:white"></i></div><h3>AI Test Generation</h3><p>Create intelligent, adaptive tests automatically from any topic or document in seconds.</p></div>
      <div class="feature-card reveal" style="transition-delay:.1s"><div class="fc-num">02</div><div class="feature-icon" style="background:rgba(0,212,170,.15)"><i class="fa-solid fa-bolt-lightning" style="color:white"></i></div><h3>Instant Evaluation</h3><p>Get detailed scores, analytics, and personalized AI feedback the moment you submit.</p></div>
      <div class="feature-card reveal" style="transition-delay:.2s"><div class="fc-num">03</div><div class="feature-icon" style="background:rgba(255,107,107,.15)"><i class="fa-solid fa-lock" style="color:white"></i></div><h3>Role-Based Access</h3><p>Distinct dashboards for Admins and Students — everyone gets exactly the controls they need.</p></div>
      <div class="feature-card reveal" style="transition-delay:.3s"><div class="fc-num">04</div><div class="feature-icon" style="background:rgba(255,193,7,.15)"><i class="fa-solid fa-shield-halved" style="color:white"></i></div><h3>Secure & Reliable</h3><p>JWT-based authentication with encrypted sessions — your data is always safe with us.</p></div>
    </div>
  </div>
</section>

<!-- HOW IT WORKS -->
<section id="how">
  <div style="max-width:1100px;margin:0 auto">
    <div class="centered reveal">
      <div class="section-label">Process</div>
      <h2 class="section-title">Up and running<br>in four steps</h2>
      <p class="section-sub">Simple, intuitive, powerful. Go from zero to assessment in minutes.</p>
    </div>
    <div class="steps-track">
      <div class="step-item"><div class="step-circle">1</div><div class="step-body"><h3>Create Your Account</h3><p>Register as an Admin or Student in under a minute. No credit card required.</p></div></div>
      <div class="step-item"><div class="step-circle">2</div><div class="step-body"><h3>Log In Securely</h3><p>Access your personalized dashboard with secure JWT authentication.</p></div></div>
      <div class="step-item"><div class="step-circle">3</div><div class="step-body"><h3>Create or Take a Test</h3><p>Admins build AI-powered assessments. Students complete tests at their own pace.</p></div></div>
      <div class="step-item"><div class="step-circle">4</div><div class="step-body"><h3>Get Instant AI Results</h3><p>Detailed scores, visual analytics, and AI-powered feedback delivered instantly.</p></div></div>
    </div>
  </div>
</section>

<!-- CTA -->
<section id="cta">
  <div class="centered reveal" style="position:relative">
    <div class="section-label" style="color:rgba(255,255,255,.6)">Get Started Today</div>
    <h2 class="section-title">Ready to transform<br>how you assess?</h2>
    <p class="section-sub" style="margin-left:auto;margin-right:auto">Join thousands of educators and students already using Smart Assess AI.</p>
    <button type="button" class="btn-cta" onclick="openModal('signup')">Create Free Account &rarr;</button>
  </div>
</section>

<!-- FOOTER -->
<footer>
  <div class="footer-logo">Smart<span>Assess</span> AI</div>
  <div class="footer-links"><a href="#">Privacy</a><a href="#">Terms</a><a href="#">Contact</a></div>
  <p>&copy; 2026 SmartAssess AI. All rights reserved.</p>
</footer>

<!-- ════════ MODAL ════════ -->
<div class="modal-overlay" id="modalOverlay" onclick="overlayClick(event)">
  <div class="modal">
    <div class="modal-header">
      <div>
        <div class="modal-title" id="modalTitle">Welcome Back</div>
        <div class="modal-sub"  id="modalSub">Sign in to your account</div>
      </div>
      <!-- close button uses FA icon -->
      <button type="button" class="modal-close" onclick="closeModal()" title="Close">
        <i class="fa-solid fa-xmark"></i>
      </button>
    </div>
    <div class="modal-tabs">
      <button type="button" class="modal-tab" id="tabLogin"  onclick="switchTab('login')">Login</button>
      <button type="button" class="modal-tab" id="tabSignup" onclick="switchTab('signup')">Sign Up</button>
    </div>
    <div class="modal-body">

      <!-- ══ LOGIN PANE ══ -->
      <div class="tab-pane" id="paneLogin">

        <!--
          sb-icon holds an <i> tag — JS sets its class.
          Never set textContent on .sb-icon itself.
        -->
        <div class="status-banner" id="lBanner">
          <div class="sb-icon"><i id="lBannerIco"></i></div>
          <div class="sb-body">
            <div class="sb-title" id="lBannerTitle"></div>
            <div class="sb-msg"   id="lBannerMsg"></div>
          </div>
        </div>

        <!-- POST /smartai/login  →  fields: email, role, password -->
        <form id="loginForm" action="/smartai/login" method="post"
              novalidate onsubmit="return validateLogin()">

          <div class="form-group">
            <label class="form-label" for="loginEmail">Email Address</label>
            <input type="email" id="loginEmail" name="email" class="form-input"
                   placeholder="you@example.com" autocomplete="email">
            <div class="field-err" id="loginEmailErr">
              <i class="fa-solid fa-circle-exclamation"></i><span>Please enter a valid email address.</span>
            </div>
          </div>

          <div class="form-group">
            <label class="form-label" for="loginRole">Role</label>
            <div class="select-wrap">
              <select id="loginRole" name="role" class="form-select">
                <option value="">Select your role</option>
                <option value="student">Student</option>
                <option value="admin">Admin</option>
              </select>
            </div>
            <div class="field-err" id="loginRoleErr">
              <i class="fa-solid fa-circle-exclamation"></i><span>Please select a role.</span>
            </div>
          </div>

          <div class="form-group">
            <label class="form-label" for="loginPass">Password</label>
            <div class="input-wrap">
              <input type="password" id="loginPass" name="password" class="form-input"
                     placeholder="Enter your password" autocomplete="current-password">
              <button type="button" class="toggle-pw" onclick="togglePw('loginPass',this)" tabindex="-1">
                <i class="fa-regular fa-eye"></i>
              </button>
            </div>
            <div class="field-err" id="loginPassErr">
              <i class="fa-solid fa-circle-exclamation"></i><span>Please enter your password.</span>
            </div>
          </div>

          <button type="submit" class="btn-submit" id="loginBtn">
            <span id="loginBtnTxt">Sign In &rarr;</span>
            <div class="spinner" id="loginSpinner"></div>
          </button>
        </form>

        <div class="form-footer">
          Don't have an account? <a onclick="switchTab('signup')">Create one free</a>
        </div>
      </div><!-- /paneLogin -->

      <!-- ══ SIGNUP PANE ══ -->
      <div class="tab-pane" id="paneSignup">

        <div class="status-banner" id="rBanner">
          <div class="sb-icon"><i id="rBannerIco"></i></div>
          <div class="sb-body">
            <div class="sb-title" id="rBannerTitle"></div>
            <div class="sb-msg"   id="rBannerMsg"></div>
          </div>
        </div>

        <!-- POST /smartai/register  →  fields: name, phone, email, role, password -->
        <form id="signupForm" action="/smartai/register" method="post"
              novalidate onsubmit="return validateSignup()">

          <div class="form-row">
            <div class="form-group">
              <label class="form-label" for="regName">Full Name</label>
              <input type="text" id="regName" name="name" class="form-input"
                     placeholder="Jane Doe" autocomplete="name">
              <div class="field-err" id="regNameErr">
                <i class="fa-solid fa-circle-exclamation"></i><span>Please enter your full name.</span>
              </div>
            </div>
            <div class="form-group">
              <label class="form-label" for="regPhone">Phone Number</label>
              <input type="tel" id="regPhone" name="phone" class="form-input"
                     placeholder="+91 98765 43210" autocomplete="tel">
              <div class="field-err" id="regPhoneErr">
                <i class="fa-solid fa-circle-exclamation"></i><span>Enter a valid phone number.</span>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label class="form-label" for="regEmail">Email Address</label>
            <input type="email" id="regEmail" name="email" class="form-input"
                   placeholder="you@example.com" autocomplete="email">
            <div class="field-err" id="regEmailErr">
              <i class="fa-solid fa-circle-exclamation"></i><span>Please enter a valid email address.</span>
            </div>
          </div>

          <div class="form-group">
            <label class="form-label" for="regRole">Role</label>
            <div class="select-wrap">
              <select id="regRole" name="role" class="form-select">
                <option value="">Select your role</option>
                <option value="student">Student</option>
                <option value="admin" disabled>Admin</option>
              </select>
            </div>
            <div class="field-err" id="regRoleErr">
              <i class="fa-solid fa-circle-exclamation"></i><span>Please select a role.</span>
            </div>
          </div>

          <div class="form-group">
            <label class="form-label" for="regPass">Password</label>
            <div class="input-wrap">
              <input type="password" id="regPass" name="password" class="form-input"
                     placeholder="Minimum 6 characters" autocomplete="new-password">
              <button type="button" class="toggle-pw" onclick="togglePw('regPass',this)" tabindex="-1">
                <i class="fa-regular fa-eye"></i>
              </button>
            </div>
            <div class="field-err" id="regPassErr">
              <i class="fa-solid fa-circle-exclamation"></i><span>Password must be at least 6 characters.</span>
            </div>
          </div>

          <button type="submit" class="btn-submit" id="signupBtn">
            <span id="signupBtnTxt">Create Account &rarr;</span>
            <div class="spinner" id="signupSpinner"></div>
          </button>
        </form>

        <div class="form-footer">
          Already have an account? <a onclick="switchTab('login')">Sign in</a>
        </div>
      </div><!-- /paneSignup -->

    </div>
  </div>
</div><!-- /modal-overlay -->

<!-- TOAST — t-icon holds an <i> tag set by JS -->
<div class="toast" id="toast">
  <div class="t-icon"><i id="tIco"></i></div>
  <div class="t-body">
    <div class="t-title" id="tTitle"></div>
    <div class="t-msg"   id="tMsg"></div>
  </div>
  <button type="button" class="t-close" onclick="hideToast()">
    <i class="fa-solid fa-xmark"></i>
  </button>
</div>

<script>
/* 
   UTILITIES
*/
const $ = id => document.getElementById(id);
const emailRx = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const phoneRx = /^[\+\d][\d\s\-\(\)]{6,}$/;

/* ─── FA icon class map for banner / toast ─── */
const FA = {
  success: 'fa-solid fa-circle-check',
  error:   'fa-solid fa-circle-xmark',
  warning: 'fa-solid fa-triangle-exclamation'
};

/* NAVBAR */
window.addEventListener('scroll', () => {
  $('navbar').classList.toggle('scrolled', scrollY > 30);
});
function toggleNav() {
  $('hamburger').classList.toggle('open');
  $('navLinks').classList.toggle('open');
}

/*
   SCROLL REVEAL
 */
const io = new IntersectionObserver(entries => {
  entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); });
}, { threshold: 0.12 });
document.querySelectorAll('.reveal, .step-item').forEach(el => io.observe(el));

/* MODAL*/
function openModal(tab) {
  $('modalOverlay').classList.add('active');
  document.body.style.overflow = 'hidden';
  switchTab(tab);
}
function closeModal() {
  $('modalOverlay').classList.remove('active');
  document.body.style.overflow = '';
}
function overlayClick(e) {
  if (e.target.id === 'modalOverlay') closeModal();
}
document.addEventListener('keydown', e => { if (e.key === 'Escape') closeModal(); });

/* switchTab — switches pane + clears errors + hides both banners */
function switchTab(tab) {
  const isLogin = (tab === 'login');
  $('tabLogin').classList.toggle('active',   isLogin);
  $('tabSignup').classList.toggle('active', !isLogin);
  $('paneLogin').classList.toggle('active',  isLogin);
  $('paneSignup').classList.toggle('active',!isLogin);
  $('modalTitle').textContent = isLogin ? 'Welcome Back'           : 'Create Account';
  $('modalSub').textContent   = isLogin ? 'Sign in to your account' : 'Join SmartAssess AI today';
  clearErrors();
  hideBanner('l');
  hideBanner('r');
}

/*
   PASSWORD TOGGLE */
function togglePw(id, btn) {
  const inp = $(id);
  const showing = inp.type === 'password';
  inp.type = showing ? 'text' : 'password';
  btn.innerHTML = showing
    ? '<i class="fa-regular fa-eye-slash"></i>'
    : '<i class="fa-regular fa-eye"></i>';
}

/* ═══════════════════════════════════════════
   FIELD ERRORS
═══════════════════════════════════════════ */
function markErr(inputId, errId) {
  $(inputId).classList.add('is-err');
  $(errId).classList.add('show');
}
function clearErr(inputId, errId) {
  $(inputId).classList.remove('is-err');
  $(errId).classList.remove('show');
}
function clearErrors() {
  [
    ['loginEmail','loginEmailErr'], ['loginRole','loginRoleErr'], ['loginPass','loginPassErr'],
    ['regName','regNameErr'], ['regPhone','regPhoneErr'], ['regEmail','regEmailErr'],
    ['regRole','regRoleErr'], ['regPass','regPassErr']
  ].forEach(([a,b]) => clearErr(a,b));
}


function showBanner(prefix, type, title, msg) {
  /* prefix: 'l' → login pane, 'r' → signup pane */
  $('lBannerIco'.replace('l', prefix)).className = FA[type] || FA.error; /* icon <i> */
  $('lBannerTitle'.replace('l', prefix)).textContent = title;
  $('lBannerMsg'.replace('l', prefix)).textContent   = msg;
  $(prefix + 'Banner').className = 'status-banner s-' + type + ' show';
}
function hideBanner(prefix) {
  $(prefix + 'Banner').className = 'status-banner';
}

/* ─── cleaner version without string replace tricks ─── */
function _applyBanner(prefix, type, title, msg) {
  /* set icon class */
  $(prefix + 'BannerIco').className = FA[type] || FA.error;
  /* set text */
  $(prefix + 'BannerTitle').textContent = title;
  $(prefix + 'BannerMsg').textContent   = msg;
  /* show banner */
  $(prefix + 'Banner').className = 'status-banner s-' + type + ' show';
}

/* override showBanner with clean version */
function showBanner(prefix, type, title, msg) {
  _applyBanner(prefix, type, title, msg);
}


let _toastTimer;
function showToast(type, title, msg) {
  $('tIco').className    = FA[type] || FA.error;   /* ← set FA class, not textContent */
  $('tTitle').textContent = title;
  $('tMsg').textContent   = msg;
  $('toast').className    = 'toast t-' + type + ' show';
  clearTimeout(_toastTimer);
  _toastTimer = setTimeout(hideToast, 5000);
}
function hideToast() { $('toast').className = 'toast'; }

/* ═══════════════════════════════════════════
   LOADING STATE
═══════════════════════════════════════════ */
function setLoad(prefix, on) {
  const isLogin = prefix === 'login';
  $(prefix + 'Btn').disabled = on;
  $(prefix + 'BtnTxt').innerHTML = on
    ? (isLogin ? 'Signing in&hellip;' : 'Creating account&hellip;')
    : (isLogin ? 'Sign In &rarr;'     : 'Create Account &rarr;');
  $(prefix + 'Spinner').style.display = on ? 'inline-block' : 'none';
}


function validateLogin() {
  clearErrors(); hideBanner('l');
  const email = $('loginEmail').value.trim();
  const role  = $('loginRole').value;
  const pass  = $('loginPass').value;
  let ok = true;
  if (!emailRx.test(email)) { markErr('loginEmail','loginEmailErr'); ok=false; }
  if (!role)                 { markErr('loginRole', 'loginRoleErr');  ok=false; }
  if (!pass)                 { markErr('loginPass', 'loginPassErr');  ok=false; }
  if (!ok) return false;
  setLoad('login', true);
  return true; /* → POST /smartai/login */
}

function validateSignup() {
  clearErrors(); hideBanner('r');
  const name  = $('regName').value.trim();
  const phone = $('regPhone').value.trim();
  const email = $('regEmail').value.trim();
  const role  = $('regRole').value;
  const pass  = $('regPass').value;
  let ok = true;
  if (!name)                { markErr('regName', 'regNameErr');   ok=false; }
  if (!phoneRx.test(phone)) { markErr('regPhone','regPhoneErr');  ok=false; }
  if (!emailRx.test(email)) { markErr('regEmail','regEmailErr');  ok=false; }
  if (!role)                { markErr('regRole', 'regRoleErr');   ok=false; }
  if (pass.length < 6)      { markErr('regPass', 'regPassErr');   ok=false; }
  if (!ok) return false;
  setLoad('signup', true);
  return true; /* → POST /smartai/register */
}


const STATUS_MAP = {
  registered: {
    pane:'login',  banner:'l', type:'success',
    title:'Registration Successful! 🎉',
    msg:'Your account has been created. Please sign in below.',
    toast:['success','Account Created!','Please log in to continue.']
  },
  email_exists: {
    pane:'signup', banner:'r', type:'warning',
    title:'Email Already Registered',
    msg:'An account with this email already exists. Please log in instead.',
    toast:['warning','Already Registered','This email is already in use.']
  },
  register_failed: {
    pane:'signup', banner:'r', type:'error',
    title:'Registration Failed',
    msg:'Something went wrong. Please check your details and try again.',
    toast:['error','Registration Failed','Please try again.']
  },
  login_failed: {
    pane:'login',  banner:'l', type:'error',
    title:'Login Failed',
    msg:'Incorrect email, role, or password. Please check and try again.',
    toast:['error','Login Failed','Check your credentials and retry.']
  },
  wrong_password: {
    pane:'login',  banner:'l', type:'error',
    title:'Wrong Password',
    msg:'The password you entered is incorrect. Please try again.',
    toast:['error','Wrong Password','Please re-enter your password.']
  },
  not_found: {
    pane:'login',  banner:'l', type:'error',
    title:'Account Not Found',
    msg:'No account found with this email. Please register first.',
    toast:['error','Not Found','No account exists with this email.']
  }
};


(function init() {
  const params    = new URLSearchParams(window.location.search);
  const statusKey = params.get('status'); 
  const modalHint = params.get('modal');  
  if (!statusKey && !modalHint) {
    switchTab('login');
    return;
  }

  const cfg = STATUS_MAP[statusKey]; 
  const targetPane = (cfg && cfg.pane) || modalHint || 'login';


  $('modalOverlay').classList.add('active');
  document.body.style.overflow = 'hidden';

  switchTab(targetPane);

  if (cfg) {
    showBanner(cfg.banner, cfg.type, cfg.title, cfg.msg);
    if (cfg.toast) showToast(...cfg.toast);
  }

  window.history.replaceState({}, document.title, window.location.pathname);
})();
</script>
</body>
</html>