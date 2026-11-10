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

@WebServlet("/getManager")
public class GetManagerServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || !"admin".equals(session.getAttribute("role"))) {

			response.sendRedirect("login.jsp");
			return;
		}

		int id = Integer.parseInt(request.getParameter("id"));

		EventManagerDAO dao = new EventManagerDAO();

		EventManager manager = dao.getManagerById(id);

		if (manager != null) {

			request.setAttribute("manager", manager);

			request.getRequestDispatcher("editManager.jsp").forward(request, response);

		} else {

			response.sendRedirect("findAllManagers");
		}
	}
}