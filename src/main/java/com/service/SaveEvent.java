
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

@WebServlet("/saveEvent")
public class SaveEvent extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("email") == null) {

			response.sendRedirect("login.jsp");
			return;
		}

		EventDAO dao = new EventDAO();
		Event event = new Event();

		event.setClientName(request.getParameter("clientName"));
		event.setMobileNumber(request.getParameter("mobileNumber"));
		event.setEventName(request.getParameter("eventName"));
		event.setDescription(request.getParameter("description"));
		event.setEventDate(request.getParameter("eventDate"));
		
		String eventTime = request.getParameter("eventTime");

		java.time.LocalTime time =
		    java.time.LocalTime.parse(eventTime);

		String formattedTime = time.format(
		    java.time.format.DateTimeFormatter.ofPattern("hh:mm a")
		).toUpperCase();
		event.setEventTime(formattedTime);
		event.setVenue(request.getParameter("venue"));
		event.setCapacity(Integer.parseInt(request.getParameter("capacity")));

		String email = (String) session.getAttribute("email");
		String role = (String) session.getAttribute("role");

		event.setManagerEmail(email);

		boolean status = dao.saveEventDao(event);

		if (status) {

			dao.commit();

			session.setAttribute("status", "success");
			session.setAttribute("message", "Event added successfully!");

		} else {

			dao.rollback();

			session.setAttribute("status", "error");
			session.setAttribute("message", "Failed to add event. Please try again.");
		}

		// Redirect according to user role

		if ("admin".equals(role)) {

			response.sendRedirect("findAllEvents");

		} else {

			response.sendRedirect("findMyEvents");

		}
	}
}
