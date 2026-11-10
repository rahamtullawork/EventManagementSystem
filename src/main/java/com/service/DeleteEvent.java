package com.service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.EventDAO;

@WebServlet("/delete")
public class DeleteEvent extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");

        int id = Integer.parseInt(request.getParameter("id"));

        EventDAO dao = new EventDAO();

        dao.deleteEvent(id);
        dao.commit();

        session.setAttribute("status", "success");
        session.setAttribute("message", "Event deleted successfully!");

        if ("admin".equals(role)) {

            response.sendRedirect("findAllEvents");

        } else if ("manager".equals(role)) {

            response.sendRedirect("findMyEvents");

        } else {

            response.sendRedirect("login.jsp");
        }
    }
}