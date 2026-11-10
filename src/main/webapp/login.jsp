
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Event Management System - Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<style>

body {
    min-height: 100vh;
    background:
        linear-gradient(rgba(20, 30, 45, 0.35),
                        rgba(20, 30, 45, 0.45)),
        url('https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=1920');

    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
}

/* Login Card */

.login-container {
    width: 550px;
    max-width: 95%;

    background: #FFFDF8;

    border-radius: 15px;

    box-shadow: 0 10px 35px rgba(0,0,0,0.25);

    animation: fadeIn 0.7s ease;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Heading */

.login-title {
    color: #263B5A;
    font-weight: 700;
}

.login-subtitle {
    color: #777;
    font-size: 14px;
}

/* Form Controls */

.form-control, .form-select {
    padding: 12px;
    border-radius: 7px;
    border: 1px solid #ddd;
}

.form-control:focus, .form-select:focus {
    border-color: #527A9A;
    box-shadow: 0 0 0 0.2rem rgba(82,122,154,0.15);
}

/* Login Button */

.login-btn {
    background-color: #527A9A;
    color: white;
    border: none;
    padding: 13px;
    border-radius: 7px;
    font-weight: 600;
    transition: 0.3s;
}

.login-btn:hover {
    background-color: #365C7B;
    color: white;
    transform: translateY(-2px);
}

/* Password Toggle */

.password-box {
    position: relative;
}

.password-toggle {
    position: absolute;
    right: 12px;
    top: 50%;
    transform: translateY(-50%);
    border: none;
    background: none;
    color: #527A9A;
    font-size: 13px;
    font-weight: bold;
    cursor: pointer;
}

/* Error */

.error {
    color: #dc3545;
    background: #fff0f0;
    padding: 10px;
    border-radius: 5px;
    font-size: 14px;
}

/* Footer */

.footer {
    color: #888;
    font-size: 12px;
}

@media(max-width: 576px) {
    body {
        background-attachment: scroll;
    }
}

</style>
</head>

<body class="d-flex justify-content-center align-items-center py-4">

<div class="login-container p-4 p-md-5">

    <!-- Heading -->

    <div class="text-center mb-4">

        <div class="fs-1 mb-2">🎉</div>

        <h2 class="login-title">
            Event Management System
        </h2>

        <p class="login-subtitle mt-2 mb-0">
            Welcome back! Please login to continue.
        </p>

    </div>

    <!-- Error Message -->

    <%
        String status = (String) request.getAttribute("status");

        if(status != null) {
    %>

        <div class="error text-center mb-3">
            <%= status %>
        </div>

    <%
        }
    %>

    <!-- Login Form -->

    <form action="login" method="post">
        <div class="mb-3">

            <label for="email" class="form-label fw-semibold">
                Email Address
            </label>

            <input type="email"
                   class="form-control"
                   id="email"
                   name="email"
                   placeholder="Enter your email"
                   required>

        </div>

        <div class="mb-3">

            <label for="password" class="form-label fw-semibold">
                Password
            </label>

            <div class="password-box">

                <input type="password"
                       class="form-control"
                       id="password"
                       name="password"
                       placeholder="Enter your password"
                       required>

                <button type="button"
                        class="password-toggle"
                        onclick="togglePassword()">
                    Show
                </button>

            </div>

        </div>

        <button type="submit" class="btn login-btn w-100 mt-3">
            Login to Dashboard →
        </button>

    </form>

    <div class="footer text-center mt-4">
        © 2026 Event Management System. All Rights Reserved.
    </div>

</div>

<script>

function togglePassword() {

    let password = document.getElementById("password");
    let button = document.querySelector(".password-toggle");

    if(password.type === "password") {

        password.type = "text";
        button.innerText = "Hide";

    } else {

        password.type = "password";
        button.innerText = "Show";

    }

}

</script>

</body>
</html>
