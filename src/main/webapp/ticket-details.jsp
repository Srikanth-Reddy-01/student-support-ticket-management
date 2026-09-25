<%@ page import="com.assignment.model.Ticket" %>
<%@ page import="com.assignment.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.assignment.model.TicketActivity" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Ticket Details</title>

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
            width: 80%;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
        }

        .row {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        .label {
            font-weight: bold;
            display: inline-block;
            width: 150px;
        }

        .priority {
            font-weight: bold;
        }

        .status {
            font-weight: bold;
        }

        .button {
            display: inline-block;
            padding: 10px 15px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }

        .update-box {
            margin-top: 30px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        select,
        textarea {
            padding: 8px;
            margin-top: 5px;
        }

        textarea {
            width: 90%;
            resize: vertical;
        }

        .update-button {
            padding: 10px 18px;
            background: #27ae60;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        /* Activity History */

        .activity-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .activity-table th,
        .activity-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .activity-table th {
            background: #eeeeee;
        }

        .action {
            font-weight: bold;
        }

    </style>

</head>


<body>


<div class="header">

    <h2>Ticket Details</h2>

</div>


<div class="container">


    <%

        Ticket ticket =
            (Ticket) request.getAttribute("ticket");

        List<User> staffUsers =
            (List<User>) request.getAttribute("staffUsers");

        List<TicketActivity> activities =
            (List<TicketActivity>) request.getAttribute("activities");

    %>


    <h2>

        Ticket #<%= ticket.getId() %>

    </h2>


    <div class="row">

        <span class="label">
            Title:
        </span>

        <%= ticket.getTitle() %>

    </div>


    <div class="row">

        <span class="label">
            Description:
        </span>

        <%= ticket.getDescription() %>

    </div>


    <div class="row">

        <span class="label">
            Category:
        </span>

        <%= ticket.getCategory() %>

    </div>


    <div class="row">

        <span class="label">
            Priority:
        </span>

        <span class="priority">

            <%= ticket.getPriority() %>

        </span>

    </div>


    <div class="row">

        <span class="label">
            Status:
        </span>

        <span class="status">

            <%= ticket.getStatus() %>

        </span>

    </div>


    <div class="row">

        <span class="label">
            Created At:
        </span>

        <%= ticket.getCreatedAt() %>

    </div>


    <div class="row">

        <span class="label">
            Due At:
        </span>

        <%= ticket.getDueAt() %>

    </div>


    <div class="row">

        <span class="label">
            Updated At:
        </span>

        <%= ticket.getUpdatedAt() %>

    </div>


    <div class="row">

        <span class="label">
            Assigned Staff:
        </span>


        <%

            if (ticket.getAssignedStaff() != null) {

        %>

            <%= ticket.getAssignedStaff().getName() %>

            -

            <%= ticket.getAssignedStaff().getEmail() %>

        <%

            } else {

        %>

            Not Assigned

        <%

            }

        %>

    </div>


    <div class="row">

        <span class="label">
            Resolution:
        </span>

        <%= ticket.getResolution() == null
            ? "Not resolved yet"
            : ticket.getResolution() %>

    </div>



    <!-- ========================= -->
    <!-- UPDATE TICKET -->
    <!-- ========================= -->

    <div class="update-box">

        <h3>Update Ticket</h3>


        <form action="update-ticket" method="post">


            <!-- Ticket ID -->

            <input
                type="hidden"
                name="id"
                value="<%= ticket.getId() %>">


            <!-- ASSIGN STAFF -->

            <label>

                <strong>
                    Assign Staff:
                </strong>

            </label>

            <br>


            <select name="assignedStaff">

                <option value="">

                    -- Select Staff --

                </option>


                <%

                    if (staffUsers != null) {

                        for (User staff : staffUsers) {

                            boolean selected =
                                ticket.getAssignedStaff() != null
                                &&
                                ticket.getAssignedStaff().getId()
                                == staff.getId();

                %>


                    <option
                        value="<%= staff.getId() %>"
                        <%= selected ? "selected" : "" %>>

                        <%= staff.getName() %>

                        -

                        <%= staff.getEmail() %>

                    </option>


                <%

                        }

                    }

                %>

            </select>


            <br>
            <br>


            <!-- STATUS -->

            <label>

                <strong>
                    Status:
                </strong>

            </label>

            <br>


            <select name="status">


                <option
                    value="OPEN"
                    <%= "OPEN".equals(ticket.getStatus())
                        ? "selected"
                        : "" %>>

                    OPEN

                </option>


                <option
                    value="IN_PROGRESS"
                    <%= "IN_PROGRESS".equals(ticket.getStatus())
                        ? "selected"
                        : "" %>>

                    IN PROGRESS

                </option>


                <option
                    value="PENDING"
                    <%= "PENDING".equals(ticket.getStatus())
                        ? "selected"
                        : "" %>>

                    PENDING

                </option>


                <option
                    value="RESOLVED"
                    <%= "RESOLVED".equals(ticket.getStatus())
                        ? "selected"
                        : "" %>>

                    RESOLVED

                </option>


            </select>


            <br>
            <br>


            <!-- RESOLUTION -->

            <label>

                <strong>
                    Resolution:
                </strong>

            </label>

            <br>


            <textarea
                name="resolution"
                rows="5"
                placeholder="Enter resolution details..."><%=

                ticket.getResolution() == null
                    ? ""
                    : ticket.getResolution()

            %></textarea>


            <br>
            <br>


            <!-- UPDATE BUTTON -->

            <button
                type="submit"
                class="update-button">

                Update Ticket

            </button>


        </form>

    </div>



    <!-- ========================= -->
    <!-- ACTIVITY HISTORY -->
    <!-- ========================= -->

    <div class="update-box">

        <h3>Activity History</h3>


        <% if (activities == null || activities.isEmpty()) { %>

            <p>
                No activity history available.
            </p>

        <% } else { %>


            <table class="activity-table">

                <tr>

                    <th>
                        Time
                    </th>

                    <th>
                        Action
                    </th>

                    <th>
                        Description
                    </th>

                    <th>
                        Performed By
                    </th>

                </tr>


                <% for (TicketActivity activity : activities) { %>


                <tr>

                    <td>

                        <%= activity.getCreatedAt() %>

                    </td>


                    <td>

                        <span class="action">

                            <%= activity.getAction() %>

                        </span>

                    </td>


                    <td>

                        <%= activity.getDescription() %>

                    </td>


                    <td>

                        <%= activity.getPerformedBy().getName() %>

                    </td>

                </tr>


                <% } %>


            </table>


        <% } %>


    </div>



    <br>


    <a
        class="button"
        href="staff-dashboard">

        Back to Staff Dashboard

    </a>


</div>

</body>

</html>