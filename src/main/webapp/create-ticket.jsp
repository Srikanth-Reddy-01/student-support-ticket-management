<%@ page import="com.assignment.model.User" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Create Support Ticket</title>

    <style>

        body {
            font-family: Arial;
            background: #f4f6f8;
        }

        .container {
            width: 600px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }

        input, textarea, select {
            width: 100%;
            padding: 10px;
            margin: 8px 0 15px;
            box-sizing: border-box;
        }

        textarea {
            height: 120px;
        }

        button {
            padding: 12px 20px;
            cursor: pointer;
        }

    </style>

</head>

<body>

<div class="container">

    <h2>Create Support Ticket</h2>

    <form action="create-ticket" method="post">

        <label>Title</label>

        <input
            type="text"
            name="title"
            required
        >


        <label>Description</label>

        <textarea
            name="description"
            required
        ></textarea>


        <label>Category</label>

        <select name="category" required>

            <option value="">Select Category</option>

            <option value="ACADEMIC">
                Academic
            </option>

            <option value="TECHNICAL">
                Technical
            </option>

            <option value="HOSTEL">
                Hostel
            </option>

            <option value="FEES">
                Fees
            </option>

            <option value="OTHER">
                Other
            </option>

        </select>


        <label>Priority</label>

        <select name="priority" required>

            <option value="LOW">
                Low
            </option>

            <option value="MEDIUM">
                Medium
            </option>

            <option value="HIGH">
                High
            </option>

        </select>


        <button type="submit">
            Create Ticket
        </button>

    </form>

</div>

</body>

</html>