<%@ page import="com.assignment.model.User" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Dashboard</title>

    <style>

        body {
            font-family: Arial;
            background: #f5f5f5;
        }

        .container {
            width: 80%;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
        }

        .card {
            padding: 20px;
            margin-top: 20px;
            background: #eeeeee;
        }

    </style>

</head>

<body>

<%

    User user =
        (User) request.getAttribute("user");

%>

<div class="container">

    <h1>Welcome, <%= user.getName() %></h1>

    <p>
        Role: <strong><%= user.getRole() %></strong>
    </p>

    <div class="card">

    <% if ("STUDENT".equals(user.getRole())) { %>

        <h2>Student Dashboard</h2>

        <p>
            Create and track your support tickets.
        </p>

        <a href="create-ticket.jsp">
            <button>Create New Ticket</button>
        </a>

        <br><br>

        <a href="my-tickets">
            <button>View My Tickets</button>
        </a>


    <% } else if ("STAFF".equals(user.getRole())) { %>

        <h2>Staff Dashboard</h2>

        <p>
            Manage, assign and resolve student support tickets.
        </p>

        <a href="staff-dashboard">
            <button>Staff Dashboard</button>
        </a>


    <% } else if ("MANAGER".equals(user.getRole())) { %>

    <h2>Manager Dashboard</h2>

    <p>Monitor tickets, assignments, SLA and ageing.</p>

    <a href="manager-dashboard">
        <button>Open Manager Dashboard</button>
    </a>
    <% } %>

</div>
</div>

</body>

</html>