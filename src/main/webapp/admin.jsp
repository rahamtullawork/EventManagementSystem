
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");

    if (email == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Admin Dashboard | Event Management System</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
      rel="stylesheet">

<style>
    

body {
    background: #f5f7fb;
    font-family: 'Segoe UI', Arial, sans-serif;
    color: #263238;
    font-size: 16px;
    line-height: 1.6;
}

/* Sidebar */

.sidebar {
    width: 260px;
    min-height: 100vh;
    background: #ffffff;
    border-right: 1px solid #e9edf2;
    position: fixed;
    top: 0;
    left: 0;
    z-index: 1040;
    padding: 25px 15px;
    transition: transform 0.3s ease;
}

.brand {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 10px 12px 30px;
    border-bottom: 1px solid #edf0f4;
    margin-bottom: 25px;
}

.brand-icon {
    width: 45px;
    height: 45px;
    background: #e8efff;
    color: #4361ee;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 26px;
}

.brand h5 {
    font-size: 21px;
    font-weight: 750;
    margin: 0;
    color: #1e293b;
}

.brand small {
    color: #64748b;
    font-size: 14px;
}

.menu-label {
    font-size: 13px;
    text-transform: uppercase;
    letter-spacing: 1.5px;
    color: #64748b;
    font-weight: 700;
    padding: 0 15px;
    margin-bottom: 12px;
}

.sidebar-link {
    display: flex;
    align-items: center;
    gap: 13px;
    padding: 14px 16px;
    color: #475569;
    text-decoration: none;
    border-radius: 10px;
    margin-bottom: 8px;
    font-size: 16px;
    font-weight: 600;
    transition: all 0.25s ease;
}

.sidebar-link i {
    font-size: 21px;
}

.sidebar-link:hover {
    background: #f0f4ff;
    color: #3152d5;
    transform: translateX(4px);
}

.sidebar-link.active {
    background: #eef2ff;
    color: #3152d5;
    font-weight: 700;
}

.sidebar-link.logout {
    color: #c62828;
}

.sidebar-link.logout:hover {
    background: #fff0f0;
    color: #c62828;
}

/* Main Content */

.main-content {
    margin-left: 260px;
    min-height: 100vh;
}

/* Topbar */

.topbar {
    background: #ffffff;
    padding: 18px 35px;
    border-bottom: 1px solid #e9edf2;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.topbar h5 {
    font-size: 21px;
    font-weight: 700;
    margin: 0;
    color: #1e293b;
}

.topbar small {
    font-size: 14px;
    color: #64748b !important;
}

.admin-profile {
    display: flex;
    align-items: center;
    gap: 12px;
}

.admin-avatar {
    width: 45px;
    height: 45px;
    background: #eef2ff;
    color: #4361ee;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 23px;
}

.admin-email .small {
    font-size: 15px !important;
    color: #263238;
}

.admin-email small {
    font-size: 14px;
    color: #475569 !important;
}

/* Dashboard */

.dashboard-content {
    padding: 35px;
}

.welcome-banner {
    background:
        linear-gradient(110deg,
            rgba(35, 50, 150, 0.97),
            rgba(65, 85, 190, 0.92)),
        url('https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=1400');

    background-size: cover;
    background-position: center;
    border-radius: 18px;
    padding: 40px;
    color: #ffffff;
    position: relative;
    overflow: hidden;
}

.welcome-banner h2 {
    font-size: 32px;
    font-weight: 750;
    margin-bottom: 15px;
    color: #ffffff;
    line-height: 1.3;
}

.welcome-banner p {
    color: #ffffff;
    font-size: 17px;
    max-width: 600px;
    margin-bottom: 0;
    line-height: 1.8;
}

.welcome-banner .badge {
    font-size: 14px;
    font-weight: 700;
}

.welcome-icon {
    font-size: 85px;
    opacity: 0.35;
    color: #ffffff;
}

/* Section Heading */

.section-title {
    margin-top: 38px;
    margin-bottom: 22px;
}

.section-title h4 {
    font-size: 24px;
    font-weight: 750;
    margin-bottom: 7px;
    color: #1e293b;
}

.section-title p {
    color: #475569;
    font-size: 16px;
    margin: 0;
}

/* Dashboard Cards */

.dashboard-card {
    background: #ffffff;
    border: 1px solid #edf0f4;
    border-radius: 16px;
    padding: 28px;
    height: 100%;
    text-decoration: none;
    color: inherit;
    display: block;
    transition: all 0.3s ease;
}

.dashboard-card:hover {
    transform: translateY(-7px);
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.08);
    border-color: #dce4ff;
}

