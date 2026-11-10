package com.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.EventDAO;
import com.dao.EventManagerDAO;
import com.model.Event;
import com.model.EventManager;

@WebServlet("/loadAssignEvent")
public class LoadAssignEvent extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if (request.getSession().getAttribute("email") == null
				|| !"admin".equals(request.getSession().getAttribute("role"))) {

			response.sendRedirect("login.jsp");
			return;
		}

		EventManagerDAO managerDao = new EventManagerDAO();
		EventDAO eventDao = new EventDAO();

		List<EventManager> managers = managerDao.fetchAllManagers();

		List<Event> events = eventDao.fetchAllEvents();

		request.setAttribute("managers", managers);
		request.setAttribute("events", events);

		request.setAttribute("managerId", request.getParameter("managerId"));

		RequestDispatcher dispatcher = request.getRequestDispatcher("assignEvent.jsp");

		dispatcher.forward(request, response);
	}
}