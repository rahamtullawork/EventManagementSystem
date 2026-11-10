
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String email = (String) session.getAttribute("email");

    if (email == null || !"manager".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Event Manager Dashboard | EventHub</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
      rel="stylesheet">

<style>

body {
    margin: 0;
    background: #f5f7fb;
    font-family: 'Segoe UI', Arial, sans-serif;
    color: #263238;
}

/* Sidebar */

.sidebar {
    width: 260px;
    min-height: 100vh;
    background: white;
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
    font-size: 23px;
}

.brand h5 {
    font-size: 21px;
    font-weight: 750;
    margin: 0;
    color: #1e293b;
}

.brand small {
    font-size: 13px;
    color: #94a3b8;
}

.menu-label {
    font-size: 12px;
    text-transform: uppercase;
    letter-spacing: 1.5px;
    color: #94a3b8;
    font-weight: 700;
    padding: 0 15px;
    margin-bottom: 12px;
}

.sidebar-link {
    display: flex;
    align-items: center;
    gap: 13px;
    padding: 13px 16px;
    color: #64748b;
    text-decoration: none;
    border-radius: 10px;
    margin-bottom: 8px;
    font-size: 15px;
    font-weight: 500;
    transition: 0.25s;
}

.sidebar-link i {
    font-size: 19px;
}

.sidebar-link:hover {
    background: #f0f4ff;
    color: #4361ee;
    transform: translateX(4px);
}

.sidebar-link.active {
    background: #eef2ff;
    color: #4361ee;
    font-weight: 600;
}

.sidebar-link.logout {
    color: #dc3545;
}

.sidebar-link.logout:hover {
    background: #fff0f0;
    color: #dc3545;
}

/* Main Content */

.main-content {
    margin-left: 260px;
    min-height: 100vh;
}

/* Topbar */

.topbar {
    background: white;
    padding: 18px 35px;
    border-bottom: 1px solid #e9edf2;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.topbar h5 {
    font-size: 19px;
    font-weight: 700;
    margin: 0;
}

.topbar small {
    font-size: 14px;
}

.manager-profile {
    display: flex;
    align-items: center;
    gap: 12px;
}

.manager-avatar {
    width: 42px;
    height: 42px;
    background: #eef2ff;
    color: #4361ee;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 21px;
}

/* Page Content */

.page-content {
    padding: 30px 35px;
}

.breadcrumb-text {
    color: #94a3b8;
    font-size: 14px;
    margin-bottom: 22px;
}

/* Welcome Banner */

.welcome-banner {
    position: relative;
    background:
        linear-gradient(90deg, rgba(30,41,90,0.94), rgba(67,97,238,0.72)),
        url('https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=1400')
        center/cover;
    border-radius: 16px;
    padding: 40px 35px;
    color: white;
    overflow: hidden;
    margin-bottom: 30px;
}

.welcome-banner h2 {
    font-size: 32px;
    font-weight: 750;
    margin-bottom: 12px;
}

.welcome-banner p {
    font-size: 17px;
    color: #e0e7ff;
    margin-bottom: 22px;
    max-width: 600px;
}

.welcome-banner .welcome-icon {
    position: absolute;
    right: 50px;
    bottom: -25px;
    font-size: 150px;
    color: rgba(255,255,255,0.12);
}

.welcome-btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: white;
    color: #4361ee;
    text-decoration: none;
    padding: 11px 18px;
    border-radius: 8px;
    font-size: 16px;
    font-weight: 650;
    transition: 0.25s;
}

.welcome-btn:hover {
    background: #e8efff;
    color: #304bd1;
    transform: translateY(-2px);
}

/* Section Heading */

.section-heading {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 12px;
    margin-bottom: 20px;
}

.section-heading h4 {
    font-size: 21px;
    font-weight: 750;
    color: #1e293b;
    margin: 0;
}

.section-heading p {
    font-size: 14px;
    color: #94a3b8;
    margin: 5px 0 0;
}

/* Dashboard Cards */

.dashboard-card {
    background: white;
    border: 1px solid #edf0f4;
    border-radius: 15px;
    padding: 25px;
    height: 100%;
    box-shadow: 0 3px 15px rgba(0,0,0,0.025);
    transition: all 0.3s ease;
}

.dashboard-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
    border-color: #dce5ff;
}

.card-icon {
    width: 55px;
    height: 55px;
    border-radius: 13px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 25px;
    margin-bottom: 20px;
}

.icon-blue {
    background: #e8efff;
    color: #4361ee;
}

.icon-green {
    background: #e6f8f1;
    color: #16a085;
}

.dashboard-card h5 {
    font-size: 23px;
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 10px;
}

.dashboard-card p {
    color: #64748b;
    font-size: 17px;
    line-height: 1.7;
    margin-bottom: 22px;
}

.card-link {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
    font-size: 14px;
    font-weight: 650;
    color: #4361ee;
    transition: 0.2s;
}

.card-link:hover {
    gap: 13px;
    color: #304bd1;
}

.card-link.green {
    color: #16a085;
}

.card-link.green:hover {
    color: #11836e;
}

/* Quick Information Panel */

