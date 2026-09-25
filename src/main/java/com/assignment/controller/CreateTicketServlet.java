package com.assignment.controller;

import java.io.IOException;

import com.assignment.model.User;
import com.assignment.service.TicketService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/create-ticket")
public class CreateTicketServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private TicketService ticketService;


    @Override
    public void init() throws ServletException {

        ticketService = new TicketService();
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        HttpSession session =
                request.getSession(false);


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
                "Only students can create tickets."
            );

            return;
        }


        String title =
                request.getParameter("title");

        String description =
                request.getParameter("description");

        String category =
                request.getParameter("category");

        String priority =
                request.getParameter("priority");


        ticketService.createTicket(
                title,
                description,
                category,
                priority,
                student
        );


        response.sendRedirect(
            "my-tickets"
        );
    }
}