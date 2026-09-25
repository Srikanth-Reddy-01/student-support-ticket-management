package com.assignment.service;

import java.time.LocalDateTime;

import com.assignment.dao.TicketDAO;
import com.assignment.model.Ticket;
import com.assignment.model.User;

public class TicketService {

    private TicketDAO ticketDAO;

    public TicketService() {
        ticketDAO = new TicketDAO();
    }


    public void createTicket(
            String title,
            String description,
            String category,
            String priority,
            User student) {

        Ticket ticket = new Ticket();

        ticket.setTitle(title);
        ticket.setDescription(description);
        ticket.setCategory(category);
        ticket.setPriority(priority);

        ticket.setStatus("OPEN");

        ticket.setStudent(student);

        LocalDateTime now = LocalDateTime.now();

        ticket.setCreatedAt(now);
        ticket.setUpdatedAt(now);

        // Simple SLA rules
        if ("HIGH".equals(priority)) {

            ticket.setDueAt(
                now.plusHours(4)
            );

        } else if ("MEDIUM".equals(priority)) {

            ticket.setDueAt(
                now.plusHours(8)
            );

        } else {

            ticket.setDueAt(
                now.plusHours(24)
            );
        }

        ticketDAO.saveTicket(ticket);
    }
}