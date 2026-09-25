<%@ page import="java.util.List" %>
<%@ page import="com.assignment.model.Ticket" %>
<%@ page import="java.time.LocalDateTime" %>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Staff Dashboard</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
        }

        .header {
            background: #2c3e50;
            color: white;
            padding: 20px 40px;
        }

        .container {
            width: 92%;
            margin: 30px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #eeeeee;
        }

        .section-title {
            margin-top: 10px;
            margin-bottom: 15px;
            color: #2c3e50;
        }

        .high {
            color: #c0392b;
            font-weight: bold;
        }

        .medium {
            color: #f39c12;
            font-weight: bold;
        }

        .low {
            color: #27ae60;
            font-weight: bold;
        }

        .btn {
            padding: 8px 12px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .my-ticket {
            background: #f8fbff;
        }

        .empty-message {
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
        }

        .sla-ok {
            color: #27ae60;
            font-weight: bold;
        }

        .sla-overdue {
            color: #c0392b;
            font-weight: bold;
        }

        .sla-resolved {
            color: #2980b9;
            font-weight: bold;
        }

    </style>

</head>

<body>

<div class="header">

    <h2>Staff Dashboard</h2>

    <p>Student Support & Ticket Management</p>

</div>


<div class="container">


    <!-- ========================= -->
    <!-- MY ASSIGNED TICKETS -->
    <!-- ========================= -->

    <h2 class="section-title">My Assigned Tickets</h2>

    <%
        List<Ticket> myTickets =
            (List<Ticket>) request.getAttribute("myTickets");
    %>


    <% if (myTickets == null || myTickets.isEmpty()) { %>

        <p class="empty-message">
            No tickets are currently assigned to you.
        </p>

    <% } else { %>

        <table>

            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Category</th>
                <th>Priority</th>
                <th>Status</th>
                <th>Created</th>
                <th>Due</th>
                <th>SLA</th>
                <th>Action</th>
            </tr>


            <% for (Ticket ticket : myTickets) {

                boolean resolved =
                    "RESOLVED".equals(ticket.getStatus());

                boolean overdue =
                    !resolved &&
                    ticket.getDueAt() != null &&
                    LocalDateTime.now().isAfter(ticket.getDueAt());
            %>


            <tr class="my-ticket">

                <td>
                    <%= ticket.getId() %>
                </td>

                <td>
                    <%= ticket.getTitle() %>
                </td>

                <td>
                    <%= ticket.getCategory() %>
                </td>

                <td class="<%= ticket.getPriority().toLowerCase() %>">
                    <%= ticket.getPriority() %>
                </td>

                <td>
                    <%= ticket.getStatus() %>
                </td>

                <td>
                    <%= ticket.getCreatedAt() %>
                </td>

                <td>
                    <%= ticket.getDueAt() %>
                </td>

                <td>

                    <% if (resolved) { %>

                        <span class="sla-resolved">
                            RESOLVED
                        </span>

                    <% } else if (overdue) { %>

                        <span class="sla-overdue">
                            OVERDUE
                        </span>

                    <% } else { %>

                        <span class="sla-ok">
                            WITHIN SLA
                        </span>

                    <% } %>

                </td>

                <td>

                    <a class="btn"
                       href="ticket-details?id=<%= ticket.getId() %>">

                        View

                    </a>

                </td>

            </tr>


            <% } %>

        </table>

    <% } %>



    <!-- ========================= -->
    <!-- ALL SUPPORT TICKETS -->
    <!-- ========================= -->

    <h2 class="section-title">All Support Tickets</h2>

    <%
        List<Ticket> tickets =
            (List<Ticket>) request.getAttribute("tickets");
    %>


    <% if (tickets == null || tickets.isEmpty()) { %>

        <p class="empty-message">
            No support tickets available.
        </p>

    <% } else { %>

        <table>

            <tr>

                <th>ID</th>
                <th>Title</th>
                <th>Category</th>
                <th>Priority</th>
                <th>Status</th>
                <th>Created</th>
                <th>Due</th>
                <th>SLA</th>
                <th>Action</th>

            </tr>


            <% for (Ticket ticket : tickets) {

                boolean resolved =
                    "RESOLVED".equals(ticket.getStatus());

                boolean overdue =
                    !resolved &&
                    ticket.getDueAt() != null &&
                    LocalDateTime.now().isAfter(ticket.getDueAt());
            %>


            <tr>

                <td>
                    <%= ticket.getId() %>
                </td>

                <td>
                    <%= ticket.getTitle() %>
                </td>

                <td>
                    <%= ticket.getCategory() %>
                </td>

                <td class="<%= ticket.getPriority().toLowerCase() %>">

                    <%= ticket.getPriority() %>

                </td>

                <td>

                    <%= ticket.getStatus() %>

                </td>

                <td>

                    <%= ticket.getCreatedAt() %>

                </td>

                <td>

                    <%= ticket.getDueAt() %>

                </td>

                <td>

                    <% if (resolved) { %>

                        <span class="sla-resolved">
                            RESOLVED
                        </span>

                    <% } else if (overdue) { %>

                        <span class="sla-overdue">
                            OVERDUE
                        </span>

                    <% } else { %>

                        <span class="sla-ok">
                            WITHIN SLA
                        </span>

                    <% } %>

                </td>

                <td>

                    <a class="btn"
                       href="ticket-details?id=<%= ticket.getId() %>">

                        View

                    </a>

                </td>

            </tr>


            <% } %>

        </table>

    <% } %>


    <br>

    <a href="dashboard">Back to Dashboard</a>


</div>

</body>

</html>