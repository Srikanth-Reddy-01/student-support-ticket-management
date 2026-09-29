<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Student Account</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background: #f4f6f8;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
    }

    .register-container {
        background: white;
        width: 380px;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.12);
    }

    h2 {
        text-align: center;
        margin-bottom: 25px;
    }

    label {
        display: block;
        margin-top: 15px;
        margin-bottom: 6px;
        font-weight: bold;
    }

    input {
        width: 100%;
        padding: 10px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    button {
        width: 100%;
        padding: 11px;
        margin-top: 25px;
        border: none;
        border-radius: 5px;
        background: #2563eb;
        color: white;
        font-size: 16px;
        cursor: pointer;
    }

    button:hover {
        background: #1d4ed8;
    }

    .message {
        text-align: center;
        margin-bottom: 15px;
        color: red;
    }

    .login-link {
        text-align: center;
        margin-top: 20px;
    }

    .login-link a {
        color: #2563eb;
        text-decoration: none;
    }
</style>
</head>

<body>

<div class="register-container">

    <h2>Create Student Account</h2>

    <% if ("1".equals(request.getParameter("error"))) { %>
        <div class="message">
            Registration failed. Please try again.
        </div>
    <% } %>

    <% if ("exists".equals(request.getParameter("error"))) { %>
        <div class="message">
            An account with this email already exists.
        </div>
    <% } %>

    <form action="register" method="post">

        <label for="name">Full Name</label>
        <input type="text"
               id="name"
               name="name"
               required>

        <label for="email">Email</label>
        <input type="email"
               id="email"
               name="email"
               required>

        <label for="password">Password</label>
        <input type="password"
               id="password"
               name="password"
               required
               minlength="6">

        <label for="confirmPassword">Confirm Password</label>
        <input type="password"
               id="confirmPassword"
               name="confirmPassword"
               required
               minlength="6">

        <button type="submit">Create Account</button>

    </form>

    <div class="login-link">
        Already have an account?
        <a href="login.jsp">Login</a>
    </div>

</div>

</body>
</html>