<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Add Event Manager | EventHub</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f5f7fb;
    color: #1e293b;
    font-size: 15px;
}

/* Sidebar */
.sidebar {
    width: 260px;
    height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    background: #fff;
    border-right: 1px solid #e8edf4;
    padding: 24px 18px;
    z-index: 1000;
    transition: transform 0.3s ease;
}

.brand {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 0 10px;
    margin-bottom: 35px;
    font-size: 23px;
    font-weight: bold;
    color: #4361ee;
}

.brand i {
    font-size: 27px;
}

.menu-label {
    color: #94a3b8;
    font-size: 12px;
    font-weight: bold;
    text-transform: uppercase;
    padding: 0 12px;
    margin-bottom: 12px;
}

.sidebar a {
    display: flex;
    align-items: center;
    gap: 13px;
    padding: 12px 14px;
    margin-bottom: 7px;
    color: #64748b;
    text-decoration: none;
    border-radius: 8px;
    font-size: 14px;
    transition: 0.2s;
}

.sidebar a:hover,
.sidebar a.active {
    background: #eef2ff;
    color: #4361ee;
}

.sidebar a.active {
    font-weight: 600;
}

.sidebar a i {
    font-size: 18px;
}

/* Main Content */
.main-content {
    margin-left: 260px;
    min-height: 100vh;
}

.topbar {
    height: 70px;
    background: #fff;
    border-bottom: 1px solid #e8edf4;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 30px;
}

.topbar-left {
    display: flex;
    align-items: center;
    gap: 15px;
}

.menu-toggle {
    display: none;
    border: none;
    background: transparent;
    font-size: 23px;
    color: #334155;
}

.topbar h6 {
    margin: 0;
    font-size: 16px;
    font-weight: 600;
}

.profile {
    display: flex;
    align-items: center;
    gap: 10px;
    color: #475569;
    font-size: 14px;
}

.profile-icon {
    width: 36px;
    height: 36px;
    background: #eef2ff;
    color: #4361ee;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 17px;
}

/* Page */
.page-content {
    padding: 30px;
}

.breadcrumb {
    font-size: 13px;
    margin-bottom: 20px;
}

.breadcrumb a {
    color: #64748b;
    text-decoration: none;
}

.breadcrumb .active {
    color: #4361ee;
}

.page-heading {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    flex-wrap: wrap;
    gap: 12px;
}

.page-heading h3 {
    font-size: 25px;
    font-weight: 700;
    margin-bottom: 6px;
}

.page-heading p {
    color: #64748b;
    font-size: 14px;
    margin: 0;
}

/* Form Card */
.form-card {
    background: #fff;
    border: 1px solid #edf0f5;
    border-radius: 12px;
    padding: 28px;
    box-shadow: 0 3px 12px rgba(15, 23, 42, 0.03);
}

.form-card-header {
    display: flex;
    align-items: center;
    gap: 12px;
    padding-bottom: 20px;
    margin-bottom: 22px;
    border-bottom: 1px solid #edf0f5;
}

.form-icon {
    width: 43px;
    height: 43px;
    background: #eef2ff;
    color: #4361ee;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 21px;
}

.form-card-header h5 {
    font-size: 18px;
    font-weight: 600;
    margin: 0 0 4px;
}

.form-card-header p {
    font-size: 13px;
    color: #64748b;
    margin: 0;
}

.form-label {
    font-size: 14px;
    font-weight: 600;
    color: #334155;
    margin-bottom: 8px;
}

.form-control {
    min-height: 43px;
    border: 1px solid #dce2eb;
    border-radius: 7px;
    font-size: 14px;
    padding: 10px 12px;
}

.form-control:focus {
    border-color: #4361ee;
    box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.10);
}

.input-group-text {
    background: #f8fafc;
    color: #64748b;
    border-color: #dce2eb;
}

.input-group .form-control {
    border-radius: 0 7px 7px 0;
}

.input-group-text:first-child {
    border-radius: 7px 0 0 7px;
}

.password-toggle {
    background: #f8fafc;
    color: #64748b;
    border: 1px solid #dce2eb;
    border-left: 0;
    border-radius: 0 7px 7px 0;
    padding: 0 14px;
}

.password-toggle:hover {
    background: #eef2ff;
    color: #4361ee;
}

.form-text {
    font-size: 12px;
    color: #94a3b8;
}

.form-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
    flex-wrap: wrap;
    border-top: 1px solid #edf0f5;
    margin-top: 25px;
    padding-top: 22px;
}

.btn {
    padding: 10px 18px;
    font-size: 14px;
    border-radius: 7px;
    font-weight: 500;
}

.btn-primary {
    background: #4361ee;
    border-color: #4361ee;
}

.btn-primary:hover {
    background: #3451d1;
    border-color: #3451d1;
}

.btn-light {
    background: #f1f5f9;
    border: 1px solid #e2e8f0;
    color: #475569;
}

.btn-light:hover {
    background: #e2e8f0;
}

.info-panel {
    background: #eef2ff;
    border: 1px solid #dce4ff;
    border-radius: 9px;
    padding: 16px;
    margin-top: 22px;
    display: flex;
    gap: 12px;
    align-items: flex-start;
}

.info-panel i {
    color: #4361ee;
    font-size: 19px;
}

.info-panel p {
    color: #475569;
    font-size: 13px;
    margin: 0;
    line-height: 1.6;
}

.footer {
    text-align: center;
    color: #94a3b8;
    font-size: 12px;
    padding: 20px;
}

