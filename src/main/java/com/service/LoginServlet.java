
package com.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.EventManagerDAO;
import com.model.EventManager;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		EventManagerDAO dao = new EventManagerDAO();

		EventManager manager = dao.loginUser(email, password);

		if (manager != null) {

			HttpSession session = request.getSession();

			session.setAttribute("em_id", manager.getId());
			session.setAttribute("em_name", manager.getName());
			session.setAttribute("email", manager.getEmail());
			session.setAttribute("role", manager.getUserRole());

			if ("admin".equals(manager.getUserRole())) {

				response.sendRedirect("admin.jsp");

			} else if ("manager".equals(manager.getUserRole())) {

				response.sendRedirect("eventmanager.jsp");

			}

		} else {

			request.setAttribute("status", "Invalid Email or Password!");

			RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");

			dispatcher.forward(request, response);
		}
	}
}
