package com.assignment.controller;

import java.io.IOException;
import java.util.List;

import com.assignment.dao.TicketDAO;
import com.assignment.model.Ticket;
import com.assignment.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/my-tickets")
public class MyTicketsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private TicketDAO ticketDAO;

    @Override
    public void init() throws ServletException {
        ticketDAO = new TicketDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User student =
                (User) session.getAttribute("user");

        if (!"STUDENT".equals(student.getRole())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access denied"
            );

            return;
        }

        List<Ticket> tickets =
                ticketDAO.getTicketsByStudent(student.getId());

        request.setAttribute("tickets", tickets);

        request.getRequestDispatcher(
                "my-tickets.jsp"
        ).forward(request, response);
    }
}