.card-icon {
    width: 58px;
    height: 58px;
    border-radius: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 29px;
    margin-bottom: 25px;
}

.event-icon {
    background: #e8efff;
    color: #3152d5;
}

.manager-icon {
    background: #e6f8f1;
    color: #087d60;
}

.dashboard-card h5 {
    font-size: 21px;
    color: #1e293b;
    font-weight: 700;
    margin-bottom: 12px;
}

.dashboard-card p {
    color: #475569;
    font-size: 16px;
    line-height: 1.8;
    min-height: 58px;
}

.card-action {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-size: 16px;
    font-weight: 700;
    color: #3152d5;
    margin-top: 15px;
}

.dashboard-card:hover .card-action i {
    transform: translateX(5px);
}

.card-action i {
    transition: transform 0.3s ease;
}

/* Info Panel */

.info-panel {
    background: #ffffff;
    border: 1px solid #edf0f4;
    border-radius: 16px;
    padding: 25px;
    margin-top: 30px;
}

.info-panel h5 {
    font-size: 21px;
    font-weight: 700;
    margin-bottom: 12px;
    color: #1e293b;
}

.info-panel p {
    color: #475569;
    font-size: 16px;
    margin-bottom: 0;
    line-height: 1.9;
}

/* Footer */

.footer {
    text-align: center;
    padding: 25px;
    color: #64748b;
    font-size: 15px;
}

/* Mobile */

.mobile-menu-btn {
    display: none;
}

@media (max-width: 991px) {
    .sidebar {
        transform: translateX(-100%);
    }

    .sidebar.show {
        transform: translateX(0);
    }

    .main-content {
        margin-left: 0;
    }

    .mobile-menu-btn {
        display: inline-flex;
    }

    .dashboard-content {
        padding: 20px;
    }

    .topbar {
        padding: 15px 20px;
    }

    .welcome-banner {
        padding: 28px;
    }

    .welcome-icon {
        display: none;
    }
}

@media (max-width: 576px) {
    .admin-email {
        display: none;
    }

    .welcome-banner h2 {
        font-size: 25px;
    }

    .welcome-banner p {
        font-size: 16px;
    }

    .dashboard-card {
        padding: 22px;
    }

    .dashboard-card p {
        min-height: auto;
    }

    .section-title h4 {
        font-size: 21px;
    }
}

</style>
</head>

<body>

<!-- Sidebar -->

<aside class="sidebar" id="sidebar">

    <div class="brand">
        <div class="brand-icon">
            <i class="bi bi-calendar-event"></i>
        </div>

        <div>
            <h5>EventHub</h5>
            <small>Management Portal</small>
        </div>
    </div>

    <p class="menu-label">Main Menu</p>

    <a href="admin.jsp" class="sidebar-link active">
        <i class="bi bi-grid-1x2"></i>
        Dashboard
    </a>

    <a href="findAllEvents" class="sidebar-link">
        <i class="bi bi-calendar-check"></i>
        Manage Events
    </a>

    <a href="findAllManagers" class="sidebar-link">
        <i class="bi bi-people"></i>
        Event Managers
    </a>

    <div class="mt-4">
        <p class="menu-label">Account</p>

        <a href="logout" class="sidebar-link logout">
            <i class="bi bi-box-arrow-right"></i>
            Logout
        </a>
    </div>

