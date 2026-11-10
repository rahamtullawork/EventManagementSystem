package com.service;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.EventDAO;
import com.model.Event;

@WebServlet("/updateEvent")
public class EditEvent extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String role = (String) request.getSession().getAttribute("role");
		String loggedInEmail = (String) request.getSession().getAttribute("email");

		EventDAO dao = new EventDAO();
		Event event = new Event();

		event.setEventId(Integer.parseInt(request.getParameter("eventId")));
		event.setClientName(request.getParameter("clientName"));
		event.setMobileNumber(request.getParameter("mobileNumber"));
		event.setEventName(request.getParameter("eventName"));
		event.setDescription(request.getParameter("description"));
		event.setEventDate(request.getParameter("eventDate"));
		event.setEventTime(request.getParameter("eventTime"));
		event.setVenue(request.getParameter("venue"));
		event.setCapacity(Integer.parseInt(request.getParameter("capacity")));

		if ("admin".equals(role)) {
			event.setManagerEmail(request.getParameter("managerEmail"));
		} else {
			event.setManagerEmail(loggedInEmail);
		}
		dao.editEvent(event);
		dao.commit();

		if ("admin".equals(role)) {
			response.sendRedirect("findAllEvents");
		} else {
			response.sendRedirect("findMyEvents");
		}

	}

}