.info-panel {
    background: white;
    border: 1px solid #edf0f4;
    border-radius: 15px;
    padding: 23px 25px;
    margin-top: 28px;
    box-shadow: 0 3px 15px rgba(0,0,0,0.025);
}

.info-panel h5 {
    font-size: 17px;
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 18px;
}

.info-item {
    display: flex;
    align-items: center;
    gap: 13px;
    padding: 12px 0;
    border-bottom: 1px solid #f0f2f5;
}

.info-item:last-child {
    border-bottom: none;
}

.info-item i {
    font-size: 19px;
    color: #4361ee;
}

.info-item span {
    font-size: 14px;
    color: #64748b;
}

/* Footer */

.footer {
    text-align: center;
    padding: 25px;
    color: #94a3b8;
    font-size: 14px;
}

/* Mobile */

.mobile-menu-btn {
    display: none;
}

@media(max-width: 991px) {

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

    .page-content {
        padding: 22px 18px;
    }

    .topbar {
        padding: 15px 20px;
    }

    .welcome-banner .welcome-icon {
        right: 20px;
        font-size: 110px;
    }

}

@media(max-width: 576px) {

    .manager-email {
        display: none;
    }

    .welcome-banner {
        padding: 30px 22px;
    }

    .welcome-banner h2 {
        font-size: 23px;
    }

    .welcome-banner .welcome-icon {
        display: none;
    }

    .dashboard-card {
        padding: 22px;
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

    <a href="eventmanager.jsp" class="sidebar-link active">
        <i class="bi bi-grid-1x2"></i>
        Dashboard
    </a>

    <a href="findMyEvents" class="sidebar-link">
        <i class="bi bi-calendar-check"></i>
        My Events
    </a>

    <a href="addEvent.jsp" class="sidebar-link">
        <i class="bi bi-plus-circle"></i>
        Add Event
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
                    onclick="toggleSidebar()">

                <i class="bi bi-list fs-4"></i>

            </button>

            <div>
                <h5>Manager Dashboard</h5>
                <small class="text-muted">Your event management workspace</small>
            </div>

        </div>

        <div class="manager-profile">

            <div class="text-end manager-email">

                <div class="fw-semibold">
                    Event Manager
                </div>

                <small class="text-muted"><%=email%></small>

            </div>

            <div class="manager-avatar">
                <i class="bi bi-person-fill"></i>
            </div>

        </div>

    </div>

    <!-- Page Content -->

    <main class="page-content">

        <div class="breadcrumb-text">
            Dashboard / <strong class="text-dark">Overview</strong>
        </div>

        <!-- Welcome Banner -->

        <section class="welcome-banner">

            <div class="position-relative" style="z-index: 1;">

                <h2>Welcome to EventHub!</h2>

                <p>
                    Hello, <strong><%=email%></strong>.
                    Manage your events, organize activities,
                    and keep everything running smoothly from one place.
                </p>

                <a href="addEvent.jsp" class="welcome-btn">
                    <i class="bi bi-plus-circle"></i>
                    Create New Event
                </a>

            </div>

            <i class="bi bi-calendar2-event welcome-icon"></i>

        </section>

        <!-- Section Heading -->

        <div class="section-heading">

            <div>
                <h4>Quick Actions</h4>
                <p>Choose what you would like to do today.</p>
            </div>

        </div>

        <!-- Dashboard Cards -->

        <div class="row g-4">

            <!-- Add Event Card -->

            <div class="col-lg-6 col-md-6">

                <div class="dashboard-card">

                    <div class="card-icon icon-blue">
                        <i class="bi bi-calendar-plus"></i>
                    </div>

                    <h5>Add New Event</h5>

                    <p>
                        Create and organize a new event by providing
                        its name, description, date, time, venue, and capacity.
                    </p>

                    <a href="addEvent.jsp" class="card-link">
                        Create Event
                        <i class="bi bi-arrow-right"></i>
                    </a>

                </div>

            </div>

            <!-- Manage Events Card -->

            <div class="col-lg-6 col-md-6">

                <div class="dashboard-card">

                    <div class="card-icon icon-green">
                        <i class="bi bi-calendar-check"></i>
                    </div>

                    <h5>Manage My Events</h5>

                    <p>
                        View all your events and manage their information.
                        You can edit event details or delete events when required.
                    </p>

                    <a href="findMyEvents" class="card-link green">
                        View My Events
                        <i class="bi bi-arrow-right"></i>
                    </a>

                </div>

            </div>

        </div>

        <!-- Information Panel -->

        <div class="info-panel">

            <h5>
                <i class="bi bi-info-circle text-primary me-2"></i>
                Quick Information
            </h5>

            <div class="info-item">

                <i class="bi bi-person-check"></i>

                <span>
                    You are logged in as an Event Manager.
                </span>

            </div>

            <div class="info-item">

                <i class="bi bi-calendar-plus"></i>

                <span>
                    Use Add New Event to create an event.
                </span>

            </div>

            <div class="info-item">

                <i class="bi bi-pencil-square"></i>

                <span>
                    Use Manage My Events to edit or delete your events.
                </span>

            </div>

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

    // Mobile Sidebar

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