/* Responsive */
@media (max-width: 768px) {
    .sidebar {
        transform: translateX(-100%);
    }

    .sidebar.show {
        transform: translateX(0);
    }

    .main-content {
        margin-left: 0;
    }

    .menu-toggle {
        display: block;
    }

    .topbar {
        padding: 0 18px;
    }

    .page-content {
        padding: 20px 15px;
    }

    .form-card {
        padding: 20px 16px;
    }

    .page-heading h3 {
        font-size: 22px;
    }
}
</style>
</head>

<body>

<%
    if (session.getAttribute("email") == null ||
        !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">

    <div class="brand">
        <i class="bi bi-calendar-event-fill"></i>
        EventHub
    </div>

    <div class="menu-label">Main Menu</div>

    <a href="admin.jsp">
        <i class="bi bi-grid"></i> Dashboard
    </a>

    <a href="findAllEvents">
        <i class="bi bi-calendar3"></i> Manage Events
    </a>

    <a href="findAllManagers" class="active">
        <i class="bi bi-people"></i> Manage Managers
    </a>

    <div class="menu-label mt-4">Account</div>

    <a href="logout">
        <i class="bi bi-box-arrow-right"></i> Logout
    </a>

</div>

<!-- Main Content -->
<div class="main-content">

    <!-- Topbar -->
    <div class="topbar">

        <div class="topbar-left">
            <button class="menu-toggle" onclick="toggleSidebar()">
                <i class="bi bi-list"></i>
            </button>

            <h6>Add Event Manager</h6>
        </div>

        <div class="profile">
            <div class="profile-icon">
                <i class="bi bi-person-fill"></i>
            </div>
            <span>Administrator</span>
        </div>

    </div>

    <!-- Page Content -->
    <div class="page-content">

        <div class="breadcrumb">
            <a href="admin.jsp">Dashboard</a>
            <span class="mx-2">/</span>
            <a href="findAllManagers">Manage Managers</a>
            <span class="mx-2">/</span>
            <span class="active">Add Manager</span>
        </div>

        <div class="page-heading">
            <div>
                <h3>Add Event Manager</h3>
                <p>Create a new event manager account.</p>
            </div>
        </div>

        <!-- Add Manager Form -->
        <div class="form-card">

            <div class="form-card-header">
                <div class="form-icon">
                    <i class="bi bi-person-plus"></i>
                </div>

                <div>
                    <h5>Manager Information</h5>
                    <p>Enter the manager's personal and account details.</p>
                </div>
            </div>

            <form action="addEventManager" method="post" id="addManagerForm">

                <div class="mb-3">
                    <label class="form-label">
                        Full Name <span class="text-danger">*</span>
                    </label>

                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-person"></i>
                        </span>

                        <input type="text" class="form-control"
                            name="name" maxlength="100"
                            placeholder="Enter manager name" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">
                        Email Address <span class="text-danger">*</span>
                    </label>

                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-envelope"></i>
                        </span>

                        <input type="email" class="form-control"
                            name="email"
                            placeholder="Enter email address" required>
                    </div>
                    <small class="form-text">
                        This email address will be used for manager login.
                    </small>
                </div>

                <div class="mb-3">
                    <label class="form-label">
                        Mobile Number <span class="text-danger">*</span>
                    </label>

                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-telephone"></i>
                        </span>

                        <input type="tel" class="form-control"
                            name="mobile" id="mobile"
                            placeholder="Enter mobile number"
                            pattern="[0-9]{10,15}"
                            maxlength="15"
                            inputmode="numeric" required>
                    </div>
                    <small class="form-text">
                        Enter a mobile number containing 10 to 15 digits.
                    </small>
                </div>

                <div class="mb-3">
                    <label class="form-label">
                        Password <span class="text-danger">*</span>
                    </label>

                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-lock"></i>
                        </span>

                        <input type="password" class="form-control"
                            name="password" id="password"
                            placeholder="Enter password"
                            minlength="8" required>

                        <button type="button" class="password-toggle"
                            onclick="togglePassword()"
                            aria-label="Show password">
                            <i class="bi bi-eye" id="passwordIcon"></i>
                        </button>
                    </div>
                    <small class="form-text">
                        Password must contain at least 8 characters.
                    </small>
                </div>

                <div class="form-actions">

                    <a href="findAllManagers" class="btn btn-light">
                        <i class="bi bi-arrow-left me-1"></i> Cancel
                    </a>

                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-person-plus me-1"></i> Add Manager
                    </button>

                </div>

            </form>

        </div>

        <div class="info-panel">
            <i class="bi bi-info-circle-fill"></i>
            <p>
                <strong>Note:</strong> Ensure the email address is unique.
                The manager can use the registered email and password to log in to EventHub.
            </p>
        </div>

    </div>

    <div class="footer">
        © 2026 EventHub. All rights reserved.
    </div>

</div>

<script>
function toggleSidebar() {
    document.getElementById("sidebar").classList.toggle("show");
}

// Show / Hide password
function togglePassword() {
    const password = document.getElementById("password");
    const icon = document.getElementById("passwordIcon");
    const button = icon.closest("button");

    if (password.type === "password") {
        password.type = "text";
        icon.classList.replace("bi-eye", "bi-eye-slash");
        button.setAttribute("aria-label", "Hide password");
    } else {
        password.type = "password";
        icon.classList.replace("bi-eye-slash", "bi-eye");
        button.setAttribute("aria-label", "Show password");
    }
}

// Allow only digits in the mobile number field
const mobileInput = document.getElementById("mobile");

mobileInput.addEventListener("input", function() {
    this.value = this.value.replace(/[^0-9]/g, "").slice(0, 15);
});

// Form validation
document.getElementById("addManagerForm").addEventListener("submit", function(e) {
    if (!this.checkValidity()) {
        e.preventDefault();
        this.reportValidity();
    }
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
