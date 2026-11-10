
package com.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.EventDAO;
import com.model.Event;

@WebServlet("/findMyEvents")
public class GetManagerEvents extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);

		EventDAO dao = new EventDAO();
		String managerEmail = (String) session.getAttribute("email");

		List<Event> eventList = dao.fetchManagerEvents(managerEmail);
		

		request.setAttribute("eventList", eventList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("viewEvents.jsp");
		dispatcher.forward(request, response);
	}
}
