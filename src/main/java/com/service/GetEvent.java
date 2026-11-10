package com.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.dao.EventDAO;
import com.model.Event;

@WebServlet("/loadEvent")
public class GetEvent extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("email") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String role = (String) session.getAttribute("role");
		String email = (String) session.getAttribute("email");

		if (!"admin".equals(role) && !"manager".equals(role)) {
			response.sendRedirect("login.jsp");
			return;
		}

		int eventId = Integer.parseInt(request.getParameter("id"));

		EventDAO dao = new EventDAO();

		Event event = dao.getEventById(eventId);

		if (event == null) {
			response.sendRedirect("findAllEvents");
			return;
		}

		// Managers can edit only their own events.
		if ("manager".equals(role) && !email.equals(event.getManagerEmail())) {

			response.sendRedirect("findMyEvents");
			return;
		}

		request.setAttribute("event", event);

		RequestDispatcher rd = request.getRequestDispatcher("editEvent.jsp");

		rd.forward(request, response);
	}
}