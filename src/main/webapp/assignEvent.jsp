<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

<title>Assign Event | EventHub</title>

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

.admin-profile {
    display: flex;
    align-items: center;
    gap: 12px;
}

.admin-avatar {
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

.page-heading h3 {
    font-size: 26px;
    font-weight: 750;
    color: #1e293b;
}

.page-heading p {
    color: #94a3b8;
    font-size: 15px;
}

/* Assignment Panel */

.assignment-panel {
    background: white;
    border: 1px solid #edf0f4;
    border-radius: 15px;
    padding: 28px;
    margin-top: 25px;
    box-shadow: 0 3px 15px rgba(0,0,0,0.025);
}

.panel-heading {
    display: flex;
    align-items: center;
    gap: 13px;
    padding-bottom: 22px;
    margin-bottom: 25px;
    border-bottom: 1px solid #edf0f4;
}

.panel-icon {
    width: 48px;
    height: 48px;
    background: #eef2ff;
    color: #4361ee;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 23px;
}

.panel-heading h5 {
    font-size: 19px;
    font-weight: 700;
    color: #1e293b;
    margin: 0 0 4px;
}

.panel-heading p {
    font-size: 14px;
    color: #94a3b8;
    margin: 0;
}

/* Form */

.form-label {
    font-size: 14px;
    font-weight: 650;
    color: #334155;
    margin-bottom: 9px;
}

.form-select {
    min-height: 48px;
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    font-size: 14px;
    padding: 11px 38px 11px 13px;
    color: #334155;
}

.form-select:focus {
    border-color: #4361ee;
    box-shadow: 0 0 0 3px rgba(67,97,238,0.10);
}

.input-group-text {
    background: #f8faff;
    border-color: #e2e8f0;
    color: #64748b;
}

.input-group .form-select {
    border-left: 0;
}

.field-help {
    font-size: 12px;
    color: #94a3b8;
    margin-top: 7px;
}

/* Preview Cards */

.preview-panel {
    background: #f8faff;
    border: 1px solid #e7ecf5;
    border-radius: 12px;
    padding: 20px;
    height: 100%;
}

.preview-panel h6 {
    font-size: 15px;
    font-weight: 700;
    color: #334155;
    margin-bottom: 16px;
}

.preview-item {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 13px;
}

.preview-item:last-child {
    margin-bottom: 0;
}

.preview-item i {
    width: 35px;
    height: 35px;
    background: #eef2ff;
    color: #4361ee;
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
    flex-shrink: 0;
}

.preview-item small {
    display: block;
    color: #94a3b8;
    font-size: 12px;
}

.preview-item strong {
    display: block;
    color: #334155;
    font-size: 13px;
    font-weight: 600;
    overflow-wrap: anywhere;
}

/* Assignment Information */

.assignment-info {
    background: #eef2ff;
    border: 1px solid #dce5ff;
    border-radius: 11px;
    padding: 17px;
    margin-top: 22px;
}

.assignment-info i {
    color: #4361ee;
    font-size: 17px;
}

.assignment-info p {
    color: #64748b;
    font-size: 13px;
    margin: 0;
}

/* Buttons */

.form-actions {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 12px;
    border-top: 1px solid #edf0f4;
    margin-top: 25px;
    padding-top: 22px;
}

.btn-assign {
    background: #4361ee;
    color: white;
    border: none;
    border-radius: 8px;
    padding: 11px 20px;
    font-size: 14px;
    font-weight: 650;
    transition: 0.2s;
}

.btn-assign:hover {
    background: #304bd1;
    color: white;
    transform: translateY(-2px);
}

.btn-cancel {
    background: #f1f5f9;
    color: #475569;
    border: none;
    border-radius: 8px;
    padding: 11px 20px;
    font-size: 14px;
    font-weight: 600;
    text-decoration: none;
    transition: 0.2s;
}

.btn-cancel:hover {
    background: #e2e8f0;
    color: #334155;
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

}

@media(max-width: 576px) {

    .admin-email {
        display: none;
    }

    .assignment-panel {
        padding: 20px 16px;
    }

    .page-heading h3 {
        font-size: 23px;
    }

    .form-actions {
        flex-direction: column-reverse;
    }

    .form-actions .btn,
    .form-actions .btn-cancel {
        width: 100%;
        text-align: center;
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

    <a href="admin.jsp" class="sidebar-link">
        <i class="bi bi-grid-1x2"></i>
        Dashboard
    </a>

    <a href="findAllEvents" class="sidebar-link active">
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
                    onclick="toggleSidebar()">

                <i class="bi bi-list fs-4"></i>

            </button>

            <div>
                <h5>Assign Event</h5>
                <small class="text-muted">Allocate events to managers</small>
            </div>

        </div>

        <div class="admin-profile">

            <div class="text-end admin-email">

                <div class="fw-semibold">
                    Administrator
                </div>

                <small class="text-muted"><%=email%></small>

            </div>

            <div class="admin-avatar">
                <i class="bi bi-person-fill"></i>
            </div>

        </div>

    </div>

    <!-- Page Content -->

    <main class="page-content">

        <div class="breadcrumb-text">
            Dashboard / Events / <strong class="text-dark">Assign Event</strong>
        </div>

        <!-- Heading -->

        <div class="page-heading">

            <h3>Assign Event to Manager</h3>

            <p>
                Select an event and an event manager to create an assignment.
            </p>

        </div>

        <!-- Assignment Panel -->

        <div class="assignment-panel">

            <div class="panel-heading">

                <div class="panel-icon">
                    <i class="bi bi-person-check"></i>
                </div>

                <div>
                    <h5>Assignment Details</h5>
                    <p>Choose the manager and event below.</p>
                </div>

            </div>

            <form action="assignEvent" method="post" id="assignForm">

                <div class="row g-4">

                    <!-- Manager Selection -->

                    <div class="col-md-6">

                        <label class="form-label" for="managerId">
                            Select Event Manager <span class="text-danger">*</span>
                        </label>

                        <div class="input-group">

                            <span class="input-group-text">
                                <i class="bi bi-person"></i>
                            </span>

                            <select name="managerId"
                                    id="managerId"
                                    class="form-select"
                                    required>

                                <option value="">Choose a manager</option>

                                <c:forEach items="${managers}" var="manager">

                                    <option value="${manager.id}"
                                        ${param.managerId == manager.id ? 'selected' : ''}>

                                        <c:out value="${manager.name}"/> -
                                        <c:out value="${manager.email}"/>

                                    </option>

                                </c:forEach>

                            </select>

                        </div>

                        <small class="field-help">
                            Select the manager responsible for this event.
                        </small>

                    </div>

                    <!-- Event Selection -->

                    <div class="col-md-6">

                        <label class="form-label" for="eventId">
                            Select Event <span class="text-danger">*</span>
                        </label>

                        <div class="input-group">

                            <span class="input-group-text">
                                <i class="bi bi-calendar-event"></i>
                            </span>

                            <select name="eventId"
                                    id="eventId"
                                    class="form-select"
                                    required>

                                <option value="">Choose an event</option>

                                <c:forEach items="${events}" var="event">

                                    <option value="${event.eventId}">

                                        <c:out value="${event.eventName}"/>

                                    </option>

                                </c:forEach>

                            </select>

                        </div>

                        <small class="field-help">
                            Select the event you want to assign.
                        </small>

                    </div>

                    <!-- Assignment Preview -->

                    <div class="col-12">

                        <div class="preview-panel">

                            <h6>
                                <i class="bi bi-eye me-2 text-primary"></i>
                                Assignment Preview
                            </h6>

                            <div class="row g-3">

                                <div class="col-md-6">

                                    <div class="preview-item">

                                        <i class="bi bi-person-badge"></i>

                                        <div>
                                            <small>Selected Manager</small>
                                            <strong id="managerPreview">
                                                Not selected
                                            </strong>
                                        </div>

                                    </div>

                                </div>

                                <div class="col-md-6">

                                    <div class="preview-item">

                                        <i class="bi bi-calendar-check"></i>

                                        <div>
                                            <small>Selected Event</small>
                                            <strong id="eventPreview">
                                                Not selected
                                            </strong>
                                        </div>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

                <!-- Information -->

                <div class="assignment-info d-flex align-items-start gap-3">

                    <i class="bi bi-info-circle"></i>

                    <p>
                        Please verify the selected manager and event before
                        submitting. The assignment will be processed when
                        you click the Assign Event button.
                    </p>

                </div>

                <!-- Buttons -->

                <div class="form-actions">

                    <a href="findAllEvents" class="btn-cancel">
                        <i class="bi bi-arrow-left me-1"></i>
                        Back to Events
                    </a>

                    <button type="reset" class="btn btn-light border">
                        <i class="bi bi-arrow-counterclockwise me-1"></i>
                        Reset
                    </button>

                    <button type="submit" class="btn btn-assign">
                        <i class="bi bi-check-circle me-1"></i>
                        Assign Event
                    </button>

                </div>

            </form>

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

    // Assignment Preview

    const managerSelect = document.getElementById("managerId");
    const eventSelect = document.getElementById("eventId");

    const managerPreview = document.getElementById("managerPreview");
    const eventPreview = document.getElementById("eventPreview");

    function updatePreview() {

        const selectedManager =
            managerSelect.options[managerSelect.selectedIndex];

        const selectedEvent =
            eventSelect.options[eventSelect.selectedIndex];

        managerPreview.textContent =
            managerSelect.value
                ? selectedManager.text.trim()
                : "Not selected";

        eventPreview.textContent =
            eventSelect.value
                ? selectedEvent.text.trim()
                : "Not selected";

    }

    managerSelect.addEventListener("change", updatePreview);
    eventSelect.addEventListener("change", updatePreview);

    // Display preselected manager, if available

    updatePreview();

    // Reset Preview

    document.getElementById("assignForm").addEventListener("reset", function() {

        setTimeout(updatePreview, 0);

    });

    // Form Validation

    document.getElementById("assignForm").addEventListener("submit", function(event) {

        if (!managerSelect.value || !eventSelect.value) {

            event.preventDefault();

            alert("Please select both an event manager and an event.");

        }

    });

</script>

</body>
</html>
