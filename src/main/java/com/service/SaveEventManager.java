
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
import com.dao.EventManagerDAO;
import com.model.Event;
import com.model.EventManager;

@WebServlet("/addEventManager")
public class SaveEventManager extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		EventManagerDAO dao = new EventManagerDAO();
		EventManager manager = new EventManager();

		manager.setName(request.getParameter("name"));
		manager.setEmail(request.getParameter("email"));
		manager.setMobile(request.getParameter("mobile"));
		manager.setPassword(request.getParameter("password"));

		boolean status = dao.saveManager(manager);

		RequestDispatcher dispatcher = request.getRequestDispatcher("findAllManagers");

		if (status) {
			dao.commit();
			response.sendRedirect("findAllManagers");

		} else {

			dao.rollback();
			request.setAttribute("status", "Error in registering the event manager");
			dispatcher.forward(request, response);
		}

	}
}
