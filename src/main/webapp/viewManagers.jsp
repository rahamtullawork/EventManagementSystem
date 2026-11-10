
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

String status = (String) session.getAttribute("status");
String message = (String) session.getAttribute("message");

// Clear message after retrieving it
session.removeAttribute("status");
session.removeAttribute("message");
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Event Managers | EventHub</title>

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

/* Managers Panel */
.managers-panel {
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
	font-size: 22px;
	font-weight: 700;
	margin-bottom: 5px;
}

.panel-heading p {
	font-size: 15px;
	color: #94a3b8;
	margin: 0;
}

/* Search */
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
	font-size: 16px;
}

.search-box input:focus {
	border-color: #4361ee;
	box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
}

/* Table */
.table-responsive {
	border-radius: 9px;
}

.managers-table {
	min-width: 700px;
	margin-bottom: 0;
	vertical-align: middle;
}

.managers-table thead th {
	background: #f6f8fc;
	color: #64748b;
	font-size: 15px;
	font-weight: 750;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	padding: 16px 13px;
	border-bottom: 1px solid #e9edf2;
	white-space: nowrap;
}

.managers-table tbody td {
	padding: 16px 13px;
	color: #475569;
	font-size: 17px;
	border-bottom: 1px solid #f0f2f5;
}

.managers-table tbody tr {
	transition: background 0.2s ease;
}

.managers-table tbody tr:hover {
	background: #f8faff;
}

.manager-name {
	color: #263b5a;
	font-weight: 650;
}

.manager-id {
	color: #4361ee;
	font-weight: 700;
}

/* Manager Avatar */
.manager-avatar {
	width: 36px;
	height: 36px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	border-radius: 50%;
	background: #eef2ff;
	color: #4361ee;
	font-size: 16px;
	margin-right: 9px;
}

/* Action Buttons */
.action-btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 6px;
	padding: 7px 10px;
	border-radius: 7px;
	text-decoration: none;
	font-size: 13px;
	font-weight: 600;
	margin-right: 5px;
	transition: 0.2s;
	white-space: nowrap;
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

/* Add Manager Button */
.add-manager-btn {
	background: #4361ee;
	color: white;
	border: none;
	border-radius: 8px;
	padding: 10px 16px;
	font-size: 14px;
	font-weight: 600;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	transition: 0.2s;
}

.add-manager-btn:hover {
	background: #304bd1;
	color: white;
	transform: translateY(-2px);
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
	.managers-panel {
		padding: 17px;
	}
	.page-heading h3 {
		font-size: 23px;
	}
	.panel-heading>div:last-child {
		width: 100%;
	}
	.add-manager-btn {
		justify-content: center;
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

		<a href="admin.jsp" class="sidebar-link"> <i
			class="bi bi-grid-1x2"></i> Dashboard
		</a> <a href="findAllEvents" class="sidebar-link"> <i
			class="bi bi-calendar-check"></i> Manage Events
		</a> <a href="findAllManagers" class="sidebar-link active"> <i
			class="bi bi-people"></i> Event Managers
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
					<h5>Event Managers</h5>
					<small class="text-muted">Manage your event management team</small>
				</div>

			</div>

			<div class="admin-profile">

				<div class="text-end admin-email">

					<div class="fw-semibold">Administrator</div>

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
				Dashboard / Managers / <strong class="text-dark">Event
					Managers</strong>
			</div>

			<!-- Heading -->

			<div class="page-heading">

				<h3>Event Managers</h3>

				<p>View, manage, and assign events to your registered event
					managers.</p>

			</div>

			<!-- Managers Panel -->

			<div class="managers-panel">

				<div class="panel-heading">

					<div>
						<h5>Manager Details</h5>
						<p>Browse and manage registered event managers.</p>
					</div>

					<div class="d-flex gap-2 flex-wrap">

						<div class="search-box">

							<i class="bi bi-search"></i> <input type="text"
								id="managerSearch" class="form-control"
								placeholder="Search managers...">

						</div>

						<a href="addEventManager.jsp" class="add-manager-btn"> <i
							class="bi bi-person-plus"></i> Add Manager

						</a>

					</div>

				</div>

				<!-- Managers Table -->

				<c:choose>

					<c:when test="${empty managerList}">

						<div class="empty-state">

							<i class="bi bi-people"></i>

							<h5>No event managers found</h5>

							<p class="mb-3">Start by adding your first event manager.</p>

							<a href="addEventManager.jsp" class="add-manager-btn"> <i
								class="bi bi-plus-lg"></i> Add Event Manager

							</a>

						</div>

					</c:when>

					<c:otherwise>

						<div class="table-responsive">

							<table class="table managers-table" id="managersTable">

								<thead>

									<tr>

										<th>Manager ID</th>
										<th>Name</th>
										<th>Email</th>
										<th>Mobile</th>
										<th>Actions</th>

									</tr>

								</thead>

								<tbody>

									<c:forEach items="${managerList}" var="manager">

										<tr>

											<td><span class="manager-id"> #${manager.id} </span></td>

											<td><span class="manager-avatar"> <i
													class="bi bi-person-fill"></i>
											</span> <span class="manager-name"> <c:out
														value="${manager.name}" />
											</span></td>

											<td><c:out value="${manager.email}" /></td>

											<td><c:out value="${manager.mobile}" /></td>

											<td>

												<div class="d-flex align-items-center flex-wrap">

													<!-- Edit Manager -->

													<a href="getManager?id=${manager.id}"
														class="action-btn edit-btn" title="Edit Manager"> <i
														class="bi bi-pencil-square"></i> Edit

													</a>

													<!-- Assign Event -->

													<a href="loadAssignEvent?managerId=${manager.id}"
														class="action-btn assign-btn" title="Assign Event"> <i
														class="bi bi-calendar-plus"></i> Assign

													</a>

													<!-- Delete Manager -->

													<a href="deleteManager?id=${manager.id}"
														class="action-btn delete-btn" title="Delete Manager"
														onclick="return confirm('Delete this manager?')"> <i
														class="bi bi-trash3"></i> Delete

													</a>

												</div>

											</td>

										</tr>

									</c:forEach>

								</tbody>

							</table>

							<!-- Search Empty State -->

							<div class="empty-state d-none" id="emptyState">

								<i class="bi bi-search"></i>

								<h5>No matching managers found</h5>

								<p class="mb-0">Try changing your search keyword.</p>

							</div>

						</div>

					</c:otherwise>

				</c:choose>

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

        if (window.innerWidth <= 991 &&
            sidebar.classList.contains("show") &&
            !sidebar.contains(event.target) &&
            !menuButton.contains(event.target)) {

            sidebar.classList.remove("show");

        }

    });

    // Manager Search

    const searchInput = document.getElementById("managerSearch");
    const tableRows = document.querySelectorAll("#managersTable tbody tr");
    const emptyState = document.getElementById("emptyState");

    if (searchInput) {

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

    }
    

    document.addEventListener("DOMContentLoaded", function() {

        const status = "<%=status != null ? status : ""%>
		";

			if (status === "success" || status === "error") {

				const modalElement = document
						.getElementById("assignmentStatusModal");

				const modal = new bootstrap.Modal(modalElement);

				modal.show();

			}

		});
	</script>

	<!-- Assignment Status Modal -->

	<div class="modal fade" id="assignmentStatusModal" tabindex="-1"
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

					<h4 class="text-danger">Assignment Failed!</h4>

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

</body>
</html>
