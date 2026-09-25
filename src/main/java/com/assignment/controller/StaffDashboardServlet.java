package com.assignment.controller;

import java.io.IOException;
import java.util.List;

import com.assignment.dao.TicketDAO;
import com.assignment.model.Ticket;
import com.assignment.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/staff-dashboard")
public class StaffDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private TicketDAO ticketDAO;

    @Override
    public void init() throws ServletException {
        ticketDAO = new TicketDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User staff = (User) session.getAttribute("user");

        if (!"STAFF".equals(staff.getRole())) {
            response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Access denied"
            );
            return;
        }

        // All tickets
        List<Ticket> allTickets = ticketDAO.getAllTickets();

        // Tickets assigned to logged-in staff
        List<Ticket> myTickets =
                ticketDAO.getTicketsByStaff(staff.getId());

        request.setAttribute("tickets", allTickets);
        request.setAttribute("myTickets", myTickets);

        request.getRequestDispatcher("staff-dashboard.jsp")
               .forward(request, response);
    }
}