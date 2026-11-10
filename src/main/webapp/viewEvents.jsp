
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String email = (String) session.getAttribute("email");
String role = (String) session.getAttribute("role");

String status = (String) session.getAttribute("status");
String message = (String) session.getAttribute("message");

// Remove the flash message after reading it
session.removeAttribute("status");
session.removeAttribute("message");

if (email == null || (!"admin".equals(role) && !"manager".equals(role))) {
	response.sendRedirect("login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Manage Events | EventHub</title>

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

.page-content {
	padding: 30px 35px;
}

.breadcrumb-text {
	color: #94a3b8;
	font-size: 14px;
	margin-bottom: 20px;
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

.events-panel {
	background: white;
	border: 1px solid #edf0f4;
	border-radius: 15px;
	padding: 25px;
	margin-top: 25px;
	box-shadow: 0 3px 15px rgba(0, 0, 0, 0.025);
}

.panel-heading {
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
	gap: 15px;
	margin-bottom: 30px;
}

.panel-heading h5 {
	font-size: 23px;
	font-weight: 700;
	margin-bottom: 5px;
}

.panel-heading p {
	font-size: 15px;
	color: #94a3b8;
	margin: 0;
}

.search-box {
	position: relative;
	width: 260px;
}

.search-box i {
	position: absolute;
	left: 12px;
	top: 50%;
	transform: translateY(-50%);
	color: #94a3b8;
}

.search-box input {
	padding: 10px 12px 10px 36px;
	border-radius: 8px;
	border: 1px solid #e2e8f0;
	font-size: 18px;
}

.search-box input:focus {
	border-color: #4361ee;
	box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
}

.table-responsive {
	border-radius: 9px;
}

.events-table {
	min-width: 1500px;
	width: 100%;
	margin-bottom: 0;
	vertical-align: middle;
	table-layout: auto;
}

.events-table thead th {
	background: #f6f8fc;
	color: #64748b;
	font-size: 14px;
	font-weight: 750;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	padding: 16px 13px;
	border-bottom: 1px solid #e9edf2;
	white-space: nowrap;
}

.events-table tbody td {
	padding: 16px 13px;
	color: #475569;
	font-size: 15px;
	border-bottom: 1px solid #f0f2f5;
	vertical-align: middle;
}

.events-table tbody tr {
	transition: background 0.2s ease;
}

.events-table tbody tr:hover {
	background: #f8faff;
}

.event-name {
	color: #263b5a;
	font-weight: 650;
}

.event-id {
	color: #4361ee;
	font-weight: 700;
}

.manager-email {
	min-width: 230px;
	white-space: nowrap;
	color: #4361ee !important;
	font-weight: 600;
}

/* Client Mobile */
.client-mobile {
	min-width: 140px;
	white-space: nowrap;
}

/* Event Description */
.event-description {
	min-width: 250px;
	max-width: 300px;
	white-space: normal;
	overflow-wrap: break-word;
}

.action-btn {
	width: 34px;
	height: 34px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	border-radius: 7px;
	text-decoration: none;
	border: none;
	transition: 0.2s;
	margin-right: 4px;
	font-size: 15px;
}

.edit-btn {
	background: #e8efff;
	color: #4361ee;
}

.edit-btn:hover {
	background: #4361ee;
	color: white;
}

.assign-btn {
	background: #e6f8f1;
	color: #16a085;
}

.assign-btn:hover {
	background: #16a085;
	color: white;
}

.delete-btn {
	background: #fff0f0;
	color: #dc3545;
}

.delete-btn:hover {
	background: #dc3545;
	color: white;
}

/* Empty State */
.empty-state {
	text-align: center;
	padding: 55px 15px;
	color: #94a3b8;
}

.empty-state i {
	font-size: 45px;
	color: #cbd5e1;
}

.empty-state h5 {
	font-size: 19px;
	color: #475569;
	margin-top: 15px;
}

.empty-state p {
	font-size: 14px;
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
	.admin-email {
		display: none;
	}
	.search-box {
		width: 100%;
	}
	.events-panel {
		padding: 17px;
	}
	.page-heading h3 {
		font-size: 23px;
	}
}
</style>
</head>

<body>
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
		<%
		if ("admin".equals(role)) {
		%>
		<a href="admin.jsp" class="sidebar-link"> <i
			class="bi bi-grid-1x2"></i> Dashboard
		</a> <a href="findAllEvents" class="sidebar-link active"> <i
			class="bi bi-calendar-check"></i> Manage Events
		</a> <a href="findAllManagers" class="sidebar-link"> <i
			class="bi bi-people"></i> Event Managers
		</a>

		<%
		} else {
		%>

		<a href="eventmanager.jsp" class="sidebar-link"> <i
			class="bi bi-grid-1x2"></i> Dashboard
		</a> <a href="findMyEvents" class="sidebar-link active"> <i
			class="bi bi-calendar-check"></i> My Events
		</a> <a href="addEvent.jsp" class="sidebar-link"> <i
			class="bi bi-plus-circle"></i> Add Event
		</a>

		<%
		}
		%>

		<div class="mt-4">
			<p class="menu-label">Account</p>
			<a href="logout" class="sidebar-link logout"> <i
				class="bi bi-box-arrow-right"></i> Logout
			</a>
		</div>
	</aside>

	<div class="main-content">
		<div class="topbar">
			<div class="d-flex align-items-center gap-3">
				<button class="btn btn-light mobile-menu-btn" type="button"
					onclick="toggleSidebar()">
					<i class="bi bi-list fs-4"></i>
				</button>

				<div>
					<h5>Manage Events</h5>
					<small class="text-muted">Event Management Overview</small>
				</div>
			</div>

			<div class="admin-profile">
				<div class="text-end admin-email">
					<div class="fw-semibold">
						<%="admin".equals(role) ? "Administrator" : "Event Manager"%>
					</div>
					<small class="text-muted"><%=email%></small>
				</div>

				<div class="admin-avatar">
					<i class="bi bi-person-fill"></i>
				</div>
			</div>
		</div>

		<main class="page-content">
			<div class="breadcrumb-text">
				Dashboard / Events / <strong class="text-dark">Manage
					Events</strong>
			</div>

			<!-- Heading -->

			<div class="page-heading">

				<h3>
					<%="admin".equals(role) ? "All Events" : "My Events"%>
				</h3>

				<p>
					<%="admin".equals(role)
		? "View and manage all events in the system."
		: "View and manage the events associated with your account."%>
				</p>

			</div>

			<!-- Events Panel -->

			<div class="events-panel">

				<div class="panel-heading">

					<div>
						<h5>Event Details</h5>
						<p>Browse and manage event information.</p>
					</div>

					<div class="d-flex gap-2 flex-wrap">

						<div class="search-box">

							<i class="bi bi-search"></i> <input type="text" id="eventSearch"
								class="form-control" placeholder="Search events...">

						</div>

						<%-- <% if ("manager".equals(role)) { %> --%>

						<a href="addEvent.jsp"
							class="btn btn-primary btn-sm d-flex align-items-center gap-2 px-3">

							<i class="bi bi-plus-lg"></i> Add Event

						</a>

						<%-- <% } %> --%>

					</div>

				</div>

				<!-- Events Table -->

				<div class="table-responsive">

					<table class="table events-table" id="eventsTable">

						<thead>
							<tr>
								<th>Event ID</th>
								<th>Client Name</th>
								<th>Mobile Number</th>
								<th>Event Name</th>
								<th>Description</th>
								<th>Date</th>
								<th>Time</th>
								<th>Venue</th>
								<th>Capacity</th>

								<%
								if ("admin".equals(role)) {
								%>
								<th>Manager Email</th>
								<%
								}
								%>

								<th>Actions</th>
							</tr>
						</thead>

						<tbody>

							<c:forEach items="${eventList}" var="e">

								<tr>

									<td><span class="event-id"> #${e.eventId} </span></td>
									<td><span class="client-name"> <c:out
												value="${e.clientName}" />
									</span></td>

									<td><span class="client-mobile-number"> <c:out
												value="${e.mobileNumber}" />
									</span></td>

									<td><span class="event-name"> <c:out
												value="${e.eventName}" />
									</span></td>

									<td><c:out value="${e.description}" /></td>

									<td>${e.eventDate}</td>

									<td>${e.eventTime}</td>

									<td><c:out value="${e.venue}" /></td>

									<td>${e.capacity}</td>

									<%
									if ("admin".equals(role)) {
									%>

									<td><c:out value="${e.managerEmail}" /></td>

									<%
									}
									%>

									<td>

										<div class="d-flex align-items-center">
											<a href="loadEvent?id=${e.eventId}"
												class="action-btn edit-btn" title="Edit Event"> <i
												class="bi bi-pencil-square"></i>

											</a>

											<!-- Assign -->

											<%
											if ("admin".equals(role)) {
											%>

											<a href="loadAssignEvent?id=${e.eventId}"
												class="action-btn assign-btn" title="Assign Event"> <i
												class="bi bi-person-plus"></i>

											</a>

											<%
											}
											%>

											<a href="delete?id=${e.eventId}"
												class="action-btn delete-btn" title="Delete Event"
												onclick="return confirm('Are you sure you want to delete this event?')">

												<i class="bi bi-trash3"></i>

											</a>

										</div>

									</td>

								</tr>

							</c:forEach>

						</tbody>

					</table>

					<!-- Empty State -->

					<div class="empty-state d-none" id="emptyState">

						<i class="bi bi-calendar-x"></i>

						<h5>No matching events found</h5>

						<p class="mb-0">Try changing your search keyword.</p>

					</div>

				</div>

			</div>

		</main>

		<!-- Footer -->

		<footer class="footer"> © 2026 EventHub | Event Management
			System </footer>

	</div>


	<!-- Event Success/Error Modal -->

	<div class="modal fade" id="eventStatusModal" tabindex="-1"
		aria-hidden="true">

		<div class="modal-dialog modal-dialog-centered">

			<div class="modal-content">

				<div class="modal-body text-center p-4">

					<%
					if ("success".equals(status)) {
					%>

					<div class="text-success mb-3">
						<i class="bi bi-check-circle-fill" style="font-size: 65px;"></i>
					</div>

					<h4 class="text-success">Success!</h4>

					<%
					} else if ("error".equals(status)) {
					%>

					<div class="text-danger mb-3">
						<i class="bi bi-x-circle-fill" style="font-size: 65px;"></i>
					</div>

					<h4 class="text-danger">Failed!</h4>

					<%
					}
					%>

					<p class="text-muted">
						<%=message != null ? message : ""%>
					</p>

					<button type="button" class="btn btn-primary px-4"
						data-bs-dismiss="modal">OK</button>

				</div>

			</div>

		</div>

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

        if (window.innerWidth <= 991 &&
            sidebar.classList.contains("show") &&
            !sidebar.contains(event.target) &&
            !menuButton.contains(event.target)) {

            sidebar.classList.remove("show");

        }

    });

    // Event Search

    const searchInput = document.getElementById("eventSearch");
    const tableRows = document.querySelectorAll("#eventsTable tbody tr");
    const emptyState = document.getElementById("emptyState");

    searchInput.addEventListener("keyup", function() {

        const searchValue = this.value.toLowerCase().trim();

        let visibleCount = 0;

        tableRows.forEach(function(row) {

            const rowText = row.innerText.toLowerCase();

            if (rowText.includes(searchValue)) {

                row.style.display = "";
                visibleCount++;

            } else {

                row.style.display = "none";

            }

        });

        if (visibleCount === 0) {
            emptyState.classList.remove("d-none");
        } else {
            emptyState.classList.add("d-none");
        }

    });
    
    

    document.addEventListener("DOMContentLoaded", function() {

        const status = "<%=status != null ? status : ""%>
		";

			if (status === "success" || status === "error") {

				const modalElement = document
						.getElementById("eventStatusModal");

				const eventModal = new bootstrap.Modal(modalElement);

				eventModal.show();

				// Redirect after clicking OK
				modalElement.addEventListener("hidden.bs.modal", function() {

					// User is already on the correct events page.
					// No additional redirect is needed.

				});

			}

		});
	</script>

</body>
</html>
