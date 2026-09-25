package com.assignment.controller;

import java.io.IOException;
import java.time.LocalDateTime;
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

@WebServlet("/manager-dashboard")
public class ManagerDashboardServlet extends HttpServlet {

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

        User manager = (User) session.getAttribute("user");

        if (!"MANAGER".equals(manager.getRole())) {
            response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Access denied"
            );
            return;
        }

        List<Ticket> tickets = ticketDAO.getAllTickets();

        int total = tickets.size();
        int open = 0;
        int inProgress = 0;
        int pending = 0;
        int resolved = 0;
        int overdue = 0;

        LocalDateTime now = LocalDateTime.now();

        for (Ticket ticket : tickets) {

            String status = ticket.getStatus();

            if ("OPEN".equals(status)) {
                open++;
            } else if ("IN_PROGRESS".equals(status)) {
                inProgress++;
            } else if ("PENDING".equals(status)) {
                pending++;
            } else if ("RESOLVED".equals(status)) {
                resolved++;
            }

            if (!"RESOLVED".equals(status)
                    && ticket.getDueAt() != null
                    && now.isAfter(ticket.getDueAt())) {
                overdue++;
            }
        }

        request.setAttribute("tickets", tickets);
        request.setAttribute("total", total);
        request.setAttribute("open", open);
        request.setAttribute("inProgress", inProgress);
        request.setAttribute("pending", pending);
        request.setAttribute("resolved", resolved);
        request.setAttribute("overdue", overdue);

        request.getRequestDispatcher("manager-dashboard.jsp")
               .forward(request, response);
    }
}