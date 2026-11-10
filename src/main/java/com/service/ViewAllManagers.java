
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

import com.dao.EventManagerDAO;
import com.model.EventManager;

@WebServlet("/findAllManagers")
public class ViewAllManagers extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            !"admin".equals(session.getAttribute("role"))) {

            response.sendRedirect("login.jsp");
            return;
        }

        EventManagerDAO dao = new EventManagerDAO();

        List<EventManager> managerList = dao.fetchAllManagers();

        request.setAttribute("managerList", managerList);

        RequestDispatcher dispatcher =
            request.getRequestDispatcher("viewManagers.jsp");

        dispatcher.forward(request, response);
    }
}
