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

@WebServlet("/updateManager")
public class UpdateManagerServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		// Check admin login
		if (session == null || !"admin".equals(session.getAttribute("role"))) {

			response.sendRedirect("login.jsp");
			return;
		}

		// Retrieve form data
		int id = Integer.parseInt(request.getParameter("id"));

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");

		// Create DAO object
		EventManagerDAO dao = new EventManagerDAO();

		boolean status = dao.updateManagerDetails(id, name, email, mobile);

		if (status) {
			dao.commit();
			response.sendRedirect("findAllManagers");
		} else {
			dao.rollback();
			response.sendRedirect("admin.jsp");
		}
	}
}