
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String email = (String) session.getAttribute("email");
String role = (String) session.getAttribute("role");

if (email == null || !("manager".equals(role) || ("admin".equals(role)))) {
	response.sendRedirect("login.jsp");
	return;
}

String status = (String) request.getAttribute("status");
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Add Event | EventHub</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Bootstrap Icons -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
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

.page-heading h3 {
	font-size: 26px;
	font-weight: 750;
	color: #1e293b;
}

.page-heading p {
	color: #94a3b8;
	font-size: 15px;
}

/* Form Panel */
.form-panel {
	background: white;
	border: 1px solid #edf0f4;
	border-radius: 15px;
	padding: 28px;
	margin-top: 25px;
	box-shadow: 0 3px 15px rgba(0, 0, 0, 0.025);
}

.form-panel-heading {
	display: flex;
	align-items: center;
	gap: 13px;
	padding-bottom: 20px;
	margin-bottom: 25px;
	border-bottom: 1px solid #edf0f4;
}

.form-heading-icon {
	width: 46px;
	height: 46px;
	background: #eef2ff;
	color: #4361ee;
	border-radius: 11px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 25px;
}

.form-panel-heading h5 {
	font-size: 23px;
	font-weight: 700;
	margin: 0 0 4px;
	color: #1e293b;
}

.form-panel-heading p {
	font-size: 17px;
	color: #94a3b8;
	margin: 0;
}

.form-label {
	font-size: 16px;
	font-weight: 650;
	color: #334155;
	margin-bottom: 8px;
}

.form-control {
	min-height: 46px;
	border: 1px solid #e2e8f0;
	border-radius: 8px;
	font-size: 16px;
	padding: 11px 13px;
	color: #334155;
}

textarea.form-control {
	min-height: 110px;
	resize: vertical;
}

.form-control:focus {
	border-color: #4361ee;
	box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.10);
}

.input-group-text {
	background: #f8faff;
	border-color: #e2e8f0;
	color: #64748b;
}

.input-group .form-control {
	border-left: 0;
}

.input-group .form-control:focus {
	border-left: 1px solid #4361ee;
}

.field-help {
	font-size: 12px;
	color: #94a3b8;
	margin-top: 6px;
}

.form-actions {
	display: flex;
	align-items: center;
	justify-content: flex-end;
	gap: 12px;
	border-top: 1px solid #edf0f4;
	margin-top: 25px;
	padding-top: 22px;
}

.btn-save {
	background: #4361ee;
	color: white;
	border: none;
	border-radius: 8px;
	padding: 11px 20px;
	font-size: 16px;
	font-weight: 650;
	transition: 0.2s;
}

.btn-save:hover {
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
	font-size: 16px;
	font-weight: 600;
	text-decoration: none;
	transition: 0.2s;
}

.btn-cancel:hover {
	background: #e2e8f0;
	color: #334155;
}

/* Alert */
.status-alert {
	border-radius: 9px;
	font-size: 16px;
	margin-bottom: 22px;
}

/* Tips Panel */
.tips-panel {
	background: #eef2ff;
	border: 1px solid #dce5ff;
	border-radius: 12px;
	padding: 20px;
	margin-top: 20px;
}

.tips-panel h6 {
	color: #304bd1;
	font-size: 15px;
	font-weight: 700;
	margin-bottom: 12px;
}

.tips-panel p {
	color: #64748b;
	font-size: 13px;
	margin: 0 0 8px;
}

