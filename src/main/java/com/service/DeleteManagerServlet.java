package com.service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.EventDAO;
import com.dao.EventManagerDAO;

@WebServlet("/deleteManager")
public class DeleteManagerServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		EventManagerDAO dao = new EventManagerDAO();  

		int id = Integer.parseInt(request.getParameter("id"));

		dao.removeManager(id);
		dao.commit();

		response.sendRedirect("findAllManagers");
	}

}
