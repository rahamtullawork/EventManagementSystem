
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.model.Event"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Edit Event | EventHub</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">

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

.sidebar a:hover, .sidebar a.active {
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

textarea.form-control {
	min-height: 105px;
	resize: vertical;
}

.input-group-text {
	background: #f8fafc;
	color: #64748b;
	border-color: #dce2eb;
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
@media ( max-width : 768px) {
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
	String email = (String) session.getAttribute("email");
	String role = (String) session.getAttribute("role");

	if (email == null || (!"admin".equals(role) && !"manager".equals(role))) {
		response.sendRedirect("login.jsp");
		return;
	}

	Event event = (Event) request.getAttribute("event");

	if (event == null) {
		response.sendRedirect("admin".equals(role) ? "findAllEvents" : "findMyEvents");
		return;
	}
	%>

	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">

		<div class="brand">
			<i class="bi bi-calendar-event-fill"></i> EventHub
		</div>

		<div class="menu-label">Main Menu</div>

		<%
		if ("admin".equals(role)) {
		%>

		<a href="admin.jsp"> <i class="bi bi-grid"></i> Dashboard
		</a> <a href="findAllEvents" class="active"> <i
			class="bi bi-calendar3"></i> Manage Events
		</a> <a href="findAllManagers"> <i class="bi bi-people"></i> Manage
			Managers
		</a>

		<%
		} else {
		%>

		<a href="eventmanager.jsp"> <i class="bi bi-grid"></i> Dashboard
		</a> <a href="findMyEvents" class="active"> <i class="bi bi-calendar3"></i>
			My Events
		</a> <a href="addEvent.jsp"> <i class="bi bi-plus-circle"></i> Add
			Event
		</a>

		<%
		}
		%>

		<div class="menu-label mt-4">Account</div>

		<a href="logout"> <i class="bi bi-box-arrow-right"></i> Logout
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

				<h6>Edit Event</h6>
			</div>

			<div class="profile">
				<div class="profile-icon">
					<i class="bi bi-person-fill"></i>
				</div>
				<span><%="admin".equals(role) ? "Administrator" : "Event Manager"%></span>
			</div>

		</div>

		<!-- Page Content -->
		<div class="page-content">

			<div class="breadcrumb">
				<a
					href="<%="admin".equals(role) ? "admin.jsp" : "eventmanager.jsp"%>">
					Dashboard </a> <span class="mx-2">/</span> <a
					href="<%="admin".equals(role) ? "findAllEvents" : "findMyEvents"%>">
					<%="admin".equals(role) ? "Manage Events" : "My Events"%>
				</a> <span class="mx-2">/</span> <span class="active">Edit Event</span>
			</div>

			<div class="page-heading">
				<div>
					<h3>Edit Event</h3>
					<p>Update the event details and save your changes.</p>
				</div>
			</div>

			<!-- Edit Form -->
			<div class="form-card">

				<div class="form-card-header">
					<div class="form-icon">
						<i class="bi bi-pencil-square"></i>
					</div>

					<div>
						<h5>Event Information</h5>
						<p>Modify the information for this event.</p>
					</div>
				</div>

				<form action="updateEvent" method="post" id="editEventForm">
					<input type="hidden" name="eventId" value="<%=event.getEventId()%>">

					<div class="mb-3">

						<label class="form-label"> Client Name <span
							class="text-danger">*</span>
						</label>

						<div class="input-group">

							<span class="input-group-text"> <i class="bi bi-person"></i>
							</span> <input type="text" class="form-control" name="clientName"
								value="<%=event.getClientName()%>" maxlength="150" required>

						</div>

					</div>

					<div class="mb-3">

						<label class="form-label"> Mobile Number <span
							class="text-danger">*</span>
						</label>
						<div class="input-group">
							<span class="input-group-text"> <i class="bi bi-telephone"></i>
							</span> <input type="tel" class="form-control" name="mobileNumber"
								value="<%=event.getMobileNumber()%>" maxlength="15"
								pattern="[0-9]{10,15}" required>
						</div>
					</div>

					<div class="mb-3">
						<label class="form-label"> Event Name <span
							class="text-danger">*</span>
						</label>
						<div class="input-group">

							<span class="input-group-text"> <i
								class="bi bi-calendar-event"></i>
							</span> <input type="text" class="form-control" name="eventName"
								value="<%=event.getEventName()%>" maxlength="150" required>
						</div>
					</div>

					<div class="mb-3">
						<label class="form-label">Description <span
							class="text-danger">*</span></label>
						<textarea class="form-control" name="description" id="description"
							maxlength="1000" required><%=event.getDescription()%></textarea>
						<div class="d-flex justify-content-end">
							<small class="form-text"> <span id="charCount">0</span>/1000
								characters
							</small>
						</div>
					</div>

					<div class="row">
						<div class="col-md-6 mb-3">
							<label class="form-label">Event Date <span
								class="text-danger">*</span></label>
							<div class="input-group">
								<span class="input-group-text"> <i
									class="bi bi-calendar3"></i>
								</span> <input type="date" class="form-control" name="eventDate"
									id="eventDate" value="<%=event.getEventDate()%>" required>
							</div>
						</div>

						<div class="col-md-6 mb-3">
							<label class="form-label">Event Time <span
								class="text-danger">*</span></label>
							<div class="input-group">
								<span class="input-group-text"> <i class="bi bi-clock"></i>
								</span> <input type="text" class="form-control" name="eventTime"
									value="<%=event.getEventTime()%>" placeholder="10:00 AM"
									required>
							</div>
						</div>

					</div>

					<div class="mb-3">
						<label class="form-label">Venue <span class="text-danger">*</span></label>
						<div class="input-group">
							<span class="input-group-text"> <i class="bi bi-geo-alt"></i>
							</span> <input type="text" class="form-control" name="venue"
								value="<%=event.getVenue()%>" maxlength="200" required>
						</div>
					</div>

					<div class="mb-3">
						<label class="form-label">Capacity <span
							class="text-danger">*</span></label>
						<div class="input-group">
							<span class="input-group-text"> <i class="bi bi-people"></i>
							</span> <input type="number" class="form-control" name="capacity"
								value="<%=event.getCapacity()%>" min="1" required>
						</div>
						<small class="form-text">Enter the maximum number of
							attendees.</small>
					</div>

					<%
					if ("admin".equals(role)) {
					%>

					<div class="mb-3">
						<label class="form-label">Manager Email <span
							class="text-danger">*</span></label>
						<div class="input-group">
							<span class="input-group-text"> <i class="bi bi-envelope"></i>
							</span> <input type="email" class="form-control" name="managerEmail"
								value="<%=event.getManagerEmail()%>" required>
						</div>
						<small class="form-text">The event will be assigned to
							this manager.</small>
					</div>

					<%
					}
					%>

					<div class="form-actions">

						<a
							href="<%="admin".equals(role) ? "findAllEvents" : "findMyEvents"%>"
							class="btn btn-light"> <i class="bi bi-arrow-left me-1"></i>
							Cancel
						</a>

						<button type="submit" class="btn btn-primary">
							<i class="bi bi-check-circle me-1"></i> Update Event
						</button>

					</div>

				</form>

			</div>

			<div class="info-panel">
				<i class="bi bi-info-circle-fill"></i>
				<p>
					<strong>Note:</strong> Please verify the event details before
					updating. Changes will be reflected in the event management system
					after a successful update.
				</p>
			</div>

		</div>

		<div class="footer">© 2026 EventHub. All rights reserved.</div>

	</div>

	<script>
		function toggleSidebar() {
			document.getElementById("sidebar").classList.toggle("show");
		}

		// Description character counter
		const description = document.getElementById("description");
		const charCount = document.getElementById("charCount");

		function updateCharCount() {
			charCount.textContent = description.value.length;
		}

		updateCharCount();
		description.addEventListener("input", updateCharCount);

		// Prevent selecting a date earlier than today,
		// while preserving an existing past event date.
		const dateInput = document.getElementById("eventDate");
		const today = new Date();
		const localToday = new Date(today.getTime() - today.getTimezoneOffset()
				* 60000).toISOString().split("T")[0];

		dateInput.min = localToday;

		document.getElementById("editEventForm").addEventListener("submit",
				function(e) {
					if (!this.checkValidity()) {
						e.preventDefault();
						this.reportValidity();
					}
				});
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
