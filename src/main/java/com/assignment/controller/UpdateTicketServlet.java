package com.assignment.controller;

import java.io.IOException;
import java.time.LocalDateTime;

import com.assignment.dao.TicketActivityDAO;
import com.assignment.dao.TicketDAO;
import com.assignment.dao.UserDAO;
import com.assignment.model.Ticket;
import com.assignment.model.TicketActivity;
import com.assignment.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/update-ticket")
public class UpdateTicketServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private TicketDAO ticketDAO;
    private UserDAO userDAO;
    private TicketActivityDAO activityDAO;

    @Override
    public void init() throws ServletException {

        ticketDAO = new TicketDAO();
        userDAO = new UserDAO();
        activityDAO = new TicketActivityDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User loggedInUser =
                (User) session.getAttribute("user");

        if (!"STAFF".equals(loggedInUser.getRole())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access denied");

            return;
        }

        String idParameter =
                request.getParameter("id");

        if (idParameter == null ||
            idParameter.isBlank()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Ticket ID is required");

            return;
        }

        try {

            int ticketId =
                    Integer.parseInt(idParameter);

            Ticket ticket =
                    ticketDAO.getTicket(ticketId);

            if (ticket == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Ticket not found");

                return;
            }


            /*
             * Store old values before updating.
             */

            String oldStatus =
                    ticket.getStatus();

            User oldAssignedStaff =
                    ticket.getAssignedStaff();

            String oldResolution =
                    ticket.getResolution();


            /*
             * -------------------------
             * UPDATE STATUS
             * -------------------------
             */

            String newStatus =
                    request.getParameter("status");

            if (newStatus != null &&
                !newStatus.isBlank()) {

                ticket.setStatus(newStatus);
            }


            /*
             * -------------------------
             * UPDATE RESOLUTION
             * -------------------------
             */

            String newResolution =
                    request.getParameter("resolution");

            if (newResolution != null &&
                !newResolution.isBlank()) {

                ticket.setResolution(newResolution);
            }


            /*
             * -------------------------
             * ASSIGN STAFF
             * -------------------------
             */

            String assignedStaffId =
                    request.getParameter("assignedStaff");

            if (assignedStaffId != null &&
                !assignedStaffId.isBlank()) {

                int staffId =
                        Integer.parseInt(assignedStaffId);

                User assignedStaff =
                        userDAO.getUserById(staffId);

                if (assignedStaff != null &&
                    "STAFF".equals(assignedStaff.getRole())) {

                    ticket.setAssignedStaff(assignedStaff);
                }
            }


            /*
             * -------------------------
             * UPDATED TIME
             * -------------------------
             */

            ticket.setUpdatedAt(
                    LocalDateTime.now());


            /*
             * -------------------------
             * RESOLVED TIME
             * -------------------------
             */

            if ("RESOLVED".equals(newStatus)) {

                if (ticket.getResolvedAt() == null) {

                    ticket.setResolvedAt(
                            LocalDateTime.now());
                }

            } else {

                ticket.setResolvedAt(null);
            }


            /*
             * Save ticket
             */

            ticketDAO.updateTicket(ticket);


            /*
             * -------------------------
             * ACTIVITY: ASSIGNMENT
             * -------------------------
             */

            User newAssignedStaff =
                    ticket.getAssignedStaff();

            boolean assignmentChanged = false;

            if (oldAssignedStaff == null &&
                newAssignedStaff != null) {

                assignmentChanged = true;

            } else if (oldAssignedStaff != null &&
                       newAssignedStaff == null) {

                assignmentChanged = true;

            } else if (oldAssignedStaff != null &&
                       newAssignedStaff != null &&
                       oldAssignedStaff.getId()
                       != newAssignedStaff.getId()) {

                assignmentChanged = true;
            }


            if (assignmentChanged) {

                TicketActivity activity =
                        new TicketActivity();

                activity.setTicket(ticket);

                activity.setPerformedBy(
                        loggedInUser);

                activity.setAction("ASSIGNED");

                activity.setDescription(
                        "Ticket assigned to "
                        + newAssignedStaff.getName());

                activity.setCreatedAt(
                        LocalDateTime.now());

                activityDAO.saveActivity(activity);
            }


            /*
             * -------------------------
             * ACTIVITY: STATUS
             * -------------------------
             */

            if (newStatus != null &&
                !newStatus.equals(oldStatus)) {

                TicketActivity activity =
                        new TicketActivity();

                activity.setTicket(ticket);

                activity.setPerformedBy(
                        loggedInUser);

                activity.setAction(
                        "STATUS_CHANGED");

                activity.setDescription(
                        "Status changed from "
                        + oldStatus
                        + " to "
                        + newStatus);

                activity.setCreatedAt(
                        LocalDateTime.now());

                activityDAO.saveActivity(activity);
            }


            /*
             * -------------------------
             * ACTIVITY: RESOLUTION
             * -------------------------
             */

            if (newResolution != null &&
                !newResolution.isBlank() &&
                !newResolution.equals(oldResolution)) {

                TicketActivity activity =
                        new TicketActivity();

                activity.setTicket(ticket);

                activity.setPerformedBy(
                        loggedInUser);

                activity.setAction(
                        "RESOLUTION_UPDATED");

                activity.setDescription(
                        "Resolution details updated");

                activity.setCreatedAt(
                        LocalDateTime.now());

                activityDAO.saveActivity(activity);
            }


            response.sendRedirect(
                    "ticket-details?id=" + ticketId);


        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid ticket ID or staff ID");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to update ticket");
        }
    }
}