.tips-panel p:last-child {
	margin-bottom: 0;
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

@media ( max-width : 991px) {
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

@media ( max-width : 576px) {
	.manager-email {
		display: none;
	}
	.form-panel {
		padding: 20px 16px;
	}
	.page-heading h3 {
		font-size: 23px;
	}
	.form-actions {
		flex-direction: column-reverse;
	}
	.form-actions .btn, .form-actions .btn-cancel {
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

		<a href="eventmanager.jsp" class="sidebar-link"> <i
			class="bi bi-grid-1x2"></i> Dashboard
		</a> <a href="findMyEvents" class="sidebar-link"> <i
			class="bi bi-calendar-check"></i> My Events
		</a> <a href="addEvent.jsp" class="sidebar-link active"> <i
			class="bi bi-plus-circle"></i> Add Event
		</a>

		<div class="mt-4">

			<p class="menu-label">Account</p>

			<a href="logout" class="sidebar-link logout"> <i
				class="bi bi-box-arrow-right"></i> Logout
			</a>

		</div>

	</aside>

	<!-- Main Content -->

	<div class="main-content">

		<!-- Topbar -->

		<div class="topbar">

			<div class="d-flex align-items-center gap-3">

				<button class="btn btn-light mobile-menu-btn" type="button"
					onclick="toggleSidebar()">

					<i class="bi bi-list fs-4"></i>

				</button>

				<div>
					<h5>Add New Event</h5>
					<small class="text-muted">Create and organize your event</small>
				</div>

			</div>

			<div class="manager-profile">

				<div class="text-end manager-email">

					<div class="fw-semibold">Event Manager</div>

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
				Dashboard / Events / <strong class="text-dark">Add Event</strong>
			</div>

			<!-- Heading -->

			<div class="page-heading">

				<h3>Create New Event</h3>

				<p>Enter the event information below to add it to your event
					list.</p>

			</div>

			<!-- Form Panel -->

			<div class="form-panel">

				<div class="form-panel-heading">

					<div class="form-heading-icon">
						<i class="bi bi-calendar-plus"></i>
					</div>

					<div>
						<h5>Event Information</h5>
						<p>Provide the required details about your event.</p>
					</div>

				</div>

				<!-- Status Message -->

				<%
				if (status != null) {
				%>

				<div class="alert alert-info status-alert" role="alert">
					<i class="bi bi-info-circle me-2"></i>
					<%=status%>
				</div>

				<%
				}
				%>

				<form action="saveEvent" method="post" id="eventForm">

					<div class="row g-4">

						<!-- Client Name -->
						<div class="col-md-6">

							<label class="form-label" for="clientName"> Client Name <span
								class="text-danger">*</span>
							</label>

							<div class="input-group">

								<span class="input-group-text"> <i class="bi bi-person"></i>
								</span> <input type="text" class="form-control" id="clientName"
									name="clientName" placeholder="Enter client name"
									maxlength="150" required>

							</div>

						</div>

						<!-- Mobile Number -->
						<div class="col-md-6">

							<label class="form-label" for="mobileNumber"> Mobile
								Number <span class="text-danger">*</span>
							</label>

							<div class="input-group">

								<span class="input-group-text"> <i
									class="bi bi-telephone"></i>
								</span> <input type="tel" class="form-control" id="mobileNumber"
									name="mobileNumber" placeholder="Enter client mobile number"
									maxlength="15" pattern="[0-9]{10,15}"
									title="Enter a valid mobile number (10 to 15 digits)" required>

							</div>

						</div>

						<!-- Event Name -->
						<div class="col-md-6">

							<label class="form-label" for="eventName"> Event Name <span
								class="text-danger">*</span>
							</label>

							<div class="input-group">

								<span class="input-group-text"> <i
									class="bi bi-calendar-event"></i>
								</span> <input type="text" class="form-control" id="eventName"
									name="eventName" placeholder="Enter event name" maxlength="150"
									required>

							</div>

						</div>

						<!-- Venue -->
						<div class="col-md-6">

							<label class="form-label" for="venue"> Venue <span
								class="text-danger">*</span>
							</label>

							<div class="input-group">

								<span class="input-group-text"> <i class="bi bi-geo-alt"></i>
								</span> <input type="text" class="form-control" id="venue" name="venue"
									placeholder="Enter event venue" maxlength="200" required>

							</div>

						</div>

						<!-- Description -->
						<div class="col-12">

							<label class="form-label" for="description"> Event
								Description <span class="text-danger">*</span>
							</label>

							<textarea class="form-control" id="description"
								name="description" placeholder="Describe your event..."
								maxlength="1000" required></textarea>

							<div class="d-flex justify-content-between">

								<small class="field-help"> Provide a short description
									of your event. </small> <small class="field-help" id="descriptionCount">
									0 / 1000 </small>

							</div>

						</div>

						<!-- Event Date -->
						<div class="col-md-6">

							<label class="form-label" for="eventDate"> Event Date <span
								class="text-danger">*</span>
							</label>

							<div class="input-group">

								<span class="input-group-text"> <i
									class="bi bi-calendar-date"></i>
								</span> <input type="date" class="form-control" id="eventDate"
									name="eventDate" required>

							</div>

						</div>

						<!-- Event Time -->
						<div class="col-md-6">

							<label class="form-label" for="eventTime"> Event Time <span
								class="text-danger">*</span>
							</label>

							<div class="input-group">

								<span class="input-group-text"> <i class="bi bi-clock"></i>
								</span> <input type="time" class="form-control" id="eventTime"
									name="eventTime" required>

							</div>

						</div>

						<!-- Capacity -->
						<div class="col-md-6">

							<label class="form-label" for="capacity"> Event Capacity
								<span class="text-danger">*</span>
							</label>

							<div class="input-group">

								<span class="input-group-text"> <i class="bi bi-people"></i>
								</span> <input type="number" class="form-control" id="capacity"
									name="capacity" placeholder="Enter maximum attendees" min="1"
									required>

							</div>

							<small class="field-help"> Maximum number of attendees. </small>

						</div>

					</div>

					<!-- Form Buttons -->
					<div class="form-actions">

						<a href="eventmanager.jsp" class="btn-cancel"> <i
							class="bi bi-x-circle me-1"></i> Cancel
						</a>

						<button type="reset" class="btn btn-light border">
							<i class="bi bi-arrow-counterclockwise me-1"></i> Reset
						</button>

						<button type="submit" class="btn btn-save">
							<i class="bi bi-check-circle me-1"></i> Save Event
						</button>

					</div>

				</form>


			</div>

			<!-- Tips Panel -->

			<div class="tips-panel">

				<h6>
					<i class="bi bi-lightbulb me-2"></i> Helpful Tips
				</h6>

				<p>
					<i class="bi bi-check-circle me-2"></i> Enter a clear and
					meaningful event name.
				</p>

				<p>
					<i class="bi bi-check-circle me-2"></i> Provide the correct date,
					time, and venue.
				</p>

				<p>
					<i class="bi bi-check-circle me-2"></i> Make sure the event
					capacity is greater than zero.
				</p>

			</div>

		</main>

		<!-- Footer -->

		<footer class="footer"> © 2026 EventHub | Event Management
			System </footer>

	</div>

	<!-- Bootstrap JS -->

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		// Mobile Sidebar

		function toggleSidebar() {
			document.getElementById("sidebar").classList.toggle("show");
		}

		// Close sidebar when clicking outside on mobile

		document.addEventListener("click", function(event) {

			const sidebar = document.getElementById("sidebar");
			const menuButton = document.querySelector(".mobile-menu-btn");

			if (window.innerWidth <= 991 && sidebar.classList.contains("show")
					&& !sidebar.contains(event.target)
					&& !menuButton.contains(event.target)) {

				sidebar.classList.remove("show");

			}

		});

		// Prevent selecting a past event date

		const eventDate = document.getElementById("eventDate");

		const today = new Date();
		const localDate = new Date(today.getTime() - today.getTimezoneOffset()
				* 60000).toISOString().split("T")[0];

		eventDate.min = localDate;

		// Description Character Counter

		const description = document.getElementById("description");
		const descriptionCount = document.getElementById("descriptionCount");

		description.addEventListener("input", function() {

			descriptionCount.textContent = this.value.length + " / 1000";

		});

		// Form Validation

		const eventForm = document.getElementById("eventForm");

		eventForm
				.addEventListener(
						"submit",
						function(event) {

							const name = document.getElementById("eventName").value
									.trim();
							const venue = document.getElementById("venue").value
									.trim();
							const descriptionValue = description.value.trim();
							const capacity = document
									.getElementById("capacity").value;

							if (!name || !venue || !descriptionValue
									|| !capacity || Number(capacity) < 1) {

								event.preventDefault();

								alert("Please enter valid information in all required fields.");

							}

						});
	</script>

</body>
</html>
