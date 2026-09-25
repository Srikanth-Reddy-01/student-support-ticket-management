package com.assignment.controller;

import java.io.IOException;
import java.util.List;

import com.assignment.dao.TicketActivityDAO;
import com.assignment.dao.TicketDAO;
import com.assignment.model.Ticket;
import com.assignment.model.TicketActivity;
import com.assignment.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ticket-details")
public class TicketDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private TicketDAO ticketDAO;
    private TicketActivityDAO activityDAO;

    @Override
    public void init() throws ServletException {

        ticketDAO = new TicketDAO();
        activityDAO = new TicketActivityDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null || session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Only STAFF and MANAGER can view ticket details
        if (!"STAFF".equals(user.getRole())
                && !"MANAGER".equals(user.getRole())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access denied");

            return;
        }

        String idParameter = request.getParameter("id");

        if (idParameter == null || idParameter.isBlank()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Ticket ID is required");

            return;
        }

        try {

            int ticketId = Integer.parseInt(idParameter);

            Ticket ticket = ticketDAO.getTicket(ticketId);

            if (ticket == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Ticket not found");

                return;
            }

            // Get all staff members for assignment
            List<User> staffUsers =
                    ticketDAO.getStaffUsers();

            // Get activity history for this ticket
            List<TicketActivity> activities =
                    activityDAO.getActivitiesByTicket(ticketId);

            // Send data to JSP
            request.setAttribute("ticket", ticket);
            request.setAttribute("staffUsers", staffUsers);
            request.setAttribute("activities", activities);

            request.getRequestDispatcher("ticket-details.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid ticket ID");
        }
    }
}