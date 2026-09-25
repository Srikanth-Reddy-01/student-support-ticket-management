<%@ page import="java.util.List" %>
<%@ page import="com.assignment.model.Ticket" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Manager Dashboard</title>

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

        .cards {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 15px;
            margin-bottom: 30px;
        }

        .card {
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
            text-align: center;
            border: 1px solid #ddd;
        }

        .card h3 {
            margin: 0 0 10px;
            font-size: 15px;
        }

        .card p {
            margin: 0;
            font-size: 28px;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #eeeeee;
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

        .overdue {
            color: #c0392b;
            font-weight: bold;
        }

        .resolved {
            color: #2980b9;
            font-weight: bold;
        }

        .btn {
            padding: 8px 12px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .back {
            margin-top: 20px;
            display: inline-block;
        }

    </style>

</head>


<body>


<div class="header">

    <h2>Manager Dashboard</h2>

    <p>Student Support & Ticket Management</p>

</div>


<div class="container">


    <!-- SUMMARY CARDS -->

    <div class="cards">

        <div class="card">
            <h3>Total Tickets</h3>
            <p><%= request.getAttribute("total") %></p>
        </div>

        <div class="card">
            <h3>Open</h3>
            <p><%= request.getAttribute("open") %></p>
        </div>

        <div class="card">
            <h3>In Progress</h3>
            <p><%= request.getAttribute("inProgress") %></p>
        </div>

        <div class="card">
            <h3>Pending</h3>
            <p><%= request.getAttribute("pending") %></p>
        </div>

        <div class="card">
            <h3>Resolved</h3>
            <p><%= request.getAttribute("resolved") %></p>
        </div>

        <div class="card">
            <h3>Overdue</h3>
            <p><%= request.getAttribute("overdue") %></p>
        </div>

    </div>


    <!-- ALL TICKETS -->

    <h2>Ticket Overview</h2>

    <%
        List<Ticket> tickets =
            (List<Ticket>) request.getAttribute("tickets");
    %>


    <% if (tickets == null || tickets.isEmpty()) { %>

        <p>No tickets available.</p>

    <% } else { %>

        <table>

            <tr>

                <th>ID</th>
                <th>Title</th>
                <th>Category</th>
                <th>Priority</th>
                <th>Status</th>
                <th>Assigned Staff</th>
                <th>Due</th>
                <th>SLA</th>
                <th>Action</th>

            </tr>


            <% for (Ticket ticket : tickets) { %>

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

                    <% if (ticket.getAssignedStaff() != null) { %>

                        <%= ticket.getAssignedStaff().getName() %>

                    <% } else { %>

                        Not Assigned

                    <% } %>

                </td>

                <td>
                    <%= ticket.getDueAt() %>
                </td>

                <td>

                    <% if ("RESOLVED".equals(ticket.getStatus())) { %>

                        <span class="resolved">
                            RESOLVED
                        </span>

                    <% } else if (ticket.getDueAt() != null
                            && java.time.LocalDateTime.now()
                               .isAfter(ticket.getDueAt())) { %>

                        <span class="overdue">
                            OVERDUE
                        </span>

                    <% } else { %>

                        WITHIN SLA

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


    <a class="back" href="dashboard">
        Back to Dashboard
    </a>


</div>

</body>

</html>