</aside>

<!-- Main Content -->

<div class="main-content">

    <!-- Topbar -->

    <div class="topbar">

        <div class="d-flex align-items-center gap-3">

            <button class="btn btn-light mobile-menu-btn"
                    type="button"
                    onclick="toggleSidebar()"
                    aria-label="Toggle navigation">
                <i class="bi bi-list fs-4"></i>
            </button>

            <div>
                <h5>Admin Dashboard</h5>
                <small class="text-muted">
                    Event Management Overview
                </small>
            </div>

        </div>

        <div class="admin-profile">

            <div class="text-end admin-email">
                <div class="fw-semibold small">Administrator</div>
                <small class="text-muted"><%=email%></small>
            </div>

            <div class="admin-avatar">
                <i class="bi bi-person-fill"></i>
            </div>

        </div>

    </div>

    <!-- Dashboard Content -->

    <main class="dashboard-content">

        <!-- Welcome Banner -->

        <div class="welcome-banner">

            <div class="row align-items-center">

                <div class="col-lg-9">

                    <span class="badge bg-white text-primary mb-3 px-3 py-2">
                        Admin Portal
                    </span>

                    <h2>Welcome back, Administrator!</h2>

                    <p>
                        Manage your events, coordinate event managers,
                        and keep everything organized from one
                        convenient dashboard.
                    </p>

                </div>

                <div class="col-lg-3 text-center">
                    <i class="bi bi-calendar2-heart welcome-icon"></i>
                </div>

            </div>

        </div>

        <!-- Section Title -->

        <div class="section-title">
            <h4>Quick Management</h4>
            <p>Choose what you would like to manage today.</p>
        </div>

        <!-- Management Cards -->

        <div class="row g-4">

            <div class="col-md-6">

                <a href="findAllEvents" class="dashboard-card">

                    <div class="card-icon event-icon">
                        <i class="bi bi-calendar-event"></i>
                    </div>

                    <h5>Manage Events</h5>

                    <p>
                        View all events created by event managers,
                        monitor event details, and delete events
                        when necessary.
                    </p>

                    <span class="card-action">
                        View All Events
                        <i class="bi bi-arrow-right"></i>
                    </span>

                </a>

            </div>

            <div class="col-md-6">

                <a href="findAllManagers" class="dashboard-card">

                    <div class="card-icon manager-icon">
                        <i class="bi bi-people-fill"></i>
                    </div>

                    <h5>Manage Event Managers</h5>

                    <p>
                        View event managers, update their information,
                        assign events, and remove managers
                        when required.
                    </p>

                    <span class="card-action">
                        Manage Event Managers
                        <i class="bi bi-arrow-right"></i>
                    </span>

                </a>

            </div>

        </div>

        <!-- Information Panel -->

        <div class="info-panel">

            <div class="d-flex align-items-center gap-3 mb-3">

                <div class="card-icon event-icon mb-0"
                     style="width:45px;height:45px;font-size:21px;">
                    <i class="bi bi-info-circle"></i>
                </div>

                <h5 class="mb-0">Administration Overview</h5>

            </div>

            <p>
                As an administrator, you have access to event
                management and event manager administration.
                Use the navigation menu or quick management
                cards to access the available features.
            </p>

        </div>

    </main>

    <!-- Footer -->

    <footer class="footer">
        © 2026 EventHub | Event Management System
    </footer>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function toggleSidebar() {
        document.getElementById("sidebar").classList.toggle("show");
    }

    // Close sidebar when clicking outside on mobile
    document.addEventListener("click", function(event) {

        const sidebar = document.getElementById("sidebar");
        const menuButton = document.querySelector(".mobile-menu-btn");

        if (window.innerWidth <= 991 &&
            sidebar.classList.contains("show") &&
            !sidebar.contains(event.target) &&
            !menuButton.contains(event.target)) {

            sidebar.classList.remove("show");
        }
    });
</script>

</body>
</html>
