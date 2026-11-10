<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin Dashboard</title>
<style>
* {
	box-sizing: border-box;
	font-family: Arial
}

body {
	margin: 0;
	background: #f4f6f9;
	color: #253047
}

header {
	background: #1d3557;
	color: white;
	padding: 22px;
	text-align: center
}

nav {
	background: #457b9d;
	padding: 15px;
	text-align: center
}

nav a {
	color: white;
	text-decoration: none;
	margin: 0 14px;
	font-weight: bold
}

.container {
	max-width: 1000px;
	margin: 35px auto;
	padding: 0 18px
}

.panel, .card {
	background: white;
	padding: 25px;
	border-radius: 10px;
	box-shadow: 0 3px 12px #0001
}

.cards {
	display: flex;
	gap: 20px;
	margin-top: 22px;
	flex-wrap: wrap
}

.card {
	flex: 1;
	min-width: 220px
}

.card h3 {
	color: #1d3557
}

.card a {
	color: #1d3557;
	font-weight: bold
}
</style>
</head>
<body>
	<%
	String email = (String) session.getAttribute("email");
	String role = (String) session.getAttribute("role");
	if (email == null || !"admin".equals(role)) {
		response.sendRedirect("login.jsp");
		return;
	}
	%>
	<header>
		<h2>EVENT MANAGEMENT SYSTEM</h2>
	</header>
	<nav>
		<a href="admin.jsp">Home</a><a href="findAllEvents">View All
			Events</a><a href="findAllManagers">View Event Managers</a><a
			href="logout">Logout</a>
	</nav>
	<div class="container">
		<div class="panel">
			<h2>Welcome, Administrator!</h2>
			<p>
				Logged in as <b><%=email%></b>.
			</p>
			<p>Manage events and event managers from this dashboard.</p>
		</div>
		<div class="cards">
			<div class="card">
				<h3>Manage Events</h3>
				<p>View and delete events.</p>
				<a href="findAllEvents">View Events</a>
			</div>
			<div class="card">
				<h3>Manage Event Managers</h3>
				<p>View, edit, assign events and delete managers.</p>
				<a href="findAllManagers">View Managers</a>
			</div>
		</div>
	</div>
</body>
</html>