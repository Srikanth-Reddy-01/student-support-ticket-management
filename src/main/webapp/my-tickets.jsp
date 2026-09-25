<%@ page import="java.util.List" %>
<%@ page import="com.assignment.model.Ticket" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>My Tickets</title>

    <style>

        body {
            font-family: Arial;
            background: #f4f6f8;
        }

        .container {
            width: 90%;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
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

    </style>

</head>

<body>

<div class="container">

    <h2>My Support Tickets</h2>

    <%
        List<Ticket> tickets =
            (List<Ticket>) request.getAttribute("tickets");
    %>

    <% if (tickets == null || tickets.isEmpty()) { %>

        <p>No tickets found.</p>

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

                    <td>
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

                </tr>

            <% } %>

        </table>

    <% } %>

    <br>

    <a href="dashboard">
        Back to Dashboard
    </a>

</div>

</body>

</html>