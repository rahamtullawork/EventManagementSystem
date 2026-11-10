
package com.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.EventDAO;
import com.model.Event;

@WebServlet("/assignEvent")
public class AssignEvent extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || !"admin".equals(session.getAttribute("role"))) {

			response.sendRedirect("login.jsp");
			return;
		}

		int managerId = Integer.parseInt(request.getParameter("managerId"));

		int eventId = Integer.parseInt(request.getParameter("eventId"));

		EventDAO dao = new EventDAO();

		boolean status = dao.assignEvent(eventId, managerId);

		if (status) {

			dao.commit();

			session.setAttribute("status", "success");
			session.setAttribute("message", "Event assigned to the manager successfully!");

		} else {

			dao.rollback();

			session.setAttribute("status", "error");
			session.setAttribute("message", "Failed to assign the event. Please try again.");
		}

		// Redirect to View All Managers
		response.sendRedirect("findAllEvents");
	}
}
