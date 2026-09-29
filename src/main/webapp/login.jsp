<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>Student Support System - Login</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f2f4f7;
        }

        .login-box {
            width: 350px;
            margin: 100px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }

        h2 {
            text-align: center;
        }

        input {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            cursor: pointer;
        }

        .error {
            color: red;
            text-align: center;
        }

        .success {
            color: green;
            text-align: center;
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
        }

        .register-link a {
            color: #2563eb;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

    </style>

</head>

<body>

<div class="login-box">

    <h2>Student Support System</h2>

    <%
        String error = request.getParameter("error");

        if ("1".equals(error)) {
    %>

        <p class="error">
            Invalid email or password
        </p>

    <%
        }

        String registered = request.getParameter("registered");

        if ("1".equals(registered)) {
    %>

        <p class="success">
            Account created successfully. Please login.
        </p>

    <%
        }
    %>

    <form action="login" method="post">

        <label>Email</label>

        <input
            type="email"
            name="email"
            required
        >

        <label>Password</label>

        <input
            type="password"
            name="password"
            required
        >

        <button type="submit">
            Login
        </button>

    </form>

    <div class="register-link">

        New student?

        <a href="register.jsp">
            Create Student Account
        </a>

    </div>

</div>

</body>
</html>